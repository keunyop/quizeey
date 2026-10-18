begin;
alter table quizeey_private.forum_reports add column state text not null default 'open' check(state in ('open','resolved'));
alter table quizeey_private.forum_reports add column resolved_at timestamptz;
create table quizeey_private.moderation_audit (
  request_id uuid primary key,
  actor_id uuid not null,
  action text not null,
  target_id uuid not null,
  result jsonb not null,
  created_at timestamptz not null default now()
);
alter table quizeey_private.moderation_audit enable row level security;
alter table quizeey_private.moderation_audit force row level security;
revoke all on quizeey_private.moderation_audit from public,anon,authenticated,service_role;
create table quizeey_private.admin_sessions (
  session_hash text primary key check(session_hash ~ '^[a-f0-9]{64}$'),
  actor_id uuid not null,
  expires_at timestamptz not null,
  revoked_at timestamptz,
  created_at timestamptz not null default now()
);
alter table quizeey_private.admin_sessions enable row level security;
alter table quizeey_private.admin_sessions force row level security;
revoke all on quizeey_private.admin_sessions from public,anon,authenticated,service_role;
create index quizeey_admin_session_expiry_idx on quizeey_private.admin_sessions(expires_at);

create function public.quizeey_admin_session_create(p_hash text,p_actor uuid,p_expires timestamptz) returns boolean
language plpgsql security definer set search_path='' as $$
begin
  if p_hash is null or p_hash !~ '^[a-f0-9]{64}$' or p_actor is null or p_expires is null or p_expires<=now() or p_expires>now()+interval '1 hour' then return false; end if;
  insert into quizeey_private.admin_sessions(session_hash,actor_id,expires_at) values(p_hash,p_actor,p_expires) on conflict do nothing;
  return found;
end $$;
create function public.quizeey_admin_session_actor(p_hash text) returns uuid
language sql stable security definer set search_path='' as $$
  select actor_id from quizeey_private.admin_sessions where session_hash=p_hash and revoked_at is null and expires_at>now();
$$;
create function public.quizeey_admin_session_revoke(p_hash text) returns void
language sql security definer set search_path='' as $$
  update quizeey_private.admin_sessions set revoked_at=coalesce(revoked_at,now()) where session_hash=p_hash;
$$;
revoke all on function public.quizeey_admin_session_create(text,uuid,timestamptz),public.quizeey_admin_session_actor(text),public.quizeey_admin_session_revoke(text) from public,anon,authenticated;
grant execute on function public.quizeey_admin_session_create(text,uuid,timestamptz),public.quizeey_admin_session_actor(text),public.quizeey_admin_session_revoke(text) to service_role;
create index quizeey_moderation_created_idx on quizeey_private.moderation_audit(created_at);
create index quizeey_reports_open_idx on quizeey_private.forum_reports(created_at desc,id) where state='open';
create index quizeey_posts_review_idx on public.quizeey_posts(visibility,created_at desc,id);

create function public.quizeey_admin_login_limit(p_abuse_hash text) returns boolean
language plpgsql security definer set search_path='' as $$
begin
  if p_abuse_hash is null or p_abuse_hash !~ '^[a-f0-9]{64}$' then return false; end if;
  return quizeey_private.consume_rate('admin-login:'||p_abuse_hash,5);
end $$;
revoke all on function public.quizeey_admin_login_limit(text) from public,anon,authenticated;
grant execute on function public.quizeey_admin_login_limit(text) to service_role;

create function public.quizeey_admin_queue(p_kind text,p_state text default 'pending',p_cursor_time timestamptz default null,p_cursor_id uuid default null)
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
      where r.state='open' and r.expires_at>now() and (p_cursor_time is null or (r.created_at,r.id)<(p_cursor_time,p_cursor_id))
      order by r.created_at desc,r.id desc limit 21
    ) q;
  end if;
  return jsonb_build_object('status',200,'items',items);
