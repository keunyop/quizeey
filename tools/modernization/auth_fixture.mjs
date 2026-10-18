// Explicit local test double for the Supabase Auth HTTP contract. No real accounts or keys.
import { createServer } from 'node:http';
import { createHmac,randomBytes,randomUUID,timingSafeEqual } from 'node:crypto';

if(process.env.VERCEL_ENV || (process.env.QUIZEEY_ENV && process.env.QUIZEEY_ENV!=='local')) throw new Error('Local fixture only');
const adminId='00000000-0000-4000-8000-000000000101';
const ordinaryId='00000000-0000-4000-8000-000000000102';
const secret=randomBytes(32);
const counts={password:0,user:0,logout:0};
const users=new Map([
  ['admin@quizeey.invalid',adminId],['ordinary@quizeey.invalid',ordinaryId],
]);
const signature=(value)=>createHmac('sha256',secret).update(value).digest('base64url');
function issue(id){const value=Buffer.from(JSON.stringify({alg:'HS256',typ:'JWT'})).toString('base64url')+'.'+Buffer.from(JSON.stringify({sub:id,exp:Math.floor(Date.now()/1000)+3600,jti:randomUUID(),role:'authenticated'})).toString('base64url');return value+'.'+signature(value);}
function verify(token){
  if(!token)return null;
  try{
    const [header,payload,mac,...extra]=token.split('.');const expected=Buffer.from(signature(header+'.'+payload));const received=Buffer.from(mac??'');
    if(extra.length || received.length!==expected.length || !timingSafeEqual(received,expected))return null;
    const claims=JSON.parse(Buffer.from(payload,'base64url').toString('utf8'));
    return claims.exp>Date.now()/1000 && [...users.values()].includes(claims.sub)?claims.sub:null;
  }catch{return null;}
}
function user(id){return {id,aud:'authenticated',role:'authenticated',email:[...users].find(([,value])=>value===id)[0],is_anonymous:false,app_metadata:{provider:'email'},user_metadata:{role:'admin',display_name:'Admin'},created_at:'2026-01-01T00:00:00Z'};}
function json(res,status,body){res.writeHead(status,{'Content-Type':'application/json','Cache-Control':'no-store'});res.end(JSON.stringify(body));}
const server=createServer(async(req,res)=>{
  const url=new URL(req.url,'http://127.0.0.1:55433');
  if(req.method==='GET'&&url.pathname==='/_fixture'){json(res,200,{fixture:true,counts});return;}
  if(req.headers.apikey!=='local-fixture-publishable'){json(res,401,{message:'Fixture key required'});return;}
  if(req.method==='POST'&&url.pathname==='/auth/v1/token'&&url.searchParams.get('grant_type')==='password'){
    counts.password++;
    try{
      let body='';for await(const chunk of req){body+=chunk;if(body.length>8192){json(res,413,{message:'Too large'});return;}}
      const value=JSON.parse(body);const id=users.get(value.email);
      if(!id||value.password!=='fixture-password-only'){json(res,400,{error_code:'invalid_credentials',msg:'Invalid login credentials'});return;}
      json(res,200,{access_token:issue(id),refresh_token:randomBytes(32).toString('base64url'),expires_in:3600,expires_at:Math.floor(Date.now()/1000)+3600,token_type:'bearer',user:user(id)});
    }catch{json(res,400,{message:'Invalid fixture input'});}
    return;
  }
  const token=req.headers.authorization?.replace(/^Bearer /,'');const id=verify(token);
  if(req.method==='GET'&&url.pathname==='/auth/v1/user'){
    counts.user++;json(res,id?200:401,id?user(id):{message:'Invalid token'});return;
  }
  if(req.method==='POST'&&url.pathname==='/auth/v1/logout'){
    counts.logout++;if(!id){json(res,401,{message:'Invalid token'});return;}
    // Like real JWT access tokens, this token remains valid until expiry.
    // Quizeey's private session registry MUST implement immediate local revocation.
    res.writeHead(204);res.end();return;
  }
  json(res,404,{message:'Fixture operation unavailable'});
});
server.requestTimeout=5000;server.on('error',()=>{process.stderr.write('Auth fixture could not start\n');process.exit(1);});
server.listen(55433,'127.0.0.1',()=>process.stdout.write('Local Auth HTTP fixture ready on 127.0.0.1:55433\n'));
for(const signal of ['SIGINT','SIGTERM'])process.on(signal,()=>{server.close();server.closeAllConnections();});
