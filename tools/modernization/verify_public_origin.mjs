// Read-only canonical requests to the new Vercel origin, without changing DNS.
import https from 'node:https';
import fs from 'node:fs';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
const root=fileURLToPath(new URL('../../',import.meta.url));
const live=process.argv.includes('--live');
const addresses=live?[null]:['216.150.1.1','216.150.16.1'];
const digest=bytes=>createHash('sha256').update(bytes).digest('hex');
async function request(hostname,pathname,address){
 return new Promise(resolve=>{
  const req=https.request({hostname,servername:hostname,path:pathname,method:'GET',family:4,
   ...(address?{lookup:(_host,options,callback)=>options.all?callback(null,[{address,family:4}]):callback(null,address,4)}:{}),
   headers:{'User-Agent':'QuizeeyCutoverVerification/1.0','Accept-Encoding':'identity'}},res=>{
   const chunks=[];let bytes=0;
   res.on('data',chunk=>{bytes+=chunk.length;if(bytes>1500000)req.destroy(new Error('Response bound exceeded'));else chunks.push(chunk);});
   res.on('end',()=>resolve({status:res.statusCode,headers:res.headers,body:Buffer.concat(chunks),tlsAuthorized:res.socket?.authorized??true}));
  });req.setTimeout(12000,()=>req.destroy(new Error('Origin timeout')));req.on('error',error=>resolve({error:error.code??error.name}));req.end();
 });
}
const checks=[];
for(const address of addresses){
 for(const pathname of ['/robots.txt','/sitemap.xml','/ads.txt','/','/industrial-engineer-electric-work','/img/letter-q.svg','/img/favicon.ico']){
  const response=await request('quizeey.com',pathname,address);
  const check={address,path:pathname,status:response.status,error:response.error,tlsAuthorized:response.tlsAuthorized};
  if(response.body){const text=response.body.toString('utf8');check.hasNoindex=/noindex/i.test(response.headers['x-robots-tag']??'');
   if(pathname==='/robots.txt')check.valid=text.includes('Allow: /')&&text.includes('Sitemap: https://quizeey.com/sitemap.xml')&&!/^Disallow: \/$/m.test(text);
   else if(pathname==='/sitemap.xml')check.valid=(text.match(/<loc>/g)??[]).length>180&&!text.includes('vercel.app');
   else if(pathname==='/ads.txt')check.valid=text.trim()==='google.com, pub-8362228066874729, DIRECT, f08c47fec0942fa0';
   else if(pathname.startsWith('/img/'))check.valid=digest(response.body)===digest(fs.readFileSync(path.join(root,'src/main/resources/static',pathname)));
   else{check.canonical=text.includes(`rel="canonical" href="https://quizeey.com${pathname==='/'?'/':pathname}"`);check.publicRobots=text.includes('content="index, follow"');check.existingGa4=text.includes('G-XM8XM4CHX7');check.existingCmp=text.includes('fundingchoicesmessages.google.com/i/pub-8362228066874729');check.valid=check.canonical&&check.publicRobots&&check.existingGa4&&check.existingCmp;}
  }check.passed=response.status===200&&!check.hasNoindex&&check.valid===true&&response.tlsAuthorized===true;checks.push(check);
  if(response.error)break;
 }
 const redirected=await request('www.quizeey.com','/sqlp-developer?verNbr=1&page=2',address);
 checks.push({address,path:'www redirect',status:redirected.status,error:redirected.error,location:redirected.headers?.location,passed:redirected.status===308&&redirected.headers?.location==='https://quizeey.com/sqlp-developer?verNbr=1&page=2'});
}
const report={checkedAt:new Date().toISOString(),status:checks.every(c=>c.passed)?'passed':'needs-attention',scope:live?'Actual public DNS HTTPS with certificate validation; no DNS overrides or writes, scripts, ad/analytics requests.':'HTTPS with real canonical Host/SNI and certificate validation, direct to both Vercel-recommended IPv4 addresses; no DNS writes, no scripts executed or ad/analytics requests.',checks};
fs.writeFileSync(path.join(root,'docs/modernization',live?'live-public-origin-evidence.json':'public-origin-evidence.json'),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report));
if(report.status!=='passed')process.exitCode=1;
