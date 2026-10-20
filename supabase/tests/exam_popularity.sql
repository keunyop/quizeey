\set ON_ERROR_STOP on
-- Isolated synthetic data; never run against hosted content.
begin;
create or replace function pg_temp.assert_true(value boolean, label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %', label; end if; end $$;

select pg_temp.assert_true(not has_table_privilege('service_role', 'quizeey_private.exam_clicks', 'SELECT,INSERT,UPDATE,DELETE'), 'service role has no direct table access');
select pg_temp.assert_true(relrowsecurity and relforcerowsecurity, 'RLS enabled and forced') from pg_class where oid = 'quizeey_private.exam_clicks'::regclass;
select pg_temp.assert_true(not has_function_privilege(role, 'public.quizeey_exam_click(text)', 'EXECUTE')
  and not has_function_privilege(role, 'public.quizeey_exam_popularity(text[])', 'EXECUTE'), 'no anonymous RPC access')
  from unnest(array['anon', 'authenticated']) role;
select pg_temp.assert_true(not prosecdef and proconfig = array['search_path=""'], 'public wrapper cannot escalate privileges')
  from pg_proc where oid in ('public.quizeey_exam_click(text)'::regprocedure, 'public.quizeey_exam_popularity(text[])'::regprocedure);

set local role service_role;
select pg_temp.assert_true(public.quizeey_exam_popularity(array['900001', '900002']) = '{}'::jsonb, 'unvisited exams start at zero');
select public.quizeey_exam_click('900001');
select public.quizeey_exam_click('900001');
select public.quizeey_exam_click('900002');
select pg_temp.assert_true(public.quizeey_exam_popularity(array['900001', '900002']) = '{"900001":"2","900002":"1"}'::jsonb, 'each click increments the right exam');
select pg_temp.assert_true(public.quizeey_exam_popularity(array['900002']) = '{"900002":"1"}'::jsonb, 'bounded lookup excludes other exams');
do $$ begin
  begin perform public.quizeey_exam_click('0'); raise exception 'Invalid ID accepted'; exception when invalid_parameter_value then null; end;
  begin perform public.quizeey_exam_popularity(array[]::text[]); raise exception 'Empty lookup accepted'; exception when invalid_parameter_value then null; end;
  begin perform public.quizeey_exam_popularity(array_fill('900001'::text, array[501])); raise exception 'Unbounded lookup accepted'; exception when invalid_parameter_value then null; end;
  begin perform public.quizeey_exam_click('9223372036854775808'); raise exception 'Overflow ID accepted'; exception when invalid_parameter_value then null; end;
end $$;
reset role;
update quizeey_private.exam_clicks set click_count = 9007199254740992 where exam_id = '900001';
set local role service_role;
select public.quizeey_exam_click('900001');
select pg_temp.assert_true(public.quizeey_exam_popularity(array['900001'])->>'900001' = '9007199254740993', 'bigint count precision preserved');
reset role;
select 'PASS: exam clicks, bounded reads, bigint precision, RLS and RPC permissions' as result;
rollback;
