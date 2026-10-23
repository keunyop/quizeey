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

quiz event: practice_start, question_start, answer_submit, explanation_open, practice_result, practice_complete, bookmark_add. forum 및 locale 이벤트를 별도 구분한다. 문제 AJAX 전환을 가짜 pageview로 세지 않는다. 사용자 이름·글/답글 본문·이메일/IP·guest token을 보내지 않는다. 테스트 유입은 운영 측정에서 제외한다.

Naver 파일: `naver90f2a35cffe6ae01fc8515f4efe88a59.html`. robots/sitemap/ads/Naver 원문은 보존 대상. GSC property/verification 파일 또는 DNS 기록은 계정과 zone export가 필요하다.

CMP는 기존 publisher의 Google Funding Choices를 사용한다. 실제 게시된 스크립트에서 현재 테스트 지역의4개 목적 NOT_APPLICABLE(3), US opt-out API 미제공 및 공식 GDPR 메시지 미리보기 표시를 확인했다. 이 계정에서 제공하지 않는 US API를 필수로 기다리면 광고·GA4가 계속 꺼지므로 목적별 명시적 EU 상태를 따른다. US API가 제공될 때는 미확정/수신 거부 차단을 유지한다. 거절/미설정·US opt-out/광고 차단/미충전/문제 이동 시 중복 요청 방지 및 공개 SEO는 회귀 검증했다. 실제 EEA 지역 동의·철회, 광고 오버레이·충전 및 GA4 계정 수신은 컷오버 현장 검증 항목이다. [증거](release-cmp-evidence.json), [Google API](https://developers.google.com/funding-choices/fc-api-docs).

## 2026-10-23 광고 밀도 개선: balanced_v1

이번 변경은 로컬 구현이며 배포·AdSense 계정 변경은 하지 않았다. 위의 Auto ads/Auto optimize/Anchor/Vignette ON은 과거 소유자 확인 기록이다. 현재 계정 설정, 형식별 수익, 실제 자동 광고 개수는 확인하지 않았다. 따라서 수익 개선이나 최적 노출량이 입증된 상태는 아니다.

### 코드에서 적용하는 범위

- 홈: 검색어·분야 필터·즐겨찾기가 없는 일반 목록에 시험이 7개 이상일 때, 첫 6개 뒤 수동 In-feed 1개. 짧은 목록과 검색/필터/즐겨찾기에는 수동 광고를 요청하지 않는다.
- 학습: 기존 Display 1개 유지. 문제·선택지·채점 버튼 내부에는 삽입하지 않는다. 넓은 화면의 기존 측면 배치와 작은 화면의 하단 배치, 48px 이상 조작부 간격을 유지한다.
- 슬롯은 화면 근처에서 요청하며 문제 전환·다시 풀기·필터 해제·동의 재허용으로 자동 새로고침하지 않는다. 이미 요청한 홈 광고를 검색 때문에 제거하면 같은 문서에서는 다시 요청하지 않는다. 동의 거절·광고 차단·미충전 상태에 빈 광고 박스를 남기지 않는다.
- 홈과 학습 모두 로더에 `data-overlays="collapsed-bottom"`을 일관되게 적용한다. 이것은 자동 광고의 개수 제한이나 모든 오버레이 비활성화를 뜻하지 않는다.
- 자체 제작 회차/문제 링크에도 `data-google-vignette="false"`를 적용한다. 기존 시험 진입·문제 링크·페이지 이동 보호는 유지한다. 이 속성은 해당 링크 클릭에만 적용되고, 다른 전면 광고 트리거를 차단하지 않는다. [Google의 링크 제외 방식](https://support.google.com/adsense/answer/17016693?hl=en)
- `google-anno-skip`은 자동 광고 전체를 차단하는 속성이 아니다. 수동 슬롯이 1개여도 계정에서 켜 둔 자동 광고가 추가될 수 있다.

### 측정 정의

모든 직접 전송 GA4 이벤트와 page_view에 `ad_policy=balanced_v1`을 붙인다. 이는 코드 버전 표식이며 무작위 A/B 배정이나 AdSense 실험군 식별자가 아니다. Analytics 동의·운영 환경 검사를 통과할 때만 전송한다.

| 이벤트 | 의미 |
| --- | --- |
| practice_start | 측정 가능한 상태에서 문제 풀이 시작. 다시 풀기·복습 시작은 새 실행으로 센다. |
| practice_result | 결과 화면 도달. 건너뛴 문제나 저장된 결과 화면 재열기도 포함한다. |
| practice_complete | 이번 실행의 시작이 측정됐고, 현재 문제 묶음에 미응답이 없을 때 결과 화면에서 전송한다. 정답률 100%를 뜻하지 않는다. |

practice_start/question_start/practice_result/practice_complete에는 `practice_mode`(standard/direct/mistakes/bookmarks/unanswered), `question_count`, `answered_count`를 보낸다. 시작 시 answered_count는 저장된 이전 응답 수를 포함한다. question_count는 해당 페이지/복습 묶음의 문항 수이며 시험 전체 문항 수가 아니다. 저장된 완료 화면을 새로고침하는 것만으로 practice_start/practice_complete를 추가하지 않는다. 예전 practice_complete는 건너뛰기도 포함했으므로 변경 전 수치와 직접 비교하지 않는다.

GA4에서 `ad_policy`, `practice_mode`를 이벤트 범위 맞춤 측정기준으로, 두 count를 맞춤 측정항목으로 등록한다. 같은 날짜·기기·국가·유입경로를 기준으로 다음 지표를 본다.

| 지표 | 용도 |
| --- | --- |
| 방문 1,000회당 광고수익 | 동일 범위 수익 ÷ 세션 × 1,000. AdSense 전체 수익을 동의한 GA4 세션으로 나누면 표본이 다르므로 정확한 세션 수익으로 해석하지 않는다. 가능하면 연결된 GA4/AdSense의 공통 측정 범위로 계산한다. |
| 첫 응답 전 이탈률 | practice_start 이후 answer_submit이 없는 세션 비율. 시작만 하고 떠나는 사용자 증가 탐지. |
| 학습 완료율 | 같은 standard 시작 세션 중 이후 practice_complete가 있는 세션 비율. 문항 수와 시작 answered_count가 같은 집단끼리 비교한다. 이벤트 총횟수끼리 나누지 않는다. |
| 세션당 응답 수·7일 재방문율 | 광고 때문에 풀이량·재방문이 줄어드는지 확인한다. |
| 형식/슬롯별 수익·Active View·미충전 | 가치가 낮은 노출을 찾는다. 브라우저의 슬롯 생성 수를 유료 노출 수로 간주하지 않는다. |

Active View는 Google의 실제 광고 측정치를 사용한다. 단순히 광고 태그를 만들었다고 사용자가 본 광고가 되지는 않는다. [Google의 Viewability 설명](https://support.google.com/adsense/answer/4510652?hl=en)

### 계정에서 진행할 실험안 — 아직 적용하지 않음

1. 동일 계측 버전으로 최소 2주 기준선을 확보한다. 모바일/데스크톱, 한국/해외, 유입경로를 분리한다. 계절·광고 단가·트래픽 변화와 코드 배포를 광고 효과로 오인하지 않는다.
2. 첫 실험은 현재 전면 광고 설정과 **10분 이상 간격 + 추가 트리거 OFF**를 비교한다. 현재 이미 10분 이상이면 간격을 줄이지 않고 OFF 변형을 후보로 둔다. 학습 진입·연속 풀이 링크 제외는 코드로 유지한다. 간격은 사이트 사용자별 자격 제한이지 강제 노출 주기가 아니다. [Google의 빈도 설정](https://support.google.com/adsense/answer/13956167?hl=en)
3. 다음 실험에서 앵커를 평가한다. 유지 후보는 하단 1개, 동적 확장 OFF, 넓은 화면 앵커 OFF. 채점·다음 버튼을 덮는 배치가 확인되면 해당 형식을 중단한다. 수동 측면 광고와 자동 Side rail이 중복되지 않도록 확인한다.
4. 자동 본문 광고가 문제·선택지·해설 조작부에 들어가면 계정의 Excluded areas에서 해당 영역을 제외한다. 제어가 불안정하면 학습 URL을 Auto ads 제외 대상으로 두고 수동 Display를 유지하는 안을 별도로 평가한다. 빈 목록의 자동 광고까지 이번 코드가 차단한다고 가정하지 않는다.
5. 일반 목록 자동 배너를 시험한다면 추가 배너 최대 1개, 최소 간격은 가능한 넓게, 추가 위치 탐색 OFF를 출발 후보로 삼는다. 수동 광고까지 합친 실제 총량을 확인한다. 2026년 4월부터 기존 ad load 대신 최대 개수·최소 간격 설정을 사용한다. [Google의 설정 변경 안내](https://support.google.com/adsense/answer/16683740?hl=en), [형식별 설정](https://support.google.com/adsense/answer/9305577?hl=en)
6. 한 번에 한 요소만 바꾸고 AdSense 실험의 자동 승자 적용과 Auto optimize 자동 적용은 실험 중 끈다. 수익만으로 UX 목표 충족 여부를 판단하지 않는다. 최소 2주와 충분한 표본을 확보하되 날짜만 채웠다고 승자를 정하지 않고 Google의 Result ready 및 불확실성을 함께 본다. 페이지 제외는 AdSense 실험 대상이 아니다. [공식 실험 안내](https://support.google.com/adsense/answer/6321879?hl=en), [실험 제한](https://support.google.com/adsense/answer/6321880?hl=en)

초기 판단 기준 제안: 방문당 수익 -5% 이내를 비열등성 한계로 놓고 학습 완료율·응답 수·재방문 개선을 함께 본다. 이는 보편적 최적값이나 사용자가 승인한 수익 손실 한계가 아니라, 수익 규모를 확인한 뒤 확정할 실험 기준이다. 불확실성 범위가 -5%보다 나쁜 손실을 포함하면 유지 결정을 보류한다. 수익은 증가해도 완료율/재방문이 악화하거나 버튼을 가리는 광고가 있으면 채택하지 않는다.

AdSense 실험군이 GA4에 자동 전달된다고 가정하지 않는다. 계정에서 동일 실험군별 UX를 연결해 비교할 수 없다면 AdSense의 수익 비교는 무작위 실험으로, GA4 UX는 전체 사이트의 동시 추세 감시로 구분한다. 전후 UX 비교만으로 인과효과를 주장하지 않는다. 수익과 UX를 동일 실험군으로 평가하려면 검증된 공통 그룹 식별 방식이 먼저 필요하다.

### 로컬 검증

`web`에서 `npm run check:local`을 실행한다. 일반 fixture 회귀 외에 실제 React 컴포넌트로 채움/미충전/차단/동의/검색/짧은 목록/중복 요청/완료 이벤트를 검증하는 격리 하네스를 포함한다. 하네스는 127.0.0.1 주소에서 모든 요청을 가로채 가짜 CMP·광고·GA 응답만 사용한다. 하네스 빌드에만 운영 origin 판정을 치환하며 앱에는 테스트 우회 경로를 추가하지 않는다. 실제 광고 전달·수익·계정 설정을 검증한 것은 아니다. DB/Auth fixture가 없는 경우 해당 검증은 별도 누락으로 보고한다.

이번 실행 결과: 단위 테스트 145개, 일반 브라우저 테스트 47개, 광고 하네스 6개 시나리오 통과. DB/Auth 관련 10개는 fixture 미연결로 제외했다. Windows의 브라우저 테스트 서버 종료 지연은 이번 실행에서 시작한 로컬 Next 프로세스만 종료하여 해소했고 전체 check 명령은 성공 종료했다. [광고 하네스 실행 기록](monetization-browser-evidence.json)
