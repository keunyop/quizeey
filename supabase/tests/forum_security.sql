\set ON_ERROR_STOP on
-- Run only through tools/modernization/test_database.py in the isolated fixture cluster.
create function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;

do $$ declare result jsonb; second jsonb; pid uuid; tid uuid; rid uuid; i integer;
  cap text:=repeat('a',64); abuse text:=repeat('d',64);
  payload jsonb:='{"examId":"5","locale":"ko","title":"Synthetic discussion","body":"Original public text","displayName":"  \t  "}';
begin
  result:=public.quizeey_forum_mutate(cap,abuse,'00000000-0000-4000-8000-000000000001','create',payload);
  perform pg_temp.assert_true((result->>'status')::int=202 and result->>'visibility'='approved','signup-free create is public immediately');
  pid:=(result->>'postId')::uuid; tid:=(result->>'topicId')::uuid;
  perform set_config('quizeey.test_post',pid::text,false);
  perform set_config('quizeey.test_topic',tid::text,false);
  perform pg_temp.assert_true((select display_name is null from public.quizeey_posts where id=pid),'blank optional name');
  second:=public.quizeey_forum_mutate(cap,abuse,'00000000-0000-4000-8000-000000000001','create',payload);
  perform pg_temp.assert_true(result=second and (select count(*)=1 from public.quizeey_posts),'idempotent create');
  second:=public.quizeey_forum_mutate(cap,abuse,'00000000-0000-4000-8000-000000000001','create',payload||'{"body":"changed"}');
  perform pg_temp.assert_true((second->>'status')::int=409,'idempotency key cannot change payload');
  second:=public.quizeey_forum_mutate(repeat('b',64),abuse,gen_random_uuid(),'edit',jsonb_build_object('postId',pid,'body','Attack','displayName','same name'));
  perform pg_temp.assert_true((second->>'status')::int=403,'guest B cannot edit A by matching name');
  second:=public.quizeey_forum_mutate(repeat('b',64),abuse,gen_random_uuid(),'delete',jsonb_build_object('postId',pid));
  perform pg_temp.assert_true((second->>'status')::int=403,'missing/different cookie cannot delete');
end $$;

set role anon;
select pg_temp.assert_true((select count(*)=1 from public.quizeey_posts),'created post visible to anon');
select pg_temp.assert_true((select count(*)=1 from public.quizeey_topics),'created topic visible to anon');
do $$ begin
  begin insert into public.quizeey_topics(exam_id,locale,title) values('5','ko','Forbidden'); raise exception 'public insert allowed'; exception when insufficient_privilege then null; end;
  begin update public.quizeey_posts set body='Forbidden'; raise exception 'public update allowed'; exception when insufficient_privilege then null; end;
  begin delete from public.quizeey_posts; raise exception 'public delete allowed'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.guest_capabilities; raise exception 'private hashes exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_forum_moderate('approve',current_setting('quizeey.test_post')::uuid); raise exception 'public moderator allowed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_forum_mutate(repeat('a',64),repeat('d',64),gen_random_uuid(),'create','{}'); raise exception 'direct public write RPC allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role authenticated;
select pg_temp.assert_true((select count(*)=1 from public.quizeey_posts),'authenticated reader sees published comment');
do $$ begin
  begin perform public.quizeey_forum_moderate('approve',current_setting('quizeey.test_post')::uuid); raise exception 'ordinary auth moderator allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;

set role service_role;
select pg_temp.assert_true((public.quizeey_admin_moderate('00000000-0000-4000-8000-000000000103',gen_random_uuid(),'approve',current_setting('quizeey.test_post')::uuid)->>'status')::int=200,'privileged audited moderation transport');
reset role;
set role anon;
select pg_temp.assert_true((select count(*)=1 from public.quizeey_posts),'approved post public');
select pg_temp.assert_true((select approved_post_count=1 from public.quizeey_topics),'atomic approved count');
reset role;

