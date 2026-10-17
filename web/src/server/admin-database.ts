import { forumConnection } from './forum-database';

export type QueueKind='posts'|'revisions'|'reports';
export type QueueState='pending'|'approved'|'hidden';
export type ModerationAction='approve'|'hide'|'delete'|'lock'|'unlock'|'approve_revision'|'reject_revision'|'resolve_report';
export type QueueItem={id:string;created_at:string;body?:string;published_body?:string;reason?:string;display_name?:string|null;visibility?:string;topic_id:string;post_id?:string;parent_id?:string|null;title:string;exam_id:string;question_id:string|null;locale:'ko'|'en';locked?:boolean};
export async function adminLoginLimit(abuseHash: string) {
  const result=await forumConnection().query<{allowed:boolean}>('select public.quizeey_admin_login_limit($1) as allowed',[abuseHash]);
  return result.rows[0].allowed;
}
export async function moderationQueue(kind:QueueKind,state:QueueState,cursor?:{time:string;id:string}) {
  const result=await forumConnection().query<{result:{status:number;items:QueueItem[]}}>('select public.quizeey_admin_queue($1,$2,$3,$4) as result',[kind,state,cursor?.time??null,cursor?.id??null]);
  const items=result.rows[0].result.items;
  const page=items.slice(0,20);
  const last=page.at(-1);
  return {items:page,nextCursor:items.length>20&&last?Buffer.from(JSON.stringify({time:last.created_at,id:last.id})).toString('base64url'):null};
}
export async function moderate(actorId:string,requestId:string,action:ModerationAction,id:string) {
  const result=await forumConnection().query<{result:{status:number}}>('select public.quizeey_admin_moderate($1,$2,$3,$4) as result',[actorId,requestId,action,id]);
  return result.rows[0].result;
}
