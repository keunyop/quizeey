\set ON_ERROR_STOP on
-- Isolated synthetic cluster only. Never call this against an existing project.
create function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;

set role anon;
do $$ begin
  begin perform public.quizeey_admin_queue('posts'); raise exception 'anon review queue exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_moderate(gen_random_uuid(),gen_random_uuid(),'approve',gen_random_uuid()); raise exception 'anon moderation allowed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_login_limit(repeat('9',64)); raise exception 'anon login limiter exposed'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.moderation_audit; raise exception 'anon audit exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_session_create(repeat('6',64),gen_random_uuid(),now()+interval '30 minutes'); raise exception 'anon session registered'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.admin_sessions; raise exception 'anon session registry exposed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role authenticated;
do $$ begin
  begin perform public.quizeey_admin_queue('posts'); raise exception 'ordinary authenticated review queue exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_moderate(gen_random_uuid(),gen_random_uuid(),'approve',gen_random_uuid()); raise exception 'ordinary authenticated moderation allowed'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.moderation_audit; raise exception 'ordinary authenticated audit exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_session_actor(repeat('6',64)); raise exception 'ordinary authenticated session lookup allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role service_role;
do $$ declare i integer; begin
  for i in 1..5 loop perform pg_temp.assert_true(public.quizeey_admin_login_limit(repeat('9',64)),'shared login attempts allowed within limit'); end loop;
  perform pg_temp.assert_true(not public.quizeey_admin_login_limit(repeat('9',64)),'sixth attempt blocked in shared storage');
  begin perform * from quizeey_private.moderation_audit; raise exception 'transport directly reads audit'; exception when insufficient_privilege then null; end;
  perform pg_temp.assert_true(public.quizeey_admin_session_create(repeat('6',64),'00000000-0000-4000-8000-000000000103',now()+interval '30 minutes'),'verified server registers hash only');
  perform pg_temp.assert_true(public.quizeey_admin_session_actor(repeat('6',64))='00000000-0000-4000-8000-000000000103'::uuid,'registered identity bound to session');
  perform public.quizeey_admin_session_revoke(repeat('6',64));
  perform pg_temp.assert_true(public.quizeey_admin_session_actor(repeat('6',64)) is null,'revoked session denied immediately');
  perform pg_temp.assert_true(not public.quizeey_admin_session_create(repeat('6',64),gen_random_uuid(),now()+interval '30 minutes'),'revoked token cannot be reactivated');
  perform pg_temp.assert_true(not public.quizeey_admin_session_create(repeat('5',64),gen_random_uuid(),now()+interval '2 hours'),'session lifetime bounded');
end $$;
reset role;

do $$ declare output jsonb; first_result jsonb; pid uuid; tid uuid; r1 uuid; r2 uuid; report_id uuid;
  actor uuid:='00000000-0000-4000-8000-000000000103'; fixture_request uuid:=gen_random_uuid(); queue jsonb;
