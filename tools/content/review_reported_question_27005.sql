-- Owner-requested review of the open report for Korean cooking question 27005.
-- Existing answer 2 is correct. Add an explanation, references and one short comment.
-- This is guarded content maintenance, not a schema migration or app release.
-- Sources: Food Sanitation Act Enforcement Decree, Articles 23 and 25(1)(2).
-- Historical source: https://www.law.go.kr/LSW/lbook/lbFileDownload.do?flExt=pdf&lbookConflSeq=36284&lbookSeq=44103
-- Before snapshot: ignored .modernization/report-review-27005/before.json.
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
  select * into strict q from quizeey_content.questions where question_id=27005 for update;
  perform 1 from quizeey_content.choices where question_id=27005 order by choice_id for update;
  select * into strict t from public.quizeey_topics where id='a15385d2-14dd-598c-9476-513400ddad48' for update;
  select * into strict s from quizeey_private.visitor_submissions where id='21f2f2ee-07d5-43c4-9be7-de59c03d7624' for update;
  if q.version_id<>350 or q.number<>13 or q.multiple_answers
     or md5((to_jsonb(q)-'explanation'-'reference'-'modified_at')::text)<>'63d784f43afacd71fce2734f53b5ce2c'
     or (select md5(jsonb_agg(to_jsonb(ch) order by choice_id)::text) from quizeey_content.choices ch where question_id=27005) is distinct from 'ac795c7a90133574b2f0b80dc75df8b7'
     or (select array_agg(choice_id order by choice_id) from quizeey_content.choices where question_id=27005 and correct) is distinct from array[108801]::bigint[] then
    raise exception 'Question or choices changed since review; aborted';
  end if;
  if not ((q.explanation is null and q.reference is null)
     or (q.explanation is not distinct from '<p><strong>정답: ② 즉석판매제조·가공업</strong></p><p>이 문항은 영업을 시작할 때 <strong>영업신고</strong>가 필요한 업종을 묻습니다. 즉석판매제조·가공업은 「식품위생법 시행령」 제25조제1항제2호에 따른 신고 대상입니다.</p><p>나머지 보기는 같은 시행령 제23조에 따른 <strong>영업허가</strong> 대상입니다.</p><ul><li>① 유흥주점영업: 허가 대상</li><li>③ 식품조사처리업: 허가 대상</li><li>④ 단란주점영업: 허가 대상</li></ul><p>따라서 신고와 허가를 구분하면 정답은 ②입니다. 허가 대상이라는 말은 아무런 절차 없이 영업할 수 있다는 뜻이 아닙니다. 2014년 당시 법령과 검토 시점의 현행 규정 모두 이 구분이 같습니다.</p>' and q.reference is not distinct from '<p>근거: 국가법령정보센터, 「식품위생법 시행령」 <a href="https://www.law.go.kr/LSW/lsLinkCommonInfo.do?chrClsCd=010202&amp;lsJoLnkSeq=1026749125">제25조제1항제2호(영업신고 대상)</a> 및 <a href="https://law.go.kr/LSW/lsLinkCommonInfo.do?chrClsCd=010202&amp;lsJoLnkSeq=1026749079">제23조(영업허가 대상)</a>. 출제 당시 규정은 <a href="https://www.law.go.kr/LSW/lbook/lbFileDownload.do?flExt=pdf&amp;lbookConflSeq=36284&amp;lbookSeq=44103#page=93">법제처 「식품안전관련법령」(2014.1.3), 식품위생법 시행령 제23조·제25조(PDF 92~93쪽)</a>에서 확인했습니다. 검토일: 2026-11-02.</p>')) then
    raise exception 'Explanation or references changed since review; aborted';
  end if;
  if t.exam_id<>'14' or t.question_id<>'27005' or t.locale<>'ko'
     or t.visibility<>'approved' or t.locked
     or t.approved_post_count<>(select count(*) from public.quizeey_posts where topic_id=t.id and visibility='approved') then
    raise exception 'Topic context or count changed; aborted';
  end if;
  if s.kind<>'question_report' or s.exam_id<>'14' or s.question_id<>'27005' or s.locale<>'ko'
     or s.path<>'/craftsman-cook-korean-food' or s.body<>'문제·보기 오류