end $$;
revoke all on function public.quizeey_admin_queue(text,text,timestamptz,uuid) from public,anon,authenticated;
grant execute on function public.quizeey_admin_queue(text,text,timestamptz,uuid) to service_role;

-- actor_id must come from a server-verified provider identity plus the server UUID allowlist.
-- Neither an ordinary authenticated DB role nor a browser-supplied identity can call this RPC.
create function public.quizeey_admin_moderate(p_actor_id uuid,p_request_id uuid,p_action text,p_id uuid)
returns jsonb language plpgsql security definer set search_path='' as $$
declare receipt quizeey_private.moderation_audit%rowtype; output jsonb; revision quizeey_private.post_revisions%rowtype;
begin
  if p_actor_id is null or p_request_id is null or p_id is null or p_action is null
    or p_action not in ('approve','hide','delete','lock','unlock','approve_revision','reject_revision','resolve_report') then return jsonb_build_object('status',400); end if;
  perform pg_advisory_xact_lock(hashtextextended('moderation:'||p_request_id::text,0));
  select * into receipt from quizeey_private.moderation_audit where request_id=p_request_id;
  if found then
    if receipt.actor_id<>p_actor_id or receipt.action<>p_action or receipt.target_id<>p_id then return jsonb_build_object('status',409); end if;
    return receipt.result;
  end if;
  if not quizeey_private.consume_rate('moderator:'||p_actor_id::text,60) then return jsonb_build_object('status',429); end if;
  if p_action='resolve_report' then
    update quizeey_private.forum_reports set state='resolved',resolved_at=coalesce(resolved_at,now()) where id=p_id;
    output:=jsonb_build_object('status',case when found then 200 else 404 end);
  elsif p_action='unlock' then
    update public.quizeey_topics set locked=false where id=p_id;
    output:=jsonb_build_object('status',case when found then 200 else 404 end);
  elsif p_action in ('approve_revision','reject_revision') then
    select * into revision from quizeey_private.post_revisions where id=p_id for update;
    if not found or revision.visibility<>'pending' then output:=jsonb_build_object('status',404);
    elsif p_action='reject_revision' then
      update quizeey_private.post_revisions set visibility='rejected' where id=p_id;
      output:=jsonb_build_object('status',200);
    elsif exists(select 1 from quizeey_private.post_revisions r where r.post_id=revision.post_id and r.visibility in ('pending','approved') and (r.created_at,r.id)>(revision.created_at,revision.id)) then
      output:=jsonb_build_object('status',409);
    else
      output:=public.quizeey_forum_moderate('approve_revision',p_id);
      if (output->>'status')::integer=200 then
        update quizeey_private.post_revisions set visibility='rejected' where post_id=revision.post_id and visibility='pending' and id<>p_id;
      end if;
    end if;
  else output:=public.quizeey_forum_moderate(p_action,p_id);
  end if;
  insert into quizeey_private.moderation_audit(request_id,actor_id,action,target_id,result) values(p_request_id,p_actor_id,p_action,p_id,output);
  return output;
end $$;
revoke all on function public.quizeey_admin_moderate(uuid,uuid,text,uuid) from public,anon,authenticated;
grant execute on function public.quizeey_admin_moderate(uuid,uuid,text,uuid) to service_role;

create or replace function public.quizeey_forum_cleanup() returns void language sql security definer set search_path='' as $$
  delete from quizeey_private.rate_windows where expires_at<now();
  delete from quizeey_private.mutation_receipts where expires_at<now();
  delete from quizeey_private.forum_reports where expires_at<now();
  delete from quizeey_private.moderation_audit where created_at<now()-interval '90 days';
  delete from quizeey_private.admin_sessions where expires_at<now();
$$;
revoke all on function public.quizeey_forum_cleanup() from public,anon,authenticated;
grant execute on function public.quizeey_forum_cleanup() to service_role;
commit;
