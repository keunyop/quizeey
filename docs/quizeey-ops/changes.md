# 변경과 실험 이력

## 2026-11-18 한식 감염 경로 학습과 신고 검수

- [원본 글](../../web/src/components/CookingInfectionArticle.tsx)에 분변-경구와 침·비말의 경로 비교, 자체 제작 세 문제와 각 오답 이유, CDC·WHO 공식 출처를 담았다. 실제 한식조리기능사 2026-10 연습 경로를 확인했고 독립 콘텐츠·코드 검수를 통과했다.
- 최종 전체 로컬 검사 종료 코드 0: 타입·lint·단위 186개·빌드·브라우저 137개·광고 6개, 격리 DB/Auth 포함, skip 0. 기존 sitemap 날짜 기대값 실패를 고친 후 전체 재실행했다. 커밋 `b237270`의 Git production READY와 영향 경로 3건 읽기를 확인했다. 운영 결과는 [오늘 보고서](reports/2026-11-18-daily.md)와 [일지](journal/2026-11-18.md)에 이어 쓴다.
- 새 신고는 현 정답 유지 근거를 확인하고 해설/공식 출처 보강안과 복구안을 준비했다. 격리 DB 9건 검사 통과, 운영 DB 승인 대기·신고 open 유지. OPS-02는 과거 공개 자료 정리 범위안을 비공개로 마련했다. 데이터 변경·신고 조치·외부 답신은 없다.

## 2026-11-17 SQLD LEFT JOIN 학습 글과 Next.js 보안 패치

- [SQLD 원본 글](../../web/src/components/SqldLeftJoinArticle.tsx)에 `ON`과 `WHERE`의 외부 조인 조건 차이를 회원·주문 예제로 설명하고, 자체 확인 문제·PostgreSQL 공식 근거·실제 11월 SQLD 연습 경로를 연결했다. 별도 콘텐츠 검토에서 3행·1행 계산과 오답 이유를 확인했다.
- [CCNA IPv4 문제 해결 5문항](../seo/ccna-ipv4-troubleshooting-questions-draft-20261117.md)은 별도 초안으로 검토했다. 제품 등록·채점 흐름은 미검증이며 게시하지 않았다.
- Next.js 16.4.2의 보안 경고가 필수 빌드를 중단해 16.4.6으로 패치했다. 첫 Git push의 운영 빌드는 `npm ci` 잠금 파일 누락으로 실패했다. 누락된 선택 의존성 두 항목만 보강한 뒤 실제 `npm ci`와 최종 `check:local` 종료 코드 0(단위 186개·브라우저 122개·광고 6개 통과, DB/Auth fixture 부재로 13개 skip)을 확인했다. 운영 의존성 감사는 취약점 0건이다. 소유자 승인 후 수정 커밋 `e949fa1`의 운영 배포 READY·도메인 연결·영향 경로 3곳의 HTTP 200과 예상 내용을 확인했다. [오늘 보고서](reports/2026-11-17-daily.md)와 [일지](journal/2026-11-17.md)에 운영 읽기 결과를 기록한다.

## 2026-11-16 SQLD 집계 조건 학습 경로

- 기존 SQLD 가이드의 앞부분에 실제 11월 원본 연습 세트로 가는 링크를 추가하고, [WHERE·HAVING 원본 글](../../web/src/components/SqldHavingArticle.tsx)에 결제 상태·팀별 합계 예제와 선택지별 오답 이유를 연결했다. SQLD 시험명·20문항·관련 HAVING 문제를 로컬 fixture에서 확인했다.
- PostgreSQL 18 공식 설명, 예제 계산, 원본 확인 문제와 연습 링크를 별도 검토자가 확인했다. 신규 DB 문항이나 채점·학습 저장 데이터는 바꾸지 않았다. [오늘 일지](journal/2026-11-16.md)에 검색 근거의 한계와 출시·관측 상태를 기록한다.
- 현재 상태: 최종 전체 `check:local` 종료 코드 0(단위 186개·브라우저 120개·광고 시뮬레이션 6개 통과). 격리 DB/Auth fixture 부재로 브라우저 13개는 생략했으며 해당 흐름은 미검증이다. Git 커밋 `bb3965a`의 production READY와 영향 경로 4개의 HTTP 200·예상 내용을 확인했다. 성장 효과는 아직 미측정이다.

## 2026-11-15 조리 경로 교정과 메이크업 위생 학습 글

