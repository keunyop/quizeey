import { NextResponse } from 'next/server';
import { z } from 'zod';
import { boundedJson } from './guest-policy';
import { adminConfiguration,adminCookieName,adminCookieOptions,AdminAuthError,readAdminToken,requireAdmin,signInAdmin,signOutAdmin } from './admin-auth';
import { adminLoginLimit,moderate,moderationQueue } from './admin-database';
import { forumConfigured } from './forum-database';
import { registerAdminSession,revokeAdminSession } from './admin-session';
import { forumAbuseHash, forumOriginAllowed as originAllowed } from './forum-config';

export const adminHeaders={'Cache-Control':'private, no-store','X-Robots-Tag':'noindex, nofollow'};
function response(value:unknown,status=200) {return NextResponse.json(value,{status,headers:adminHeaders});}
function failure(error:unknown) {return response({error:'Admin request unavailable or denied'},error instanceof AdminAuthError?error.status:503);}
function available() {
  return forumConfigured() && adminConfiguration()!==null;
}
export async function adminSession(request:Request) {
  try {
    if(!available()) return response({error:'Admin sign-in unavailable'},503);
    await requireAdmin(request);
    return response({authenticated:true});
  } catch(error) {return failure(error);}
}
export async function adminLogin(request:Request) {
  if(!originAllowed(request)) return response({error:'Origin rejected'},403);
  try {
    if(!available()) return response({error:'Admin sign-in unavailable'},503);
    const abuse=forumAbuseHash(request,'admin');
    if(!await adminLoginLimit(abuse)) return response({error:'Try again later'},429);
    let input:{email:string;password:string};
    try {input=z.object({email:z.email().max(254),password:z.string().min(1).max(1024)}).strict().parse(await boundedJson(request));}
    catch {return response({error:'Invalid sign-in input'},400);}
    const session=await signInAdmin(input.email,input.password);
    await registerAdminSession(session.token,session.id,session.maxAge);
    const output=response({authenticated:true});
    output.cookies.set(adminCookieName,session.token,{...adminCookieOptions,maxAge:session.maxAge});
    return output;
  } catch(error) {return failure(error);}
}
export async function adminLogout(request:Request) {
  if(!originAllowed(request)) return response({error:'Origin rejected'},403);
  const token=readAdminToken(request);
  let failed=false;
  try {
    if(token){if(!available())throw new AdminAuthError(503);await revokeAdminSession(token);try{await signOutAdmin(token);}catch{/* Local shared revocation already blocks this token. */}}
  }catch {failed=true;}
  const output=response(failed?{error:'Session revocation unavailable'}:{authenticated:false},failed?503:200);
  output.cookies.set(adminCookieName,'',{...adminCookieOptions,maxAge:0});
  return output;
}
export async function adminQueue(request:Request) {
  try {
    if(!available()) return response({error:'Admin unavailable'},503);
    await requireAdmin(request);
    let input:{kind:'posts'|'revisions'|'reports';state:'pending'|'approved'|'hidden'};
    let cursor:{time:string;id:string}|undefined;
    try {
      const query=new URL(request.url).searchParams;
      if(['kind','state','cursor'].some((k)=>query.getAll(k).length>1)) throw new Error();
      input=z.object({kind:z.enum(['posts','revisions','reports']),state:z.enum(['pending','approved','hidden'])}).parse({kind:query.get('kind')??'posts',state:query.get('state')??'pending'});
      const raw=query.get('cursor');
      if(raw){if(raw.length>300 || !/^[A-Za-z0-9_-]+$/.test(raw)) throw new Error();cursor=z.object({time:z.iso.datetime({offset:true}),id:z.uuid()}).strict().parse(JSON.parse(Buffer.from(raw,'base64url').toString('utf8')));}
    } catch {return response({error:'Invalid review query'},400);}
    return response(await moderationQueue(input.kind,input.state,cursor));
  } catch(error) {return failure(error);}
}
export async function adminModerate(request:Request) {
  if(!originAllowed(request)) return response({error:'Origin rejected'},403);
  try {
    if(!available()) return response({error:'Admin unavailable'},503);
    const user=await requireAdmin(request);
    let input:{action:'approve'|'hide'|'delete'|'lock'|'unlock'|'approve_revision'|'reject_revision'|'resolve_report';id:string};
    let requestId:string;
    try {
      requestId=z.uuid().parse(request.headers.get('idempotency-key'));
      input=z.object({action:z.enum(['approve','hide','delete','lock','unlock','approve_revision','reject_revision','resolve_report']),id:z.uuid()}).strict().parse(await boundedJson(request));
    } catch {return response({error:'Invalid moderation request'},400);}
    const result=await moderate(user.id,requestId,input.action,input.id);
    return response(result,result.status);
  } catch(error) {return failure(error);}
}
