# 광고·분석·동의 계약

소스와 제한된 운영 HTML에서 확인한 공개 publisher: `ca-pub-8362228066874729`.

ads.txt 원문: `google.com, pub-8362228066874729, DIRECT, f08c47fec0942fa0`.

소스 슬롯: `1033140566`, `8990988805`. 각 슬롯의 승인된 placement/type/auto-ads 설정·실제 수익·정책 상태는 계정에서 재검증한다. 계정 소유권/기존 CMP 상태도 확인해야 한다.

- 첫 운영 릴리스부터 기존 publisher/site 승인·ads.txt 유지. preview 광고로 대체하지 않는다.
- 문서 14절의 loader once/real slot once, 예약 크기, controls와 겹침 금지, timer/문제 변경마다 refresh 금지 계약을 유지한다.
- 로컬/CI/일반 preview: 스크립트·슬롯 요청 0, 빈 광고 박스 0. 자동 테스트에서 실제 광고를 클릭하지 않는다.
- preview는 인증 보호와 noindex가 모두 필요하다. 운영 HTML에 preview noindex/canonical가 남으면 출시 실패.
- pending 글·비공개 revision·관리 페이지는 no-store/noindex/ad-free. 승인된 UGC도 정책·동의 검증 뒤 허용.

확인된 분석 ID는 **UA-66061566-2**이다. 이를 GA4 해결책으로 복사하지 않는다. 실제 기존 GA4 property/measurement ID/운영 설치 여부는 미확인이다. 새로운 property를 임의 생성하지 않는다.

quiz event: question_start, answer_submit, explanation_open, practice_complete, bookmark_add. forum 및 locale 이벤트를 별도 구분한다. 문제 AJAX 전환을 가짜 pageview로 세지 않는다. 사용자 이름·글/답글 본문·이메일/IP·guest token을 보내지 않는다. 테스트 유입은 운영 측정에서 제외한다.

Naver 파일: `naver90f2a35cffe6ae01fc8515f4efe88a59.html`. robots/sitemap/ads/Naver 원문은 보존 대상. GSC property/verification 파일 또는 DNS 기록은 계정과 zone export가 필요하다.

CMP/consent의 대상 국가·provider·TCF 설정·거절 후 광고/분석 동작은 미확인이다. 운영 release gate에서 광고 차단·거절·동의·SPA 슬롯 수명주기를 검증하고 승인된 정확한 설정을 이 문서에 추가한다.
