# 광고·분석·동의 계약

소스와 제한된 운영 HTML에서 확인한 공개 publisher: `ca-pub-8362228066874729`.

ads.txt 원문: `google.com, pub-8362228066874729, DIRECT, f08c47fec0942fa0`.

소스 슬롯: Display `1033140566`, In-feed `8990988805`. 소유자가 Auto optimize/Auto ads ON, Vignette/Anchor ON을 확인했다. 유럽 규정 메시지 게시 및 광고/Analytics용 Consent mode 두 항목 체크 후 Save 완료도 확인했다. 실제 수익·정책 상태/오버레이 배치는 실제 운영에서 재검증한다.

- 첫 운영 릴리스부터 기존 publisher/site 승인·ads.txt 유지. preview 광고로 대체하지 않는다.
- 문서 14절의 loader once/real slot once, 예약 크기, controls와 겹침 금지, timer/문제 변경마다 refresh 금지 계약을 유지한다.
- 로컬/CI/일반 preview: 스크립트·슬롯 요청 0, 빈 광고 박스 0. 자동 테스트에서 실제 광고를 클릭하지 않는다.
- preview는 인증 보호와 noindex가 모두 필요하다. 운영 HTML에 preview noindex/canonical가 남으면 출시 실패.
- pending 글·비공개 revision·관리 페이지는 no-store/noindex/ad-free. 승인된 UGC도 정책·동의 검증 뒤 허용.

소유자가 확인한 기존 GA4 측정 ID는 **G-XM8XM4CHX7**이며 동일 값을 Production·Preview 서버 설정에 등록했다. v1 소스의 UA-66061566-2는 과거 태그로만 기록한다. 기존 GA4 속성을 유지하며 새로운 속성을 만들지 않는다. Preview와 보호 Production review는 실제 분석을 전송하지 않는다. 실제 기존 속성 수신은 컷오버 시 실시간/DebugView에서 확인한다.

quiz event: question_start, answer_submit, explanation_open, practice_complete, bookmark_add. forum 및 locale 이벤트를 별도 구분한다. 문제 AJAX 전환을 가짜 pageview로 세지 않는다. 사용자 이름·글/답글 본문·이메일/IP·guest token을 보내지 않는다. 테스트 유입은 운영 측정에서 제외한다.

Naver 파일: `naver90f2a35cffe6ae01fc8515f4efe88a59.html`. robots/sitemap/ads/Naver 원문은 보존 대상. GSC property/verification 파일 또는 DNS 기록은 계정과 zone export가 필요하다.

CMP는 기존 publisher의 Google Funding Choices를 사용한다. 실제 게시된 스크립트에서 현재 테스트 지역의4개 목적 NOT_APPLICABLE(3), US opt-out API 미제공 및 공식 GDPR 메시지 미리보기 표시를 확인했다. 이 계정에서 제공하지 않는 US API를 필수로 기다리면 광고·GA4가 계속 꺼지므로 목적별 명시적 EU 상태를 따른다. US API가 제공될 때는 미확정/수신 거부 차단을 유지한다. 거절/미설정·US opt-out/광고 차단/미충전/문제 이동 시 중복 요청 방지 및 공개 SEO는 회귀 검증했다. 실제 EEA 지역 동의·철회, 광고 오버레이·충전 및 GA4 계정 수신은 컷오버 현장 검증 항목이다. [증거](release-cmp-evidence.json), [Google API](https://developers.google.com/funding-choices/fc-api-docs).
