# 검증 기록

최종 hosted 검증 완료(2026-10-17): `dpl_ANXS2HUdcsoZeV6z7gPPjPZeJGWX`의 실제 SDK→DB→API/SSR→브라우저 원본값·정답 대사와 한국어·영어/복수정답/채점/복원/390px 모바일/권한·앱 bundle 경계가 통과했다. 외부 앱 요청/브라우저 오류0, Vercel 협업 툴바 요청9개는 전송 전 차단해 별도로 기록했다. owner 승인 임시 링크는 최초1시간 만료를 연장하지 않고 사용 후 폐기했고 HTTP302 인증 이동을 재확인했다. [cloud-preview-flow-evidence.json](cloud-preview-flow-evidence.json), [cloud-preview-access-evidence.json](cloud-preview-access-evidence.json). 아래 hosted SDK 미검증·임시 접근 승인 대기는 이전 상태다.

2026-10-17 최신 live 결과: 실제5테이블160,630행 전체 값 해시/sequence/constraint 대사 통과. anon/authenticated/service_role의 콘텐츠 직접 SELECT0, 공개 schema definer0, 비공개 schema HTTP406, anon reader HTTP401. Vercel 보호 preview READY/API target=staging, 공개 요청302→vercel.com, 단위58/typecheck/lint/build/Linux ci dry-run 통과. 실제 hosted SDK/채점·복원 브라우저 흐름은 아직 미검증이며 별도 임시 접근 승인 대기다. [cloud-preview-deployment-report.md](cloud-preview-deployment-report.md), [cloud-content-upload-evidence.json](cloud-content-upload-evidence.json). 아래 이전 미적용 상태를 최신 결과로 사용하지 않는다.

최신 live 결과: 사용자 A+B 승인 후 Supabase candidate1회 적용(version20261016235602).15테이블0행/public invoker10/private definer11/public definer0, FORCE RLS/owner/search_path/table/RPC/sequence ACL 전부 통과. HTTP PGRST106으로 private/content 비노출 확인. Advisor ERROR/WARN0, INFO는 [적용 결과](cloud-schema-apply-report.md)에서 설명했다. B signup 차단은 도구 부재로 owner 작업 대기이며 최신값false다. 실제 콘텐츠/preview 반출 질문은 답변 대기여서 업로드/배포0이다.

후속 actual reader는 cloud 미적용이며 로컬17.11 direct ID beyond20·bounded20·전체 버전·전체집합 랜덤1·NULL/빈값·카운터·role denial/backup restore·Python/Postgres UTC/UTF8 framed hash가 통과했다. 새 async SSR/legacy read loader 포함 unit58/typecheck/lint/build, 학습/URL browser8개와 보호 preview smoke 통과. [hosted-study-reader-evidence.json](hosted-study-reader-evidence.json), [cloud-content-preparation-evidence.json](cloud-content-preparation-evidence.json). actual hosted SDK/브라우저 흐름은 실제 업로드와 secret provisioning 후 검증해야 한다.

최신17.11 검증(2026-10-16): [hosted-schema-preflight.json](hosted-schema-preflight.json)의 live role/default ACL을 로컬 EDB17.11에 재현했다. 실제 연결은 current_user/session_user=postgres, NOSUPERUSER/BYPASSRLS/CREATEROLE다. 기존002/003/004/006 baseline 및 CLI 생성 새 boundary migration을 각각 검증했고15테이블 값·해시/함수 owner·ACL·search_path 복원, schema-only restore, restored session 폐기, anon/authenticated/service_role/PUBLIC 경계, 동시20회10수락/10제한, DDL transaction 취소가 통과했다. 통합 적용후보0행/권한과 데이터 보존 접근 차단 rollback도 통과했다. local CLI advisors는 No issues found. [hosted-schema-baseline-evidence.json](hosted-schema-baseline-evidence.json), [hosted-schema-rehearsal-evidence.json](hosted-schema-rehearsal-evidence.json). PG18 기존 회귀·Python26개·RPC HTTP mock6개 통과. 실제 Supabase Auth/PostgREST/역할/backup restore는 이 로컬 모델로 증명하지 않는다. Supabase cloud 변경0; [실행안](cloud-change-request.md).

