-- REVIEW CANDIDATE ONLY. Requires explicit cloud schema approval.
-- Exact target: Supabase tfkhnrbshvyfmrzxqfmq; no source/derived content or Auth changes.
begin;
set local lock_timeout='5s';
set local statement_timeout='60s';
select pg_advisory_xact_lock(hashtextextended('quizeey_schema_preview_candidate_v1',0));
do $$ begin
  if current_user<>'postgres' or current_setting('server_version_num')<>'170011'
    or (select rolsuper from pg_roles where rolname=current_user) then
    raise exception 'Wrong migration role/version';
  end if;
  if to_regnamespace('quizeey_private') is not null or to_regnamespace('quizeey_content') is not null
    or exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid where n.nspname='public' and c.relname like 'quizeey_%')
    or exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%') then
    raise exception 'Target is not the verified empty application schema';
  end if;
end $$;

-- Source: 202610160002_native_forum.sql
-- New native forum design. Apply only to a VERIFIED Quizeey target after rehearsal.
-- Legacy context IDs intentionally have no guessed foreign keys into the unverified archive.

create schema if not exists quizeey_private;
revoke all on schema quizeey_private from public, anon, authenticated, service_role;

create table public.quizeey_topics (
  id uuid primary key default gen_random_uuid(),
  exam_id text not null check (exam_id ~ '^[1-9][0-9]{0,18}$'),
  question_id text check (question_id ~ '^[1-9][0-9]{0,18}$'),
  locale text not null check (locale in ('ko','en')),
  title text not null check (char_length(title) between 1 and 120),
  visibility text not null default 'pending' check (visibility in ('pending','approved','hidden','deleted')),
  locked boolean not null default false,
  approved_post_count integer not null default 0 check (approved_post_count >= 0),
  source_thread_id text unique,
  created_at timestamptz not null default now()
);
create index quizeey_topics_context_idx on public.quizeey_topics(exam_id,locale,question_id,created_at desc);
create table public.quizeey_posts (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.quizeey_topics(id),
  parent_id uuid,
  display_name text check (char_length(display_name) <= 80),
  body text not null check (char_length(body) <= 4000),
  visibility text not null default 'pending' check (visibility in ('pending','approved','hidden','deleted')),
  source_post_id text unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(id,topic_id),
  foreign key(parent_id,topic_id) references public.quizeey_posts(id,topic_id),
  check (parent_id is null or parent_id <> id)
);
create index quizeey_posts_topic_idx on public.quizeey_posts(topic_id,created_at,id) where visibility='approved';
create index quizeey_posts_parent_idx on public.quizeey_posts(parent_id,topic_id) where parent_id is not null;
create table quizeey_private.guest_capabilities (
  capability_hash text primary key check (capability_hash ~ '^[a-f0-9]{64}$'),
  expires_at timestamptz not null
);
create table quizeey_private.post_owners (
  post_id uuid primary key references public.quizeey_posts(id),
  capability_hash text not null references quizeey_private.guest_capabilities(capability_hash)
);
create index quizeey_owners_capability_idx on quizeey_private.post_owners(capability_hash);
create table quizeey_private.post_revisions (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.quizeey_posts(id),
  display_name text check (char_length(display_name) <= 80),
  body text not null check (char_length(body) between 1 and 4000),
  visibility text not null default 'pending' check (visibility in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);
create index quizeey_revisions_post_idx on quizeey_private.post_revisions(post_id,created_at desc);
create table quizeey_private.forum_reports (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references public.quizeey_posts(id),
  reason text not null check (char_length(reason) between 1 and 500),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default now()+interval '30 days'
);
create table quizeey_private.rate_windows (
  bucket text not null,
  window_start timestamptz not null,
  hits integer not null,
  expires_at timestamptz not null,
  primary key(bucket,window_start)
);
create table quizeey_private.mutation_receipts (
  capability_hash text not null,
  request_id uuid primary key,
  input_hash text not null,
  result jsonb not null,
  expires_at timestamptz not null default now()+interval '1 day'
);

alter table public.quizeey_topics enable row level security;
alter table public.quizeey_topics force row level security;
alter table public.quizeey_posts enable row level security;
alter table public.quizeey_posts force row level security;
revoke all on public.quizeey_topics,public.quizeey_posts from public,anon,authenticated,service_role;
grant select on public.quizeey_topics,public.quizeey_posts to anon,authenticated;
create policy quizeey_topics_public on public.quizeey_topics for select to anon,authenticated
  using (visibility='approved' and approved_post_count>0);
create policy quizeey_posts_public on public.quizeey_posts for select to anon,authenticated
  using (visibility='approved' and exists (select 1 from public.quizeey_topics t where t.id=topic_id and t.visibility='approved' and t.approved_post_count>0));

do $$ declare t text; begin
  foreach t in array array['guest_capabilities','post_owners','post_revisions','forum_reports','rate_windows','mutation_receipts'] loop
    execute format('alter table quizeey_private.%I enable row level security',t);
    execute format('alter table quizeey_private.%I force row level security',t);
    execute format('revoke all on quizeey_private.%I from public,anon,authenticated,service_role',t);
  end loop;
end $$;

create function quizeey_private.consume_rate(p_bucket text,p_limit integer) returns boolean
language plpgsql security definer set search_path='' as $$
declare n integer; w timestamptz := date_bin(interval '10 minutes',now(),timestamptz '2000-01-01');
begin
  insert into quizeey_private.rate_windows(bucket,window_start,hits,expires_at)
    values(p_bucket,w,1,w+interval '20 minutes')
    on conflict(bucket,window_start) do update set hits=least(quizeey_private.rate_windows.hits+1,p_limit+1)
    returning hits into n;
  return n<=p_limit;
end $$;
revoke all on function quizeey_private.consume_rate(text,integer) from public,anon,authenticated,service_role;

create function public.quizeey_forum_mutate(p_capability_hash text,p_abuse_hash text,p_request_id uuid,p_action text,p_payload jsonb)
returns jsonb language plpgsql security definer set search_path='' as $$
declare input_hash text; old_receipt quizeey_private.mutation_receipts%rowtype;
  result jsonb; topic public.quizeey_topics%rowtype; post public.quizeey_posts%rowtype;
  v_post_id uuid; v_topic_id uuid; v_parent_id uuid; v_revision_id uuid;
  v_body text := btrim(coalesce(p_payload->>'body',''));
  author_name text := nullif(btrim(coalesce(p_payload->>'displayName',''), E' \t\n\r'),'');
  title text := btrim(coalesce(p_payload->>'title',''));
begin
  if p_capability_hash is null or p_capability_hash !~ '^[a-f0-9]{64}$' or p_abuse_hash is null or p_abuse_hash !~ '^[a-f0-9]{64}$' or p_request_id is null
    or p_payload is null or jsonb_typeof(p_payload)<>'object' or p_action not in ('create','reply','edit','delete','report') or p_action is null then
    return jsonb_build_object('status',400);
  end if;
  input_hash:=encode(sha256(convert_to(jsonb_build_object('action',p_action,'payload',p_payload)::text,'UTF8')),'hex');
  perform pg_advisory_xact_lock(hashtextextended(p_request_id::text,0));
  select * into old_receipt from quizeey_private.mutation_receipts r where r.request_id=p_request_id;
  if found then
    if old_receipt.capability_hash<>p_capability_hash or old_receipt.input_hash<>input_hash then return jsonb_build_object('status',409); end if;
    return old_receipt.result;
  end if;
  if not quizeey_private.consume_rate('guest:'||p_capability_hash,10) then return jsonb_build_object('status',429); end if;
  if not quizeey_private.consume_rate('abuse:'||p_abuse_hash,30) then return jsonb_build_object('status',429); end if;
  if char_length(author_name)>80 or char_length(v_body)>4000 or char_length(title)>120 or octet_length(v_body)>16000 then return jsonb_build_object('status',400); end if;

  if p_action in ('create','reply') then
    if v_body='' then return jsonb_build_object('status',400); end if;
    if exists(select 1 from quizeey_private.guest_capabilities where capability_hash=p_capability_hash and expires_at<=now()) then return jsonb_build_object('status',403); end if;
    if p_action='create' then
      if coalesce(p_payload->>'examId','') !~ '^[1-9][0-9]{0,18}$' or coalesce(p_payload->>'locale','') not in ('ko','en') or title='' or
        (p_payload->>'questionId' is not null and p_payload->>'questionId' !~ '^[1-9][0-9]{0,18}$') then return jsonb_build_object('status',400); end if;
      insert into public.quizeey_topics(exam_id,question_id,locale,title) values(p_payload->>'examId',p_payload->>'questionId',p_payload->>'locale',title) returning id into v_topic_id;
    else
      begin v_topic_id:=(p_payload->>'topicId')::uuid; v_parent_id:=(p_payload->>'parentId')::uuid;
      exception when invalid_text_representation then return jsonb_build_object('status',400); end;
      select * into topic from public.quizeey_topics where id=v_topic_id for update;
      if not found or topic.visibility<>'approved' or topic.locked then return jsonb_build_object('status',403); end if;
      if v_parent_id is not null and not exists(select 1 from public.quizeey_posts where id=v_parent_id and topic_id=topic.id and visibility='approved') then return jsonb_build_object('status',404); end if;
    end if;
    insert into quizeey_private.guest_capabilities(capability_hash,expires_at) values(p_capability_hash,now()+interval '90 days')
      on conflict(capability_hash) do nothing;
    if not exists(select 1 from quizeey_private.guest_capabilities where capability_hash=p_capability_hash and expires_at>now()) then return jsonb_build_object('status',403); end if;
    insert into public.quizeey_posts(topic_id,parent_id,display_name,body) values(v_topic_id,v_parent_id,author_name,v_body) returning id into v_post_id;
    insert into quizeey_private.post_owners(post_id,capability_hash) values(v_post_id,p_capability_hash);
    result:=jsonb_build_object('status',202,'postId',v_post_id,'topicId',v_topic_id,'visibility','pending');
  else
    begin v_post_id:=(p_payload->>'postId')::uuid;
    exception when invalid_text_representation then return jsonb_build_object('status',400); end;
    select * into post from public.quizeey_posts where id=v_post_id for update;
    if not found then return jsonb_build_object('status',404); end if;
    if p_action='report' then
      if post.visibility<>'approved' then return jsonb_build_object('status',404); end if;
      if char_length(btrim(coalesce(p_payload->>'reason',''))) not between 1 and 500 then return jsonb_build_object('status',400); end if;
      insert into quizeey_private.forum_reports(post_id,reason) values(v_post_id,btrim(p_payload->>'reason'));
      result:=jsonb_build_object('status',202);
    else
      if not exists(select 1 from quizeey_private.post_owners o join quizeey_private.guest_capabilities c using(capability_hash) where o.post_id=v_post_id and c.capability_hash=p_capability_hash and c.expires_at>now()) then return jsonb_build_object('status',403); end if;
      if post.visibility not in ('pending','approved') then return jsonb_build_object('status',403); end if;
      if p_action='edit' then
        if v_body='' then return jsonb_build_object('status',400); end if;
        if post.visibility='approved' then
          insert into quizeey_private.post_revisions(post_id,display_name,body) values(v_post_id,author_name,v_body) returning id into v_revision_id;
          result:=jsonb_build_object('status',202,'revisionId',v_revision_id,'visibility','pending');
        else
          update public.quizeey_posts set body=v_body,display_name=author_name,updated_at=now() where id=v_post_id;
          result:=jsonb_build_object('status',202,'postId',v_post_id,'visibility','pending');
        end if;
      elsif p_action='delete' then
        update public.quizeey_posts set visibility='deleted',body='',display_name=null,updated_at=now() where id=v_post_id;
        if post.visibility='approved' then update public.quizeey_topics set approved_post_count=approved_post_count-1 where id=post.topic_id; end if;
        result:=jsonb_build_object('status',200);
      end if;
    end if;
  end if;
  insert into quizeey_private.mutation_receipts(capability_hash,request_id,input_hash,result) values(p_capability_hash,p_request_id,input_hash,result);
  return result;
end $$;
revoke all on function public.quizeey_forum_mutate(text,text,uuid,text,jsonb) from public,anon,authenticated;
grant execute on function public.quizeey_forum_mutate(text,text,uuid,text,jsonb) to service_role;

-- This is a privileged transport endpoint, not admin authentication.
-- The server must verify the admin session and target allowlist BEFORE calling it.
create function public.quizeey_forum_moderate(p_action text,p_id uuid) returns jsonb
language plpgsql security definer set search_path='' as $$
declare post public.quizeey_posts%rowtype; revision quizeey_private.post_revisions%rowtype;
begin
  if p_action='approve_revision' then
    select * into revision from quizeey_private.post_revisions where id=p_id for update;
    if not found or revision.visibility<>'pending' then return jsonb_build_object('status',404); end if;
    select * into post from public.quizeey_posts where id=revision.post_id for update;
    if post.visibility<>'approved' then return jsonb_build_object('status',409); end if;
    update public.quizeey_posts set body=revision.body,display_name=revision.display_name,updated_at=now() where id=post.id;
    update quizeey_private.post_revisions set visibility='approved' where id=p_id;
  elsif p_action='lock' then
    update public.quizeey_topics set locked=true where id=p_id;
    if not found then return jsonb_build_object('status',404); end if;
  elsif p_action in ('approve','hide','delete') then
    select * into post from public.quizeey_posts where id=p_id for update;
    if not found then return jsonb_build_object('status',404); end if;
    if p_action='approve' then
      if post.visibility='deleted' then return jsonb_build_object('status',409); end if;
      if post.parent_id is not null and not exists(select 1 from public.quizeey_posts where id=post.parent_id and visibility='approved') then return jsonb_build_object('status',409); end if;
      if post.visibility<>'approved' then
        update public.quizeey_posts set visibility='approved',updated_at=now() where id=p_id;
        update public.quizeey_topics set visibility='approved',approved_post_count=approved_post_count+1 where id=post.topic_id;
      end if;
    else
      update public.quizeey_posts set visibility=case when p_action='hide' then 'hidden' else 'deleted' end,updated_at=now() where id=p_id;
      if post.visibility='approved' then update public.quizeey_topics set approved_post_count=approved_post_count-1 where id=post.topic_id; end if;
    end if;
  else return jsonb_build_object('status',400);
  end if;
  return jsonb_build_object('status',200);
end $$;
revoke all on function public.quizeey_forum_moderate(text,uuid) from public,anon,authenticated;
grant execute on function public.quizeey_forum_moderate(text,uuid) to service_role;

create function public.quizeey_forum_cleanup() returns void language sql security definer set search_path='' as $$
  delete from quizeey_private.rate_windows where expires_at<now();
  delete from quizeey_private.mutation_receipts where expires_at<now();
  delete from quizeey_private.forum_reports where expires_at<now();
$$;
revoke all on function public.quizeey_forum_cleanup() from public,anon,authenticated;
grant execute on function public.quizeey_forum_cleanup() to service_role;

-- Source: 202610160003_guest_private_preview.sql
create function public.quizeey_forum_mine(p_capability_hash text) returns jsonb
language sql stable security definer set search_path='' as $$
  select coalesce(jsonb_agg(to_jsonb(owned)), '[]'::jsonb) from (
    select p.id,p.topic_id,p.parent_id,p.display_name,p.body,p.visibility,p.created_at,p.updated_at,
      t.exam_id,t.question_id,t.locale,t.title,
      revision.id as pending_revision_id,revision.body as pending_body
    from quizeey_private.post_owners o
    join quizeey_private.guest_capabilities c using(capability_hash)
    join public.quizeey_posts p on p.id=o.post_id
    join public.quizeey_topics t on t.id=p.topic_id
    left join lateral (select r.id,r.body from quizeey_private.post_revisions r where r.post_id=p.id and r.visibility='pending' order by r.created_at desc,r.id limit 1) revision on true
    where c.capability_hash=p_capability_hash and c.expires_at>now() and p.visibility in ('pending','approved')
    order by p.created_at desc,p.id limit 20
  ) owned;
$$;
revoke all on function public.quizeey_forum_mine(text) from public,anon,authenticated;
grant execute on function public.quizeey_forum_mine(text) to service_role;

-- Source: 202610160004_admin_moderation.sql
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

-- Source: 202610160006_exam_content.sql
-- New service content, loaded only from the owner-approved filtered dataset.
-- NOT a publication migration. Access remains closed until hosted verification.

create schema quizeey_content;
revoke all on schema quizeey_content from public, anon, authenticated, service_role;
create table quizeey_content.exams (
  exam_id bigint generated by default as identity primary key,
  name_ko varchar(500), name_en varchar(500), legacy_slug varchar(100) not null,
  priority integer not null, created_at timestamptz not null, modified_at timestamptz not null
);
create table quizeey_content.versions (
  version_id bigint generated by default as identity primary key,
  exam_id bigint not null references quizeey_content.exams(exam_id),
  number integer not null, name varchar(500) not null,
  created_at timestamptz not null, modified_at timestamptz not null,
  unique(exam_id,number)
);
create table quizeey_content.questions (
  question_id bigint generated by default as identity primary key,
  version_id bigint not null references quizeey_content.versions(version_id),
  number integer not null, body varchar(2000) not null,
  explanation varchar(4000), reference varchar(1000), multiple_answers boolean not null,
  created_at timestamptz not null, modified_at timestamptz not null,
  unique(version_id,number)
);
create table quizeey_content.choices (
  choice_id bigint generated by default as identity primary key,
  question_id bigint not null references quizeey_content.questions(question_id),
  number integer not null, body varchar(1000) not null, correct boolean not null,
  created_at timestamptz not null, modified_at timestamptz not null,
  unique(question_id,number)
);
create table quizeey_content.legacy_counters (
  question_id bigint primary key references quizeey_content.questions(question_id),
  correct integer not null check(correct>=0), incorrect integer not null check(incorrect>=0),
  created_at timestamptz not null, modified_at timestamptz not null
);
-- Unique/FK indexes also support version/question/choice lookup. No visitor writes.
do $$ declare name text; begin
  foreach name in array array['exams','versions','questions','choices','legacy_counters'] loop
    execute format('alter table quizeey_content.%I enable row level security', name);
    execute format('alter table quizeey_content.%I force row level security', name);
    execute format('revoke all on quizeey_content.%I from public, anon, authenticated, service_role', name);
  end loop;
end $$;
revoke all on all sequences in schema quizeey_content from public, anon, authenticated, service_role;
alter default privileges in schema quizeey_content revoke all on tables from public, anon, authenticated, service_role;
alter default privileges in schema quizeey_content revoke all on sequences from public, anon, authenticated, service_role;
comment on schema quizeey_content is 'Private new-service content. Source IDs retained; 751 reviewed source questions excluded by owner. No public access/production import authorized by this migration.';

-- Source: 20261016233418_private_rpc_boundary.sql
-- Locally rehearsed hardening; cloud application requires a separate change request.
-- Only invoker wrappers live in the exposed public schema. Service credentials are
-- a server trust boundary, not an Auth user: requireAdmin must verify actor/session
-- before an admin RPC. Visitors never receive these credentials or schema access.

grant usage on schema quizeey_private to service_role;

do $$
declare name text; fn record; placeholders text; volatility text;
begin
  foreach name in array array[
    'quizeey_forum_mutate','quizeey_forum_moderate','quizeey_forum_cleanup','quizeey_forum_mine',
    'quizeey_admin_session_create','quizeey_admin_session_actor','quizeey_admin_session_revoke',
    'quizeey_admin_login_limit','quizeey_admin_queue','quizeey_admin_moderate'
  ] loop
    select p.oid,pg_get_function_identity_arguments(p.oid) as signature,
      pg_get_function_arguments(p.oid) as arguments,pg_get_function_result(p.oid) as result,
      p.pronargs,p.provolatile into strict fn
      from pg_proc p join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public' and p.proname=name and p.prosecdef;
    select string_agg('$'||i,',' order by i) into placeholders from generate_series(1,fn.pronargs) i;
    volatility:=case fn.provolatile when 's' then 'stable' when 'i' then 'immutable' else 'volatile' end;
    execute format('alter function public.%I(%s) set schema quizeey_private',name,fn.signature);
    execute format('create function public.%I(%s) returns %s language sql %s security invoker set search_path='''' as %L',
      name,fn.arguments,fn.result,volatility,'select quizeey_private.'||quote_ident(name)||'('||coalesce(placeholders,'')||')');
    execute format('revoke all on function public.%I(%s) from public,anon,authenticated,service_role',name,fn.signature);
    execute format('revoke all on function quizeey_private.%I(%s) from public,anon,authenticated,service_role',name,fn.signature);
    -- The low-level moderator is owner-only; server callers must use audited admin RPC.
    if name<>'quizeey_forum_moderate' then
      execute format('grant execute on function public.%I(%s) to service_role',name,fn.signature);
      execute format('grant execute on function quizeey_private.%I(%s) to service_role',name,fn.signature);
    end if;
  end loop;
end $$;

-- The original consume_rate helper stays owner-only, despite service schema USAGE.
revoke all on function quizeey_private.consume_rate(text,integer) from public,anon,authenticated,service_role;
comment on schema quizeey_private is 'Unexposed server implementation and private tables. Service role has USAGE and explicit RPC EXECUTE only; no direct table access. Never add this schema to Data API exposed schemas.';

do $$ begin
  if exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid
    where n.nspname='public' and p.proname like 'quizeey_%' and p.prosecdef) then
    raise exception 'Exposed SECURITY DEFINER remains';
  end if;
  if (select count(*) from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r'
    and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')))<>15 then
    raise exception 'Unexpected application table inventory';
  end if;
end $$;
notify pgrst, 'reload schema';
commit;
