\set ON_ERROR_STOP on
-- Isolated synthetic cluster only. Transaction rollback leaves no test records.
begin;
create or replace function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;

insert into public.quizeey_topics(id,exam_id,locale,title,visibility)
values('00000000-0000-4000-9000-000000000001','5','ko','Retention fixture','approved');
insert into public.quizeey_posts(id,topic_id,body,visibility)
values('00000000-0000-4000-9000-000000000002','00000000-0000-4000-9000-000000000001','Synthetic comment','approved');
insert into quizeey_private.forum_reports(id,post_id,reason,state,expires_at,created_at)
values
 ('00000000-0000-4000-9000-000000000011','00000000-0000-4000-9000-000000000002','Synthetic expired open','open',now()-interval '1 day',now()-interval '31 days'),
 ('00000000-0000-4000-9000-000000000012','00000000-0000-4000-9000-000000000002','Synthetic unexpired open','open',now()+interval '1 day',now()-interval '29 days'),
 ('00000000-0000-4000-9000-000000000013','00000000-0000-4000-9000-000000000002','Synthetic expired resolved','resolved',now()-interval '1 day',now()-interval '31 days'),
 ('00000000-0000-4000-9000-000000000014','00000000-0000-4000-9000-000000000002','Synthetic unexpired resolved','resolved',now()+interval '1 day',now()-interval '29 days'),
 ('00000000-0000-4000-9000-000000000015','00000000-0000-4000-9000-000000000002','Synthetic expiry boundary','resolved',now(),now()-interval '30 days');

set role anon;
do $$ begin
  begin perform public.quizeey_forum_cleanup(); raise exception 'anon cleanup exposed'; exception when insufficient_privilege then null; end;
  begin perform quizeey_private.quizeey_forum_cleanup(); raise exception 'anon private cleanup exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_queue('reports'); raise exception 'anon report queue exposed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role authenticated;
do $$ begin
  begin perform public.quizeey_forum_cleanup(); raise exception 'authenticated cleanup exposed'; exception when insufficient_privilege then null; end;
  begin perform quizeey_private.quizeey_forum_cleanup(); raise exception 'authenticated private cleanup exposed'; exception when insufficient_privilege then null; end;
  begin perform public.quizeey_admin_queue('reports'); raise exception 'authenticated report queue exposed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role service_role;
select public.quizeey_forum_cleanup();
select public.quizeey_forum_cleanup();
do $$ declare queue jsonb; begin
  queue:=public.quizeey_admin_queue('reports','pending',now(), 'ffffffff-ffff-4fff-8fff-ffffffffffff');
  perform pg_temp.assert_true((queue->>'status')::int=200,'service report queue status unchanged');
  perform pg_temp.assert_true(exists(select 1 from jsonb_array_elements(queue->'items') i where i->>'id'='00000000-0000-4000-9000-000000000011'),'expired open report remains actionable after repeated cleanup');
  perform pg_temp.assert_true(exists(select 1 from jsonb_array_elements(queue->'items') i where i->>'id'='00000000-0000-4000-9000-000000000012'),'unexpired open report remains queued');
  perform pg_temp.assert_true(not exists(select 1 from jsonb_array_elements(queue->'items') i where i->>'id' in ('00000000-0000-4000-9000-000000000014','00000000-0000-4000-9000-000000000015')),'resolved reports stay out of open queue');
end $$;
reset role;
select pg_temp.assert_true((select count(*)=4 from quizeey_private.forum_reports where post_id='00000000-0000-4000-9000-000000000002'),'only expired resolved report is deleted; unexpired and exact boundary remain');
select pg_temp.assert_true(not exists(select 1 from quizeey_private.forum_reports where id='00000000-0000-4000-9000-000000000013'),'expired resolved report removed');
select pg_temp.assert_true((select not prosecdef and prorettype='void'::regtype from pg_proc where oid='public.quizeey_forum_cleanup()'::regprocedure),'public cleanup keeps invoker boundary and void contract');
select pg_temp.assert_true((select prosecdef and prorettype='void'::regtype and proconfig=array['search_path=""'] from pg_proc where oid='quizeey_private.quizeey_forum_cleanup()'::regprocedure),'private cleanup keeps definer and empty search path');
select pg_temp.assert_true((select not prosecdef from pg_proc where oid='public.quizeey_admin_queue(text,text,timestamp with time zone,uuid)'::regprocedure),'public queue remains security invoker');

set role service_role;
select pg_temp.assert_true((public.quizeey_admin_moderate('00000000-0000-4000-9000-000000000021',gen_random_uuid(),'resolve_report','00000000-0000-4000-9000-000000000011')->>'status')::int=200,'expired open report can still be resolved normally');
select public.quizeey_forum_cleanup();
reset role;
select pg_temp.assert_true(not exists(select 1 from quizeey_private.forum_reports where id='00000000-0000-4000-9000-000000000011'),'resolved expired report uses the existing expiration deadline');
select pg_temp.assert_true((select count(*)=3 from quizeey_private.forum_reports where post_id='00000000-0000-4000-9000-000000000002'),'other retained reports are unchanged');
rollback;
select 'PASS: report retention, actionable expired reports, cleanup replay and RPC access boundaries' as result;
