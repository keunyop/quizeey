# 회원가입 없는 native forum

구현한 범위: 새 native schema·RLS/명시적 grants, 로컬 전용 HTTP API 및 화면, capability/CSRF/input policy, DB idempotency·원자적 shared rate limit. 실제 Supabase target/관리자 identity provider가 검증되지 않아 production 활성화는 차단한다.

- 읽기/가입 없는 글·답글, 선택적 이름. 빈 문자열·모든 whitespace는 한국어 익명/영어 Anonymous로 표시한다. 이름으로 소유권을 판단하지 않는다.
- 첫 글/답글 제출에만 256bit random capability를 발급한다. `__Host-quizeey-guest`, Secure, HttpOnly, SameSite=Strict, Path=/, 90일. 서버 DB에는 SHA-256과 ownership mapping만 저장한다. GET이나 신고만으로 쿠키/Auth 계정을 만들지 않는다.
- 같은 브라우저의 유효 capability만 자기 글을 수정/삭제할 수 있다. 쿠키 삭제/만료·다른 기기·같은 이름으로 복구 불가. Disqus import에는 ownership을 만들지 않는다.
- create/reply는 pending. approved 글의 edit은 private pending revision; 승인 전 원문을 바꾸지 않는다. 자기 삭제는 tombstone으로 남긴다. 승인/hide/lock/global delete는 privileged moderation transport만 호출 가능하다.
- pending/revision/report/ownership/capability는 공개 DB 역할에서 접근 불가. anon/authenticated는 승인된 nonempty topic/post SELECT만 허용. 모든 직접 public write 및 privileged RPC 호출을 거부한다.
- text는 React의 텍스트 노드로 출력하며 HTML을 실행하지 않는다. 링크 최대3, ugc/nofollow/noopener/noreferrer. 글4000자/16000바이트, 이름80자, 제목120자, 신고500자, streamed request24000바이트 제한.
- Origin/CSRF 및 UUID idempotency key 필수. 서로 다른 capability가 같은 key를 사용하면409; 응답 유실 뒤 새 cookie로 재시도해도 중복 글/소유권 이전이 생기지 않는다. 성공 receipts는1일, rate window20분, report30일 expiry/cleanup 함수가 있다.
- rate: capability당10회/10분, abuse bucket30회/10분. PostgreSQL UPSERT로 공유·원자적 처리한다. process memory로 limiter를 대체하지 않는다.
- `/api/forum/mine`은 private/no-store/noindex이고 검증된 cookie 소유자20개만 반환한다. 공개 조회도 현재 no-store로 takedown이 즉시 반영되도록 한다. empty/pending topic용 indexable 페이지를 만들지 않는다.

로컬 검증:

```powershell
python tools/modernization/test_database.py
# 별도 터미널: 비어 있는 fixture 클러스터를 잠시 유지
python -u tools/modernization/test_database.py --serve
# web/.env.local에는 .env.example에 안내한 정확한 loopback fixture URL만 설정
```

로컬 transport는 `quizeey_server@127.0.0.1:55432/quizeey_fixture` 이외의 URL·비밀번호·query, hosted stage를 거부한다. `QUIZEEY_LOCAL_FORUM_ORIGIN`은 브라우저의 정확한 loopback origin으로 설정한다(기본 http://127.0.0.1:3000, 테스트3100). 기존 5432 PostgreSQL 서비스나 제공된 Supabase 프로젝트에 접속하지 않는다. SQL/테스트는 관리자 gateway 자체가 아니다. 현재 moderator는 DB fixture 테스트에서만 호출하며 HTTP moderator endpoint/가짜 로그인은 만들지 않았다.

실서비스 전에 남은 작업: 검증된 Quizeey Supabase target의 RPC transport, provider에서 검증한 관리자 session 및 UUID allowlist·관리 화면, 실제 platform peer의 rotating HMAC limiter와 cleanup schedule, 승인된 타겟의 signup 차단, 신고처리/삭제 정책, 실제 Disqus export·cache invalidation·staging load/abuse 검증. 이 작업은 타 서비스의 auth 정책에 적용하지 않는다. production에서는 로컬 고정 abuse bucket/관리자 fixture를 사용하지 않는다.
