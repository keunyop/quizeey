-- Correct the duplicate reports for Korean cooking question 27068.
-- Reviewed 2026-10-28: WHO/JECFA lists lecithin as a phospholipid emulsifier.
-- https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/1477
-- Backup: ignored .modernization/report-review-20261028/before.json.
-- This is a guarded content correction, not a schema migration.
begin;
do $repair$
declare
  q quizeey_content.questions%rowtype;
  result jsonb;
  report_id uuid;
begin
  select * into strict q from quizeey_content.questions where question_id=27068 for update;
  if q.version_id<>351 or q.number<>16 or q.multiple_answers then
    raise exception 'Unexpected question identity; correction aborted';
  end if;
  if (select array_agg(choice_id order by choice_id) from quizeey_content.choices where question_id=27068)
      is distinct from array[109052,109053,109054,109055]::bigint[]
    or (select array_agg(choice_id order by choice_id) from quizeey_content.choices where question_id=27068 and correct)
      is distinct from array[109052]::bigint[] then
    raise exception 'Unexpected answer identity; correction aborted';
  end if;
  if q.body=$old$ 인상을 함유하는 복합지방질로서 유화제로 사용되는 것은?$old$ and q.explanation is null and q.reference is null then
    update quizeey_content.questions
      set body=$new$ 인산을 함유하는 복합지방질로서 유화제로 사용되는 것은?$new$,
          explanation=$explanation$<p>레시틴은 인산기를 포함하는 인지질 성분으로, 물과 기름이 잘 섞이도록 돕는 유화제로 쓰입니다. 따라서 정답은 레시틴입니다.</p>$explanation$,
          reference=$reference$<p>참고: <a href="https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/1477" rel="noopener noreferrer">WHO/JECFA 레시틴 자료</a></p>$reference$,
          modified_at=now()
      where question_id=27068;
  elsif q.body is distinct from $new$ 인산을 함유하는 복합지방질로서 유화제로 사용되는 것은?$new$
     or q.explanation is distinct from $explanation$<p>레시틴은 인산기를 포함하는 인지질 성분으로, 물과 기름이 잘 섞이도록 돕는 유화제로 쓰입니다. 따라서 정답은 레시틴입니다.</p>$explanation$
     or q.reference is distinct from $reference$<p>참고: <a href="https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/1477" rel="noopener noreferrer">WHO/JECFA 레시틴 자료</a></p>$reference$ then
    raise exception 'Question changed since review; correction aborted';
  end if;
  foreach report_id in array array['bb139dfd-3a80-4911-88fb-c356d31967bb','e780aaf1-a20b-4902-9a6a-c53897a827a8']::uuid[] loop
    if not exists (select 1 from quizeey_private.visitor_submissions
      where id=report_id and kind='question_report' and exam_id='14' and question_id='27068') then
      raise exception 'Unexpected report context; correction aborted';
    end if;
    if exists (select 1 from quizeey_private.visitor_submissions where id=report_id and state='open') then
      result:=public.quizeey_admin_resolve_submission(
        '00000000-0000-4000-8000-000000000001'::uuid,gen_random_uuid(),report_id,'resolved');
      if result->>'status'<>'200' then raise exception 'Report resolution failed'; end if;
    end if;
  end loop;
end
$repair$;
commit;
