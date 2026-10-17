-- New native forum design. Apply only to a VERIFIED Quizeey target after rehearsal.
-- Legacy context IDs intentionally have no guessed foreign keys into the unverified archive.
begin;
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
commit;
