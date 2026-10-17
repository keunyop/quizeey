import { createHash } from 'node:crypto';
import { forumConnection } from './forum-database';
const hash=(token:string)=>createHash('sha256').update(token).digest('hex');
export async function registerAdminSession(token:string,actorId:string,maxAge:number) {
  const result=await forumConnection().query<{allowed:boolean}>('select public.quizeey_admin_session_create($1,$2,$3) as allowed',[hash(token),actorId,new Date(Date.now()+maxAge*1000).toISOString()]);
  if(!result.rows[0].allowed)throw new Error('Admin session could not be registered');
}
export async function activeAdminSession(token:string) {
  const result=await forumConnection().query<{actor:string|null}>('select public.quizeey_admin_session_actor($1) as actor',[hash(token)]);
  return result.rows[0].actor;
}
export async function revokeAdminSession(token:string) {
  await forumConnection().query('select public.quizeey_admin_session_revoke($1)',[hash(token)]);
}