- 양식·일식·중식·복어 URL의 잘못된 한식 문제 제공을 안내로 바꾸고 목록·검색·사이트맵에서 제외했다. 기존 한식 문제·답안·북마크·점수와 조건 유지 링크를 독립 검수했다.
- [메이크업 위생 글](../../web/src/components/MakeupHygieneArticle.tsx)에 FDA·CDC 공식 근거, 자체 확인문제 두 개와 실제 기초 위생 세 문항의 연습 경로를 연결했다. 정답·오답 이유·적용 범위는 별도 검토를 거쳤다.
- 최종 전체 로컬 `check:local` 종료 코드 0: 단위 186개, 브라우저 131개, 타입·lint·빌드·광고 6개 시나리오 통과. 격리 DB/Auth 포함, skip 0개다. 상시 승인된 저위험 PO Git release 후보이며 실제 운영 결과는 push 이후 비공개 영수증에 기록한다. [보고서](reports/2026-11-15-daily.md)와 [일지](journal/2026-11-15.md)에 첫 실행 실패·수정, 범위 검수, 검색 유입 감소 가능성과 효과 미측정 상태를 기록했다.

## 2026-11-14 1,000 DAU 목표와 바리스타 학습 경로

- [성장 계획](growth-plan.md)에 2027-11-14까지 완결 28일 평균 DAU 1,000명이라는 관리 목표와 단계별 판단·계측 조건을 기록했다. GA4 잠정 기준선의 원값과 source 정보는 비공개 상태에만 두며, 효과나 달성 예측을 주장하지 않는다.
- GSC 검색 의도와 실제 바리스타 2급 11월 문제 세트를 대조해 [추출 비율 원본 글](../../web/src/components/BaristaExtractionArticle.tsx)을 작성했다. 계산·오답 이유·네 공식 출처·연습 링크는 별도 검토를 거쳤다. SCA 설문 수치를 평균 응답으로 정정했다.
- 최종 전체 로컬 `check:local` 종료 코드 0: 단위 184개, 빌드, 브라우저 108개, 광고 검사 통과. DB/Auth fixture 전용 브라우저 13개는 skip. Git release 후보이며 push 이후 운영 상태는 비공개 영수증에서 확인한다. [오늘 보고서](reports/2026-11-14-daily.md)와 [일지](journal/2026-11-14.md)에 우선순위와 관측 조건을 기록한다.

## 2026-11-13 SQLP 일일 학습 글과 문항 신고 검토

- 한국 SQLP 검색 의도와 실제 11월 SQLP 세트를 대조해 [실행계획 원본 글](../../web/src/components/SqlpPlanArticle.tsx)을 작성·독립 검수했다. PostgreSQL 공식 근거, 자체 확인 문제, 실제 연습 경로를 연결했다. PostgreSQL/Auth 격리 fixture를 포함한 `check:local`에서 단위 183개·브라우저 116개와 나머지 필수 검사가 통과했다.
- `master` Git push 커밋 `6201e126a1c5dbbd2f4f158deaace91ebcc81f52`와 운영 READY 배포의 SHA를 일치 확인했다. 새 글·블로그 목록·SQLP 연습 경로 세 곳의 읽기 GET은 모두 HTTP 200과 예상 내용을 반환했다. 효과는 28일 관찰 전까지 미측정이다.
- 신규 한식조리 문항 신고는 독립 기출 근거에서 정답 ④를 확인했다. 옛 표현과 비어 있는 해설·출처의 보완을 제안했으며 운영 DB 변경과 신고 해결은 승인 전 보류한다. OPS-06 네 조리 경로가 한식 시험 ID·학습 기록을 공유하는 범위를 확인하고 별도 교정을 backlog에 남겼다. 자세한 내용은 [오늘 보고서](reports/2026-11-13-daily.md)와 [일지](journal/2026-11-13.md)에 있다.

## 2026-11-12 OPS-01 운영 적용과 일일 글

- 소유자가 미처리 댓글 신고의 해결 시점까지 보존과 운영 DB 적용을 승인했다. 운영 Supabase migration 버전 `20261112232605`를 한 번 적용하고 함수 정의·권한·migration 목록을 읽기 확인했다. 실제 장기 미처리 신고의 동작은 관찰 대기다.
- [PO 스킬](../../.agents/skills/quizeey-po/SKILL.md)에 하루 한 편의 원본 글, 중복 방지, 검색·공식 근거, 실제 시험 문제 경로 검증, 게시 전 로컬 검사를 추가했다. [한식 식품위생 글](../../web/src/components/KoreanCookingArticle.tsx)은 독립 콘텐츠 검수와 최종 로컬 전체 검사(단위 183개·브라우저 114개 포함)를 통과했다. `master` Git push 뒤 production READY와 글·목록·한식시험·한/영 개인정보 고지 5경로의 HTTP 200/예상 내용을 읽기 확인했다.
- 기존 양식조리 URL이 한식조리 시험 ID 14와 문제를 보여 주는 결함을 로컬에서 재현했다. 자료 정합성을 확인하기 전까지 양식 글과 문제 링크를 게시하지 않는다.

