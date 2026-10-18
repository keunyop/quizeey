-- REVIEW ONLY: forward containment after a committed schema-only candidate.
-- Exact project must be checked by the API caller. No DROP/TRUNCATE/DELETE/CASCADE.
begin;
set local lock_timeout='5s';
set local statement_timeout='30s';
do $$ declare fn record; begin
  if current_user<>'postgres' or to_regnamespace('quizeey_private') is null
    or to_regnamespace('quizeey_content') is null then
    raise exception 'Unexpected rollback role/application schema';
  end if;
  for fn in select n.nspname,p.proname,pg_get_function_identity_arguments(p.oid) as signature
    from pg_proc p join pg_namespace n on p.pronamespace=n.oid
    where n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%') loop
    execute format('revoke all on function %I.%I(%s) from public,anon,authenticated,service_role',fn.nspname,fn.proname,fn.signature);
  end loop;
end $$;
revoke all on public.quizeey_topics,public.quizeey_posts from public,anon,authenticated,service_role;
revoke usage on schema quizeey_private from service_role;
notify pgrst, 'reload schema';
commit;
