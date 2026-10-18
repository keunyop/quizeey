# Hosted 연결 리허설 실행안

최신 후속: 이 문서의 초기 미적용/키·signup 상태는 과거 기록이다. 실제 schema/콘텐츠 preview 완료는 [session-handoff.md](session-handoff.md), 현재 HTTP 연결 준비 및 비활성화 조건은 [cutover-owner-followup-evidence.json](cutover-owner-followup-evidence.json)을 따른다. transport는 현재9개 allowlisted RPC(기존8개 + service-only cleanup)를 지원한다. 운영 API는 명시적 hosted gate 뒤에 연결되었으나 실제 Vercel flag/추가 키/운영자 계정/원본 해설 import는 아직 활성화·생성·반출하지 않았다.

후속 검증 완료: PostgreSQL17.11 non-superuser/default ACL 검증과 새 private_rpc_boundary의 local advisor·role/RLS·schema/data 복원·rollback이 통과했다. 아래 초기4개 후보에 새 boundary가 추가되어 최종 후보는5개다. 정확한 SQL/해시/빈 schema·signup 변경/rollback은 [cloud-change-request.md](cloud-change-request.md), [hosted-change-manifest.json](hosted-change-manifest.json)을 따른다. cloud에는 아직 적용하지 않았다.

2026-10-16. **준비 문서이며 실행 승인 요청이나 실행 기록이 아니다.** 현재 승인 범위는 계정 읽기 전용 조회와 로컬 개발, 사용자 추가 요청에 따른 Vercel quizeey project 생성이다. 실제 콘텐츠 반출·cloud migration·Auth 설정 변경은 실행하지 않았다.

## 확인한 대상과 차이

[cloud-account-evidence.json](cloud-account-evidence.json): Supabase `tfkhnrbshvyfmrzxqfmq`, org `ffwqtsvqdnhmpnfqnjuq`, us-west-2, ACTIVE_HEALTHY, PostgreSQL17.11, 조직 Pro. 앱 테이블·migration·Auth user/session은0이다. SQL은 명시적 READ ONLY transaction에서 실행했다. 연결된 사람의 조직 역할/쓰기 권한은 추정하지 않는다.

Vercel team `team_VSzA796D92aso5IuzUIiOdnb`에 사용자 명시 요청으로 `quizeey` / `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`를 생성하고 재조회했다. Next.js/Node24.x이며 rootDirectory=web로 요청했다(조회 도구는 해당 field 생략). live=false/latestDeployment=null/domains0. 배포/Git 연결/env 추가/콘텐츠 업로드 없음. [vercel-project-creation-evidence.json](vercel-project-creation-evidence.json). 커넥터의 team 응답은 plan/member role을 제공하지 않아 Vercel Pro 검증은 남아 있다.

공개 Auth settings GET: `disable_signup=false`, email=true, anonymous_users=false, mailer_autoconfirm=false. 관리자만 precreated 계정을 쓰는 요구와 현재 signup 설정이 다르다. 계정0개를 가입 차단의 증거로 해석하지 않는다. Auth 변경 시 현재값/변경값과 롤백을 별도 제출한다. signup 차단·admin 생성·allowlist 설정은 미실행이다. URL allowlist·MFA·JWT TTL·SMTP 등 관리 설정은 공개 settings로 확인할 수 없다.

## 서버 transport 준비 결과

[supabase-transport.ts](../../web/src/server/supabase-transport.ts)는 protected preview와 정확한 프로젝트 URL, 서버 전용 현대 publishable/secret key를 요구한다. `server-only`가 Client Component import를 차단한다. 공개 조회는 publishable client의 anon RLS, 쓰기는 별도 secret client의 명시적8개 RPC만 사용한다. Auth client와 세션을 공유하지 않는다. raw/typed/content 테이블 읽기, cleanup, 일반 SQL, 직접 테이블 쓰기 API는 제공하지 않는다.

RPC 인수의 이름은 기존 SQL 함수 signature와 대조했다. guest token/JWT 대신 hash만 받으며, actor UUID 검증은 호출 전 기존 `requireAdmin`이 담당해야 한다. transport만으로 관리자 인증을 수행하지 않는다. write 자동 재시도 비활성, 5초 timeout, no-store, HTTP redirect 거부, 공급자 오류 redaction, 응답 형태 검증을 적용했다. 공개 조회는20topics/50posts, 검토는21items, mine은20items 상한이다. 원본 question-ID 기반 해설은 locale 공통, 새 topic은 locale별이다.

**기존 HTTP routes와 연결하지 않았다.** 현재 loopback fixture와 production 차단은 유지한다. secret key를 가져오거나 저장하지 않았으며 테스트의 HTTP 응답은 mock이다. 학습 content의 hosted read adapter는 이 forum transport와 별도 작업이다. private content 스키마에는 service_role 읽기 권한도 없으므로 SDK `.from`으로 우회하지 않는다.

검증 근거: [supabase-transport-verification.json](supabase-transport-verification.json). 전체55개 unit/typecheck/lint/build, 기존 격리 DB RLS/소유권/검토/복원, 보호 preview smoke가 통과했다. 현재 fixture build의 공개 JS11개에서 검사한 credential/transport marker0이다. transport는 아직 routes에 연결되지 않았으므로 실제 Supabase 역할/번들 연결 검증을 대신하지 않는다.