## 2026-11-12 OPS-01 로컬 검증과 성장 조사

- [신고 보존 migration](../../supabase/migrations/20261112232605_preserve_open_forum_reports.sql)을 공식 CLI로 생성해 기존 후보 SQL을 담았다. 격리 DB에서 보존·정리·권한 검사를 통과했고, 빈 새 클러스터에 전체 migration을 적용한 후에도 동일 회귀가 통과했다. [DB 검사](../../tools/modernization/test_database.py)와 [CI](../../.github/workflows/modernization.yml)에 [회귀 SQL](../../supabase/tests/forum_report_retention.sql)을 연결했다.
- 독립 검수에서 기능·권한 차단 결함은 발견하지 못했다. 최초 `check:local`은 DB/Auth fixture 포함 브라우저 112개까지 통과했다. 이 항목은 승인 이전의 로컬 검증 이력이며 위의 운영 적용 기록이 최신 상태다.
- [성장 계획](growth-plan.md)에 기존 검색 유입을 학습 시작으로 연결하는 방안, 기존 페이지 의도 개선, 재방문 여정, 근거가 확인된 해외 기존 경로 파일럿을 우선순위와 측정 조건으로 기록했다. 자세한 결과는 [오늘 보고서](reports/2026-11-12-ops01-growth.md)에 있다.

## 2026-11-11 CCNA 한국어 글 게시 준비

- 소유자의 조기 게시 요청에 따라 검수된 IPv4 서브네팅 초안을 한국어 블로그 글에 통합하고 목록·사이트맵·CCNA 시험 페이지에 연결했다. [게시 보고서](reports/2026-11-11-ccna-ko-publication.md)에 범위와 검수 내용을 기록했다.
- 독립 검수에서 Cisco 공식 범위·전환 일정과 계산을 재확인했다. 기존 연습 회차 링크가 전체 23문항을 한 화면에 여는 것처럼 읽히던 설명을 고쳤다. 미게시 원본 5문항은 제품 글에서 예고하지 않는다.
- 릴리스와 영향 경로 읽기 확인은 [오늘 일지](journal/2026-11-11.md)에 기록한다. 신규 유입·학습 시작 효과는 아직 측정하지 않았다.
- `master` Git push 한 번으로 production READY 및 `quizeey.com` 연결을 확인했다. 새 글·블로그 목록·CCNA 시험 페이지의 읽기 GET 세 건 모두 HTTP 200과 예상 내용을 반환했다.

## 2026-11-11 문항 신고 처리 후속 확인

- 소유자의 별도 요청에 따라 이미 운영 반영된 한식조리 문항 정정과 공식 근거를 한 경로에서 재확인하고, 같은 미처리 신고 한 건을 관리자 감사 기록 함수로 완료 처리했다. [오늘 일지](journal/2026-11-11.md)에 처리 범위와 DB readback을 기록했다. 정답·보기·저장 점수는 바꾸지 않았다.

## 2026-11-11 문항 신고 검토

- 새 미해결 한식조리 문항 신고를 우선 검토했다. 정답 오류는 확인되지 않았고 질문·해설을 명확히 하며 식품안전 근거를 연결했다. 신고 원문과 원천 식별자는 비공개 기록에만 남긴다.
- 독립 검수로 변경 범위가 문항 한 건의 질문·해설·출처뿐이며 보기·정답·ID가 유지됨을 확인했다. 이전 릴리스의 고정 해시는 바꾸지 않고 승인된 정정 기록으로만 비교한다. [오늘 보고서](reports/2026-11-11-question-review-and-content-draft.md)와 [일지](journal/2026-11-11.md)에 검증과 release 상태를 기록한다.
- CCNA 한국어 IPv4 서브네팅 글은 로컬 초안이며 게시 전 전체 콘텐츠 검수와 로컬 품질 검사가 남아 있다.
- 정정은 커밋 `4aed5d4`의 `master` Git push로 운영 READY 확인, 영향 문항 한 경로의 읽기 smoke 통과. 원천 신고는 여전히 open이며 관리자 해결 조치는 수행하지 않았다.

## 2026-11-10 국가×시험 추가 입력과 사용자 대화

