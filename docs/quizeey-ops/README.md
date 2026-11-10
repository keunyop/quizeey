# Quizeey 제품 운영

목표는 정확한 학습·완료·재방문과 지속 가능한 AdSense 수익을 함께 개선하는 것이다. 수익 목표는 최신 기준선과 비용을 확인한 뒤 정한다.

저장소는 공개 상태이므로 비공개 지표·사용자 원문·인증 정보를 새 문서나 이슈에 복제하지 않는다. 운영 기록의 상세 수치와 처리 cursor는 ignored `.modernization/quizeey-ops/`에 보관한다.

2026-11-09 최초 실행은 코드·기존 보고서·현재 Supabase 집계·Vercel 로그·GitHub 열린 이슈를 확인했다. 운영 배포·신고 조치·예약 실행은 수행하지 않았다.

## 재개와 문서

[상태](state.json), 최신 [일지](journal/2026-11-09.md), 마지막 보고서부터 읽고 [현황](inventory.md), [접근](access.md), [지표](metrics.md), [우선순위/30일 방향](backlog.md), [변경 이력](changes.md)을 필요한 만큼 갱신한다. [.agents Skill](../../.agents/skills/quizeey-po/SKILL.md)을 `$quizeey-po daily`처럼 호출한다. 이는 Skill의 자연어 입력 규약이며 Codex 내장 명령 옵션이 아니다. Owner가 오늘 할 일을 지정할 필요는 없다. Skill이 미완료·신규 신고·오류·지표·backlog를 대조해 오늘 가능한 최우선 작업을 고르고 일지에 근거와 완료조건을 먼저 기록한 뒤 실행한다.

공식 [Codex Skills](https://developers.openai.com/codex/skills/) 문서의 name/description frontmatter와 저장소 `.agents/skills/` 위치를 적용했다. 자동검색에 보이지 않으면 직접 파일을 읽도록 요청하거나 새 세션에서 확인한다.

## 책임과 승인

PO는 목표·범위·우선순위·결과통합, Growth는 수요·검색·재방문, Engineering은 구현·검증·복구, Content는 문항·해설·번역, Data는 계측·비용·실험, Trust는 분류·신고·처리이력을 맡는다. 필요한 역할만 활성화하며 중요코드/문항 작성자와 검수자는 다르게 지정한다.

조회·조사·초안·로컬 수정/테스트·문서와 routine low-risk release는 허용됐다. 검증된 routine PO 변경은 master에서 직접 작업·commit 후 `git push origin master` 한 번으로 배포할 수 있다. required check가 실패·생략·중단되면 배포하지 않는다. 위험하거나 파괴적이거나 여러 변경을 묶는 작업은 개발 branch를 사용한다. 신규 유료비용/예산증가/운영DB 변경/파괴적변경/영구제재/대규모공개변경은 구체적인 영향·복구안 후 승인이 필요하다. 외부 사람에게 전달되는 메시지는 명시적 전송 승인 없이는 보내지 않는다.

기존 관리자 기능의 존재만으로 반복 신고조치가 승인됐다고 가정하지 않는다. 현재는 분류/검증/수정 준비까지 수행하고, 승인된 조치범위를 기록한 뒤 그 반복업무에 재사용한다. 운영 반영과 readback 전에는 resolved가 아니라 prepared/awaiting_release다.

Private 경로는 ignored일 뿐 접근통제나 백업이 아니다. 다른 실행환경에서는 안전한 비공개 저장소로 이관해야 한다. Git에는 sanitized 정책·코드·작업상태만 보존하고 staged diff를 검토한다. 기존 공개 지표/원문 노출 정리는 별도 범위이며 history를 자동 재작성하지 않는다.

## 일지 규칙

`docs/quizeey-ops/journal/YYYY-MM-DD.md`에 같은 날 실행을 이어 쓴다. 시작 시 관측 상태·오늘 선택한 작업·선정 근거·완료조건·성과지표·release/rollback을 남긴다. 진행 중에는 실제 검증과 상태 변경을 추가하고, 종료 시 완료/미완료·운영 반영·성과 대기·실패/복구·owner 조치·다음 후보를 남긴다. private 지표·사용자 원문·source ID는 일지에 쓰지 않는다. 중단된 실행도 마지막 성공 checkpoint와 정확한 재개 단계가 있어야 한다.

Google 제품을 연결하는 구체적인 절차는 [connections.md](connections.md)를 따른다. API 연결 대신 Owner가 내보낸 보고서를 사용할 때는 [로컬 report 입력함](../report/README.md)의 주기·파일명·필수열을 따른다. `docs/report/`의 원본 export는 private 운영 입력이며 Git에 commit하지 않는다. Skill은 새 파일만 처리하고 성공한 readback 뒤에만 private 처리 manifest를 갱신한다.
