# 운영 이전 실행안 — 트래픽 전환 전

CUTOVER COMPLETE: Owner confirmed existing GA4 Realtime receipt and normal real-phone ad placement after the final production release. Master8ce414df / dpl_7SHtHERNcgYfFuY2yBmYCqfjPgti. CMP CORS incident resolved; historical interrupted live-pointer test remains unchanged as evidence. No additional owner setup is required for cutover. Keep AWS/MySQL and private backups. Monitoring and separately authorized source retirement are follow-up work. See [current handoff](cutover-live-handoff.md) and [execution evidence](cutover-execution-2026-10-18.json).

---

2026-10-17 후속: 소유자가 GA4 `G-XM8XM4CHX7`, AdSense Auto optimize/Auto ads ON, Cloudflare 원본 레코드를 제공했다. 기존 Vercel 프로젝트 `prj_0SVBqfgurtvZErmpMJl01BJkUKOd`에 해당 GA4 ID를 plain/server env로 Production·Preview에 등록하고 재조회했다. 프리뷰는 광고·분석을 실행하지 않는다. `quizeey.com`, `www.quizeey.com`도 같은 프로젝트에 등록했고 둘 다 verified=true다. DNS/네임서버/기존 AWS/Google 계정 설정은 변경하지 않았다. 상세 변경·검증은 [cutover-owner-followup-evidence.json](cutover-owner-followup-evidence.json), 이전 콘텐츠·UI 증거는 [cutover-preparation-evidence.json](cutover-preparation-evidence.json)을 참조한다.

## 소유자 확인 및 설정

최신 범위 결정: **사용자가 작성한 글은 비공개 보관하고, 포럼 구성·공개 전환은 이후에 진행한다.** 이번 컷오버는 문항 풀이·기본 문항 해설·SEO·기존 Google 연결을 대상으로 한다. 포럼/해설 작성·수정·공개와 운영자 로그인 검증은 이번 출시의 필수 게이트에서 제외한다. 향후 포럼 활성화 전에 관련 보안/복구 검증을 완료한다.

