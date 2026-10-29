\set ON_ERROR_STOP on
-- Isolated synthetic fixture only. Roll back every inserted row.
begin;
insert into quizeey_content.exams(exam_id,name_ko,legacy_slug,priority,created_at,modified_at)
values(800001,'Session fixture','session-fixture',1,now(),now());
insert into quizeey_content.versions(version_id,exam_id,number,name,created_at,modified_at)
select 800000+i,800001,i,'Set '||i,now(),now() from generate_series(1,4) i;
insert into quizeey_content.questions(question_id,version_id,number,body,explanation,reference,multiple_answers,created_at,modified_at)
select 800000+i,800001+(i-1)/30,(i-1)%30+1,'Synthetic question',null,'',false,now(),now() from generate_series(1,120) i;
insert into quizeey_content.choices(choice_id,question_id,number,body,correct,created_at,modified_at)
select 800000+i,800000+i,1,'Correct',true,now(),now() from generate_series(1,120) i;
set local role anon;
do $$ begin
  begin perform public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',20); raise exception 'anon allowed'; exception when insufficient_privilege then null; end;
end $$;
set local role authenticated;
do $$ begin
  begin perform public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',20); raise exception 'authenticated allowed'; exception when insufficient_privilege then null; end;
end $$;
set local role service_role;
do $$ declare a jsonb; b jsonb; begin
  a:=public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',20);
  b:=public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',20);
  if a<>b then raise exception 'Session is not reproducible'; end if;
  if jsonb_array_length(a#>'{tables,questions}')<>20 or a#>>'{pagination,total}'<>'120' then raise exception 'Invalid session bounds'; end if;
  if (select count(distinct q->>'version_id') from jsonb_array_elements(a#>'{tables,questions}') q)<>4 then raise exception 'Sample did not span sets'; end if;
  if a=public.quizeey_study_session(800001,0,'9e03847d-087f-4d35-81e8-57cb015db2e8',20) then raise exception 'Seed ignored'; end if;
  if jsonb_array_length(public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',100)#>'{tables,questions}')<>100 then raise exception 'Custom count truncated'; end if;
  b:=public.quizeey_study_session(800001,2,'b75d8c32-a053-4d50-9465-c84d430d6dd8',100);
  if jsonb_array_length(b#>'{tables,questions}')<>30 or exists(select 1 from jsonb_array_elements(b#>'{tables,questions}') q where q->>'version_id'<>'800002') then raise exception 'Set filter failed'; end if;
  begin perform public.quizeey_study_session(800001,0,'b75d8c32-a053-4d50-9465-c84d430d6dd8',101); raise exception 'Unbounded count'; exception when invalid_parameter_value then null; end;
  begin perform public.quizeey_study_session(800001,0,null,20); raise exception 'Missing seed accepted'; exception when invalid_parameter_value then null; end;
end $$;
rollback;