- 추가 GA4·국가 필터 GSC 네 자료를 검증해 비공개 교차 기준선·manifest·상세 보고서를 갱신했다. 공개 [추가 보고서](reports/2026-11-10-country-exam-followup.md)에는 판단과 일정을 기록했다. GA4 행 합계와 표시 총계의 차이, GSC 전체와 Pages 표 차이는 미해결로 표시했다.
- Owner가 요청한 한식조리기능사 댓글에 친근한 응원 답글 한 건을 게시하고 공개 읽기에서 중복 없이 확인했다. 원문·식별자·요청 영수증은 비공개 보관한다.
- 한국어 CCNA 글 11월 16일, 원본 연습문항 5개 11월 20일 게시를 검수 통과 조건의 목표로 정했다. 미국·캐나다 다음 영어 콘텐츠는 11월 23일 재판단한다. 이번 실행에서 새 글·문항은 아직 게시하지 않았다.

## 2026-11-10 국가·시험 다변화 GROWTH-01

- Owner의 유입 다변화 요청에 따라 새 일별·랜딩 자료와 기존 국가별 자료를 별도 기간으로 검증하고 상세 현황을 private 경로에 저장했다. 총계 불일치와 교차 차원 부재는 미해결로 유지한다.
- [실행계획](growth-plan.md): 기존 한국어 비조리와 영어 학습 경로를 우선 활용하고, 국가×시험 실측으로 다음 시장/시험을 선택한다. 새 지출·외부 홍보 전송·문항 대량 발행 없음.
- 홈 검색창 다음에 언어별 내부링크를 추가했다. 실제 목적지·JavaScript 비활성·모바일·키보드 검증과 별도 검토를 통과했다.
- 최초 전체 회귀에서 긴 Texas 시나리오가 테스트 전체 시간 제한을 초과했다. 해당 시나리오의 모든 assertion을 유지하고 한정된 시간 예산만 조정해 전체 검사를 다시 진행한다.
- 이어진 복합 접근성 검사는 경로별로 분리해 동일 검증 범위를 유지했다. 최종 전체 실행은 기존 November 320문항 단위 테스트의 시간 초과로 실패했다. 모든 테스트 조정은 준비 상태이며 최종 회귀 통과 전 release하지 않는다.
- 해당 단위 테스트는 단독 1.389초 통과했다. 로컬 Vitest 워커 수를 2개로 제한한 뒤 전체 `check:local` 종료 코드 0: 단위 183개·브라우저 97개·빌드·광고 회귀 통과, DB/Auth 13개 skip. 독립 검토도 완료했다. Git release readback 대기다.
- 배포 상태는 [오늘 일지](journal/2026-11-10.md)와 [현재 상태](state.json)를 따른다. 기능 구현·운영 반영·유입 효과는 별도 상태로 기록한다.

## 2026-11-09 최초 실행

- PO: 개발 브랜치 생성, 공식 Skill 형식 확인, 역할별 코드/콘텐츠/측정 감사, 현재 Supabase·Vercel·GitHub 읽기와 과거 CSV 재계산. 원문·비밀·비공개 수치를 새 tracked 문서에 넣지 않음.
- Engineering: [SQL 후보](../../tools/content/preserve_open_forum_reports.sql), [회귀 SQL](../../supabase/tests/forum_report_retention.sql) 작성. migration 생성 CLI는 telemetry 권한 오류, 로컬DB 시작은 restricted token 오류. 권한 확대 거절 후 반복하지 않음. **운영 미적용, SQL 실행 미검증**.
- 후보는 open 신고의 만료삭제와 관리자목록 만료필터를 함께 수정한다. 원본 migration 덮어쓰기 없음. 관리권한/다른 정리기능 유지가 검수 기준이다.
- 보존 연장에는 신고사유 개인정보 장기보관 위험이 있다. 오래된 open 검토 기준/비식별 보관을 정한 뒤 운영 승인 요청. 검증 전 release-ready로 표시하지 않음.
- 복구: 로컬 후보 제외는 운영에 영향 없음. 적용 요청 시 직전 함수정의/권한을 비공개 보존하고 원복 SQL 검증. 기존 cleanup 복귀는 신고삭제 위험을 되살리므로 조용히 원복하지 말고 forward-fix/정리일시중단을 승인 범위에서 검토.
- 외부 답글/신고조치/콘텐츠 게시/배포/새 유료 도입/예약 등록 없음. 비공개 기준선으로 재측정하기 전 수익효과 주장 없음.
- 독립 Trust 검수자는 root가 실제 파일을 읽어 전달한 SQL/회귀 로직을 정적으로 검토했다. 차단 수준 결함은 찾지 못했지만 실행 검증은 아니다. private queue 직접호출 거절·21개 keyset 경계와 runner 연결은 추가 확인 대상이다. 미해결 신고는 계속 보존되고 이미 만료된 신고는 해결 후 다음 cleanup에서 즉시 삭제될 수 있다(해결 후30일 유예 아님).

