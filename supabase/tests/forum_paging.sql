\set ON_ERROR_STOP on
-- Synthetic, rollback-only fixture. Includes >20 owned comments in one thread.
begin;
create or replace function pg_temp.assert_true(value boolean,label text) returns void language plpgsql as $$
begin if value is distinct from true then raise exception 'Assertion failed: %',label; end if; end $$;

do $$ declare topic uuid; other uuid; imported uuid;
begin
  insert into public.quizeey_topics(exam_id,locale,title,visibility,approved_post_count)
    values('555','ko','Paging fixture','approved',25) returning id into topic;
  insert into public.quizeey_posts(topic_id,body,visibility,created_at)
    select topic,'Page fixture '||n,'approved','2026-10-18T03:04:05.123456Z'::timestamptz from generate_series(1,25) n;
  insert into quizeey_private.guest_capabilities values(repeat('9',64),now()+interval '1 day');
  insert into quizeey_private.post_owners select id,repeat('9',64) from public.quizeey_posts where topic_id=topic;
  insert into public.quizeey_topics(exam_id,question_id,locale,title,visibility,approved_post_count)
    values('555','123','ko','Other context','approved',1) returning id into other;
  insert into public.quizeey_posts(topic_id,body,visibility) values(other,'Other question','approved');
  insert into public.quizeey_topics(exam_id,question_id,locale,title,visibility,approved_post_count,source_thread_id)
    values('555','124','ko','Imported locale sharing','approved',1,'mysql:question:124') returning id into imported;
  insert into public.quizeey_posts(topic_id,body,visibility) values(imported,'Shared legacy explanation','approved');
end $$;

set local role anon;
do $$ declare page jsonb; cursor_time timestamptz; cursor_id uuid; seen uuid[]:='{}'; count integer:=0; ids uuid[];
begin
  loop
    page:=public.quizeey_forum_page('555','ko',null,cursor_time,cursor_id);
    perform pg_temp.assert_true(jsonb_array_length(page->'posts') between 1 and 10,'bounded page including one large thread');
    select array_agg((p->>'id')::uuid) into ids from jsonb_array_elements(page->'posts') p;
    perform pg_temp.assert_true(not seen && ids,'no repeated IDs at equal microsecond timestamps');
    seen:=seen||ids; count:=count+1;
    exit when page->'next'='null'::jsonb;
    cursor_time:=(page->'next'->>'createdAt')::timestamptz; cursor_id:=(page->'next'->>'id')::uuid;
    perform pg_temp.assert_true(count<4,'cursor always advances');
  end loop;
  perform pg_temp.assert_true(cardinality(seen)=25 and count=3,'every comment reachable across 10/10/5 pages');
  perform set_config('quizeey.test_old_page',array_to_string(ids,','),true);
  perform pg_temp.assert_true(jsonb_array_length(public.quizeey_forum_page('555','en',null,null,null)->'posts')=0,'new comments remain locale scoped');
  perform pg_temp.assert_true(jsonb_array_length(public.quizeey_forum_page('555','en','124',null,null)->'posts')=1,'imported explanation shared across locales');
  begin perform public.quizeey_forum_owned(repeat('9',64),ids); raise exception 'public ownership lookup allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set local role service_role;
select pg_temp.assert_true(jsonb_array_length(public.quizeey_forum_owned(repeat('9',64),string_to_array(current_setting('quizeey.test_old_page'),',')::uuid[]))=5,'old page ownership not limited to newest 20 posts');
select pg_temp.assert_true(public.quizeey_forum_owned(repeat('8',64),string_to_array(current_setting('quizeey.test_old_page'),',')::uuid[])='[]'::jsonb,'another browser cannot claim ownership');
reset role;
select 'PASS: comment paging, timestamp ties, context isolation, legacy locales and bounded ownership' as result;
rollback;
