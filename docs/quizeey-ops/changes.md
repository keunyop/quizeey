# 변경과 실험 이력

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
