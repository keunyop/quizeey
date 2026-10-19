-- Immediate publication; public reads remain subject to grants and RLS.
begin;
set local lock_timeout='5s';
set local statement_timeout='60s';
create or replace function quizeey_private.quizeey_forum_mutate(p_capability_hash text,p_abuse_hash text,p_request_id uuid,p_action text,p_payload jsonb)
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
      insert into public.quizeey_topics(exam_id,question_id,locale,title,visibility,approved_post_count) values(p_payload->>'examId',p_payload->>'questionId',p_payload->>'locale',title,'approved',1) returning id into v_topic_id;
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
    insert into public.quizeey_posts(topic_id,parent_id,display_name,body,visibility) values(v_topic_id,v_parent_id,author_name,v_body,'approved') returning id into v_post_id;
    insert into quizeey_private.post_owners(post_id,capability_hash) values(v_post_id,p_capability_hash);
    if p_action='reply' then update public.quizeey_topics set approved_post_count=approved_post_count+1 where id=v_topic_id; end if;
    -- Preserve accepted-write status for already deployed servers that issue the
    -- ownership cookie only on 202. The approved visibility is immediate.
    result:=jsonb_build_object('status',202,'postId',v_post_id,'topicId',v_topic_id,'visibility','approved');
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
        if post.visibility<>'approved' then return jsonb_build_object('status',403); end if;
        update public.quizeey_posts set body=v_body,display_name=author_name,updated_at=now() where id=v_post_id;
        update quizeey_private.post_revisions set visibility='rejected' where post_id=v_post_id and visibility='pending';
        result:=jsonb_build_object('status',200,'postId',v_post_id,'visibility','approved');
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

-- Keep server writes behind the existing invoker wrapper and private capability checks.
revoke all on function quizeey_private.quizeey_forum_mutate(text,text,uuid,text,jsonb) from public,anon,authenticated;
grant execute on function quizeey_private.quizeey_forum_mutate(text,text,uuid,text,jsonb) to service_role;

create index quizeey_topics_public_context_idx
  on public.quizeey_topics(exam_id,question_id,locale,id)
  where visibility='approved' and approved_post_count>0;
create index quizeey_posts_public_page_idx
  on public.quizeey_posts(created_at desc,id desc) include(topic_id)
  where visibility='approved';

-- Each row is a comment (including replies), so one large thread cannot evade
-- the page bound. Microsecond timestamp + UUID give a stable, complete cursor.
create function public.quizeey_forum_page(
  p_exam_id text,p_locale text,p_question_id text,
  p_cursor_time timestamptz,p_cursor_id uuid
) returns jsonb language plpgsql stable security invoker set search_path='' as $page$
begin
  if p_exam_id is null or p_exam_id !~ '^[1-9][0-9]{0,18}$'
    or p_locale is null or p_locale not in ('ko','en')
    or (p_question_id is not null and p_question_id !~ '^[1-9][0-9]{0,18}$')
    or (p_cursor_time is null)<>(p_cursor_id is null)
    or (p_cursor_time is not null and not isfinite(p_cursor_time)) then
    raise exception 'Invalid comment page' using errcode='22023';
  end if;
  return (
    with selected as materialized (
      select p.id,p.topic_id,p.parent_id,p.display_name,p.body,p.created_at,
        t.title,t.locale,t.created_at as topic_created_at
      from public.quizeey_topics t join public.quizeey_posts p on p.topic_id=t.id
      where t.exam_id=p_exam_id and t.question_id is not distinct from p_question_id
        and (t.locale=p_locale or (p_question_id is not null and t.source_thread_id='mysql:question:'||p_question_id))
        and t.visibility='approved' and t.approved_post_count>0 and p.visibility='approved'
        and (p_cursor_time is null or (p.created_at,p.id)<(p_cursor_time,p_cursor_id))
      order by p.created_at desc,p.id desc limit 11
    ), page as materialized (
      select * from selected order by created_at desc,id desc limit 10
    ), topics as (
      select distinct topic_id as id,title,locale,topic_created_at as created_at from page
    )
    select jsonb_build_object(
      'topics',coalesce((select jsonb_agg(to_jsonb(t) order by t.id) from topics t),'[]'::jsonb),
      'posts',coalesce((select jsonb_agg(jsonb_build_object('id',p.id,'topic_id',p.topic_id,
        'parent_id',p.parent_id,'display_name',p.display_name,'body',p.body,'created_at',p.created_at)
        order by p.created_at desc,p.id desc) from page p),'[]'::jsonb),
      'next',case when (select count(*) from selected)>10 then
        (select jsonb_build_object('createdAt',created_at,'id',id) from page order by created_at,id limit 1)
        else null end)
  );
