# 관리자 인증·검토 계약

2026-10-17 후속: 소유자가 기존 사용자 글을 비공개 보관하고 포럼 구성을 이후 결정하기로 했다. 이번 컷오버의 관리자/포럼 활성화는 보류한다. 제공된 실제 운영자 UUID의 계정 상태를 읽기 전용으로 확인해 Preview allowlist/provider를 등록했으나 실제 hosted 로그인 검증 완료를 뜻하지 않는다. 현재 범위/준비 결과는 [cutover-owner-followup-evidence.json](cutover-owner-followup-evidence.json)을 따른다. 아래 local-only 구현 기록은 이전 이력이며 새 hosted adapter는 명시적 비활성 gate 뒤에 준비돼 있다.

2026-10-16 구현 및 검증. 일반 방문자는 Auth 계정 없이 학습·읽기·글·답글을 이용한다. `/admin`, `/en/admin`과 `/api/admin/*`는 관리자 전용이며 공개 가입·프로필 기능은 없다.

## 인증과 권한

- 공식 `@supabase/supabase-js` 2.118.0의 password sign-in과 서버 `getUser(token)`을 사용한다. 매 요청마다 공급자에게 다시 검증하며 이메일·표시 이름·user metadata의 `role`은 권한 근거가 아니다. 검증된 UUID가 서버 `QUIZEEY_ADMIN_USER_IDS` allowlist에 있어야 하고 anonymous Auth 사용자는 거부한다.
- 공급자 기본값과 allowlist 기본값은 비활성이다. 실제 공급자는 사용자 지정 Quizeey 프로젝트 `tfkhnrbshvyfmrzxqfmq`만 허용한다. 키는 서버 전용 publishable/legacy anon 키만 사용하며 service-role/secret 키는 인증 클라이언트에서 거부한다. 세션을 요청 간 공유하거나 브라우저 localStorage에 넣지 않는다.
- `__Host-quizeey-admin` 쿠키는 Secure/HttpOnly/SameSite=Strict/Path=/, 최대 1시간이다. JWT·refresh token·사용자 이메일을 JSON 응답이나 분석 이벤트에 보내지 않는다. refresh token은 저장하지 않고 만료 후 다시 로그인한다.
- 비공개 `admin_sessions`에는 토큰의 SHA-256, 검증된 UUID, 만료·폐기 시각만 기록한다. 서버가 발급하고 아직 폐기되지 않은 세션이어야 공급자 검증과 관리 요청을 진행한다. 로그아웃은 공유 DB에서 먼저 폐기한다. 공급자 JWT가 여전히 유효해도 같은 쿠키 재사용은 거부한다. DB 폐기 실패는 성공으로 응답하지 않는다.
- [Supabase getUser](https://supabase.com/docs/reference/javascript/auth-getuser), [signOut](https://supabase.com/docs/reference/javascript/auth-signout)의 실제 동작을 기준으로 했다. 공급자 logout만으로 access JWT가 즉시 무효화된다고 가정하지 않는다.

## 관리 동작

pending/공개/숨김 글, pending 수정본, 미처리 신고를 페이지당 20개씩 읽는다. 원래 공개 본문과 수정본을 비교하고 승인·거절할 수 있다. 승인·숨김·삭제·답글 잠금/해제·신고 처리는 검증된 관리자만 수행한다. 오래된 수정본은 더 최신의 pending/approved 수정본을 덮어쓸 수 없다.

변경은 Origin/CSRF, strict 입력 검증, UUID idempotency key와 공유 DB 제한을 통과해야 한다. 동일 key의 actor/action/target 변경은 409다. 비공개 감사 기록에는 검증된 actor UUID와 동작·대상·결과를 남긴다. 공개 글 수는 승인·숨김·삭제와 함께 원자적으로 갱신한다. 현재 public forum 응답은 no-store여서 다음 조회에 takedown이 반영된다. 향후 공개 캐시를 도입하면 별도 invalidation 검증이 필요하다.

anon/authenticated는 검토 RPC·비공개 세션·감사 기록에 접근할 수 없다. service_role도 비공개 테이블을 직접 읽지 못하며 제한된 SECURITY DEFINER 함수만 호출한다. 이 역할은 인증 자체가 아니므로 호출 전에 서버 세션 검증이 필수다. 모든 관리 응답은 private/no-store/noindex이며 광고·분석을 실행하지 않는다.

## 로컬 검증과 실제 배포의 차이

현재 DB transport는 정확한 `127.0.0.1:55432/quizeey_fixture`만 허용하고 hosted 환경에서는 막힌다. Auth HTTP double도 명시적인 local 설정과 정확한 `127.0.0.1:55433`에서만 허용한다. double은 JWT를 logout 후에도 유효하게 유지해 Quizeey 측 폐기를 검증한다. 테스트용 `.invalid` 계정은 실제 Supabase 계정이 아니다.

로컬 SQL에서 권한·세션 폐기·만료·idempotency·수정본 순서·신고를 확인했고 실제 브라우저에서 관리자 로그인·처리·로그아웃, 일반 사용자 권한 거부, 방문자 Auth 요청 없음, cookie 재사용 거부, 20개 keyset 페이지, axe 위반 0을 확인했다. **실제 Supabase Auth/역할/관리자 UUID·signup 설정 검증을 대체하지 않는다.**

현재 로그인 제한 5회/10분, 관리 변경 60회/10분, 감사 보존 90일은 로컬 정책이다. 운영에는 검증된 peer 주소의 회전 HMAC, 대상 프로젝트의 admin UUID·signup 제한, 정리 schedule과 고지/보존 정책 검토가 필요하다. 실제 계정·설정 변경은 아직 없다. 복원 시 관리자 세션을 모두 폐기하고 재로그인하도록 하며 guest 소유권 기록은 보존한다.
