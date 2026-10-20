begin;

-- One shared lifetime total per exam ID, including Korean/English route aliases.
create table quizeey_private.exam_clicks (
  exam_id text primary key check (exam_id ~ '^[1-9][0-9]{0,18}$' and exam_id::numeric <= 9223372036854775807),
  click_count bigint not null default 0 check (click_count >= 0)
);
alter table quizeey_private.exam_clicks enable row level security;
alter table quizeey_private.exam_clicks force row level security;
revoke all on quizeey_private.exam_clicks from public, anon, authenticated, service_role;

-- These private implementations intentionally serve anonymous visitor clicks
-- through the server-only service_role boundary, without an Auth session.
create function quizeey_private.quizeey_exam_click(p_exam_id text)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if p_exam_id is null or p_exam_id !~ '^[1-9][0-9]{0,18}$'
    or p_exam_id::numeric > 9223372036854775807 then
    raise exception 'Invalid exam ID' using errcode = '22023';
  end if;
  insert into quizeey_private.exam_clicks as clicks (exam_id, click_count)
    values (p_exam_id, 1)
    on conflict (exam_id) do update set click_count = clicks.click_count + 1;
end;
$$;

create function quizeey_private.quizeey_exam_popularity(p_exam_ids text[])
returns jsonb language plpgsql stable security definer set search_path = '' as $$
begin
  if p_exam_ids is null or cardinality(p_exam_ids) not between 1 and 500
    or exists (select 1 from unnest(p_exam_ids) id where id is null
      or id !~ '^[1-9][0-9]{0,18}$' or id::numeric > 9223372036854775807) then
    raise exception 'Invalid exam IDs' using errcode = '22023';
  end if;
  return (select coalesce(jsonb_object_agg(exam_id, click_count::text), '{}'::jsonb)
    from quizeey_private.exam_clicks where exam_id = any(p_exam_ids));
end;
$$;

create function public.quizeey_exam_click(p_exam_id text)
returns void language sql security invoker set search_path = '' as $$
  select quizeey_private.quizeey_exam_click(p_exam_id);
$$;
create function public.quizeey_exam_popularity(p_exam_ids text[])
returns jsonb language sql stable security invoker set search_path = '' as $$
  select quizeey_private.quizeey_exam_popularity(p_exam_ids);
$$;

revoke all on function quizeey_private.quizeey_exam_click(text) from public, anon, authenticated, service_role;
revoke all on function quizeey_private.quizeey_exam_popularity(text[]) from public, anon, authenticated, service_role;
revoke all on function public.quizeey_exam_click(text) from public, anon, authenticated, service_role;
revoke all on function public.quizeey_exam_popularity(text[]) from public, anon, authenticated, service_role;
grant execute on function quizeey_private.quizeey_exam_click(text) to service_role;
grant execute on function quizeey_private.quizeey_exam_popularity(text[]) to service_role;
grant execute on function public.quizeey_exam_click(text) to service_role;
grant execute on function public.quizeey_exam_popularity(text[]) to service_role;

notify pgrst, 'reload schema';
commit;