식품위생법상 영업신고를 하여야 하는 업종은?
>식품위생법상 영업신고를 하지 않아도 되는 업종은?'
     or (s.state<>'open' and not (s.state='resolved' and exists (
       select 1 from quizeey_private.moderation_audit where request_id='e9eb7b24-8f5b-4f61-b457-2d9910a8e727' and actor_id='00000000-0000-4000-8000-000000000001'
       and action='submission_resolved' and target_id=s.id and result->>'status'='200'))) then
    raise exception 'Report context or processing state changed; aborted';
  end if;
  if not exists (select 1 from quizeey_private.operator_credentials where username='admin' and actor_id='00000000-0000-4000-8000-000000000001') then
    raise exception 'Expected existing operator identity missing; aborted';
  end if;

  update quizeey_content.questions
    set explanation='<p><strong>정답: ② 즉석판매제조·가공업</strong></p><p>이 문항은 영업을 시작할 때 <strong>영업신고</strong>가 필요한 업종을 묻습니다. 즉석판매제조·가공업은 「식품위생법 시행령」 제25조제1항제2호에 따른 신고 대상입니다.</p><p>나머지 보기는 같은 시행령 제23조에 따른 <strong>영업허가</strong> 대상입니다.</p><ul><li>① 유흥주점영업: 허가 대상</li><li>③ 식품조사처리업: 허가 대상</li><li>④ 단란주점영업: 허가 대상</li></ul><p>따라서 신고와 허가를 구분하면 정답은 ②입니다. 허가 대상이라는 말은 아무런 절차 없이 영업할 수 있다는 뜻이 아닙니다. 2014년 당시 법령과 검토 시점의 현행 규정 모두 이 구분이 같습니다.</p>', reference='<p>근거: 국가법령정보센터, 「식품위생법 시행령」 <a href="https://www.law.go.kr/LSW/lsLinkCommonInfo.do?chrClsCd=010202&amp;lsJoLnkSeq=1026749125">제25조제1항제2호(영업신고 대상)</a> 및 <a href="https://law.go.kr/LSW/lsLinkCommonInfo.do?chrClsCd=010202&amp;lsJoLnkSeq=1026749079">제23조(영업허가 대상)</a>. 출제 당시 규정은 <a href="https://www.law.go.kr/LSW/lbook/lbFileDownload.do?flExt=pdf&amp;lbookConflSeq=36284&amp;lbookSeq=44103#page=93">법제처 「식품안전관련법령」(2014.1.3), 식품위생법 시행령 제23조·제25조(PDF 92~93쪽)</a>에서 확인했습니다. 검토일: 2026-11-02.</p>', modified_at=now()
    where question_id=27005 and explanation is null and reference is null;
  insert into public.quizeey_posts(topic_id,parent_id,display_name,body,visibility,source_post_id)
    values(t.id,null,'Quizeey 운영팀','신고 감사합니다. 법령을 확인한 결과 ② 즉석판매제조·가공업이 영업신고 대상이므로 기존 문제와 정답이 맞습니다. 나머지 보기는 허가 대상이며, 신고·허가의 차이를 해설에 추가했습니다.','approved','owner-review:question:27005:20261102')
    on conflict(source_post_id) do nothing;
  get diagnostics inserted=row_count;
  if not exists (select 1 from public.quizeey_posts where source_post_id='owner-review:question:27005:20261102'
     and topic_id=t.id and parent_id is null and display_name='Quizeey 운영팀'
     and body='신고 감사합니다. 법령을 확인한 결과 ② 즉석판매제조·가공업이 영업신고 대상이므로 기존 문제와 정답이 맞습니다. 나머지 보기는 허가 대상이며, 신고·허가의 차이를 해설에 추가했습니다.' and visibility='approved') then
    raise exception 'Existing review comment differs; aborted';
  end if;
  if inserted=1 then
    update public.quizeey_topics set approved_post_count=approved_post_count+1 where id=t.id;
  end if;
  resolution_result:=public.quizeey_admin_resolve_submission('00000000-0000-4000-8000-000000000001','e9eb7b24-8f5b-4f61-b457-2d9910a8e727',s.id,'resolved');
  if resolution_result->>'status' is distinct from '200' then
    raise exception 'Report resolution failed; aborted';
  end if;
  if (select approved_post_count from public.quizeey_topics where id=t.id)
     <> (select count(*) from public.quizeey_posts where topic_id=t.id and visibility='approved') then
    raise exception 'Comment count mismatch; aborted';
  end if;
end $review$;
commit;
