\set ON_ERROR_STOP on
-- Synthetic isolated rehearsal only; intentionally checks access, never imports content.
create or replace function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;

select pg_temp.assert_true(not (select rolsuper from pg_roles where rolname=current_user),'non-superuser migration/test role');
select pg_temp.assert_true(not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%' and p.prosecdef),'no exposed SECURITY DEFINER');
select pg_temp.assert_true(not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid cross join lateral aclexplode(coalesce(p.proacl,acldefault('f',p.proowner))) a where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) and a.grantee=0 and a.privilege_type='EXECUTE'),'no PUBLIC function execute inheritance');
select pg_temp.assert_true((select count(*)=10+case when to_regprocedure('public.quizeey_study_context(bigint,bigint,integer,boolean)') is null then 0 else 1 end+case when to_regprocedure('public.quizeey_study_page(bigint,integer,integer)') is null then 0 else 1 end from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%'),'all wire functions preserved');
select pg_temp.assert_true(not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) and (pg_get_userbyid(p.proowner)<>'postgres' or not coalesce('search_path=""'=any(p.proconfig),false))),'function owner and locked search_path');
select pg_temp.assert_true(not exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r' and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')) and not(c.relrowsecurity and c.relforcerowsecurity)),'all application tables force RLS');

do $$ declare role_name text; obj record; allowed boolean;
begin
  foreach role_name in array array['anon','authenticated','service_role'] loop
    for obj in select c.oid,n.nspname,c.relname from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r' and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')) loop
      allowed:=obj.nspname='public' and role_name in ('anon','authenticated');
      perform pg_temp.assert_true(has_table_privilege(role_name,obj.oid,'SELECT')=allowed,role_name||' SELECT '||obj.nspname||'.'||obj.relname);
      perform pg_temp.assert_true(not has_table_privilege(role_name,obj.oid,'INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER'),role_name||' direct mutation forbidden');
    end loop;
    for obj in select c.oid from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='S' and n.nspname='quizeey_content' loop
      perform pg_temp.assert_true(not has_sequence_privilege(role_name,obj.oid,'USAGE,SELECT,UPDATE'),role_name||' identity sequence forbidden');
    end loop;
    for obj in select p.oid,p.proname,n.nspname from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%') loop
      allowed:=role_name='service_role' and obj.proname not in ('consume_rate','quizeey_forum_moderate');
      perform pg_temp.assert_true(has_function_privilege(role_name,obj.oid,'EXECUTE')=allowed,role_name||' EXECUTE '||obj.nspname||'.'||obj.proname);
    end loop;
  end loop;
end $$;

set role anon;
do $$ begin
  begin perform quizeey_private.quizeey_admin_queue('posts'); raise exception 'anon private function allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role service_role;
do $$ begin
  begin perform public.quizeey_forum_moderate('approve',gen_random_uuid()); raise exception 'unaudited helper callable'; exception when insufficient_privilege then null; end;
  begin perform quizeey_private.quizeey_forum_moderate('approve',gen_random_uuid()); raise exception 'private unaudited helper callable'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_private.admin_sessions; raise exception 'service reads sessions directly'; exception when insufficient_privilege then null; end;
  begin perform * from quizeey_content.questions; raise exception 'service reads private content'; exception when insufficient_privilege then null; end;
end $$;
reset role;
select 'PASS: hosted role/default-ACL, private implementations, invoker wire wrappers and closed tables';