end;
$page$;
revoke all on function public.quizeey_forum_page(text,text,text,timestamptz,uuid) from public,anon,authenticated,service_role;
grant execute on function public.quizeey_forum_page(text,text,text,timestamptz,uuid) to anon,authenticated;

-- Resolve ownership for only the ten visible IDs, including older pages.
create function quizeey_private.quizeey_forum_owned(p_capability_hash text,p_post_ids uuid[])
returns jsonb language sql stable security definer set search_path='' as $owned$
  select coalesce(jsonb_agg(to_jsonb(owned)),'[]'::jsonb) from (
    select p.id,p.topic_id,p.parent_id,p.display_name,p.body,p.visibility,p.created_at,
      t.exam_id,t.question_id,t.locale,t.title,null::text as pending_body
    from quizeey_private.post_owners o
    join quizeey_private.guest_capabilities c using(capability_hash)
    join public.quizeey_posts p on p.id=o.post_id
    join public.quizeey_topics t on t.id=p.topic_id
    where c.capability_hash=p_capability_hash and c.expires_at>now()
      and p.id=any(p_post_ids) and cardinality(p_post_ids) between 1 and 10
      and p.visibility='approved'
    order by p.created_at desc,p.id desc limit 10
  ) owned;
$owned$;
revoke all on function quizeey_private.quizeey_forum_owned(text,uuid[]) from public,anon,authenticated,service_role;
grant execute on function quizeey_private.quizeey_forum_owned(text,uuid[]) to service_role;
create function public.quizeey_forum_owned(p_capability_hash text,p_post_ids uuid[])
returns jsonb language sql stable security invoker set search_path='' as $owned$
  select quizeey_private.quizeey_forum_owned(p_capability_hash,p_post_ids);
$owned$;
revoke all on function public.quizeey_forum_owned(text,uuid[]) from public,anon,authenticated,service_role;
grant execute on function public.quizeey_forum_owned(text,uuid[]) to service_role;

-- Existing ordinary pending comments follow the new publication policy.
-- Imported, hidden, deleted and locked discussions remain untouched.
with recursive eligible as (
  select p.id,p.topic_id from public.quizeey_posts p join public.quizeey_topics t on t.id=p.topic_id
  where p.visibility='pending' and p.source_post_id is null and t.source_thread_id is null
    and t.visibility in ('pending','approved') and not t.locked
    and (p.parent_id is null or exists(select 1 from public.quizeey_posts parent
      where parent.id=p.parent_id and parent.topic_id=p.topic_id and parent.visibility='approved'))
  union
  select p.id,p.topic_id from public.quizeey_posts p join eligible parent
    on parent.id=p.parent_id and parent.topic_id=p.topic_id
  where p.visibility='pending' and p.source_post_id is null
), published as (
  update public.quizeey_posts p set visibility='approved'
    where p.id in (select id from eligible) returning p.topic_id
), counts as (
  select topic_id,count(*) as amount from published group by topic_id
)
update public.quizeey_topics t set visibility='approved',approved_post_count=t.approved_post_count+c.amount
  from counts c where t.id=c.topic_id;

notify pgrst,'reload schema';
commit;
