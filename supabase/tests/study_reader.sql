\set ON_ERROR_STOP on
-- Synthetic local-only rows; never execute this file in the hosted project.
insert into quizeey_content.exams(exam_id,name_ko,legacy_slug,priority,created_at,modified_at)
values(5,'Synthetic','sqlp-developer',1,now(),now()),(1,'Synthetic other','other',2,now(),now());
insert into quizeey_content.versions(version_id,exam_id,number,name,created_at,modified_at)
values(11,5,1,'First',now(),now()),(12,5,2,'Second',now(),now());
insert into quizeey_content.questions(question_id,version_id,number,body,explanation,reference,multiple_answers,created_at,modified_at)
select 9007199254740992+i,11,i,E'Synthetic <CTRL> 한국어\n\tquote\'end',null,'',false,now(),now() from generate_series(1,25) i;
insert into quizeey_content.choices(choice_id,question_id,number,body,correct,created_at,modified_at)
select 10000000000000000+i,9007199254740992+i,1,'Synthetic correct',true,now(),now() from generate_series(1,25) i;
insert into quizeey_content.legacy_counters(question_id,correct,incorrect,created_at,modified_at)
values(9007199254741017,9,3,now(),now());
set role anon;
do $$ begin
  begin perform public.quizeey_study_context(5); raise exception 'anon study RPC allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role authenticated;
do $$ begin
  begin perform public.quizeey_study_context(5); raise exception 'ordinary user study RPC allowed'; exception when insufficient_privilege then null; end;
end $$;
reset role;
set role service_role;
do $$ declare result jsonb; q jsonb; begin
  begin perform * from quizeey_content.questions; raise exception 'service direct content read allowed'; exception when insufficient_privilege then null; end;
  result:=public.quizeey_study_context(5);
  if jsonb_array_length(result#>'{tables,questions}')<>20 then raise exception 'Unbounded study batch'; end if;
  if jsonb_array_length(result#>'{tables,versions}')<>2 then raise exception 'Versions truncated to question batch'; end if;
  result:=public.quizeey_study_context(5,9007199254741017);
  q:=result#>'{tables,questions,0}';
  if q->>'question_id'<>'9007199254741017' or (q->>'number')::integer<>25 then raise exception 'Direct bigint identity beyond20 lost'; end if;
  if q->'explanation'<>'null'::jsonb or q->>'reference'<>'' then raise exception 'NULL/empty semantics lost'; end if;
  if result#>>'{tables,legacy_counters,0,correct}'<>'9' then raise exception 'Counters lost'; end if;
  if jsonb_array_length(public.quizeey_study_context(1,9007199254741017)#>'{tables,questions}')<>0 then raise exception 'Cross-exam lookup allowed'; end if;
  if jsonb_array_length(public.quizeey_study_context(5,9007199254741017,2)#>'{tables,questions}')<>0 then raise exception 'Wrong version lookup allowed'; end if;
  if jsonb_array_length(public.quizeey_study_context(5,123)#>'{tables,questions}')<>0 then raise exception 'Unknown/deleted ID substituted'; end if;
  if jsonb_array_length(public.quizeey_study_context()#>'{tables,questions}')<>0 then raise exception 'Home context reveals arbitrary questions'; end if;
  if jsonb_array_length(public.quizeey_study_context(5,null,0,true)#>'{tables,questions}')<>1 then raise exception 'Random API must return exactly one'; end if;
  -- With25 eligible rows, random draws must not be confined to the ordered first20.
  perform setseed(0.314159);
  if not exists(select 1 from generate_series(1,200) i where (public.quizeey_study_context(5,null,0,true)#>>'{tables,questions,0,number}')::integer>20) then raise exception 'Random API limited to first20'; end if;
  begin perform public.quizeey_study_context(-1); raise exception 'Invalid context accepted'; exception when invalid_parameter_value then null; end;
end $$;
reset role;
select 'PASS: private bounded study reader and identity/NULL/filter contracts';
