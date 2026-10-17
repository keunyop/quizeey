# 다음 대화에서 이어갈 작업

2026-10-17 America/Vancouver. 작업 폴더는 이 저장소, 브랜치는 `modernization/discovery-foundation`이다. `README.md`, `verification-report.md`, 이 문서와 `hosted-rehearsal-plan.md`를 읽고 진행한다.

최신 실행 완료: owner가 2026-10-17 **실제 문항 업로드 + 보호 preview 배포**를 명시적으로 승인했다. 지정 Supabase의5테이블160,630행을191개 원본 배치로 적재했고 **전체 값 해시5개·행수·sequence watermarks·constraint·역할/HTTP 경계가 통과**했다. [cloud-content-upload-evidence.json](cloud-content-upload-evidence.json). reader migration은 `quizeey_private_study_reader_v1` / 실제 version `20261017071433`이다. completed191/pending=null checkpoint를 owner-private에 보관하며 재업로드하지 않는다. 최종 Vercel 배포 `dpl_ANXS2HUdcsoZeV6z7gPPjPZeJGWX`는 **READY**, API target=staging(legacy preview), URL `https://quizeey-13nrq49m1-kevins-projects-e2dcc34c.vercel.app`이다. 실제 자동 검증에서 회차 select의 모바일2px 넘침을 발견해 CSS min-width/max-width로 수정·재배포했고390px 너비를 확인했다. [cloud-preview-deployment-report.md](cloud-preview-deployment-report.md). 접근 암호와 최종 URL은 `.modernization/exports/source-265c3ca16e/preview-access.txt`에만 보관한다. Linux lockfile의 누락된 emnapi3항목만 보완해 기존 버전을 유지했고 Linux ci dry-run/unit58/typecheck/lint/build가 통과했다. 실제 콘텐츠/작성자/비밀값을 Git·채팅에 출력하지 않는다.

실제 hosted API/브라우저 검증까지 **통과**했다. 직접 ID beyond20/원본 본문·선택지·정답/전체 시험·회차/카운터/제외ID·잘못된ID 거부/한국어·영어/복수정답 부분선택 오답/채점·새로고침 복원/모바일/정적 앱 bundle 비밀값 경계/admin 차단을 확인했다. [cloud-preview-flow-evidence.json](cloud-preview-flow-evidence.json). Vercel 협업 툴바는 공식 자동화 헤더와 Preview feedback=false를 설정했으나 기존 빌드에 남은 요청9개를 브라우저 네트워크 전송 전 차단·별도 집계했다. 나머지 외부 앱 요청과 브라우저 오류는0이다. 이 테스트를 플랫폼 툴바 자체 검증으로 확대하지 않는다.

owner가 별도 **1시간 임시 접근 승인(앱 암호 유지)**을 했고, 승인 후 생성해 검증했다. 모바일 수정 배포로 대상을 교체할 때 기존 링크를 먼저 폐기했고 최초 만료시간을 연장하지 않았다. 최종 검증 후 두 링크 모두 폐기했으며 fresh HTTP 요청302→vercel.com으로 차단을 재확인했다. owner-private 접근 파일에서도 임시 URL을 제거했다. [cloud-preview-access-evidence.json](cloud-preview-access-evidence.json). SSO/Basic은 유지되며 임시 접근 승인은 이번 검증으로 종료됐다. 이전 자동승인 거절/답변 대기 상태는 과거 이력이다.

첫 배포 `dpl_BmaVCM98JEns29WDBbJEfRCfYKn4`는 target 생략에도 production으로 분류됐고 npm ci 실패로 ERROR였다. 앱은 제공되지 않았고 production 앱 키/guard 완화/운영 도메인 변경은0이다. [preview-deployment-attempts.json](preview-deployment-attempts.json), Vercel 공식 PR17206에 첫 배포 분류가 설명돼 있다. 두 번째는 target=staging 명시로 안전하게 preview 빌드를 완료했다.