begin
  output:=public.quizeey_forum_mutate(repeat('7',64),repeat('8',64),gen_random_uuid(),'create','{"examId":"5","locale":"ko","title":"Admin review fixture","body":"Original body"}');
  pid:=(output->>'postId')::uuid;tid:=(output->>'topicId')::uuid;
  perform pg_temp.assert_true((output->>'status')::int=202,'published guest post');
  -- Historical pending content is seeded explicitly to exercise the existing queue.
  update public.quizeey_posts set visibility='pending' where id=pid;
  update public.quizeey_topics set visibility='pending',approved_post_count=0 where id=tid;
  queue:=public.quizeey_admin_queue('posts');
  perform pg_temp.assert_true(exists(select 1 from jsonb_array_elements(queue->'items') i where i->>'id'=pid::text),'pending review queue');
  perform pg_temp.assert_true(queue::text not like '%capability%' and queue::text not like '%abuse%' and queue::text not like '%email%','review queue has no ownership or abuse secrets');
  perform pg_temp.assert_true((public.quizeey_admin_queue('posts','pending',now(),null)->>'status')::int=400,'cursor pair validated');
  first_result:=public.quizeey_admin_moderate(actor,fixture_request,'approve',pid);
  perform pg_temp.assert_true((first_result->>'status')::int=200,'verified server transport can approve');
  output:=public.quizeey_admin_moderate(actor,fixture_request,'approve',pid);
  perform pg_temp.assert_true(output=first_result and (select approved_post_count=1 from public.quizeey_topics where id=tid),'moderation replay does not duplicate counters');
  perform pg_temp.assert_true((public.quizeey_admin_moderate(gen_random_uuid(),fixture_request,'approve',pid)->>'status')::int=409,'idempotency is bound to actor');
  perform pg_temp.assert_true((public.quizeey_admin_moderate(actor,fixture_request,'hide',pid)->>'status')::int=409,'idempotency is bound to action');
  perform pg_temp.assert_true((select actor_id=actor and action='approve' and target_id=pid from quizeey_private.moderation_audit where moderation_audit.request_id=fixture_request),'private audit stores verified actor');
  insert into quizeey_private.post_revisions(post_id,body) values(pid,'Older private edit') returning id into r1;
  insert into quizeey_private.post_revisions(post_id,body) values(pid,'Newest private edit') returning id into r2;
  -- now() is transaction-stable, so force chronological order for this single-transaction fixture.
  update quizeey_private.post_revisions set created_at=now()-interval '1 second' where id=r1;
  perform pg_temp.assert_true((public.quizeey_admin_moderate(actor,gen_random_uuid(),'approve_revision',r1)->>'status')::int=409,'stale revision cannot overwrite newer submitted content');
  perform pg_temp.assert_true((select body='Original body' from public.quizeey_posts where id=pid),'private edits not published early');
  perform pg_temp.assert_true((public.quizeey_admin_moderate(actor,gen_random_uuid(),'approve_revision',r2)->>'status')::int=200,'latest revision accepted');
  perform pg_temp.assert_true((select body='Newest private edit' from public.quizeey_posts where id=pid),'approved revision visible');
  perform pg_temp.assert_true((select visibility='rejected' from quizeey_private.post_revisions where id=r1),'superseded pending revision closed');
  insert into quizeey_private.post_revisions(post_id,body) values(pid,'Rejected private edit') returning id into r1;
  perform pg_temp.assert_true((public.quizeey_admin_moderate(actor,gen_random_uuid(),'reject_revision',r1)->>'status')::int=200,'moderator can reject revision');
  perform public.quizeey_admin_moderate(actor,gen_random_uuid(),'lock',tid);
  perform pg_temp.assert_true((select locked from public.quizeey_topics where id=tid),'topic locked');
  perform public.quizeey_admin_moderate(actor,gen_random_uuid(),'unlock',tid);
  perform pg_temp.assert_true((select not locked from public.quizeey_topics where id=tid),'topic unlocked');
  perform public.quizeey_forum_mutate(repeat('7',64),repeat('8',64),gen_random_uuid(),'report',jsonb_build_object('postId',pid,'reason','Synthetic report'));
  select id into report_id from quizeey_private.forum_reports where post_id=pid;
  perform pg_temp.assert_true(exists(select 1 from jsonb_array_elements(public.quizeey_admin_queue('reports')->'items') i where i->>'id'=report_id::text),'open report queued privately');
  perform public.quizeey_admin_moderate(actor,gen_random_uuid(),'resolve_report',report_id);
  perform pg_temp.assert_true(not exists(select 1 from jsonb_array_elements(public.quizeey_admin_queue('reports')->'items') i where i->>'id'=report_id::text),'resolved report removed from queue');
  perform public.quizeey_admin_moderate(actor,gen_random_uuid(),'hide',pid);
  perform pg_temp.assert_true((select approved_post_count=0 from public.quizeey_topics where id=tid),'hide invalidates aggregate count');
  perform public.quizeey_admin_moderate(actor,gen_random_uuid(),'delete',pid);
  perform pg_temp.assert_true((public.quizeey_admin_moderate(actor,gen_random_uuid(),'approve',pid)->>'status')::int=409,'deleted post cannot be republished');
end $$;
select 'PASS: admin grants, review queues, audited idempotency, revision ordering and reports' as result;