do $$ declare result jsonb; pid uuid:=current_setting('quizeey.test_post')::uuid; tid uuid:=current_setting('quizeey.test_topic')::uuid; revision_id uuid; imported_id uuid; i integer;
begin
  result:=public.quizeey_forum_mutate(repeat('a',64),repeat('d',64),gen_random_uuid(),'edit',jsonb_build_object('postId',pid,'body','Pending private edit'));
  perform pg_temp.assert_true((result->>'status')::int=200 and result->>'visibility'='approved','edit publishes immediately');
  perform pg_temp.assert_true((select body='Pending private edit' from public.quizeey_posts where id=pid),'edited body immediately visible');
  perform pg_temp.assert_true(not exists(select 1 from quizeey_private.post_revisions where post_id=pid and visibility='pending'),'no pending revision created');
  result:=public.quizeey_forum_mutate(repeat('b',64),repeat('d',64),gen_random_uuid(),'reply',jsonb_build_object('topicId',tid,'parentId',pid,'body','Pending reply'));
  perform pg_temp.assert_true((result->>'status')::int=202 and result->>'visibility'='approved','reply is public with parent');
  perform pg_temp.assert_true((select parent_id=pid from public.quizeey_posts where id=(result->>'postId')::uuid),'parent preserved');
  insert into public.quizeey_posts(topic_id,body,source_post_id) values(tid,'Imported historical author','disqus-fixture-1') returning id into imported_id;
  result:=public.quizeey_forum_mutate(repeat('a',64),repeat('d',64),gen_random_uuid(),'edit',jsonb_build_object('postId',imported_id,'body','Claim history'));
  perform pg_temp.assert_true((result->>'status')::int=403,'imported author never auto-claimed');
  update quizeey_private.guest_capabilities set expires_at=now()-interval '1 second' where capability_hash=repeat('a',64);
  result:=public.quizeey_forum_mutate(repeat('a',64),repeat('d',64),gen_random_uuid(),'delete',jsonb_build_object('postId',pid));
  perform pg_temp.assert_true((result->>'status')::int=403,'expired cookie cannot delete');
  update quizeey_private.guest_capabilities set expires_at=now()+interval '1 day' where capability_hash=repeat('a',64);
  result:=public.quizeey_forum_mutate(repeat('a',64),repeat('d',64),gen_random_uuid(),'report',jsonb_build_object('postId',pid,'reason','Synthetic report'));
  perform pg_temp.assert_true((result->>'status')::int=202,'reports private');
  perform public.quizeey_forum_moderate('hide',pid);
  perform pg_temp.assert_true((select approved_post_count=1 from public.quizeey_topics where id=tid),'takedown preserves approved reply count');
  perform public.quizeey_forum_moderate('lock',tid);
  result:=public.quizeey_forum_mutate(repeat('b',64),repeat('d',64),gen_random_uuid(),'reply',jsonb_build_object('topicId',tid,'body','Locked reply'));
  perform pg_temp.assert_true((result->>'status')::int=403,'moderator lock enforced');
  for i in 1..11 loop
    result:=public.quizeey_forum_mutate(repeat('c',64),repeat('e',64),gen_random_uuid(),'create','{"examId":"5","locale":"ko","title":"Rate fixture","body":"Text"}');
  end loop;
  perform pg_temp.assert_true((result->>'status')::int=429,'shared database rate limit');
end $$;

set role anon;
select pg_temp.assert_true((select count(*)=0 from public.quizeey_topics where approved_post_count=0),'no empty indexable topics');
select pg_temp.assert_true((select count(*)=0 from public.quizeey_posts where id=current_setting('quizeey.test_post')::uuid or source_post_id='disqus-fixture-1'),'hidden and pending imported content excluded');
do $$ begin
  begin perform * from quizeey_private.post_revisions; raise exception 'private revision leaked'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.forum_reports; raise exception 'private report leaked'; exception when insufficient_privilege then null; end;
end $$;
reset role;
select 'PASS: forum database security and accepted-write fixture' as result;
