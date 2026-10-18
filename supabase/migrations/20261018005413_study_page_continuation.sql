-- Add bounded sequential practice without changing the existing random/direct-ID RPC.
-- No content writes or grants to browser roles. The private definer is service-only.
begin;
create function quizeey_private.quizeey_study_page(p_exam_id bigint,p_version integer,p_page integer)
returns jsonb language sql stable security definer set search_path='' as $$
  with eligible as materialized (
    select q.* from quizeey_content.questions q
    join quizeey_content.versions v on v.version_id=q.version_id
    where v.exam_id=p_exam_id
      and (p_version=0 or v.number=p_version)
  ), selected as materialized (
    select q.* from eligible q join quizeey_content.versions v on v.version_id=q.version_id
    order by v.number desc,q.number,q.question_id
    limit 20 offset ((p_page-1)*20)
  )
  select jsonb_build_object('schema',1,'tables',jsonb_build_object(
    'exams',coalesce((select jsonb_agg(jsonb_build_object('exam_id',e.exam_id::text,'name_ko',e.name_ko,'name_en',e.name_en,'legacy_slug',e.legacy_slug,'priority',e.priority) order by e.priority,e.exam_id) from quizeey_content.exams e),'[]'::jsonb),
    'versions',coalesce((select jsonb_agg(jsonb_build_object('version_id',v.version_id::text,'exam_id',v.exam_id::text,'number',v.number,'name',v.name) order by v.exam_id,v.number) from quizeey_content.versions v where p_exam_id is null or v.exam_id=p_exam_id),'[]'::jsonb),
    'questions',coalesce((select jsonb_agg(jsonb_build_object('question_id',q.question_id::text,'version_id',q.version_id::text,'number',q.number,'body',q.body,'explanation',q.explanation,'reference',q.reference,'multiple_answers',q.multiple_answers) order by q.version_id,q.number,q.question_id) from selected q),'[]'::jsonb),
    'choices',coalesce((select jsonb_agg(jsonb_build_object('choice_id',c.choice_id::text,'question_id',c.question_id::text,'number',c.number,'body',c.body,'correct',c.correct) order by c.question_id,c.number,c.choice_id) from quizeey_content.choices c join selected q on q.question_id=c.question_id),'[]'::jsonb),
    'legacy_counters',coalesce((select jsonb_agg(jsonb_build_object('question_id',c.question_id::text,'correct',c.correct,'incorrect',c.incorrect) order by c.question_id) from quizeey_content.legacy_counters c join selected q on q.question_id=c.question_id),'[]'::jsonb)
  ),'pendingExplanationCounts','{}'::jsonb,'pagination',jsonb_build_object('page',p_page,'total',(select count(*) from eligible)));
$$;
revoke all on function quizeey_private.quizeey_study_page(bigint,integer,integer) from public,anon,authenticated,service_role;
grant execute on function quizeey_private.quizeey_study_page(bigint,integer,integer) to service_role;
create function public.quizeey_study_page(p_exam_id bigint,p_version integer default 0,p_page integer default 1)
returns jsonb language plpgsql stable security invoker set search_path='' as $$
begin
  if p_exam_id is null or p_exam_id<=0 or p_version is null or p_version<0 or p_page is null or p_page<1 or p_page>10000 then
    raise exception 'Invalid practice page' using errcode='22023';
  end if;
  return quizeey_private.quizeey_study_page(p_exam_id,p_version,p_page);
end $$;
revoke all on function public.quizeey_study_page(bigint,integer,integer) from public,anon,authenticated,service_role;
grant execute on function public.quizeey_study_page(bigint,integer,integer) to service_role;
notify pgrst,'reload schema';
commit;