최신 설정 확인: owner가 Dashboard에서 신규 가입 차단과 Vercel 키 등록 완료를 알렸다. 읽기 전용 재조회로 Supabase `disable_signup=true`, `email=true`, `anonymous_users=false`를 확인했다. Vercel `QUIZEEY_SUPABASE_SECRET_KEY`는 API type=sensitive(Secret), target=[preview]이며 decrypt=false로 등록 메타데이터만 확인했다. 실제 hosted SDK 조회 성공으로 유효성을 검증했고 비밀값은 조회·출력하지 않았다. [cloud-setup-readback-evidence.json](cloud-setup-readback-evidence.json). 아래 B 미적용/env0 기록은 이전 상태다.

## 이번 대화에서 완료

최신 사용자 선택: **샘플 preview를 배포하지 않고 실제 문항 버전을 기다림**, **A+B 승인**. A/B를 다시 승인받지 않는다. A는 `quizeey_schema_preview_candidate_v1` / 실제 version `20261016235602`로 지정 Supabase에 적용했고15테이블0행/모든 read-only postflight가 통과했다. HTTP schema probe로 private/content는 unexposed(public/graphql_public만 노출)임도 확인했다. [cloud-schema-apply-report.md](cloud-schema-apply-report.md), [cloud-schema-apply-evidence.json](cloud-schema-apply-evidence.json). 클라우드 schema 적용1, 실제 콘텐츠 업로드0, Vercel 배포0.

B는 승인됐지만 연결 도구에 Auth config GET/PATCH가 없고 기존 로컬 Management token도 없어 아직 미적용이다. owner에게 Dashboard signup 차단과 Vercel preview-only `QUIZEEY_SUPABASE_SECRET_KEY` 설정을 async 요청했다. 최신 공개 Auth readback은 disable_signup=false/email=true/anonymous_users=false, Vercel env 목록은0이다. 키·비밀번호를 채팅에 보내도록 요구하지 않는다.

실제 콘텐츠 반출/preview는 별도 async 질문으로 승인 대기다. [preview-content-upload-request.md](preview-content-upload-request.md): 기존 지정 Supabase private 콘텐츠5테이블160,630행/문항26,733개, 지정 Vercel 보호 서버 처리만. native 사용자 해설/작성자·raw전체·Git/정적 bundle 제외. 이 질문에는 아직 답이 없으며 “실제 문항을 기다림”을 업로드 승인으로 확대하지 않는다. 로컬 owner 검증으로191개 private batch/전체 값 framed SHA256을 준비했고 Python/Postgres UTF8/NULL/UTC hash를 합성 데이터로 대조했다. [cloud-content-preparation-evidence.json](cloud-content-preparation-evidence.json). source raw/batches는 owner-private 폴더이며 승인 전 tool/API에 원문을 보내지 않는다.

실제 bounded reader와 async SSR/API loader를 로컬에서 구현했다. 새 CLI migration `20261016235845_private_study_reader.sql`은 아직 cloud 미적용이다. service-only private definer/public invoker, batch20/direct ID를 제한 전에 조회/전체 버전/전체 eligible 집합 랜덤1문항/NULL·카운터·bigint 문자열 계약을 검증했다. forum_reports FK index 보완도 이 migration에 포함했다. [hosted-study-reader-evidence.json](hosted-study-reader-evidence.json). unit58/typecheck/lint/build 통과, 기존 학습/호환 browser8개와 Basic preview smoke 통과. reader local17.11 역할/값 복원·동시성·source hash framing 통과. 현재 실제 데이터는0행이고 미인가 source fallback은 없다.

