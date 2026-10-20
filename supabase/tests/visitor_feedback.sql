\set ON_ERROR_STOP on
begin;
create or replace function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;
select pg_temp.assert_true(not has_table_privilege(role,'quizeey_private.visitor_submissions','SELECT,INSERT,UPDATE,DELETE')
  and not has_table_privilege(role,'quizeey_private.operator_credentials','SELECT,INSERT,UPDATE,DELETE'),'no direct table privileges')
  from unnest(array['anon','authenticated','service_role']) role;
select pg_temp.assert_true(not has_function_privilege(role,'public.quizeey_admin_credential(text)','EXECUTE')
  and not has_function_privilege(role,'public.quizeey_admin_overview()','EXECUTE')
  and not has_function_privilege(role,'public.quizeey_admin_inbox(text,text,timestamptz,uuid)','EXECUTE')
  and not has_function_privilege(role,'public.quizeey_submit_feedback(uuid,text,jsonb)','EXECUTE'),'no anonymous RPC access')
  from unnest(array['anon','authenticated']) role;
select pg_temp.assert_true(relrowsecurity and relforcerowsecurity,'private tables have forced RLS') from pg_class
  where oid in ('quizeey_private.visitor_submissions'::regclass,'quizeey_private.operator_credentials'::regclass);

set local role service_role;
select pg_temp.assert_true(public.quizeey_admin_credential('unknown') is null,'unknown operator rejected');
select pg_temp.assert_true(public.quizeey_admin_credential('admin')->>'actor_id'='00000000-0000-4000-8000-000000000001','requested admin account exists');
select pg_temp.assert_true((public.quizeey_submit_feedback('50000000-0000-4000-8000-000000000001',repeat('7',64),
  '{"kind":"feedback","locale":"ko","path":"/","body":"Fixture feedback"}')->>'status')::int=201,'feedback accepted');
select pg_temp.assert_true((public.quizeey_submit_feedback('50000000-0000-4000-8000-000000000001',repeat('7',64),
  '{"kind":"feedback","locale":"ko","path":"/","body":"Fixture feedback"}')->>'status')::int=201,'retry does not duplicate feedback');
select pg_temp.assert_true((public.quizeey_submit_feedback('50000000-0000-4000-8000-000000000001',repeat('8',64),
  '{"kind":"feedback","locale":"ko","path":"/","body":"Fixture feedback"}')->>'status')::int=409,'other visitor cannot reuse receipt');
select pg_temp.assert_true((public.quizeey_submit_feedback(gen_random_uuid(),repeat('7',64),
  '{"kind":"question_report","locale":"ko","path":"/sqlp-developer","body":"Incorrect answer"}')->>'status')::int=400,'question context required');
select pg_temp.assert_true((public.quizeey_submit_feedback('50000000-0000-4000-8000-000000000002',repeat('7',64),
  '{"kind":"question_report","locale":"ko","path":"/sqlp-developer","examId":"5","questionId":"123","body":"Incorrect answer"}')->>'status')::int=201,'question report accepted');
select pg_temp.assert_true(jsonb_array_length(public.quizeey_admin_inbox('feedback','all',null,null))=1,'feedback retry has one row');
select pg_temp.assert_true((public.quizeey_admin_overview()->>'feedback_open')::int=1,'open feedback count');
select pg_temp.assert_true((public.quizeey_admin_overview()->>'question_reports_open')::int=1,'open question report count');
select pg_temp.assert_true((public.quizeey_admin_resolve_submission('00000000-0000-4000-8000-000000000001',
  '50000000-0000-4000-8000-000000000003','50000000-0000-4000-8000-000000000001','resolved')->>'status')::int=200,'mark resolved');
select pg_temp.assert_true(jsonb_array_length(public.quizeey_admin_inbox('feedback','open',null,null))=0,'resolved excluded from open queue');
select pg_temp.assert_true(jsonb_array_length(public.quizeey_admin_inbox('feedback','resolved',null,null))=1,'resolved retained');
select pg_temp.assert_true(public.quizeey_admin_overview()->'activity'->0->>'action'='submission_resolved','resolution is audited');
reset role;

-- Cursor paging at equal timestamps keeps all 25 rows reachable exactly once.
insert into quizeey_private.visitor_submissions(id,request_hash,kind,locale,path,body,created_at)
  select gen_random_uuid(),repeat('a',64),'feedback','en','/en','Page fixture '||n,'2026-10-20T12:00:00.123456Z' from generate_series(1,25) n;
set local role service_role;
do $$ declare page jsonb; tail jsonb; next_time timestamptz; next_id uuid; seen uuid[]:='{}'; ids uuid[]; begin
  loop
    page:=public.quizeey_admin_inbox('feedback','all',next_time,next_id);
    perform pg_temp.assert_true(jsonb_array_length(page)<=21,'bounded inbox');
    select array_agg((x.value->>'id')::uuid order by x.ordinality) into ids from jsonb_array_elements(page) with ordinality x(value,ordinality) where x.ordinality<=20;
    perform pg_temp.assert_true(not seen && ids,'no duplicate cursor entries'); seen:=seen||ids;
    exit when jsonb_array_length(page)<=20;
    tail:=page->19; next_time:=(tail->>'created_at')::timestamptz; next_id:=(tail->>'id')::uuid;
  end loop;
  perform pg_temp.assert_true(cardinality(seen)=26,'all feedback entries reachable');
end $$;
reset role;
select 'PASS: feedback/report receipts, contexts, inbox cursors, resolution, audit, RLS and credentials boundary' as result;
rollback;
