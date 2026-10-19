# Quizeey 개편 작업 기록

이 문서는 전환 당시의 조사·승인·검증 이력이다. 2026-10-19에 v1 코드와 소스 전용 조사 도구를 정리했으며, 현재 v2 개발·검증 절차는 루트 [README](../../README.md)와 [AGENTS.md](../../AGENTS.md)를 따른다.

최종 preview 검증 완료(2026-10-17): [실제 문항 보호 preview](https://quizeey-13nrq49m1-kevins-projects-e2dcc34c.vercel.app) READY. 실제 API 원본 대사/한국어·영어 채점/복수정답/새로고침 복원/모바일/권한·정적 bundle 경계가 통과했다. 모바일 회차 선택 상자의2px 넘침을 수정했고 owner가 승인한 임시 접근은 검증 후 모두 폐기했다. SSO+앱 Basic은 유지된다. [흐름 증거](cloud-preview-flow-evidence.json), [임시 접근 폐기](cloud-preview-access-evidence.json), [배포 기록](cloud-preview-deployment-report.md). 아래 자동검증 승인 대기 문구는 이전 상태다.

2026-10-17 최신: 실제 콘텐츠 업로드와 보호 preview를 별도 승인받아5테이블160,630행(문항26,733개)을 적재·전체 값 해시 대사했다. Signup 차단과 Preview Secret 등록도 확인했다. Vercel `dpl_D576fzEfZJZDkXYEekr53Us4YAXg`는 READY/API target=staging이며 SSO+앱 Basic 유지, 공개 접근302 인증 이동을 확인했다. 자동 브라우저 검증은 임시 접근 승인 대기다. [배포·검증 한계](cloud-preview-deployment-report.md), [적재 증거](cloud-content-upload-evidence.json). 아래 미승인/미적용 기록은 과거 이력이다.

최신 실제 적용: 사용자가 A+B를 승인해 Supabase 빈 schema15테이블을 실제 적용했고 권한/RLS/postflight가 통과했다(version20261016235602). [cloud-schema-apply-report.md](cloud-schema-apply-report.md). B는 승인됐으나 Auth 변경 도구가 없어 owner Dashboard 작업 대기다. 사용자는 샘플 preview 대신 실제 문항 버전을 선택했다.5테이블160,630행 반출/보호 preview는 별도 질문 답변 대기이며 아직 업로드/배포0. 실제 reader/async SSR/API는 로컬 개발·검증했고58unit/build·browser8개·17.11 reader/복원 통과. [preview-content-upload-request.md](preview-content-upload-request.md), [hosted-study-reader-evidence.json](hosted-study-reader-evidence.json). 아래 미승인/클라우드변경0은 이전 시점 이력이다.

최신 검증·실행안(2026-10-16): PostgreSQL17.11에서 실계정의 non-superuser postgres/public 기본 ACL을 재현해 기존4개 migration을 검증했다. 새 private_rpc_boundary migration으로 public 권한 상승 구현을 private으로 이동하고 감사 없는 하위 moderator 직접 호출을 차단했다. schema-only/15테이블 합성 데이터 backup restore·역할/RLS/동시성·DDL rollback·local advisors·정확한 통합 SQL/접근 차단 rollback 검증을 완료했다. [cloud-change-request.md](cloud-change-request.md), [hosted-change-manifest.json](hosted-change-manifest.json), [hosted-schema-rehearsal-evidence.json](hosted-schema-rehearsal-evidence.json). 기존 PG18 회귀/Python26개/RPC6개도 통과했다. Supabase cloud 적용/실제 콘텐츠 업로드/Auth 변경0이다. 실행안은 빈 스키마 생성(A)과 signup 차단(B)을 분리하며 실제 적용은 아직 승인받지 않았다.

최신 대상 갱신: 사용자의 명시 요청으로 Vercel `quizeey` / `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`를 지정 팀에 생성하고 재조회했다. Next.js/Node24.x, 배포0/도메인0. 이전 project 부재·답변 대기·리소스 생성0 기록은 생성 전 이력이다. [vercel-project-creation-evidence.json](vercel-project-creation-evidence.json). Supabase/콘텐츠/Auth/DNS 변경은 없다.

사용자 요청: `QUIZEEY_MODERNIZATION_REVIEW.md` 14절에 따라 조사·호환성 검증부터 시작하고 확정 요구사항은 계속 구현한다. 운영 DB/DNS 전환과 AWS 종료는 검증 결과와 실행안을 준비한 뒤 별도 확인받는다.

검토 기준: `33e8fb73294d1ab66d87cb424d500b63a7320736`. 작업 브랜치: `modernization/discovery-foundation`. 날짜: 2026-10-16 America/Vancouver.

최신 후속 작업: Vercel·Supabase 도구가 새 대화에 노출되어 기존 대상 읽기 전용 조회를 완료했다. Supabase org Pro/us-west-2/PostgreSQL17.11/앱테이블0/migration0/Auth user0을 확인했다. 공개 Auth 설정의 signup은 열려 있다. Vercel 팀 접근은 확인했으나 기존5개 프로젝트에 Quizeey가 없어 대상 이름/ID를 질문했다. Vercel Pro와 실제 구성원 역할은 커넥터 응답으로 확인되지 않았다. [cloud-account-evidence.json](cloud-account-evidence.json). 서버 전용 Supabase forum transport와 SDK wire/security 테스트6개를 추가했으며 기존 HTTP routes는 활성화하지 않았다. [hosted-rehearsal-plan.md](hosted-rehearsal-plan.md)에 범위·migration 해시·역할/RLS·native 검토/공개 리허설 계획을 정리했다. cloud 쓰기/원본 업로드/새 리소스 생성0. 아래 도구 미노출 기록은 이전 대화의 이력이다.

현재 산출물:

- [baseline.md](baseline.md): 사실·사용자 제공 수치·미확인 항목
- [seo-url-inventory.csv](seo-url-inventory.csv), [public-probe.json](public-probe.json): URL 발견 근거와 제한된 운영 GET 결과
- [api-contracts.md](api-contracts.md), [data-mapping.md](data-mapping.md), [ads-analytics-contract.md](ads-analytics-contract.md): 보존 계약
- [guest-posting-contract.md](guest-posting-contract.md), [source-data-evidence.json](source-data-evidence.json): native forum과 소스의 데이터 근거
- [admin-auth-contract.md](admin-auth-contract.md): 관리자 allowlist·비공개 서버 세션·검토·감사·로그아웃 계약
- [owner-supplied-schema.sql](owner-supplied-schema.sql), [legacy-schema-access-master.json](legacy-schema-access-master.json): 제공 DDL와 읽기 전용 DB 접근 거부 근거
- [public-read-api.json](public-read-api.json), [catalog-reconciliation.json](catalog-reconciliation.json), [catalog-route-probe.json](catalog-route-probe.json): 실제 읽기 API·시험 ID/경로 차이
- [legacy-host-evidence.json](legacy-host-evidence.json), [static-copy-evidence.json](static-copy-evidence.json): AWS IP/PTR와 정적 본문·자산 근거
- [ec2-inspection.md](ec2-inspection.md): 사용자가 식별한 questionbank 인스턴스와 읽기 전용 서버 조사 절차
- [ssh-access-evidence.json](ssh-access-evidence.json): 기존 PEM을 사용한 SSH timeout과 22/3306 도달 여부
- [ssh-rule-diagnosis.json](ssh-rule-diagnosis.json): 기존 SSH 허용 목록에 현재 공인 IP가 없음과 TCP22 `/32` 추가·회수 준비안
- [decisions.md](decisions.md), [cost-model.md](cost-model.md): 승인 범위와 비용 가정
- [migration-runbook.md](migration-runbook.md), [rollback-runbook.md](rollback-runbook.md), [launch-checklist.md](launch-checklist.md): 운영 변경 준비
- [verification-report.md](verification-report.md): 실제 검증 결과 및 남은 게이트
- [deployment-targets.json](deployment-targets.json): 사용자 확인 Vercel team ID·Supabase project/리전과 계정 검증 상태

최신 원본 조사: [source-reconciliation.md](source-reconciliation.md). 운영은 EC2 내부 **MySQL5.7.30**이며 실제 JAR의 controller2개·템플릿218개를 저장소와 대조했다. 사용자의 명시적 승인으로 6개 테이블 167,205행을 소유자 전용 로컬 폴더에 반출했다. 중복·고아 관계 때문에 공개 이전은 차단하고 원본을 private staging에 보존한다. 이전 SSH timeout·DDL 미확인 기록은 이 조사 이전의 이력이다.

이후 사용자가 오류751문항을 새 서비스 이전 대상에서 삭제하고 원본을 유지하도록 확인했다. [publication-candidate-evidence.json](publication-candidate-evidence.json)의 ID 집합 해시로 범위를 고정한 private 새 dataset26,733문항을 생성했고 관계/정답 검증이 통과했다. migration006과 `content_etl.py`는 원본 ID를 유지하는 FK/unique 콘텐츠 모델이다. 사용자 해설2,183개는 별도의 native forum 이전 대상으로 보존한다. [learning-html-evidence.json](learning-html-evidence.json)은 실제 전체 텍스트의 기술 token 보존·정제 안정성 검증이다. 실계정·권리·URL·광고/동의·최종 전환 gate는 계속 유지한다.

새 콘텐츠5테이블2회 ETL/정답/ID/UTC·FK/unique·sequence·역할 거부·backup restore도 통과했다. [content-rehearsal-evidence.json](content-rehearsal-evidence.json). 실제 dataset의 서버 조회 어댑터도 구현했다. 기본값은 fixture이며 `local-archive`는 소유자 전용 원본 폴더의 해시 검증된 artifact만 읽는다. 직접 question ID 조회는20개 응답 제한 **전**에 수행하며 전체 version 목록은 별도로 읽는다. 실제 원본 ID·정답·통계·NULL/빈 값,20개 이후 문항의 직접 접근, 모바일 채점과 새로고침 복원이 통과했다. 인증 없음/틀림401, 삭제/다른 시험 문항404, noindex/no-store, 외부 요청0을 확인했다. [local-content-flow-evidence.json](local-content-flow-evidence.json). 서버 캐시는 불변 콘텐츠만 보관하며 locale별 응답을 분리한다. 이 모드는 loopback·Basic 인증·로컬 stage가 필수이고 hosted 환경에서 차단된다. 작성자 이름·사용자 해설 본문은 학습 artifact에 넣지 않는다.

사용자 확인을 다시 요청하지 않을 항목: 기존 Pro 사용, 위 target IDs/전용 project/리전, signup-free forum, 첫 production AdSense,751문항의 **새 서비스 대상 삭제·원본 백업 유지**. 사용자가 Vercel·Supabase 연결 완료를 알렸고 플러그인 설치 상태도 확인했다. 현재 대화에는 두 서비스의 호출 도구가 노출되지 않아 계정 접근은 미검증이다. 재설치·재연결·키 전달을 요구하지 않는다. 새 도구를 불러올 대화의 구체적 인계는 [session-handoff.md](session-handoff.md)에 정리했다. DB/DNS 전환·AWS 종료는 검증된 구체적 실행안으로 별도 확인받는다.

재현:

```powershell
python -m unittest discover -s tools/migration -p 'test_*.py'
python tools/modernization/test_database.py
cd web
npm.cmd ci
npm.cmd run check:local
npm.cmd run dev:local
```

2026-10-19 v1 정리: 기존 Java 소스·템플릿, Gradle·Travis·Eclipse 설정과 빌드 결과, 해당 소스에 의존하던 조사·추출·JDBC 검사 도구는 제거했다. 이전 소스는 Git 이력에 남아 있다. `web/fixtures/legacy-contract.json`, `web/fixtures/legacy-pages.json`, `web/public/`의 이관 자산은 v2가 계속 사용하므로 보존한다. 아래를 포함한 전환 단계·승인 대기 기록은 작성 당시의 이력이며, 현재 개발·검증·릴리스 규칙은 루트 [README](../../README.md)와 [AGENTS.md](../../AGENTS.md)를 따른다. 회귀 테스트는 로컬 fixture만 사용한다.

native forum의 로컬 작성 화면은 `test_database.py --serve`로 비어 있는 격리 DB를 시작하고 셸의 `QUIZEEY_LOCAL_FORUM_DATABASE_URL`에 `.env.example`의 정확한 loopback URL을 설정하면 활성화된다. 자동 로드되는 `.env.local` 파일은 만들지 않는다. Playwright forum 검증도 이 환경 변수가 없으면 명시적으로 skip한다. Windows에서는 `PLAYWRIGHT_CHANNEL=msedge`로 설치된 Edge를 사용할 수 있다. CI는 별도 PostgreSQL18 service를 만들어 확인한다.

관리자 브라우저 재현은 `test_database.py --serve --auth-fixture`와 `QUIZEEY_AUTH_FIXTURE_URL=http://127.0.0.1:55433`를 명시한다. Playwright가 테스트용 provider/allowlist를 로컬 Next 서버에 전달한다. 실제 Supabase 계정을 만들거나 가입 설정을 바꾸지 않는다. 방문자에 Auth 호출이 없고 logout 후 공급자 JWT가 유효해도 서버 측 재사용이 차단됨을 검증한다.

사용자 해설의 native 이전도 격리 로컬 DB에서 통과했다. [native-explanation-evidence.json](native-explanation-evidence.json): 630개 문항별 topic/2,183개 post, 두 번 적재·backup restore의 전체 값/원본 ID/UTC 일치. 원본 UI가 `innerText`를 사용하므로 본문과 이름을 정확히 보존하고 React가 텍스트로 출력한다. 모든 글은 pending, 공개 조회0, 임의 계정/guest 소유권 생성0, 무권한 수정403이다. 재적재는 이후 검토 결과를 초기화하지 않으며, 기존 question-ID 기반 해설의 언어 공통 범위를 실제 앱 조회 SQL/RLS로 검증했다. 실제 Supabase import·공개는 실행하지 않았다. 테스트용 private 서버는 종료했다.

다음 운영 단계에는 새 대화에서 플러그인 도구를 불러온 뒤 기존 Pro 대상·권한·리전·DB 버전·기존 스키마/Auth 설정을 읽기 전용으로 검증한다. 로컬 ETL/해설 이전 결과를 토대로 hosted transport·파일 대사·Disqus·최종 delta 검증을 이어간다. 직접 DB 연결의 과거1130 거부는 SSH 내부 읽기로 해결했다. `inspect_mariadb.sql` 자체는 실행하지 않았으며 별도 SSH 검사 도구로 실제 DDL을 취득했다. AWS 계정 전체 inventory와 hosted 전환은 미실행이다.
