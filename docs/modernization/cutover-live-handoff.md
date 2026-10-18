# 실제 도메인 전환 상태

현재 기준 문서는 이 파일과 [실행 증거](cutover-execution-2026-10-18.json)다. 이전 runbook의 review=true, 인증서 미발급, 97unit 기록은 과거 이력이다.

**컷오버 완료 — 소유자 최종 확인:** 최종 운영 배포 후 소유자가 기존 GA4 수신과 휴대폰 광고 배치가 정상임을 확인했다. Google 연결 장애는 해결됐으며 컷오버를 위해 추가로 요청할 설정은 없다. master `8ce414dfcb1db5cc1443d07c23cebe75582e29ee`, 운영 배포 `dpl_7SHtHERNcgYfFuY2yBmYCqfjPgti`를 유지한다. 아래 “확인 대기”와 중계/자동 입력 검사 기록은 소유자 확인 전의 이력이다. 자동 입력 검사의 중단 결과는 그대로 보존하고, 소유자 실기기 확인을 별도 근거로 기록했다. AWS/MySQL·비공개 사용자 글·전환 전후 백업을 유지한다. 이후 모니터링과 별도 승인에 따른 구 서버 정리는 후속 작업이다.

**최신 후속 — Google 연결 오류 수정·배포 완료, 실제 모바일 배치 확인 대기:** 소유자 GA4 미수신/광고 미노출은 CMP의 불필요한 crossorigin=anonymous와 ACAO 없는 응답의 CORS 차단이 원인이었다. 이전의 “관리 브라우저 Google 연결 제한” 해석은 잘못됐다. 중계/route.fulfill 검증은 실제 CORS 검사를 우회해 충분하지 않았다. PR83은 CMP만 classic script로 수정하고 회귀 검사를 CI에 추가했다. PR84는 문제 화면의 공식 collapsed-bottom 앵커 옵션과 study 영역 google-anno-skip을 추가했다. 최종 master `8ce414dfcb1db5cc1443d07c23cebe75582e29ee`, 배포 `dpl_7SHtHERNcgYfFuY2yBmYCqfjPgti` READY·승격, quizeey.com/www alias 모두 일치한다. CI99unit/22browser/광고3시나리오가 통과했다.

중계/모의 응답/DOM 주입 없는 실제 공개 브라우저에서 CMP200, AdSense200 및 filled 광고, 기존 GA4 collect204와 page_view1을 확인했다. 다만 실광고 입력 검사에서 의도하지 않은 광고 페이지 이동이 확인됐다. 추가 실광고 포인터 검사는 중단했으며, 실제 모바일 광고/버튼 사용성을 완료로 인증하지 않는다. 직접 검증 도구는 이후 수동 입력 없는 관찰용으로 제한했다. 소유자에게 새 탭 재접속 후 기존 GA4 Realtime과 실제 휴대폰 배치 확인을 요청한 상태다. 아래 중계 성공 기록과 최초 master 상태는 과거 이력이다. [사고 기록](cmp-cors-incident.json), [직접 검증 결과와 제한](live-google-direct-evidence.json).

**현재: 공개 DNS 전환 및 실제 v2 서비스 확인 완료.** 소유자가 Cloudflare 변경 완료를 회신했고 Vercel은 apex A/www CNAME 모두 misconfigured=false다. 공개 DNS를 사용하는 HTTPS/SEO8개·실제 읽기 API8개·브라우저6개 검사가 통과했다. 실제 문항 선택·채점·기록 복원·다음 이동·390px 화면을 확인했다. 구 경로/영문/개인정보/Naver 검증 파일도 정상이다.

Google 직접 연결이 제한된 자동 브라우저는 별도 기록했으며, 원본 Google 응답을 변경하지 않는 Node 전송으로 실제 CMP200, AdSense200 및 filled 광고, 기존 `G-XM8XM4CHX7`의 collect204와 page_view1을 확인했다. 가짜 동의/모의 스크립트/광고 클릭은 사용하지 않았다. GA4 관리자 실시간 수신과 실제 휴대폰 오버레이 배치는 소유자 확인을 요청한 상태다. [라이브 Google 증거](live-google-evidence.json).

08:40:06 UTC 전환 후 비공개 스냅샷 `.modernization/exports/source-9b92d233d8`을 추가 보관했다. 사용자 글2,209개·문항/보기는 변함없다. 07:58 이후 통계8건을 old-value/row lock/count8 전제로 원자적으로 반영하고 old0/new8/conflict0을 확인했다. 초기272건을 재적용하지 않았다. [전환 후 백업](postcutover-source-snapshot-evidence.json), [대사](postcutover-source-comparison.json).

## 완료

