# Quizeey 빈 스키마·가입 차단 실행안

2026-10-16 America/Vancouver. 후속 사용자 답변으로 **A+B 승인**을 받았다. A는 version20261016235602로 적용·검증 완료했고 B는 Auth 변경 API 부재로 owner Dashboard 작업 대기다. [실행 결과](cloud-schema-apply-report.md). 아래는 승인·실행 전 준비한 절차이며 실제 콘텐츠 업로드/preview는 별도 질문 답변 대기다. candidate를 재적용하지 않는다.

## 대상과 요청할 변경

| 항목 | 정확한 대상 / 변경 |
| --- | --- |
| Supabase | quizeey / `tfkhnrbshvyfmrzxqfmq` / org `ffwqtsvqdnhmpnfqnjuq` / us-west-2 / PostgreSQL17.11 |
| Vercel | team `team_VSzA796D92aso5IuzUIiOdnb` / project `prj_0SVBqfgurtvZErmpMJl01BJkUKOd` |
| A: DB | 합성 데이터도 넣지 않는 빈 앱 스키마15테이블, public invoker10개/private definer11개·GRANT/RLS 생성 |
| B: Auth | `disable_signup: false → true` 한 필드만 변경 |
| 배포·데이터 | 이번 요청에는 포함하지 않음. Vercel env/배포/Git 연결, 실제/합성 콘텐츠 업로드, admin 계정 생성, DNS/AWS/운영 DB 변경0 |

현재 대상은 앱테이블0/migration0/Auth 사용자0이고 실제 운영 MySQL은 별도 EC2에 있다. A/B는 서로 다른 시스템의 변경이므로 단일 원자적 작업으로 취급하지 않는다. 각각의 결과와 필요 시 복귀를 기록한다. A만 승인하면 B를 실행하지 않으며 반대도 같다.

## 검증 결과와 수정

[hosted-schema-baseline-evidence.json](hosted-schema-baseline-evidence.json): 공식 EDB PostgreSQL17.11에서 실제 로그인 역할을 `postgres NOSUPERUSER BYPASSRLS CREATEDB CREATEROLE`로 만들고 실계정에서 읽은 public 기본 ACL을 재현했다. 기존002/003/004/006의 DDL·forum/admin 보안·동시20요청·15테이블 전체 값/해시·함수 ACL/search_path 복원·DDL transaction 취소가 통과했다. PG18 superuser 결과로 대체하지 않았다.

추가 검토에서 public SECURITY DEFINER10개와 감사 없는 하위 moderator 직접 호출을 줄였다. 공식 CLI2.121.0의 `migration new private_rpc_boundary`로 [20261016233418_private_rpc_boundary.sql](../../supabase/migrations/20261016233418_private_rpc_boundary.sql)을 생성했다. 기존4개 파일은 수정하지 않았다. 모든 public wire 함수는 SECURITY INVOKER이고 실제 권한 상승 구현은 unexposed `quizeey_private`로 이동했다. 낮은 수준의 moderator/consume_rate helper는 owner-only다. service_role은 필요한 RPC EXECUTE/비공개 schema USAGE만 있고 테이블·sequence 직접 권한은 없다. 기존 server-side admin 검증과 감사 RPC는 유지한다.

Supabase의 service_role은 사용자 JWT가 없는 서버 신뢰 경계다. guest signup-free 동작 때문에 private 함수에 `auth.uid()` 필수 조건을 추가하지 않았다. 대신 anon/authenticated/PUBLIC EXECUTE 차단, server-only secret, 서버의 verified UUID/활성 session/allowlist를 사용하는 계약이다. service credential을 클라이언트에 주거나 private schema를 Data API에 노출하는 변경은 허용하지 않는다.

[hosted-schema-rehearsal-evidence.json](hosted-schema-rehearsal-evidence.json)은 추가 migration 후 비-superuser 역할별 권한·schema-only restore·합성 데이터 restore·관리 세션 폐기·기존 동시성·통합 SQL 후보·접근 차단 rollback 결과를 기록한다. Windows17.11의 한글 경로 초기화 문제는 검증한 엔진/격리 데이터 폴더를 owner temp ASCII 경로에 두어 해결했다. 원본 파일을 열지 않았다.