사용자가 이어서 “1번 검증과 2번 실행안 작성”을 요청했다. PostgreSQL17.11의 non-superuser postgres와 실제 public default ACL을 로컬에서 재현해 기존002/003/004/006 baseline을 검증했다. 공식 CLI2.121.0으로 `20261016233418_private_rpc_boundary.sql`을 생성해 public invoker/private definer 경계와 감사 없는 helper 접근을 보완했다. 새 경계의 역할별 GRANT/RLS·schema-only/15테이블 값/함수 ACL 복원·동시20회10수락10제한·DDL rollback·local advisors를 검증했다. 실제 리뷰 SQL candidate0행과 접근 차단 rollback의 값 보존도 확인했다. 기존 PG18 회귀/Python26개/RPC6개 통과. [cloud-change-request.md](cloud-change-request.md), [hosted-change-manifest.json](hosted-change-manifest.json), [hosted-schema-rehearsal-evidence.json](hosted-schema-rehearsal-evidence.json). Supabase 변경/콘텐츠 업로드/Auth 변경0. 기존7개 migration 전체를 cloud push하지 않는다. CLI telemetry/cache인 supabase/.temp는 Git ignore에 추가했다.

Vercel·Supabase 도구가 노출되어 지정 대상의 읽기 전용 조회가 성공했다. 재설치·재연결·키 전달을 요구하지 않는다. [cloud-account-evidence.json](cloud-account-evidence.json), [deployment-targets.json](deployment-targets.json).

- Supabase `quizeey` / `tfkhnrbshvyfmrzxqfmq`, organization `ffwqtsvqdnhmpnfqnjuq`, `us-west-2`, ACTIVE_HEALTHY, PostgreSQL `17.11.0.003`, 조직 Pro. 앱테이블·migration·Auth user/session0. SQL은 READ ONLY transaction이며 query role은 postgres(non-superuser/BYPASSRLS)였다. 연결된 사람의 구성원 역할/쓰기 권한은 별도 미검증이다.
- 공개 Auth settings GET: signup 열림(`disable_signup=false`), email=true, anonymous_users=false, mailer_autoconfirm=false. 관리자 전용 정책에 맞춘 signup 변경·계정 생성·allowlist 설정은 실행하지 않았다. URL/MFA/JWT TTL/SMTP 관리 설정은 미검증이다. 보안 advisor lints0은 빈 schema 시점 결과다.
- 사용자가 새 Vercel quizeey project 생성을 명시적으로 요청해 이전 새 project 금지의 이 대상 예외를 승인했다. `kevins-projects-e2dcc34c` / `team_VSzA796D92aso5IuzUIiOdnb`에 `quizeey` / `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`를 생성하고 get_project로 재확인했다. Next.js/Node24.x, rootDirectory=web 요청. 배포0/live=false/latestDeployment=null/domains0. Git 연결·env 추가·콘텐츠 업로드 없음. Vercel Pro·구성원 역할은 도구 응답이 제공하지 않아 미검증이다. [vercel-project-creation-evidence.json](vercel-project-creation-evidence.json).
- `web/src/server/supabase-transport.ts`: server-only protected-preview forum adapter 준비. 공개 anon/publishable client와 server secret RPC client 분리,8개 RPC allowlist/입력·응답 검증, no-store/5초 timeout/redirect 거부/자동 retry 비활성/오류 redaction. 기존 SQL RPC parameter 이름과 실제 SDK HTTP wire를 테스트했다. 기존 HTTP routes에는 연결하지 않았다. content serving adapter는 별도 필요하며 기존 private content grant를 우회하지 않는다.
- `server-only@0.0.1` exact pin/lockfile, 새 테스트6개 포함 전체55개 통과, typecheck/lint/build 통과. 격리 PostgreSQL18 RLS/소유권/검토/동시20회(10수락10제한)/11테이블 backup restore 재통과, 보호 preview smoke 재통과. sandbox pg_ctl restricted token87은 같은 격리 도구의 owner 실행으로 해결했다. 소유 테스트 서버 종료.
- [hosted-rehearsal-plan.md](hosted-rehearsal-plan.md)에 구체적 대상/후보 migration4개 SHA-256/데이터 범위/role-RLS/native 검토·공개/복원 검증 순서를 정리했다. 실행 승인 요청 단계까지 준비 완료된 것으로 오해하지 않는다. Supabase 쓰기/콘텐츠 업로드/Auth 변경0, 사용자 승인 Vercel project 생성1(배포0).