최신 대상 갱신: 사용자의 명시 요청으로 Vercel `quizeey` / `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`를 지정 팀에 생성하고 재조회했다. Next.js/Node24.x, 배포0/도메인0. 이전 project 부재·답변 대기·리소스 생성0 기록은 생성 전 이력이다. [vercel-project-creation-evidence.json](vercel-project-creation-evidence.json). Supabase/콘텐츠/Auth/DNS 변경은 없다.

2026-10-16 America/Vancouver. 검토 커밋 `33e8fb73294d1ab66d87cb424d500b63a7320736`, 작업 브랜치 `modernization/discovery-foundation`. 운영 전환 완료 보고가 아니라 실제 조사·로컬 개발 milestone 기록이다.

최신 후속 검증: 지정 Supabase project/org Pro/us-west-2/PostgreSQL17.11, 앱테이블0/migration0/Auth user/session0을 읽기 전용으로 확인했다. 공개 Auth signup은 열려 있고 anonymous sign-in은 꺼져 있다. Vercel 팀의 기존5개 project에 Quizeey는 없어 대상 이름/ID를 질문했다. Vercel Pro·구성원 역할·쓰기 권한은 미검증이다. [cloud-account-evidence.json](cloud-account-evidence.json). 새 `server-only` Supabase forum transport의 실제 SDK HTTP mock6개를 포함해 단위 테스트55개, typecheck/lint/build 성공. 격리 PostgreSQL18 RLS/ownership/moderation/rate/backup restore와 protected preview smoke 재통과. HTTP routes의 hosted/production 차단 유지, cloud migration/콘텐츠 업로드/Auth 변경/리소스 생성0. [hosted-rehearsal-plan.md](hosted-rehearsal-plan.md). 아래49개/플러그인 미노출 내용은 이전 검증 시점의 기록이다.