## cloud 실행 전에 확정할 변경 묶음

1. Vercel 대상은 생성·검증한 `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`로 고정한다. 실제 plan/member role과 rootDirectory 저장값을 확인한다. 새 project 생성 승인을 배포·원본 업로드·DB/Auth 변경 승인으로 확대하지 않는다.
2. Supabase17.11의 비-superuser `postgres`, extension 소유권, 실제 anon/authenticated/service_role GRANT/RLS/EXECUTE를 검증할 schema-only 리허설. CLI 생성 규칙으로 향후 migration을 생성하며 기존 파일을 검증 없이 일괄 push하지 않는다.
3. 최소 cloud schema 후보는 아래4개다. 원본 보관용001/005는 로컬에 유지하고 이 실행안에서 cloud에 올리지 않는다. 각 파일의 SECURITY DEFINER/search_path/GRANT와 대상17.11 호환성 검토 후에만 정확한 적용 명령을 제출한다. 현재 SQL 파일은 기존 로컬 검증용이며 cloud 적용 준비 완료를 뜻하지 않는다.

| 파일 | SHA-256 |
| --- | --- |
| 202610160002_native_forum.sql | 0a880273fdc48c49acda373b975247e1afbf21b6ba5e4de4b961f9682ee438e2 |
| 202610160003_guest_private_preview.sql | d374790a6534e3461bac0494896dff049d5db5d6a6d343b65e15c5fd9d68e915 |
| 202610160004_admin_moderation.sql | d60ab8d39c9d501fed200a0211a0b4bbe066e085630deb615f1eaf6461ab5264 |
| 202610160006_exam_content.sql | 108d8f85394a770b0bbc890d33b31c072adb13bf2ad7676ea82e8884c8f658f3 |

4. 실제 콘텐츠 반출을 선택할 경우 대상은 위 Supabase 한 곳으로 한정하는 별도 승인안이 필요하다. 후보 범위: exams181/versions330/questions26,733/choices107,516/counters25,870 총160,630행, native 해설 topics630/posts2,183 총2,813행. 사용자 이름·본문은 native pending에 포함되므로 이 개인정보 범위를 명시한다. 문항751개 제외 정책과 [publication-candidate-evidence.json](publication-candidate-evidence.json)의 테이블 해시를 재대조한다. private 원본167,205행·비밀번호·source config·로컬 backup은 반출하지 않는다. 현재 외부 업로드0이다.
5. Auth signup 차단과 precreated admin UUID·서버 allowlist, Vercel secret env의 범위(preview만), 검증된 platform peer HMAC·보존/회전·cleanup schedule을 구체화한다. 비밀번호/secret은 채팅/Git에 남기지 않는다. 계정 없는 방문자에게 Auth signIn/signUp을 호출하지 않는다.

## 실제 역할 검증과 native 해설 공개 순서

- anon/authenticated로 승인된 topic/post만 읽히는지 확인. pending2,183개·hidden·pending revision·ownership·session·audit는0행/권한 거부, 직접 INSERT/UPDATE/DELETE와 관리 RPC 호출은 거부되어야 한다. guest API는 server-only RPC만 호출한다.
- service_role로 private raw/typed/content/ownership/session 직접 조회가 거부되는지 확인. 제한된 session/moderation RPC만 허용하고 admin actor는 provider getUser + UUID allowlist + 활성 hash session에서 가져온다. 임의 actor 입력으로 HTTP 관리 호출이 가능하면 중단한다.
- approved imported topic은 en/ko 모두 원래 question-ID 범위로 조회되고 새 locale별 topic은 격리되는지 확인. 실제 pending 원문은 보호된 관리자 검토 화면에서만 표시한다. review 전 일괄 승인·공개를 하지 않는다.
- 정확한 한 개 검토 승인 → 공개 조회 → 숨김/삭제 후 다음 no-store 조회에서 제거 → 감사/동일 idempotency replay → logout cookie 재사용401을 확인한다. 합성 데이터로 먼저 수행하고 실제 글 공개는 검토·권리 승인을 받은 범위만 진행한다.
- 서로 다른 브라우저 guest 소유권, cookie 삭제/만료, 위조 token, CSRF, 동시 제한, 20개 이후 keyset, 실제 Supabase timeout/503에서 중복 글 생성 없음, 공개 응답의 작성자/본문 한도와 XSS 텍스트 출력을 확인한다.
- schema-only backup/restore부터 검증하고 데이터 반출 후에는 행/값/ID/UTC/정답 집합 해시와 ownership 보존을 재검증한다. 복원한 admin session은 모두 폐기한다. 실패하면 preview route를 활성화하지 않는다.

공식 근거: [서버 전용 secret client](https://supabase.com/docs/guides/troubleshooting/performing-administration-tasks-on-the-server-side-with-the-servicerole-secret-BYM4Fa), [Data API 보안](https://supabase.com/docs/guides/api/securing-your-api), [최신 changelog](https://supabase.com/changelog). markdown index fetch는 지원 content type/network 제한으로 실패해 HTML changelog를 읽었다. Postgres17.11 변경과 HTTP CBC TLS 폐기 공지를 확인했으며 로컬 Node24/HTTPS만 사용한다. 위 실행안은 DNS/운영 writer 전환·AWS 종료를 포함하지 않는다.
