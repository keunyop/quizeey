-- Owner-requested review of the open report for Korean cooking question 27055.
-- Existing answer 1 is correct. Add an explanation, references and one short comment.
-- This is guarded content maintenance, not a schema migration or app release.
-- Sources: WHO mycotoxins fact sheet, EFSA mycotoxin summary and WHO/JECFA sterigmatocystin evaluation.
-- Before snapshot: ignored .modernization/report-review-27055/before.json.
begin;
set local lock_timeout='5s';
set local statement_timeout='20s';
set local timezone='UTC';
do $review$
declare
  q quizeey_content.questions%rowtype;
  t public.quizeey_topics%rowtype;
  s quizeey_private.visitor_submissions%rowtype;
  inserted integer;
  resolution_result jsonb;
begin
  select * into strict q from quizeey_content.questions where question_id=27055 for update;
  perform 1 from quizeey_content.choices where question_id=27055 order by choice_id for update;
  select * into strict t from public.quizeey_topics where id='df0b2ae5-884b-5b10-84b0-055d8e455056' for update;
  select * into strict s from quizeey_private.visitor_submissions where id='74dcd1c4-530d-4407-8169-407def08e8b2' for update;

  if q.version_id<>351 or q.number<>3 or q.multiple_answers
     or md5((to_jsonb(q)-'explanation'-'reference'-'modified_at')::text)<>'5d0f7a16e4ae75a8b225af71d28fc7f2'
     or (select md5(jsonb_agg(to_jsonb(ch) order by choice_id)::text) from quizeey_content.choices ch where question_id=27055)
        is distinct from '1072443e050299737a3889262ff4214d'
     or (select array_agg(choice_id order by choice_id) from quizeey_content.choices where question_id=27055 and correct)
        is distinct from array[109000]::bigint[] then
    raise exception 'Question or choices changed since review; aborted';
  end if;

  if not ((q.explanation is null and q.reference is null)
     or (q.explanation is not distinct from $explanation$<p><strong>정답: ① 아플라톡신(aflatoxin) - 신경독</strong></p><p>이 문항은 곰팡이독소와 대표적인 표적 장기의 연결이 잘못된 보기를 묻습니다. 아플라톡신은 신경독이 아니라 주로 간을 손상시키며 간암 위험과 관련됩니다. 따라서 ①의 연결이 잘못되었습니다.</p><ul><li>② 오클라톡신(ochratoxin): 신장이 가장 민감한 표적이며 간에도 영향을 줄 수 있습니다.</li><li>③ 시트리닌(citrinin): 대표적인 신독성 곰팡이독소입니다.</li><li>④ 스테리그마토시스틴(sterigmatocystin): 간이 주 표적 장기입니다.</li></ul><p>2014년 복원 기출의 출제 의도와 정답표도 ①입니다. 다만 오클라톡신을 ‘간장독’으로만 표현한 ②는 오늘날의 독성학 기준으로는 불충분하므로, 학습할 때는 오클라톡신의 대표 표적을 신장으로 기억하는 것이 정확합니다.</p>$explanation$
         and q.reference is not distinct from $reference$<p>근거: <a href="https://www.who.int/news-room/fact-sheets/detail/mycotoxins" rel="noopener noreferrer">WHO 곰팡이독소 자료</a>(아플라톡신의 간 손상·간암, 오클라톡신 A의 주된 신장독성), <a href="https://www.efsa.europa.eu/sites/default/files/2026-01/4.1_Emerging%20mycotoxin%20remediation%20methods_34th_StaDG-ER.pdf" rel="noopener noreferrer">EFSA 곰팡이독소 요약</a>(아플라톡신-간암, 오클라톡신 A-신장질환, 시트리닌-신장 손상), <a href="https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/6458" rel="noopener noreferrer">WHO/JECFA 스테리그마토시스틴 평가</a>(주 표적 장기: 간). 복원 기출 정답은 ①로 교차 확인했습니다. 검토일: 2026-11-06.</p>$reference$)) then
    raise exception 'Explanation or references changed since review; aborted';
  end if;

  if t.exam_id<>'14' or t.question_id<>'27055' or t.locale<>'ko'
     or t.visibility<>'approved' or t.locked
     or t.approved_post_count<>(select count(*) from public.quizeey_posts where topic_id=t.id and visibility='approved') then
    raise exception 'Topic context or count changed; aborted';
  end if;

  if s.kind<>'question_report' or s.exam_id<>'14' or s.question_id<>'27055' or s.locale<>'ko'
     or s.path<>'/craftsman-cook-korean-food' or s.body<>'정답 오류'
     or (s.state<>'open' and not (s.state='resolved' and exists (
       select 1 from quizeey_private.moderation_audit
       where request_id='9d067d15-9e75-4a3d-b871-e66a3cf1f33e'
         and actor_id='00000000-0000-4000-8000-000000000001'
         and action='submission_resolved' and target_id=s.id and result->>'status'='200'))) then
    raise exception 'Report context or processing state changed; aborted';
  end if;

  if not exists (select 1 from quizeey_private.operator_credentials
      where username='admin' and actor_id='00000000-0000-4000-8000-000000000001') then
    raise exception 'Expected existing operator identity missing; aborted';
  end if;

  update quizeey_content.questions
    set explanation=$explanation$<p><strong>정답: ① 아플라톡신(aflatoxin) - 신경독</strong></p><p>이 문항은 곰팡이독소와 대표적인 표적 장기의 연결이 잘못된 보기를 묻습니다. 아플라톡신은 신경독이 아니라 주로 간을 손상시키며 간암 위험과 관련됩니다. 따라서 ①의 연결이 잘못되었습니다.</p><ul><li>② 오클라톡신(ochratoxin): 신장이 가장 민감한 표적이며 간에도 영향을 줄 수 있습니다.</li><li>③ 시트리닌(citrinin): 대표적인 신독성 곰팡이독소입니다.</li><li>④ 스테리그마토시스틴(sterigmatocystin): 간이 주 표적 장기입니다.</li></ul><p>2014년 복원 기출의 출제 의도와 정답표도 ①입니다. 다만 오클라톡신을 ‘간장독’으로만 표현한 ②는 오늘날의 독성학 기준으로는 불충분하므로, 학습할 때는 오클라톡신의 대표 표적을 신장으로 기억하는 것이 정확합니다.</p>$explanation$,
        reference=$reference$<p>근거: <a href="https://www.who.int/news-room/fact-sheets/detail/mycotoxins" rel="noopener noreferrer">WHO 곰팡이독소 자료</a>(아플라톡신의 간 손상·간암, 오클라톡신 A의 주된 신장독성), <a href="https://www.efsa.europa.eu/sites/default/files/2026-01/4.1_Emerging%20mycotoxin%20remediation%20methods_34th_StaDG-ER.pdf" rel="noopener noreferrer">EFSA 곰팡이독소 요약</a>(아플라톡신-간암, 오클라톡신 A-신장질환, 시트리닌-신장 손상), <a href="https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/6458" rel="noopener noreferrer">WHO/JECFA 스테리그마토시스틴 평가</a>(주 표적 장기: 간). 복원 기출 정답은 ①로 교차 확인했습니다. 검토일: 2026-11-06.</p>$reference$,
        modified_at=now()
    where question_id=27055 and explanation is null and reference is null;

  insert into public.quizeey_posts(topic_id,parent_id,display_name,body,visibility,source_post_id)
    values(t.id,null,'Quizeey 운영팀','신고 감사합니다. 출제 당시 정답표와 WHO·EFSA 자료를 확인한 결과, 아플라톡신은 신경독이 아니라 주로 간독성을 나타내므로 정답 ①이 맞습니다. 오클라톡신은 신장이 대표 표적이라는 점도 해설에 보완했습니다.','approved','owner-review:question:27055:20261106')
    on conflict(source_post_id) do nothing;
  get diagnostics inserted=row_count;

  if not exists (select 1 from public.quizeey_posts
      where source_post_id='owner-review:question:27055:20261106' and topic_id=t.id and parent_id is null
        and display_name='Quizeey 운영팀'
        and body='신고 감사합니다. 출제 당시 정답표와 WHO·EFSA 자료를 확인한 결과, 아플라톡신은 신경독이 아니라 주로 간독성을 나타내므로 정답 ①이 맞습니다. 오클라톡신은 신장이 대표 표적이라는 점도 해설에 보완했습니다.'
        and visibility='approved') then
    raise exception 'Existing review comment differs; aborted';
  end if;

  if inserted=1 then
    update public.quizeey_topics set approved_post_count=approved_post_count+1 where id=t.id;
  end if;

  resolution_result:=public.quizeey_admin_resolve_submission(
    '00000000-0000-4000-8000-000000000001','9d067d15-9e75-4a3d-b871-e66a3cf1f33e',s.id,'resolved');
  if resolution_result->>'status' is distinct from '200' then
    raise exception 'Report resolution failed; aborted';
  end if;

  if (select approved_post_count from public.quizeey_topics where id=t.id)
     <> (select count(*) from public.quizeey_posts where topic_id=t.id and visibility='approved') then
    raise exception 'Comment count mismatch; aborted';
  end if;
end $review$;
commit;