| 검사 | 실제 결과 / 한계 |
| --- | --- |
| 소스 URL/API inventory | controller227경로(시험214, 영어27), sitemap238 loc, 초기 URL후보446 → 운영 목록 404경로2개 추가 후448. REST14개. 소스 템플릿 누락0 |
| 제한된 운영 공개 GET | 초기15/15 200, redirect0. 추가 catalog 경로3개: 200 1개/404 2개. 표본 canonical link 없음. 광고·쓰기 API 실행0 |
| 공개 읽기 API | 소스의 read-only 동작 확인 후 /tests·/versions·/question 각1회 직렬 POST, 3/3 200. 한국어 시험181/SQLD 버전3/표본 질문751·선택지4. 상대 slug와 boolean wire 계약 확인. 전체 DB snapshot 아님 |
| DB 자료/접근 | 초기 직접 연결1130 거부 후 SSH 내부 읽기 성공. EC2 localhost MySQL5.7.30, live DDL6개 확인. 승인된 원본167,205행/51,689,927바이트 READ ONLY 일관 snapshot·UTC·행수/해시 확인. 원본은 owner-only/Git ignored, Disqus XML 없음 |
| 레거시 Java | 공식 portable JDK8 checksum 검증 후 Gradle6.8.3 build 성공. Java test source 없음(NO-SOURCE). 앱 시작/DB 접속 없음 |
| 새 앱 | Node24.13.0, Next16.4.2, React19.3.1, TypeScript6.0.3, ESLint10.13.0; exact dependencies + lockfile |
| typecheck/lint/unit/build | `npm.cmd run check` 최종 성공. Vitest49개 통과(기술 token/보안 + 실제 조회 어댑터의20개 이후 ID·관계·NULL·해시/위치·hosted 차단 검증). @supabase/supabase-js2.118.0 exact pin |
| 이전/Disqus 단위 검증 | Python unittest26개 통과: 기존23개 + native 해설의 결정적 ID·정확한 본문/이름/UTC·ownership 없음·중복/orphan/폭/시간 차단 검증 |
| 브라우저 | 최종 전체11개 통과: 관리자1/forum2/compatibility4/practice4.227경로/title·정적 본문/이미지·legacy API·학습/mobile/키보드·기술 token 표시·스크립트/외부 요청0. 별도로 실제 archive 인증/API/채점·복원 smoke 통과. Edge/Chromium Windows 로컬 |
| 경로 회귀 | 227개 controller 경로의200/원래 title 보존, query direct link/별칭/invalid ID 400/404. **전체 본문·파일·운영 redirect·GSC95% 검증은 아님** |
| 학습/i18n | 한국어/영어, 단일·복수 ID 채점, 버전, skip/back/refresh/북마크, corrupt storage, 코드/표/이미지, mobile390px·키보드·axe 위반0(표본 영어 화면), 강제 locale redirect/가짜 hreflang 없음 |
| 로컬 forum HTTP/두 브라우저 | 실제 작성 폼, 선택/빈 이름, Secure/HttpOnly/Strict 쿠키, GET/신고에서 쿠키 안 만듦, pending/revision 격리, A/B 권한, cookie삭제/만료, XSS 텍스트 출력, CSRF, 입력한도, idempotency, 답글 parent·신고·자기삭제, 동시 제한 통과 |
| DB security/동시성 | 격리 PostgreSQL18.3: anon/authenticated 직접쓰기·moderation RPC·private 조회 거부, approved만 공개, imported ownership 없음. 동시20회 중10수락/10차단 |
| 관리자 인증/검토 | 실제 SDK + local Auth HTTP double. verified UUID allowlist, ordinary user/metadata role 거부, private session 폐기·만료, 공급자 JWT 유효 상태에서 logout cookie 재사용401, pending/수정/신고/잠금/승인/숨김/삭제·감사·idempotency·20개 keyset 페이지 통과. axe 표본0. **실제 Supabase 계정 검증 아님** |
| staging/fixture 복구 | raw staging 두 번 실행 후7행 유지. pg_dump/restore로 이전9개 + moderation_audit/admin_sessions 총11개 테이블 count 및 전체 행 해시 일치. SQL public role/admin transport 권한 검증 통과. **운영 backup 복구 증거는 아님** |
| 실제 원본 private 이전/복원 | 승인 원본167,205행을 raw JSONB와 private typed6테이블에 각각2회 적재·pg_dump/restore. 모든 raw payload/시험·버전/정답/counter hash와 typed 전체 값·UTC instant hash 일치. 원본 이상 관계·ID 보존, 5개 identity 원본ID 이후 확인. anon/authenticated/service_role은 raw/typed 접근42501 거부(복원 후 재확인), SCRAM loopback 서버 종료. **공개 serving ETL·Supabase 실계정·전체 EC2 복원 증거는 아님** |
| 정적 본문/이미지 | about/privacy 원문 추출 및 SSR 보존, 기존 이미지1개 sha256 보존/브라우저 로드 통과. script/광고/form 주입0. 과거 privacy 내용의 새 정책 승인 아님; contact/request 전달은 대기 |
| 보호 preview smoke | 실제 localhost에서 UTF-8 Basic 인증 없음/틀림401, 올바른 인증200, noindex, SSR 문제, live script 없음. hosted admin503/쿠키 없음·임시 preview 비밀번호 HTML 노출 없음. 서버 종료 |
| client bundle 경계 | 공개 JS에서 검사한 server auth env/key marker·fixture credential 문자열 검출0. 실제 운영 secret을 넣은 배포 검증은 아님 |
| DB 실제 호스트 | SSH/IMDSv2 i-046087bdb8dff10f7/us-west-2 확인, 실제 prod 설정localhost:3306/quizeey·Java DB socket10개·mysqld·SQL VERSION5.7.30 일치. 별도 RDS 자산 존재/용도는 미검증 |
| 배포/source 호환 | 실제 Java-open JAR SHA256 기록, server checkout7e6424c의 Java/templates Git tree가 reviewed33e8과 동일. controller class2개 byte 동일, HBS218개 줄바꿈 정규화 후 SHA256 동일. 모든 dependency/원본 build commit attestation은 아님 |
| 사용자 제공 EC2/SSH | 사용자 temporary TCP22 규칙 추가 후 성공. PEM 소유자 유지·해당 파일 ACL만 제한하고 원래 ACL 백업, 키 복사/출력0. host key pin. SSH stdin 읽기 도구만 실행, 서버 파일/패키지/서비스 변경0 |
| SSH 규칙 회수 | 기존5개 SSH 규칙은 유지. 사용자가 추가한 temporary 신규 rule ID 확인·조사 후 회수 필요. AWS API 연결·자동 회수 없음 |
| 실제 원본 관계/결정 | source의 중복/orphan/정답 오류는 겹친다. 문항별 합집합751개를 사용자 확인 범위대로 **새 서비스 dataset에서 제외**했다. 원본/운영 MySQL 유지. 남은26,733문항의 관계/정답 검증 통과. 원본 보관 테이블을 공개 serving에 사용하지 않는다 |
| 승인된 삭제 범위 | 원본ID 집합 SHA/행수751 검증. 연결 choice433/explanation26/counter726 제외. 무관한 orphan choice2438/counter18은 private 원본에 보존. 새 dataset107,516choices/2,183explanations/25,870counters. production 삭제/전환 승인 아님 |
| 새 콘텐츠 관계형 ETL/복원 | owner 승인 dataset → 별도 FK/unique 콘텐츠5테이블. exam181/version330/question26,733/choice107,516/counter25,870의 전체 값·UTC·원본ID hash가2회 적재/backup restore에서 일치. 실제 정답 ID 집합 대사, FK23503/중복choice번호23505 거부, 4개 sequence 원본ID 이후, anon/authenticated/service_role42501 거부·복원 후 재확인. 로컬 서버 종료. 사용자 해설2,183개는 native import 대기로 보존. 실제 Supabase/public serving 증거는 아님 |
| 실제 DDL 타입/HTML | 전체167,205행의 정확한 컬럼·정수·폭·NULL·UTC timestamp 통과. 텍스트144,033필드 검사, URL 자산 참조0은 파일 보존 증명이 아님. 중복 question10그룹/choice73그룹은 내용도 달라 자동 병합 불가. owner-only 오프라인 검토 HTML 작성 |
| 실제 HTML 정제 | 144,033필드, 정규화8,966개. parsed-text 차이36개는 모두 의도한 기술 token 복원. 예상 밖 text 차이0/재정제 차이0/활성 markup 검출0. 원문은 private 오프라인 차이 문서에만 저장. 모든 브라우저 layout/권리 검증은 아님 |
| 실제 dataset 로컬 학습 | 해시 검증된26,733문항의 local-archive 어댑터. 실제20개 이후 문항의 직접 API/SSR/browser 접근, 원본 ID/정답 집합/통계/NULL·빈 값·전체 버전/목록 대사,390px 채점/새로고침 복원 통과. 인증 없음/틀림401·삭제/다른 시험404·751 IDs 부재·noindex/no-store·외부 요청0·browser error0. 실제 source는 로컬 전용이며 hosted 사용 차단. 사용자 해설/작성자 이름은 artifact에 없음 |
| source 배포 포함 방지 | `.vercelignore`·runtime 전용 파일 읽기·Next trace 제외. 최종21개 trace의 private archive 포함0, client JS11개에서 고정 private env/path marker 검출0. 실제 hosted 배포 attestation은 아님. [local-content-build-boundary.json](local-content-build-boundary.json) |
| 실제 사용자 해설 native 이전 | 원본2,209개 중 승인된751문항에 속한26개를 새 대상에서 제외한2,183개 →630개 문항 topic. 두 번 적재·backup restore의 본문/작성자 이름/원본 ID/UTC 전체 해시 일치. 기존 innerText 계약대로 본문/이름 정확히 보존, pending 공개0, 계정/guest ownership 생성0, 무권한 edit403, 재적재 후 moderation 보존, 실제 앱 SQL의 언어 공통 해설 조회를 anon RLS에서 검증. private 서버 종료. hosted import/공개 미실행 |
| Vercel/Supabase 연결 | 사용자 연결 완료 통보·Plugin Management installed=true 확인. 현재 대화 도구 목록에 서비스 조회 도구가 없고 CLI도 없음. 실제 authenticated account 조회·Pro/리전/DB version 검증은 미실행. 새 대화 활성화 안내와 인계 작성. [session-handoff.md](session-handoff.md) |
| 광고/분석 mock | loader once/slot once·크기예약·광고차단·동의거절/preview 비활성·PII 제한 이벤트 단위 검증. 브라우저 표본 광고/분석/Disqus 요청0, 빈 광고 slot0 |
| npm audit | 최종 전체 dependency audit 취약점0 |
| CI | 별도 PostgreSQL18 service + checks/browser/Python workflow 작성. GitHub 원격 workflow는 아직 실행하지 않음 |
| 변경 범위 | Java 소스/기존 Travis·생산 root 유지. assistant의 외부 배포·운영 DB/app/DNS·AWS 종료0. 사용자가 temporary SSH 규칙 추가; 로컬 PEM ACL 제한. 추가 유료 리소스0 |

