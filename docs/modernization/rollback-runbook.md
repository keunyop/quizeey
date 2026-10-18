# 되돌리기 계약 — 리허설 전

Current execution: see [cutover-live-handoff.md](cutover-live-handoff.md). Source AWS/MySQL is retained. DNS rollback restores both original proxied A52.35.43.187 records. No source data deletion or new forum writes.

**DNS rollback은 데이터 rollback이 아니다.** 어느 단계에서든 writer는 하나만 유지한다.

2026-10-17 소유자 확인 DNS 복구 값: Cloudflare `@` A `52.35.43.187`, `www` A `52.35.43.187`, 두 레코드 모두 Proxied/TTL Auto. 전환 시 추가한 두 apex A 또는 www CNAME을 이 원래 형태로 복원한다. 네임서버는 `arnold.ns.cloudflare.com`, `miki.ns.cloudflare.com`을 유지한다. 이 값은 검증된 구 앱/DB 및 writer 통제와 함께 사용한다. 공개 DNS의 Cloudflare proxy IP로 되돌리지 않는다. 전환 후보·실행 전 재확인은 [migration-runbook.md](migration-runbook.md)의 DNS 표를 따른다.

| 시점 | 동작 |
| --- | --- |
| 새 쓰기 수락 전 | 모든 새 writer 닫힘 확인 → 검증된 구 DB/앱 복귀 → routing 회복 → 데이터/작업 확인 후 구 writer만 열기 |
| 새 쓰기 수락 후 | Supabase 유지, 이전 호환 앱 배포로 rollback 우선. 필요 시 기능 read-only로 제한 |
| AWS/MySQL 복귀 필요 | 새 쓰기 동결·drain → 수락된 delta 전체 export → 검증된 reverse ETL → 대사 → 구 writer만 열기 |
| reverse ETL 미검증/지원 불가 | read-only 상태로 forward-fix. accepted write 유실을 감추기 위해 DNS만 되돌리지 않음 |

accepted write에는 stats/해설 외 native topics/posts/replies, pending revisions, reports, private ownership·capability 검증 정보를 포함한다. legacy가 표현할 수 없는 데이터는 Supabase에 보존하고 해당 기능을 닫거나 호환 앱을 복구한다. imported Disqus 글은 이름 기반 소유권이나 복구 capability를 부여하지 않는다.

관리 감사 기록과 서버 세션 폐기 정보도 복구 범위다. DB snapshot 복원 후 트래픽을 열기 전에 관리자 세션을 모두 폐기하고 재로그인하도록 한다. 예비 운영 SQL은 `UPDATE quizeey_private.admin_sessions SET revoked_at=coalesce(revoked_at,now());`이며 실제 운영 실행에는 승인된 복구 절차가 필요하다. 과거 snapshot으로 폐기된 관리자 세션을 되살리지 않는다. Guest ownership/capability는 accepted post의 소유권 보존을 위해 유지한다.

리허설 증거: backup restore checksum, 수락된 글/답글/수정/신고/ownership 보존 count/hash, owner 확인한 RPO/RTO·소요시간, exact app/migration revision. fixture11테이블 복원은 통과했다. 승인된 실제6개 테이블의 로컬 raw 보존 리허설은 별도 evidence로 기록한다. Supabase 실제 backup·신규 accepted write의 reverse ETL·전체 EC2 복원은 아직 검증되지 않았다.
