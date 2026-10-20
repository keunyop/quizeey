begin;
create table quizeey_private.operator_credentials (
  username text primary key,
  actor_id uuid not null unique,
  salt text not null check (salt ~ '^[a-f0-9]{32}$'),
  password_hash text not null check (password_hash ~ '^[a-f0-9]{128}$')
);
-- Initial owner-requested account. Passwords are derived with Node scrypt;
-- neither this record nor password hashes are exposed to browser clients.
insert into quizeey_private.operator_credentials values
  ('admin','00000000-0000-4000-8000-000000000001','5e69e87b89c66bcccd3900c425f08031','ce345557e6411d291af957ae71b6a72477249f89046d5b87e7532e49a8fd39532d2e6a125683349193550e91fe3cae1e94359fd2a66cf9cfaaee84f414aba6cf');

create table quizeey_private.visitor_submissions (
  id uuid primary key,
  request_hash text not null,
  kind text not null check (kind in ('feedback','question_report')),
  locale text not null check (locale in ('ko','en')),
  path text not null check (path ~ '^/[a-zA-Z0-9/_-]*$' and length(path)<=200),
  exam_id text,
  question_id text,
  body text not null check (length(btrim(body)) between 1 and 4000),
  state text not null default 'open' check (state in ('open','resolved')),
  created_at timestamptz not null default now(),
  resolved_at timestamptz,
  resolved_by uuid,
  check (kind<>'question_report' or (exam_id is not null and question_id is not null)),
  check (exam_id is null or (exam_id ~ '^[1-9][0-9]{0,18}$' and exam_id::numeric<=9223372036854775807)),
  check (question_id is null or (question_id ~ '^[1-9][0-9]{0,18}$' and question_id::numeric<=9223372036854775807))
);
create index visitor_submissions_inbox_idx on quizeey_private.visitor_submissions(kind,created_at desc,id desc);
create index visitor_submissions_open_idx on quizeey_private.visitor_submissions(kind,state) where state='open';
create index quizeey_posts_latest_admin_idx on public.quizeey_posts(created_at desc,id desc) where visibility<>'deleted';
alter table quizeey_private.operator_credentials enable row level security;
alter table quizeey_private.operator_credentials force row level security;
alter table quizeey_private.visitor_submissions enable row level security;
alter table quizeey_private.visitor_submissions force row level security;
revoke all on quizeey_private.operator_credentials,quizeey_private.visitor_submissions from public,anon,authenticated,service_role;

create function quizeey_private.quizeey_admin_credential(p_username text)
returns jsonb language sql stable security definer set search_path='' as $$
  select jsonb_build_object('actor_id',actor_id,'salt',salt,'password_hash',password_hash)
    from quizeey_private.operator_credentials where username=p_username and length(p_username)<=80;
$$;

create function quizeey_private.quizeey_submit_feedback(p_request_id uuid,p_abuse_hash text,p_payload jsonb)
returns jsonb language plpgsql security definer set search_path='' as $$
declare fingerprint text; previous text;
begin
  if p_request_id is null or p_abuse_hash is null or p_abuse_hash !~ '^[a-f0-9]{64}$'
    or p_payload is null or jsonb_typeof(p_payload)<>'object'
    or coalesce(p_payload->>'kind','') not in ('feedback','question_report')
    or coalesce(p_payload->>'locale','') not in ('ko','en')
    or coalesce(p_payload->>'path','') !~ '^/[a-zA-Z0-9/_-]*$' or length(p_payload->>'path')>200
    or coalesce(length(btrim(p_payload->>'body')),0) not between 1 and 4000
    or (p_payload->>'kind'='question_report' and (p_payload->>'examId' is null or p_payload->>'questionId' is null)) then
    return jsonb_build_object('status',400);
  end if;
  fingerprint:=encode(sha256(convert_to(p_abuse_hash||p_payload::text,'UTF8')),'hex');
  perform pg_advisory_xact_lock(hashtextextended(p_request_id::text,0));
  select request_hash into previous from quizeey_private.visitor_submissions where id=p_request_id;
  if found then return jsonb_build_object('status',case when previous=fingerprint then 201 else 409 end); end if;
  if not quizeey_private.consume_rate('submission:'||p_abuse_hash,10) then return jsonb_build_object('status',429); end if;
  insert into quizeey_private.visitor_submissions(id,request_hash,kind,locale,path,exam_id,question_id,body)
    values(p_request_id,fingerprint,p_payload->>'kind',p_payload->>'locale',p_payload->>'path',p_payload->>'examId',p_payload->>'questionId',p_payload->>'body');
  return jsonb_build_object('status',201);
end;
$$;

create function quizeey_private.quizeey_admin_overview()
returns jsonb language sql stable security definer set search_path='' as $$
  select jsonb_build_object(
    'feedback_open',(select count(*) from quizeey_private.visitor_submissions where kind='feedback' and state='open'),
    'question_reports_open',(select count(*) from quizeey_private.visitor_submissions where kind='question_report' and state='open'),
    'comments',(select count(*) from public.quizeey_posts where visibility<>'deleted'),
    'comment_reports_open',(select count(*) from quizeey_private.forum_reports where state='open'),
    'clicks',(select coalesce(jsonb_object_agg(exam_id,click_count::text),'{}'::jsonb) from quizeey_private.exam_clicks),
    'activity',(select coalesce(jsonb_agg(to_jsonb(a) order by a.created_at desc),'[]'::jsonb) from
      (select action,created_at from quizeey_private.moderation_audit order by created_at desc,request_id desc limit 10) a));