## 기존 승인·완료 범위

기존 Pro 사용, 위 team/ref/전용 프로젝트/리전, signup-free 게시판, 첫 production AdSense, 오류751문항의 **새 서비스 이전 대상 삭제·원본 백업 유지**는 확정이며 다시 묻지 않는다. 원본 MySQL 삭제·DNS 전환·AWS 종료는 승인되지 않았다.

실측 EC2 MySQL5.7.30 조사, 승인 원본6테이블167,205행 반출·private typed 보존/복원,751문항 제외 후26,733문항 FK/unique ETL/복원, 실제 문항의 보호된 로컬 API/브라우저 채점·새로고침 복원 완료. Native 해설630topics/2,183posts의2회 적재/restore도 통과했고 전부 pending/공개0/guest ownership 생성0이다. 원문·이름·UTC를 보존하며 검토 상태를 replay로 초기화하지 않는다. 학습 artifact에 사용자 해설/작성자 이름은 넣지 않는다.

기본 앱은 fixture, 실제 archive 모드는 로컬 전용이다. 원본/파생 콘텐츠 승인은 **소유자 전용 로컬 반출·검증, Git/외부 업로드 금지**다. Supabase 연결이나 Pro 사용 승인은 실제 콘텐츠 업로드 승인이 아니다. cloud 반출은 target·테이블/개인정보 범위·해시·비용·복원·권한 검증안을 준비한 뒤 별도 확인받는다.

원본 폴더 `.modernization/exports/source-265c3ca16e/`는 owner-only ACL. sandbox에서 안 읽히면 기존 승인된 원문 비출력 로컬 검증에만 owner 실행을 사용한다. 키/비밀번호/문항/작성자 원문 출력 금지, Git에는 집계·해시만. 중단 서버 임의 재사용 금지, 점유 포트 거부/finally 종료 유지. SSH temporary 규칙 회수는 기존5개 규칙을 유지하고 신규 rule ID를 확인한 뒤 별도 진행한다.

## 다음 순서

1. Vercel 대상은 새로 생성하고 검증한 `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`이다. 기존 project 이름/ID를 다시 묻지 않는다. 다른 resource를 생성하지 않는다. project 생성 권한을 DB/Auth 변경·실제 콘텐츠 업로드·배포 승인으로 확대하지 않는다. Vercel plan/구성원 역할·rootDirectory 저장값은 추가 확인 필요.
2. A/B·reader migration·승인된5테이블 업로드·보호 preview·실제 hosted 검증은 모두 완료했다. schema/적재를 재실행하거나 signup/키/업로드 승인을 다시 묻지 않는다. 최초 candidate는5개 원본을1개 cloud baseline으로 적용했으므로 CLI root push/history repair를 하지 않는다. 최종 배포/검증/임시 접근 폐기는 이 문서 상단과 증거3개를 확인한다. 새로운 임시 접근 링크가 필요하면 이번 종료된1시간 승인을 재사용하지 않는다.
3. Native 관리자 검토 화면에 transport를 연결할 설계와 provider verified UUID/session gate·peer HMAC·CSRF·signup 차단·cleanup 검증을 구체화한다. transport 자체는 관리자 인증을 하지 않으며 caller가 기존 requireAdmin을 거쳐야 한다. 실제 글 검토/권리 승인 전 일괄 공개 금지.
4. 실제 assets/Disqus export/전체 URL 대사, hosted content adapter를 계속 개발한다. 원본을 외부 서비스에 보내는 probe/번들/테스트는 실행하지 않는다.
5. 이번 승인한5테이블/지정 preview 반출은 완료 상태다. 추가 사용자 해설·작성자 정보·관리자 계정 생성은 이번 범위에 포함되지 않았다. 운영 canonical/query 정책·GSC·GA4/CMP·권리·연락 전달·최종 delta·부하/성능·RPO/RTO·관찰기간은 여전히 출시 게이트다. DB/DNS 전환·AWS 종료는 각각 별도 승인안이다.