## 2026-11-09 자율 일지와 routine release 정책

- 매 실행이 최신 일지·상태·backlog·미해결 source를 읽고 오늘의 최우선 feasible 작업을 스스로 선택하도록 `quizeey-po` Skill을 갱신했다.
- 선택 근거, 완료 조건, 진행, 검증, release 상태와 다음 재개 지점을 날짜별 일지에 기록하도록 했다.
- 검증된 routine low-risk 작업은 `master`에서 직접 commit하고 GitHub push 한 번으로 release할 수 있는 standing authority를 기록했다. 필수 로컬 check가 실패하거나 생략되면 release하지 않는다.
- GA4, Search Console, AdSense의 최소 읽기 연결 절차와 제품별 인증 차이를 문서화했다.
- 검증: 로컬 파일 readback과 state JSON parse를 확인했다. Skill validator, Git 검사와 `web/npm run check:local`은 host command runner 장애로 실행하지 못했다.
- release: 수행하지 않았다. command runner 복구 후 `journal/2026-11-09.md`에서 재개한다.

## 2026-11-09 Google 데이터 연결 안내 상세화

- GA4, Search Console과 AdSense 연결을 Google Cloud 준비부터 최소 권한, credential 보관, OAuth, 최초 API readback, 수동 export, 오류 진단과 해제까지 단계별로 확장했다.
- GA4는 Property Viewer service account, Search Console은 `webmasters.readonly` 사용자 OAuth, AdSense는 service account가 아닌 `adsense.readonly` 사용자 OAuth를 기본 구조로 정했다.
- AdSense Standard UI 역할이 보고 전용이 아니라는 점과 제품별 시간대·지연·분모 차이를 기록했다.
- 공식 Google 문서 대조와 로컬 파일 readback은 완료했다. 실제 계정 연결과 sample read는 Owner 연결 후 수행한다.
- host command runner 오류로 Git 검사, commit, push와 release는 수행하지 않았다.

## 2026-11-09 Owner-uploaded report 입력함

- Google API 없이 운영할 수 있도록 로컬 `docs/report/` 입력함, export checklist와 주기를 추가했다.
- raw report는 공개 Git에서 제외하고 CSV/XLSX/PDF를 untrusted private input으로 처리한다.
- Skill은 처리 manifest를 사용해 중복을 피하고 parse·validation·baseline write·readback 성공 후에만 processed 상태를 올린다.
- 주간 핵심6개와 월간 확정수익/비용을 정의했으며, 부담이 큰 경우 핵심3개로 시작할 수 있게 했다.
- 실제 report parse는 입력 파일이 없어 미실행이다. command runner 오류로 Git/validator 검증과 release는 수행하지 않았다.

- GROWTH-01 commit `f7718a6` production READY와 한/영 홈 새 링크의 읽기 smoke를 확인했다. 효과는 아직 미측정이다.

## 2026-11-19 · CCNA IPv4 한국어 연습과 설정 점검

- 문제: 기존 한국어 CCNA 글이 영어 10월 세트로만 이어지고, 준비한 한국어 원본 5문항이 제품에 등록되지 않았다.
- 변경: 별도 한국어 11월 회차와 양쪽 마스크 판단·AND·실제 통신 구분을 설명하는 원본 글을 연결했다. 기존 영어 문항과 저장 식별자를 보존한다. 현재 Cisco 안내의 버전별 시험 언어 표기 차이도 기존 글에 반영했다.
- 근거/검증: [문항 검수 기록](../seo/ccna-ipv4-troubleshooting-questions-draft-20261117.md), 별도 공식 원문·계산·코드 검수, DB/Auth 포함 전체 로컬 검사 종료 0(단위 190·브라우저 141·광고 6, skip 0). 첫 테스트 제목 기대값 실패는 수정·독립 검토 후 전체 재실행했다.
- 상태: 커밋 f47550e의 운영 Git production READY·도메인 연결·영향 경로 네 곳 읽기 확인 완료, 검색·학습 효과 미측정. 운영 DB·신고 변경 없음. 최종 출시·관측·복구 기록은 [오늘 일지](journal/2026-11-19.md)를 따른다.
