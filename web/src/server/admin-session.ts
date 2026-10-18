import { createHash } from 'node:crypto';
import { forumConnection, hostedForumTransport } from './forum-database';
const hash=(token:string)=>createHash('sha256').update(token).digest('hex');
export async function registerAdminSession(token:string,actorId:string,maxAge:number) {
  const hosted = hostedForumTransport();
  if (hosted) {
    if (!await hosted.rpc('quizeey_admin_session_create', { p_hash: hash(token), p_actor: actorId, p_expires: new Date(Date.now()+maxAge*1000).toISOString() })) throw new Error('Admin session could not be registered');
    return;
  }
  const result=await forumConnection().query<{allowed:boolean}>('select public.quizeey_admin_session_create($1,$2,$3) as allowed',[hash(token),actorId,new Date(Date.now()+maxAge*1000).toISOString()]);
  if(!result.rows[0].allowed)throw new Error('Admin session could not be registered');
}
export async function activeAdminSession(token:string) {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc('quizeey_admin_session_actor', { p_hash: hash(token) });
  const result=await forumConnection().query<{actor:string|null}>('select public.quizeey_admin_session_actor($1) as actor',[hash(token)]);
  return result.rows[0].actor;
}
export async function revokeAdminSession(token:string) {
  const hosted = hostedForumTransport();
  if (hosted) { await hosted.rpc('quizeey_admin_session_revoke', { p_hash: hash(token) }); return; }
  await forumConnection().query('select public.quizeey_admin_session_revoke($1)',[hash(token)]);
}
