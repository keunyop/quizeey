-- Read-only metadata/counts after approved schema-only apply. No fixture writes.
begin read only;
select jsonb_build_object(
  'read_only',current_setting('transaction_read_only'),
  'application_tables',(select count(*) from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r' and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%'))),
  'all_force_rls',not exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r' and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')) and not(c.relrowsecurity and c.relforcerowsecurity)),
  'public_invokers',(select count(*) from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%' and not p.prosecdef),
  'public_definers',(select count(*) from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%' and p.prosecdef),
  'private_definers',(select count(*) from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='quizeey_private' and p.prosecdef),
  'function_owner_search_path_ok',not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) and (pg_get_userbyid(p.proowner)<>'postgres' or not coalesce('search_path=""'=any(p.proconfig),false))),
  'public_execute_revoked',not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid cross join lateral aclexplode(coalesce(p.proacl,acldefault('f',p.proowner))) a where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) and a.grantee=0 and a.privilege_type='EXECUTE'),
  'table_acl_ok',not exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid cross join unnest(array['anon','authenticated','service_role']) r(role) where c.relkind='r' and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')) and (has_table_privilege(r.role,c.oid,'SELECT')<>(n.nspname='public' and r.role in ('anon','authenticated')) or has_table_privilege(r.role,c.oid,'INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER'))),
  'rpc_acl_ok',not exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid cross join unnest(array['anon','authenticated','service_role']) r(role) where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) and has_function_privilege(r.role,p.oid,'EXECUTE')<>(r.role='service_role' and p.proname not in ('consume_rate','quizeey_forum_moderate'))),
  'content_sequences_closed',not exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid cross join unnest(array['anon','authenticated','service_role']) r(role) where n.nspname='quizeey_content' and c.relkind='S' and has_sequence_privilege(r.role,c.oid,'USAGE,SELECT,UPDATE')),
  'application_rows',
    (select count(*) from public.quizeey_topics)+(select count(*) from public.quizeey_posts)+
    (select count(*) from quizeey_private.guest_capabilities)+(select count(*) from quizeey_private.post_owners)+
    (select count(*) from quizeey_private.post_revisions)+(select count(*) from quizeey_private.forum_reports)+
    (select count(*) from quizeey_private.rate_windows)+(select count(*) from quizeey_private.mutation_receipts)+
    (select count(*) from quizeey_private.moderation_audit)+(select count(*) from quizeey_private.admin_sessions)+
    (select count(*) from quizeey_content.exams)+(select count(*) from quizeey_content.versions)+
    (select count(*) from quizeey_content.questions)+(select count(*) from quizeey_content.choices)+
    (select count(*) from quizeey_content.legacy_counters)
) as schema_postflight;
commit;
