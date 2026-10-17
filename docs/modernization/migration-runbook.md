# 운영 이전 실행안 — 아직 실행/승인되지 않음

입력 gate: 검증된 source deployment/DDL/backup 복구, 대상 Vercel team/project·Supabase org/project·리전, 증분 비용, URL/광고/동의/권한 테스트, owner가 정한 RPO/RTO·쓰기 중단 시간.

현재 확보: EC2-local MySQL5.7.30 live DDL6개, 실행 JAR/controller/templates 대조, 사용자 승인 원본167,205행 snapshot. [원본 검증](source-reconciliation.md). 개발 snapshot은 최종 writer 동결 snapshot이나 전체 인스턴스 backup을 대신하지 않는다. 중복/고아/정답 예외 때문에 공개 serving ETL은 차단한다. 원본 ID 보존 raw staging 리허설은 관계 오류를 자동 수정하지 않는다.

현재 입력 정책 갱신: 사용자가 오류751문항을 새 서비스 이전 대상에서 삭제하고 원본 backup을 유지하도록 확인했다. source 전체가 아닌 hash가 고정된 `new-service-dataset.json`을 콘텐츠 ETL 입력으로 사용한다. [publication-candidate-evidence.json](publication-candidate-evidence.json). 새 FK/unique 콘텐츠5테이블의2회 replay/backup restore·정답/ID/UTC·권한/sequence는 로컬에서 통과했다. [content-rehearsal-evidence.json](content-rehearsal-evidence.json). 최종 snapshot에도 같은751 ID 정책을 대조하고 새 오류·변경된 ID 집합은 자동 확대 삭제하지 않는다. 삭제 관련 choice433/explanation26/counter726과 무관한 orphan choice2438/counter18을 구분한다. source MySQL/backup을 삭제하지 않는다.

1. 운영 스냅샷을 안전한 비공개 위치로 확보. 데이터·파일·Disqus export의 SHA-256과 table/exam/version count 기록. 실제 DB version/timezone/charset 확인. 원본은 수정하지 않는다.
2. 비운영 Quizeey 대상에 replayable staging import와 최종 ETL을 리허설한다. IDs, sequence, parent/orphan, correct-choice sets, counters, files, moderation 상태를 대사. 불일치 0 또는 승인된 예외 목록 확보.
3. 새 native forum 기능·개인 guest ownership·pending revisions/reports를 포함해 backup restore와 앱 rollback을 리허설한다. 공개 DB 역할은 직접 쓰기 불가, pending 조회 불가를 검증한다.
4. 실제 GSC 클릭 95% 이상을 포함하는 top URL과 남은 모든 알려진 경로의 HTML/canonical/status/link diff를 확인한다. 첫 production 광고 설정/CMP를 정확히 기록한다.
5. **여기서 구체적 change request 제출:** 변경 대상 IDs, exact migration revisions, 백업 경로/해시, 예상 소요·쓰기 중단·RPO/RTO, DNS record before/after·TTL·Cloudflare 상태, 비용, 중단/rollback 기준. 사용자 승인 전 6 이후 실행 금지.
6. 승인된 창에 기존 stats/해설/Disqus/관리자/배치 등 모든 writer를 동결. in-flight drain 확인. stale DNS와 구 브라우저가 구 origin에서 쓰지 못하도록 검증된 503/read-only 응답 또는 forwarding 경로 사용.
7. 최종 snapshot/delta → 검증된 ETL → 재대사. 실패 시 새 writer를 열지 않는다. 아직 쓰기 전이면 검증된 구 DB 복귀 가능.
8. 승인된 DNS/트래픽 변경 적용; canonical/SSL/redirect/ads.txt/Naver/광고/CMP/주요 URL 확인. 단일 Supabase writer만 활성화.
9. 최근 prelaunch 기준선과 오류·latency·유입·수익·DB/cache hit·실제 비용 비교. 관찰기간/중단 조건은 owner 승인값 사용.
10. AWS 종료는 별도 승인안. 리소스별 소유/공유·retained backup/restore·DNS/메일/domain/jobs/assets 누락 확인 후 exact resource IDs와 명령을 제출한다. 종료 후 다음 청구서로 잔여 비용 확인.

지금 없는 IDs/zone/DDL를 채워 넣은 가짜 실행 명령은 만들지 않는다. 이 실행안은 절차 초안이며 실제 change request는 근거가 준비된 뒤 작성한다.