## 발견·해결한 문제

- 최신 TypeScript7은 현재 typescript-eslint와 호환되지 않았다. 지원되는 stable TypeScript6.0.3으로 pin했다.
- Next lint 설정의 간접 braces 취약점이 보고돼 ESLint10 + TypeScript/React hooks 공식 규칙으로 변경했다. 최종 audit0.
- Windows child-process pipe와 sandbox의 테스트 서버 종료 대기를 해결했다. 격리 pg_ctl 실행은 파일 출력/명시적 종료로 바꾸고 브라우저 실행 권한을 확보했다. 모든 소유 테스트 서버를 종료했다.
- 정상 forum 요청의 Next 내부 origin/브라우저 origin 차이를 local origin 명시 설정으로 해결했다. CSRF 검사는 유지했다.
- ESM JSON import와 browser response-body 대기를 수정했다. 작성 폼·API의 결과 및 private mine을 재확인했다.
- 기존 JS가 testId/questId/verNbr 문자열과 빈 version을 보내는 것을 발견해 fixture 조회 어댑터에 반영했다.
- 실제 `/tests`의 상대 slug 계약을 확인해 로컬 full-path 응답을 수정했다. catalog141 vs 실제 공조냉동 페이지140 차이와 현재404인 목록2경로는 별도 근거로 보존하고 임의로 수정하지 않았다.
- 공급자 signOut만으로 JWT가 즉시 무효화되지 않는 동작을 확인해 private hash 세션 registry·공유 폐기를 추가했다. Auth double도 JWT를 계속 유효하게 유지하며 server registry의 거부를 검증한다.
- 신규 관리자 테스트의 cleanup FK 순서와 Node JSON import attribute 호환성을 수정했다. 최종 브라우저10개 및 변경된 호환성3개가 통과했다.