$$;

create function quizeey_private.quizeey_admin_inbox(p_kind text,p_state text,p_cursor_time timestamptz,p_cursor_id uuid)
returns jsonb language plpgsql stable security definer set search_path='' as $$
begin
  if p_kind is null or p_kind not in ('comments','feedback','question_report')
    or p_state is null or p_state not in ('all','open','resolved')
    or (p_cursor_time is null)<>(p_cursor_id is null)
    or (p_cursor_time is not null and not isfinite(p_cursor_time)) then
    raise exception 'Invalid inbox query' using errcode='22023';
  end if;
  if p_kind='comments' then
    return (select coalesce(jsonb_agg(to_jsonb(q) order by q.created_at desc,q.id desc),'[]'::jsonb) from (
      select p.id,p.body,p.created_at,t.locale,t.exam_id,t.question_id,null::text as path,p.visibility as state,p.display_name
        from public.quizeey_posts p join public.quizeey_topics t on t.id=p.topic_id
        where p.visibility<>'deleted' and (p_cursor_time is null or (p.created_at,p.id)<(p_cursor_time,p_cursor_id))
        order by p.created_at desc,p.id desc limit 21) q);
  end if;
  return (select coalesce(jsonb_agg(to_jsonb(q) order by q.created_at desc,q.id desc),'[]'::jsonb) from (
    select id,body,created_at,locale,exam_id,question_id,path,state,null::text as display_name
      from quizeey_private.visitor_submissions where kind=p_kind and (p_state='all' or state=p_state)
        and (p_cursor_time is null or (created_at,id)<(p_cursor_time,p_cursor_id))
      order by created_at desc,id desc limit 21) q);
end;
$$;

create function quizeey_private.quizeey_admin_resolve_submission(p_actor_id uuid,p_request_id uuid,p_id uuid,p_state text)
returns jsonb language plpgsql security definer set search_path='' as $$
declare previous quizeey_private.moderation_audit%rowtype;
begin
  if p_actor_id is null or p_request_id is null or p_id is null or p_state is null or p_state not in ('open','resolved') then return jsonb_build_object('status',400); end if;
  perform pg_advisory_xact_lock(hashtextextended(p_request_id::text,0));
  select * into previous from quizeey_private.moderation_audit where request_id=p_request_id;
  if found then
    return case when previous.actor_id=p_actor_id and previous.target_id=p_id and previous.action='submission_'||p_state
      then previous.result else jsonb_build_object('status',409) end;
  end if;
  update quizeey_private.visitor_submissions set state=p_state,
    resolved_at=case when p_state='resolved' then now() else null end,
    resolved_by=case when p_state='resolved' then p_actor_id else null end where id=p_id;
  if not found then return jsonb_build_object('status',404); end if;
  insert into quizeey_private.moderation_audit(request_id,actor_id,action,target_id,result)
    values(p_request_id,p_actor_id,'submission_'||p_state,p_id,jsonb_build_object('status',200));
  return jsonb_build_object('status',200);
end;
$$;

create function public.quizeey_admin_credential(p_username text) returns jsonb language sql stable security invoker set search_path='' as $$ select quizeey_private.quizeey_admin_credential(p_username); $$;
create function public.quizeey_submit_feedback(p_request_id uuid,p_abuse_hash text,p_payload jsonb) returns jsonb language sql security invoker set search_path='' as $$ select quizeey_private.quizeey_submit_feedback(p_request_id,p_abuse_hash,p_payload); $$;
create function public.quizeey_admin_overview() returns jsonb language sql stable security invoker set search_path='' as $$ select quizeey_private.quizeey_admin_overview(); $$;
create function public.quizeey_admin_inbox(p_kind text,p_state text,p_cursor_time timestamptz,p_cursor_id uuid) returns jsonb language sql stable security invoker set search_path='' as $$ select quizeey_private.quizeey_admin_inbox(p_kind,p_state,p_cursor_time,p_cursor_id); $$;
create function public.quizeey_admin_resolve_submission(p_actor_id uuid,p_request_id uuid,p_id uuid,p_state text) returns jsonb language sql security invoker set search_path='' as $$ select quizeey_private.quizeey_admin_resolve_submission(p_actor_id,p_request_id,p_id,p_state); $$;

do $$ declare signature text; begin
  foreach signature in array array['quizeey_admin_credential(text)','quizeey_submit_feedback(uuid,text,jsonb)',
    'quizeey_admin_overview()','quizeey_admin_inbox(text,text,timestamptz,uuid)','quizeey_admin_resolve_submission(uuid,uuid,uuid,text)'] loop
    execute 'revoke all on function quizeey_private.'||signature||' from public,anon,authenticated,service_role';
    execute 'revoke all on function public.'||signature||' from public,anon,authenticated,service_role';
    execute 'grant execute on function quizeey_private.'||signature||' to service_role';
    execute 'grant execute on function public.'||signature||' to service_role';
  end loop;
end $$;
notify pgrst,'reload schema';
commit;
