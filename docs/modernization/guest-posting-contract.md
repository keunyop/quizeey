# 회원가입 없는 native forum

구현한 범위: native schema·RLS/명시적 grants, Supabase 및 로컬 HTTP API, capability/CSRF/input policy, DB idempotency·원자적 shared rate limit, 즉시 공개와 댓글 페이지 조회. 운영 활성화는 검증된 프로젝트와 서버 전용 환경변수를 요구한다.

- 읽기/가입 없는 글·답글, 선택적 이름. 빈 문자열·모든 whitespace는 한국어 익명/영어 Anonymous로 표시한다. 이름으로 소유권을 판단하지 않는다.
- 첫 글/답글 제출에만 256bit random capability를 발급한다. `__Host-quizeey-guest`, Secure, HttpOnly, SameSite=Strict, Path=/, 90일. 서버 DB에는 SHA-256과 ownership mapping만 저장한다. GET이나 신고만으로 쿠키/Auth 계정을 만들지 않는다.
- 같은 브라우저의 유효 capability만 자기 글을 수정/삭제할 수 있다. 쿠키 삭제/만료·다른 기기·같은 이름으로 복구 불가. Disqus import에는 ownership을 만들지 않는다.
- create/reply는 즉시 approved로 공개되며 edit도 즉시 반영된다. 이미 배포된 서버의 소유권 쿠키 발급과 호환되도록 create/reply의 HTTP 상태는 202를 유지하고, edit은 200을 반환한다. 자기 삭제는 tombstone으로 남긴다. 신고/hide/lock/global delete 및 기존 pending revision 검토는 관리자 기능으로 유지한다.
- pending/revision/report/ownership/capability는 공개 DB 역할에서 접근 불가. anon/authenticated는 승인된 nonempty topic/post SELECT만 허용. 모든 직접 public write 및 privileged RPC 호출을 거부한다.
- text는 React의 텍스트 노드로 출력하며 HTML을 실행하지 않는다. 링크 최대3, ugc/nofollow/noopener/noreferrer. 글4000자/16000바이트, 이름80자, 제목120자, 신고500자, streamed request24000바이트 제한.
- Origin/CSRF 및 UUID idempotency key 필수. 서로 다른 capability가 같은 key를 사용하면409; 응답 유실 뒤 새 cookie로 재시도해도 중복 글/소유권 이전이 생기지 않는다. 성공 receipts는1일, rate window20분, report30일 expiry/cleanup 함수가 있다.
- rate: capability당10회/10분, abuse bucket30회/10분. PostgreSQL UPSERT로 공유·원자적 처리한다. process memory로 limiter를 대체하지 않는다.
- 공개 댓글은 작성 시각과 UUID를 기준으로 최신순 10개씩 조회한다. 다음 페이지의 존재만 확인하기 위해 DB에서 최대 11개를 선택하며 OFFSET과 전체 건수 집계는 사용하지 않는다. 답글도 페이지 제한에 포함하므로 하나의 긴 묶음에서 댓글이 누락되지 않는다. UTC 마이크로초 정밀도를 커서에 유지한다.
- `/api/forum/mine?posts=...`은 현재 페이지 ID 최대 10개의 소유권만 조회하므로 오래된 댓글도 수정·삭제할 수 있다. ID 없는 기존 요청은 최신 소유 글 20개를 반환하여 구버전 배포와 호환한다. 모든 응답은 private/no-store/noindex이다. empty/pending topic용 indexable 페이지를 만들지 않는다.
- 시험 댓글은 1180px 이상에서 오른쪽 패널, 좁은 화면에서는 제목 행의 `댓글 ▶` 버튼으로 여는 우측 dialog에 표시한다. 모바일에서는 처음 열기 전까지 댓글을 조회하지 않으며 닫아도 초안을 보존한다. Escape·닫기·배경 클릭, 포커스 순환/복원 및 배경 스크롤 잠금을 지원한다. 문제 댓글은 정답 설명 영역에 별도로 유지한다.

로컬 검증:

```powershell
python tools/modernization/test_database.py
# 별도 터미널: 비어 있는 fixture 클러스터를 잠시 유지
python -u tools/modernization/test_database.py --serve
# web/.env.local에는 .env.example에 안내한 정확한 loopback fixture URL만 설정
```

로컬 transport는 `quizeey_server@127.0.0.1:55432/quizeey_fixture` 이외의 URL·비밀번호·query, hosted stage를 거부한다. `QUIZEEY_LOCAL_FORUM_ORIGIN`은 브라우저의 정확한 loopback origin으로 설정한다(기본 http://127.0.0.1:3000, 테스트3100). 테스트는 기존 5432 PostgreSQL 서비스나 운영 프로젝트에 연결하지 않는다. 관리자 HTTP API는 검증된 provider identity와 등록된 관리자 세션을 요구하며 방문자 capability와 구분한다.

운영에서는 Supabase RPC transport, 별도 서버 키, 검증된 Vercel peer의 HMAC limiter와 cron cleanup 설정을 사용한다. 로컬 고정 abuse bucket/관리자 fixture를 운영에 사용하지 않는다. 2026-10-18 승인된 ASiS 복원 댓글 2,183개는 이름으로 소유권을 추정하지 않으며 원래 문항 연결과 언어 공유를 유지한다. 즉시 공개·페이지 조회 변경의 운영 검증은 `forum-publication-paging-evidence.json`에 기록한다.