## 검증 대기 / 다음 milestone

1. Supabase org/ref/리전/DB17.11/Pro·앱 schema 비어 있음과 Auth signup 설정을 확인했다. Vercel 팀은 확인했으나 Quizeey project 부재로 이름/ID 답변 대기. Vercel Pro·구성원 역할·쓰기 권한·Auth 관리 설정은 추가 확인 필요. [deployment-targets.json](deployment-targets.json), [cloud-account-evidence.json](cloud-account-evidence.json), [session-handoff.md](session-handoff.md).
2. 최신 DDL6개·원본ID·수량·UTC 일관 snapshot을 확보했다. 사용자 승인으로 오류751문항을 새 서비스 dataset에서 제외하고 원본을 보존했다. migration006/content ETL은 FK/unique와 원본 ID를 보존하는 별도 serving 모델이다. 실제 계정에서의 공개 transport·권한·최종 delta 검증이 필요하다. 기존 제공DDL5개·PK 없는 소스 INSERT로 대체하지 않는다.
3. 실제 archive ETL/asset manifest·Disqus export와 final delta·전체 HTML/crawl diff·GSC 클릭95%·최근 기준선·광고/CMP/GA4 계정 검증 필요. [source-reconciliation.md](source-reconciliation.md)가 최신 DB/배포 근거다.
4. Supabase 운영/preview RPC transport, 실제 provider admin UUID·allowlist·signup 제한 범위·peer HMAC limiter/cleanup schedule 필요. 관리자 session/검토 화면/폐기는 로컬 구현·검증했고 실제 provider 검증은 대기다. 현재 forum/admin DB transport는 **정확한 loopback fixture만 허용**한다.
5. 실제 배포와 Supabase 권한/RLS·격리·부하/성능·캐시/DB 요청 수, 운영 backup/rollback 리허설 필요. 로컬 PostgreSQL18의 superuser fixture 결과가 해당 Supabase 역할 권한을 증명하지 않는다.
6. 초기 canonical host/query 색인 정책(삭제 ID 포함), 남은 정적 본문·법적 고지 개편·contact/request 전달·이미지/권리, 실제 old `/app` 소비자와 write adapter 검증 필요. about/privacy 본문은 보존했다. 기본 앱은 fixture이며 보호된 local-archive 실제 학습과 사용자 해설2,183개 native 로컬 이전은 통과했다. hosted transport·대상 계정 권한·검토/공개·실제 기기 호환 검증은 남아 있다.
7. account 기반 실제 증분 비용, RPO/RTO·쓰기 중단·관찰기간, exact DB/DNS change request와 별도 AWS resource inventory/종료 승인안을 완성한다.

