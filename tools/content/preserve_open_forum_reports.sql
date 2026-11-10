-- MIGRATION CANDIDATE; NOT APPLIED TO ANY HOSTED DATABASE.
-- Create a versioned migration with the approved Supabase CLI before release.
-- Existing 30-day expires_at deadlines are unchanged. Only resolved reports
-- expire: an open report must remain available to operators until disposition.
-- This extends retention of unresolved report reasons, which may contain PII.
-- Review the retention policy before hosted application; do not auto-resolve.
begin;

create or replace function quizeey_private.quizeey_forum_cleanup()
returns void language sql security definer set search_path='' as $$
  delete from quizeey_private.rate_windows where expires_at<now();
  delete from quizeey_private.mutation_receipts where expires_at<now();
  delete from quizeey_private.forum_reports where state='resolved' and expires_at<now();
  delete from quizeey_private.moderation_audit where created_at<now()-interval '90 days';
  delete from quizeey_private.admin_sessions where expires_at<now();
$$;

create or replace function quizeey_private.quizeey_admin_queue(p_kind text,p_state text default 'pending',p_cursor_time timestamptz default null,p_cursor_id uuid default null)
returns jsonb language plpgsql stable security definer set search_path='' as $$
declare items jsonb;
begin
  if p_kind not in ('posts','revisions','reports') or p_kind is null or p_state not in ('pending','approved','hidden') or p_state is null
    or (p_cursor_time is null)<>(p_cursor_id is null) then return jsonb_build_object('status',400); end if;
  if p_kind='posts' then
    select coalesce(jsonb_agg(to_jsonb(q)),'[]'::jsonb) into items from (
      select p.id,p.topic_id,p.parent_id,p.body,p.display_name,p.visibility,p.created_at,
        t.title,t.exam_id,t.question_id,t.locale,t.locked
      from public.quizeey_posts p join public.quizeey_topics t on t.id=p.topic_id
      where p.visibility=p_state and (p_cursor_time is null or (p.created_at,p.id)<(p_cursor_time,p_cursor_id))
      order by p.created_at desc,p.id desc limit 21
    ) q;
  elsif p_kind='revisions' then
    select coalesce(jsonb_agg(to_jsonb(q)),'[]'::jsonb) into items from (
      select r.id,r.post_id,r.body,r.display_name,r.created_at,p.body as published_body,p.topic_id,
        t.title,t.exam_id,t.question_id,t.locale
      from quizeey_private.post_revisions r join public.quizeey_posts p on p.id=r.post_id join public.quizeey_topics t on t.id=p.topic_id
      where r.visibility='pending' and p.visibility='approved' and (p_cursor_time is null or (r.created_at,r.id)<(p_cursor_time,p_cursor_id))
      order by r.created_at desc,r.id desc limit 21
    ) q;
  else
    select coalesce(jsonb_agg(to_jsonb(q)),'[]'::jsonb) into items from (
      select r.id,r.post_id,r.reason,r.created_at,p.body,p.display_name,p.visibility,p.topic_id,
        t.title,t.exam_id,t.question_id,t.locale
      from quizeey_private.forum_reports r join public.quizeey_posts p on p.id=r.post_id join public.quizeey_topics t on t.id=p.topic_id
      where r.state='open' and (p_cursor_time is null or (r.created_at,r.id)<(p_cursor_time,p_cursor_id))
      order by r.created_at desc,r.id desc limit 21
    ) q;
  end if;
  return jsonb_build_object('status',200,'items',items);
end $$;

-- Keep the existing service-only private implementations and public invoker
-- wrappers. No direct table grants or public function signatures are changed.
revoke all on function quizeey_private.quizeey_forum_cleanup(),quizeey_private.quizeey_admin_queue(text,text,timestamptz,uuid) from public,anon,authenticated,service_role;
grant execute on function quizeey_private.quizeey_forum_cleanup(),quizeey_private.quizeey_admin_queue(text,text,timestamptz,uuid) to service_role;
commit;