런타임 공급 경로: [PostgreSQL 공식 Windows 안내](https://www.postgresql.org/download/windows/) → [EDB binaries](https://www.enterprisedb.com/download-postgresql-binaries) 17.11-5. ZIP SHA256 `80379b2c04d51c30225532e0ae04509899141e9957ed096fe749d7fd9df8f82f`는 [EDB 제공 checksum](https://github.com/EnterpriseDB/edb-installers/issues/731)과 대조했다. CLI release asset digest도 검증했다. plain EDB17.11 역할 모델은 Supabase 자체 빌드/확장·Auth/PostgREST 전체 replica가 아니다. 실제 HTTP/RLS·Auth는 A/B 승인 후 대상 계정에서 별도 검증해야 한다.

## A: 리뷰할 SQL과 적용 순서

정확한 원본5파일 해시와 artifact 해시는 [hosted-change-manifest.json](hosted-change-manifest.json)에 있다. [hosted-schema-candidate.sql](hosted-schema-candidate.sql)은002/003/004/006/새 boundary를 하나의 transaction으로 묶었다.001(raw staging)/005(원본 typed archive)는 포함하지 않는다. 문항/작성자/해설·원본ID를 INSERT하지 않는다.

1. 승인 범위가 A인지 확인하고 연결 ref/team/org를 다시 조회한다. `list_migrations`가0이고 앱 object0/버전170011/역할postgres(non-superuser)/Supabase Pro·리전이 위 근거와 같아야 한다. 새 사용자/새 schema/migration이 생겼으면 작업을 중단하고 차이를 검토한다.
2. Data API 설정에서 exposed schemas를 읽어 `quizeey_private`/`quizeey_content`가 없는지 확인한다. 읽기 전용 SQL의 pgrst role setting은 비어 있어 이 설정을 증명하지 못했다. 커넥터만으로 확인할 수 없으면 owner가 Dashboard의 Data API 설정에서 확인한다. 재연결·비밀번호 전달을 요구하지 않는다.
3. 변경 전 관리 설정과 대상 schema의 백업을 owner-private 위치에 남긴다. 앱 데이터는0행이므로 preflight metadata가 앱 baseline이다. 추가로 실제 hosted schema-only export/복원 증거를 확보하기 전에는 이를 운영 backup 검증으로 보고하지 않는다. managed Auth/Storage 전체를 임의 dump/복원하거나 raw 파일을 Git에 넣지 않는다.
4. manifest와 artifact SHA256을 재검증한다. 모든 CREATE/REVOKE/GRANT/검증은 단일 transaction이며 lock_timeout5초/statement_timeout60초다. MCP `apply_migration`의 **project_id=`tfkhnrbshvyfmrzxqfmq`, name=`quizeey_schema_preview_candidate_v1`, query=검증한 candidate SQL 전체**로 딱1회 적용한다. 이번 문서는 도구 호출 승인이나 실행 기록이 아니다.
5. 커넥터 timeout/응답 유실 시 자동 재호출하지 않는다. migration history·실제 catalog를 읽어 commit 여부를 판정한다. guard는 같은 schema 재적용을 거부한다. 실패한 transaction이면 앱 object는0이어야 한다. 일부 적용처럼 보이거나 상태가 불명확하면 중단한다.
6. commit 후 [hosted-schema-postflight.sql](hosted-schema-postflight.sql)을 READ ONLY로 실행해15테이블0행/RLS+FORCE, public invoker10/private definer11, postgres owner/빈 search_path, anon/authenticated public SELECT만, service 명시 RPC만, 모든 private/content 직접권한 차단을 대조한다. role EXECUTE/sequence/table ACL도 검사한다. actual HTTP 쓰기 검증용 합성 데이터 삽입은 이 schema-only 요청에 포함하지 않는다. localhost용 `supabase/tests/hosted_boundary.sql`은 임시 함수/합성 검증이므로 cloud에서 실행하지 않는다.
7. 대상 Supabase security/performance advisors를 읽고 결과와 remediation URL을 기록한다. PGRST schema reload 알림은 commit 후에만 전달된다. 예상과 다른 object/ACL/advisor ERROR가 있으면 아래 접근 차단으로 닫고 preview 연결을 진행하지 않는다.

Supabase project에 CLI를 link하거나 저장소 루트에서 `db push`하지 않는다. 루트에는 cloud 제외001/005가 있고, 이번 candidate는 기존 이력5개를 한 개의 승인 baseline으로 묶은 artifact다. 향후 CLI 도입 전 local/remote history를 별도 baseline으로 정리해야 하며 전체7개를 다시 replay하거나 history를 임의 repair하지 않는다.

## B: 관리자 전용 가입 설정

변경 전 공개 Auth settings는 `disable_signup=false`, email=true, anonymous_users=false, mailer_autoconfirm=false다. full Auth config/SMTP/JWT TTL/URL/MFA는 공개 settings로 확인되지 않았다. B는 기존 이메일 password 로그인은 유지하고 공개 신규 가입만 차단한다.

승인 후 [Management API](https://supabase.com/docs/reference/api/v1-update-auth-service-config)의 `PATCH /v1/projects/tfkhnrbshvyfmrzxqfmq/config/auth` body는 정확히 다음 하나다:

```json
{"disable_signup": true}
```

현재 커넥터에는 Auth config GET/PATCH 도구가 없다. 기존 연결에서 해당 관리 권한을 가진 경로가 제공되지 않으면 owner가 Supabase Dashboard에서 signup 허용을 끄고 readback한다. 이 제약을 이유로 계정키/비밀번호를 채팅에 요청하거나 새 credential을 만들지 않는다. 다른 Auth field는 변경하지 않는다.

완료 판정: 공개 `GET /auth/v1/settings`의 disable_signup=true, anonymous_users=false와 email=true 유지, auth.users는 계속0. 신규 signup 차단을 검증할 실제 POST는 거부되어도 이메일/로그 등 부작용 가능성이 있으므로 별도 합성 Auth 검증 범위에 포함시킨 뒤 실행한다. UI에 가입 폼이 없다는 사실만으로 차단을 입증하지 않는다.

관리자 추가는 다음 단계다. owner가 precreated admin 계정을 선택한 뒤 verified UUID를 server-only allowlist에 넣고, 실제 password login→DB hash session→검토→logout 재사용401을 확인한다. 이메일·비밀번호·refresh token은 JSON/로그/분석/Git에 남기지 않는다. 현재 adminUsersCreated=0이며 preview route도 아직 비활성이다.

## 백업·중단·롤백

로컬 실측: schema-only export/restore와 합성 데이터15테이블 전체 값·함수 ACL·owner·search_path 일치, restored admin session 폐기, transaction DDL rollback 후 application object0을 확인한다. cloud RTO/RPO·운영 backup/복구시간은 아직 실측하지 않았다. 이번 A는 실제 데이터를 넣지 않으므로 앱 baseline은0행, 운영 writer 중단이나 DNS 전환은 없다. 소요시간은 클라우드 확인과 advisor 결과에 따라 달라지며 로컬 시간을 운영 SLA로 사용하지 않는다.

- **commit 이전 실패:** 자동 transaction rollback. catalog/history 재조회로 object0과 기존 상태를 확인한다. 부분 성공을 추정하지 않는다.
- **commit 이후 A 검증 실패:** preview route/env를 열지 않고 [hosted-schema-close-access.sql](hosted-schema-close-access.sql)을 별도 승인된 containment 변경으로 적용한다. exact 함수 EXECUTE·public SELECT·service private schema USAGE만 회수한다. DROP/TRUNCATE/DELETE/CASCADE 없이 schema·테이블·데이터를 보존한다. 이 SQL의 해시·로컬 권한 차단/값 보존 증거는 manifest/evidence에 있다. 재활성화는 blanket GRANT나 candidate 재적용이 아닌 검토한 forward migration으로 한다.
- **B 실패/복귀:** 변경한 한 필드의 직전값만 복귀한다. 원래값에 돌아가야 하는 승인된 rollback일 때 PATCH body는 `{"disable_signup":false}`다. 오래된 full config를 덮어쓰지 않는다. A의 성공/실패와 B의 상태를 따로 기록한다.
- 실제 사용자나 글이 생겼으면 owner-private snapshot과 session 폐기를 포함한 데이터 복구안을 먼저 준비한다.0행 schema-only 복귀 절차를 실제 데이터 삭제로 확대하지 않는다.

## 비용과 남은 게이트

새 org/project/branch/compute/add-on/구독을 만들지 않는다. A/B는 기존 Supabase Pro의 DB/관리 API 사용이며 Vercel 배포 비용은 이 범위에 없다. 사용량에 따른 실제 비용0을 보장하지 않고 계정 usage에서 확인한다. 백업 저장 위치/계정 권한·Data API exposed schemas 확인과 실제 hosted advisors는 적용 직전/직후 게이트다.

실제 콘텐츠160,630행과 native pending2,813행은 이번 요청에서 제외한다. 이들은 대상·개인정보/권리·해시·최종 delta·복원을 구체화한 별도 반출 승인안으로 진행한다. production canonical/query·GSC·광고/CMP/GA4·성능·RPO/RTO·관찰기간·DB/DNS 전환·AWS 종료 승인도 유지한다.

공식 검토 근거: [non-superuser 역할](https://supabase.com/docs/guides/database/postgres/roles-superuser), [함수 권한·search_path](https://supabase.com/docs/guides/database/functions), [API 보안](https://supabase.com/docs/guides/api/securing-your-api), [17.11 변경](https://supabase.com/changelog/postgres-15-19-17-11-breaking-changes). 이번 SQL은 core sha256/gen_random_uuid/date_bin을 사용하고 ltree·float gist·PGP cipher·custom selectivity operator를 생성하지 않는다. 확장 소유권 변경이나 superuser 승격 없이17.11에서 실행·복원했다.