- PR82 병합: master `9b3c3fc1a4d033ebd383221b27240fb95ceeeee9`, tree `c75ee58855a1c7d16f4f147c07c6481464a88079`.
- Production `dpl_G6YBonUsP4f6BxTpNggAPfzBqzqu` READY·승격. quizeey.com/www alias 재조회 일치. review=false, release/ads=true.
- 인증서 `cert_AMNe1DCd3XFGrHI5ikP3x7nv`: `quizeey.com`과 `*.quizeey.com`, 자동 갱신. 비밀키는 조회하지 않았다.
- 2026-10-18 08:30:35 UTC: 두 권장 IP에 실제 Host/SNI로 직접 연결하여 TLS 인증·robots·sitemap·ads.txt·메인/시험 페이지 canonical과 기존 Google ID·v1 로고/favicon 바이트·www 경로/쿼리 보존 리다이렉트 **16개 통과**. [원본 서버 검증](public-origin-evidence.json). 이는 아직 변경하지 않은 공개 DNS의 검증과 구분한다.
- 99unit, 브라우저22개, typecheck/lint/build, GitHub CI 통과. 실제 게시 CMP API와 합성 광고/GA4 수명주기 검증 완료. 실제 지역별 광고 충전/오버레이 및 GA4 속성 실시간 수신은 전환 후 확인한다.
- 07:58:16 UTC 읽기 전용 일관 스냅샷 보관: `.modernization/exports/source-060f63bf88`. 사용자 글2,209개 비공개 보관, 원문·문항 변경0. 통계272건 old-value 전제 원자적 갱신 및 대사 완료.

## 소유자에게 요청한 DNS 변경

Cloudflare 쓰기 도구가 없어 소유자 화면에서 변경했다. 완료 회신과 Vercel 설정 API, 실제 공개 DNS 요청으로 전환을 확인했다.

| 이름 | 유형 | 전환 값 | Proxy | TTL |
| --- | --- | --- | --- | --- |
| @ | A | 216.150.1.1 | DNS only | 300초 |
| @ | A | 216.150.16.1 | DNS only | 300초 |
| www | CNAME | a32fabf8efa8b80c.vercel-dns-016.com | DNS only | 300초 |

기존 @/www의 A52.35.43.187과 교체한다. 네임서버·MX·기타 TXT 및 무관한 레코드는 유지한다. 권장값은 이번 요청 직전 Vercel 도메인 설정 API에서 다시 확인했다.

## 이번 읽기 중심 출시의 데이터 보존

v2는 문항 읽기와 브라우저 학습 기록을 제공하며 포럼/가입/서버 통계 쓰기는 활성화하지 않는다. 기존 MySQL이 기존 방문자의 서버 쓰기를 받는 유일한 데이터 저장소로 남는다. DNS 전파 동안 구 페이지를 계속 사용하는 방문자의 통계와 글은 기존 DB에 보존된다. 구 앱이나 MySQL을 지금 중단하거나 임의로 권한을 변경하지 않는다.

따라서 이번 전환은 구 writer를 동결한 완결된 데이터 이전으로 보고하지 않는다. DNS 전파 후 읽기 전용 스냅샷을 다시 확보하고, **07:58 스냅샷을 기준으로** 이후 변경을 대사한다. 새 글은 계속 비공개 보관한다. 원본과 새 스냅샷의 문항/보기 변경이 있으면 자동 덮어쓰지 않고 별도로 검토한다. 통계 delta는 현재 대상 값이 직전 적용값과 일치할 때만 원자적으로 반영한다. 이미 반영한272건을 최초 개발 스냅샷 기준으로 재적용하지 않는다.

최종 구 writer 동결/drain·마지막 accepted write 대사·복구 검증은 AWS 종료 전에 필요하다. 전체 EC2 백업, 동결된 최종 스냅샷, 검증된 RPO0 또는 수치화된 복구 시간은 확보됐다고 주장하지 않는다. 이 방식은 기존의 모든 쓰기를 한 시점에 이관하는 runbook보다 이번 읽기 중심 출시 범위에 맞춘 순서이며, 원본 보관 요구를 유지한다.

## 전환 후 확인 상태

1. 완료: 공개 DNS·HTTPS·HTTP→HTTPS·www 리다이렉트, 기존 경로·canonical·robots/sitemap/ads.txt·Naver 검증 파일.
2. 완료: 실제 새 도메인 시험/문항/채점/복원/다음 이동·390px 레이아웃. 광고 클릭0.
3. 기술 연결 확인 완료, 소유자 현장 확인 대기: 실제 광고 충전 및 GA4 collect204. 기존 속성 Realtime 수신과 실제 휴대폰 앵커 겹침을 확인 요청했다. 지역별 동의 화면은 해당 지역에서 별도 확인한다.
4. 완료: 전환 후 추가 스냅샷과 통계8건 delta 대사. AWS/MySQL과 이전 백업은 계속 유지한다. 구 writer를 동결하지 않았으므로 이 스냅샷 시각 뒤의 구 페이지 쓰기도 원본에 남을 수 있다. AWS 종료 전에 최종 동결/drain·대사가 필요하다.

복구는 추가 apex A와 www CNAME을 제거하고 **@ A52.35.43.187 / www A52.35.43.187**, 둘 다 **Proxied / TTL Auto**로 복원한다. 원본 DB를 복원하거나 새 데이터를 지우는 절차가 아니다.

이전 자동 승인 심사에서 중복 assign_alias 요청이 거절됐으나 재시도하지 않았다. 그 전에 성공한 승격으로 두 alias가 이미 올바르게 배정돼 추가 alias 쓰기는 필요 없다. 로컬 .git은 읽기 전용으로 옛 브랜치를 유지하며 원격 PR82는 이미 병합돼 있다.