현재 production은 환경 gate에서 명시적으로 차단된다. build·fixture·preview smoke 통과는 운영 사용 승인이나 개편 완료를 의미하지 않는다.

추가 근거: [publication-candidate-evidence.json](publication-candidate-evidence.json), [content-rehearsal-evidence.json](content-rehearsal-evidence.json), [learning-html-evidence.json](learning-html-evidence.json), [local-content-flow-evidence.json](local-content-flow-evidence.json), [native-explanation-evidence.json](native-explanation-evidence.json). 사용자의751문항 삭제 결정은 새 서비스 입력에 반영했으며 운영 MySQL과 원본 backup은 변경하지 않았다. 실제 콘텐츠 서버 조회·채점/복원 및 native 해설 로컬 ETL/복원은 구현·검증했고, 다음은 계정 검증 후 hosted transport와 공개/권한 검증이다.

현재 Supabase/Vercel 플러그인 skill을 읽고 로컬 Next16.4.2 버전의 Server/Client 경계 문서를 대조했다. Supabase 공식 changelog의 [명시적 테이블 권한 변경](https://supabase.com/changelog/45329-breaking-change-tables-not-exposed-to-data-and-graphql-api-automatically), [Postgres15.19/17.11 변경](https://supabase.com/changelog/postgres-15-19-17-11-breaking-changes), [CBC TLS 폐기 일정](https://supabase.com/changelog/cbc-tls-ciphers-deprecated)을 확인했다. 실제 프로젝트 버전/적용 여부는 조회 전이므로 추정하지 않는다. 기존 migration의 명시적 GRANT/RLS와 최신 Node24 연결을 유지하고 hosted 적용 전 실제 버전으로 재검증한다.

추적 가능한 근거: [source-reconciliation.md](source-reconciliation.md), [source-snapshot-evidence.json](source-snapshot-evidence.json), [source-contract-evidence.json](source-contract-evidence.json), [source-rehearsal-evidence.json](source-rehearsal-evidence.json), [deployment-compatibility.json](deployment-compatibility.json), [deployment-targets.json](deployment-targets.json), [public-probe.json](public-probe.json), [public-read-api.json](public-read-api.json), [catalog-reconciliation.json](catalog-reconciliation.json), [catalog-route-probe.json](catalog-route-probe.json), [owner-supplied-schema.sql](owner-supplied-schema.sql), [legacy-schema-access-master.json](legacy-schema-access-master.json), [legacy-host-evidence.json](legacy-host-evidence.json), [static-copy-evidence.json](static-copy-evidence.json), [source-data-evidence.json](source-data-evidence.json), [toolchain-provenance.json](toolchain-provenance.json), [fixture-restore-evidence.json](fixture-restore-evidence.json). 작업 소유 포트3100/3101/55432/55433/55434와 preview smoke 서버를 종료했고 dependency·빌드·원본/백업·임시 자격 증명은 Git에 포함하지 않았다.