1. **AdSense:** 유럽 규정 메시지 **게시됨**, 동의 모드의 **Enable consent mode for advertising purposes / Enable consent mode for analytics purposes 두 항목 체크 후 Save 완료**를 소유자가 확인했다. 다시 설정 여부를 묻지 않는다. 게시자 ID의 공개 CMP 스크립트는200/JavaScript 응답을 확인했고 Production의 `QUIZEEY_CMP_SCRIPT_URL`에 등록·일치 재조회했다. 스크립트를 실행하거나 실제 지역별 동의/광고/GA4 수신을 검증한 것은 아니므로 ADS_VERIFIED는 아직 설정하지 않는다. [Google의 별도 동의 모드 설정](https://support.google.com/adsense/answer/16053245?hl=en).
2. **광고 형식:** 소유자가 전면(Vignette)·앵커(Anchor) **모두 ON**임을 확인했다. Auto optimize/Auto ads ON과 Display/In-article/In-feed 사용도 확인됐다. 현재 계정 상태를 유지한 전환안으로 준비하되, 학습 이동은 코드의 링크별 전면 제외를 적용한다. 소스에서 확인한 publisher와 Display/In-feed 단위는 유지한다. 나머지 광고 단위의 ID/레이아웃은 추정해 추가하지 않는다.
3. **운영 설정:** 소유자가 Production 전용 `QUIZEEY_SUPABASE_SECRET_KEY`와 `QUIZEEY_PREVIEW_PASSWORD`를 직접 등록했고 두 값의 sensitive/production 메타데이터만 재조회했다. 비밀값을 읽지 않고 실제 Production 빌드의 사전 검사에서181시험 목록/20문항 읽기를 확인했으며 암호24자 이상 환경 검사도 통과했다. 보호 화면 사용자명은 `release-review`, 암호는 소유자가 등록한 값이다. 기존 Preview 값은 유지한다. 기존 GA4 ID는 Production·Preview에 등록됐다. `QUIZEEY_PRODUCTION_REVIEW=true`이며 RELEASE_READY/ADS_VERIFIED는 미설정이다. 키/암호 등록을 다시 요청하지 않는다.
4. **기존 사용자 글 보관:** 원본 스냅샷의2,209글을 그대로 보관하며, 이전 대상 문항에 연결되는2,183글/630주제와 제외 문항 관련26글을 구분한다. 원본 전체 파일·필터된 파일·2,183글의 값 해시 및 owner-only ACL, 기존 native.dump 존재/형식을 재검증했다. [retained-user-posts-evidence.json](retained-user-posts-evidence.json). 클라우드 반출·게시·원본 삭제는 실행하지 않는다. 기본 문항 해설은 계속 제공한다. `/explanations`는 유효 문항에200/빈 배열을 반환하며, 잘못된 ID/없는 문항/실제 DB 장애의400/404/503 구분을 유지한다. 최종 동결 때 이후 작성된 글도 비공개 최종 백업에 포함해야 하며 개발 스냅샷을 최신 전체 백업으로 오인하지 않는다.
5. **전환 시간:** 실제 writer 동결·최종 snapshot/delta·복구 검증 결과를 갖춘 뒤 예상 중단시간, RPO/RTO, 실행 시각과 중단 기준을 최종 변경안에 확정한다. 현재 숫자를 검증된 복구 시간으로 제시하지 않는다. Search Console 주요 유입 URL은 소유자 계정에서 확인해야 한다.

향후 포럼 작업: 소유자 제공 UUID `c07727e8-d90a-48af-acfa-1bd30cef41e5`의 실제 Auth 계정 존재·비익명·메일 확인·비삭제·비차단 상태를 읽기 전용으로 확인했고, Preview allowlist/provider에 등록·재조회했다. 실제 비밀번호 로그인/getUser/session 검증 완료를 뜻하지 않는다. 게시 정책과 UI를 확정한 뒤, 별도 HMAC/cron secret·역할/세션/동의/보존 검증을 거쳐 활성화한다. 이번 컷오버에 계정을 추가 생성하거나 방문자 가입을 열지 않는다.

## 보호 운영 검증 빌드

[운영 설정 검증 화면](https://quizeey-8n6lje53f-kevins-projects-e2dcc34c.vercel.app)은 Production/READY이며 Vercel 로그인과 앱 Basic을 유지한다. 자동 alias는 프로젝트의 vercel.app 주소만 붙었고 quizeey.com/www는 배정되지 않았다. 인증 없는 접근302→vercel.com/noindex, 기존 공개 사이트200을 확인했다. 모든 호스트에 Basic, robots 전체 차단/빈 sitemap/광고·분석 비활성을 적용한다. 소유자의 실제 hosted 로그인/최신 UI 검토는 남아 있다. 로컬97unit/typecheck/lint/Turbopack build와 별도 Production 설정의 합성 RPC/브라우저 흐름이 통과했다. [배포 증거](production-review-deployment-evidence.json), [브라우저 증거](production-review-browser-evidence.json).

**이 빌드를 그대로 공개 승격하지 않는다.** 실제 광고·동의 검증을 마치고 `QUIZEEY_PRODUCTION_REVIEW=false`와 최종 release/ads 설정으로 별도 빌드를 만들어 공개 robots/sitemap/canonical 및 보호 도메인 동작을 재검증한다. CMP URL은 위 review 배포 뒤에 등록됐으므로 다음 빌드에서 상속된다. 현재 review에서는 URL 존재 여부와 무관하게 Google 연결이 꺼진다.

## DNS 변경안 — 지금 적용하지 않음

Cloudflare가 authoritative DNS다. Vercel 도메인 등록은 완료했지만 DNS 연결은 아직 미완료다. Cloudflare의 공개 응답 IP는 프록시 주소이므로 복구 값으로 사용하지 않는다.

| 이름 | 현재/복구 | 전환 후보 | 프록시 / TTL |
| --- | --- | --- | --- |
| `@` | A `52.35.43.187` 1개 | A `216.150.1.1` + A `216.150.16.1` 2개 | 현재/복구 Proxied·Auto → 전환 DNS only·300초 |
| `www` | A `52.35.43.187` | CNAME `a32fabf8efa8b80c.vercel-dns-016.com` | 현재/복구 Proxied·Auto → 전환 DNS only·300초 |

전환 후보는 2026-10-18 01:47 UTC 지정 프로젝트의 도메인 설정 API rank1 권장값이다. 실행 직전 재조회해 최종안과 일치하는지 확인한다. 네임서버·MX/TXT/Naver/Google 검증 레코드는 유지한다. Zone export를 보관하고 apex/www의 추가 AAAA/CNAME 및 Cloudflare redirect/cache/SSL 규칙 충돌을 점검한다. www→apex는 앱의 308이 path/query를 보존한다.

DNS-only는 Vercel이 실제 요청 peer를 확인하도록 하기 위한 이번 구성의 기준이다. 현재 Cloudflare Proxied를 유지하려면 검증된 별도 proxy 설정과 요청 제한 재검증이 필요하며, `cf-connecting-ip`를 그대로 신뢰하는 것으로 대체하지 않는다. [Vercel 요청 헤더](https://vercel.com/docs/headers/request-headers), [외부 DNS 도메인 연결](https://vercel.com/docs/domains/set-up-custom-domain).

## 광고·Analytics 전환 검증

기존 publisher `ca-pub-8362228066874729`, Display `1033140566`, In-feed `8990988805` 및 ads.txt를 유지한다. 목록 6개 다음 인피드, 학습 영역 밖 Display, 광고 로딩 시 공간 확보, 미충전/차단 시 빈 영역 정리, 문제 전환 시 광고 재요청 금지를 구현했다. 시험 시작·문제 링크·이어서 풀기·문제 묶음 이동에는 공식 `data-google-vignette="false"`를 적용했다. [Google 공식 링크별 전면 광고 제외](https://support.google.com/adsense/answer/17016693?hl=en).

컷오버 창에서 AdSense 미리보기로 문제 본문·선택지·채점/이동 버튼을 자동 광고 제외 영역으로 확인한다. **영역 제외는 in-page 광고용이며 앵커/전면 오버레이 자체를 제어하지 않는다.** 앵커가 켜진 실제320/390px 화면에서 열기·닫기·스크롤·선택/채점/이어서 풀기와 개인정보 설정 접근을 확인한다. 화면 위/아래 표시 위치나 동적 확장 높이는 ON이라는 답변만으로 추정하지 않는다. 앵커/사이드레일과 수동 Display가 겹치면 해당 오버레이를 조정하고 다시 검증한다. 계정 설정은 v1에도 영향을 주므로 현재는 변경하지 않았다. 페이지 제외를 쓰는 경우 query/fragment URL은 지원되지 않으므로 경로 단위로 설정한다. [자동 광고 설정](https://support.google.com/adsense/answer/9305577), [페이지 제외](https://support.google.com/adsense/answer/9262311?hl=en).

기존 GA4 속성의 실시간/DebugView에서 운영 canonical 페이지당 1회 page_view와 퀴즈 이벤트, 중복 tag 없음, 동의 거절/철회·지역별 메시지를 확인한다. 방문자의 답안 원문·표시명·폼 입력을 분석으로 전송하지 않는다. 실제 광고를 테스트 목적으로 클릭하지 않는다. 출시 후 AdSense RPM/조회 가능성/CTR과 문제 완료·이어풀기·성능을 함께 비교하며, 사전 모의 테스트를 수익 개선 증거로 해석하지 않는다.

## 최종 실행 순서

보호된 운영 빌드의 문항/기본 해설·광고/분석·SEO 검증 → 모든 구 writer 동결·drain → 최종 backup/delta·행/값 해시 대사 및 새 사용자 글 비공개 보관 → 승인된 DNS 변경 → SSL/HTTP→HTTPS/www/기존 URL·canonical·robots/sitemap/ads.txt·동의/GA4·광고·학습 흐름 확인 → 관찰 순서다. 이번 새 앱의 포럼 writer는 열지 않는다. 향후 새 쓰기 수락 후의 복귀는 [rollback-runbook.md](rollback-runbook.md)를 따른다. AWS는 관찰·복구 확인 전까지 유지한다.

---

아래는 원본 보존 및 실행 게이트 상세다. 과거의 cloud 미실행/콘텐츠 차단 시점 설명은 위 최신 증거와 함께 읽는다.

입력 gate: 검증된 source deployment/DDL/backup 복구, 대상 Vercel team/project·Supabase org/project·리전, 증분 비용, URL/광고/동의/권한 테스트, owner가 정한 RPO/RTO·쓰기 중단 시간.

현재 확보: EC2-local MySQL5.7.30 live DDL6개, 실행 JAR/controller/templates 대조, 사용자 승인 원본167,205행 snapshot. [원본 검증](source-reconciliation.md). 개발 snapshot은 최종 writer 동결 snapshot이나 전체 인스턴스 backup을 대신하지 않는다. 중복/고아/정답 예외 때문에 공개 serving ETL은 차단한다. 원본 ID 보존 raw staging 리허설은 관계 오류를 자동 수정하지 않는다.

현재 입력 정책 갱신: 사용자가 오류751문항을 새 서비스 이전 대상에서 삭제하고 원본 backup을 유지하도록 확인했다. source 전체가 아닌 hash가 고정된 `new-service-dataset.json`을 콘텐츠 ETL 입력으로 사용한다. [publication-candidate-evidence.json](publication-candidate-evidence.json). 새 FK/unique 콘텐츠5테이블의2회 replay/backup restore·정답/ID/UTC·권한/sequence는 로컬에서 통과했다. [content-rehearsal-evidence.json](content-rehearsal-evidence.json). 최종 snapshot에도 같은751 ID 정책을 대조하고 새 오류·변경된 ID 집합은 자동 확대 삭제하지 않는다. 삭제 관련 choice433/explanation26/counter726과 무관한 orphan choice2438/counter18을 구분한다. source MySQL/backup을 삭제하지 않는다.

1. 운영 스냅샷을 안전한 비공개 위치로 확보. 데이터·파일·Disqus export의 SHA-256과 table/exam/version count 기록. 실제 DB version/timezone/charset 확인. 원본은 수정하지 않는다.
2. 비운영 Quizeey 대상에 replayable staging import와 최종 ETL을 리허설한다. IDs, sequence, parent/orphan, correct-choice sets, counters, files, moderation 상태를 대사. 불일치 0 또는 승인된 예외 목록 확보.
3. 이번 범위의 문항/기본 해설 및 비공개 사용자 글 백업 복구와 앱 rollback을 확인한다. native forum 기능·개인 guest ownership·pending revisions/reports의 복구/권한 검증은 이후 포럼 활성화 전 필수로 유지한다.
4. 실제 GSC 클릭 95% 이상을 포함하는 top URL과 남은 모든 알려진 경로의 HTML/canonical/status/link diff를 확인한다. 첫 production 광고 설정/CMP를 정확히 기록한다.
5. **여기서 구체적 change request 제출:** 변경 대상 IDs, exact migration revisions, 백업 경로/해시, 예상 소요·쓰기 중단·RPO/RTO, DNS record before/after·TTL·Cloudflare 상태, 비용, 중단/rollback 기준. 사용자 승인 전 6 이후 실행 금지.
6. 승인된 창에 기존 stats/해설/Disqus/관리자/배치 등 모든 writer를 동결. in-flight drain 확인. stale DNS와 구 브라우저가 구 origin에서 쓰지 못하도록 검증된 503/read-only 응답 또는 forwarding 경로 사용.
7. 최종 snapshot/delta → 검증된 ETL → 재대사. 실패 시 새 writer를 열지 않는다. 아직 쓰기 전이면 검증된 구 DB 복귀 가능.
8. 승인된 DNS/트래픽 변경 적용; canonical/SSL/redirect/ads.txt/Naver/광고/CMP/주요 URL 확인. 이번 공개 앱은 문항 읽기·브라우저 학습 기록으로 운영하며 포럼 writer는 비활성이다.
9. 최근 prelaunch 기준선과 오류·latency·유입·수익·DB/cache hit·실제 비용 비교. 관찰기간/중단 조건은 owner 승인값 사용.
10. AWS 종료는 별도 승인안. 리소스별 소유/공유·retained backup/restore·DNS/메일/domain/jobs/assets 누락 확인 후 exact resource IDs와 명령을 제출한다. 종료 후 다음 청구서로 잔여 비용 확인.

지금 없는 IDs/zone/DDL를 채워 넣은 가짜 실행 명령은 만들지 않는다. 이 실행안은 절차 초안이며 실제 change request는 근거가 준비된 뒤 작성한다.
