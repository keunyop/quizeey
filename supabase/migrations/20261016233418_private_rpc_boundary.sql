-- Locally rehearsed hardening; cloud application requires a separate change request.
-- Only invoker wrappers live in the exposed public schema. Service credentials are
-- a server trust boundary, not an Auth user: requireAdmin must verify actor/session
-- before an admin RPC. Visitors never receive these credentials or schema access.
begin;
grant usage on schema quizeey_private to service_role;

do $$
declare name text; fn record; placeholders text; volatility text;
begin
  foreach name in array array[
    'quizeey_forum_mutate','quizeey_forum_moderate','quizeey_forum_cleanup','quizeey_forum_mine',
    'quizeey_admin_session_create','quizeey_admin_session_actor','quizeey_admin_session_revoke',
    'quizeey_admin_login_limit','quizeey_admin_queue','quizeey_admin_moderate'
  ] loop
    select p.oid,pg_get_function_identity_arguments(p.oid) as signature,
      pg_get_function_arguments(p.oid) as arguments,pg_get_function_result(p.oid) as result,
      p.pronargs,p.provolatile into strict fn
      from pg_proc p join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public' and p.proname=name and p.prosecdef;
    select string_agg('$'||i,',' order by i) into placeholders from generate_series(1,fn.pronargs) i;
    volatility:=case fn.provolatile when 's' then 'stable' when 'i' then 'immutable' else 'volatile' end;
    execute format('alter function public.%I(%s) set schema quizeey_private',name,fn.signature);
    execute format('create function public.%I(%s) returns %s language sql %s security invoker set search_path='''' as %L',
      name,fn.arguments,fn.result,volatility,'select quizeey_private.'||quote_ident(name)||'('||coalesce(placeholders,'')||')');
    execute format('revoke all on function public.%I(%s) from public,anon,authenticated,service_role',name,fn.signature);
    execute format('revoke all on function quizeey_private.%I(%s) from public,anon,authenticated,service_role',name,fn.signature);
    -- The low-level moderator is owner-only; server callers must use audited admin RPC.
    if name<>'quizeey_forum_moderate' then
      execute format('grant execute on function public.%I(%s) to service_role',name,fn.signature);
      execute format('grant execute on function quizeey_private.%I(%s) to service_role',name,fn.signature);
    end if;
  end loop;
end $$;

-- The original consume_rate helper stays owner-only, despite service schema USAGE.
revoke all on function quizeey_private.consume_rate(text,integer) from public,anon,authenticated,service_role;
comment on schema quizeey_private is 'Unexposed server implementation and private tables. Service role has USAGE and explicit RPC EXECUTE only; no direct table access. Never add this schema to Data API exposed schemas.';
commit;
