# 지표 정의와 기준선 관리

사업 수치는 공개 Git에 신규 복제하지 않는다. 최초 재계산과 현재 DB 집계는 ignored `.modernization/quizeey-ops/baseline.json`에 저장한다. 운영일은 America/Vancouver, 원천 날짜는 각 시스템 시간대를 따른다.

| 지표 | 정의/원천 | 확인 상태·한계 |
| --- | --- | --- |
| 검색 클릭/노출/CTR/순위 | GSC 원천; CTR=clicks/impressions; 집계 순위는 원천 정의 유지 | 새 웹 검색 export의 일별 차트는 8/9~11/8 관측. 파일명 시작일과 차트가 달라 차트를 기준으로 사용. 최신 날짜의 확정 여부 미확인; query/page/country/device 독립 합계를 임의 결합 금지 |
| 사용자/페이지 | GA4 active/new users, page views | 새 8/11~11/8 개요 6종의 전체기간 신규 사용자·이벤트·조회 합계는 독립 표와 대조됨. `Nth day` 차트에는 명시적 Date 열이 없고, 유입·랜딩 세션의 일별 보고서를 대신하지 않음. 속성시간대/통화는 Owner 제공값이며 원천 표기·최신집계 확정은 미확인 |
| 예상수익/Page RPM | AdSense 원천; Page RPM=estimated earnings/AdSense PV×1000 | 새 Date export의 8/11~11/8 관측. 일별 표시반올림 수익 합으로 재계산한 RPM은 근사. 최신 날짜 잠정 가능·확정수익과 구분. GA4 PV로 대체 금지 |
| 확정수익/비용 | AdSense 정산, 공급자 청구서/usage | 미측정. 공통 구독 배분액과 Quizeey 증분비용을 분리 |
| 시험조회 | GA4 page_view와 서버 exam_clicks 별도 | click_count 누적은 기간/고유사용자/학습시작 아님. 여러 조리경로가 같은 시험ID를 공유 |
| 학습시작 | practice_start | 새 GA4 event export에 관측됨. 실행 ID가 없고 관측일이 제한되어 실행별 시작/완료율은 미측정 |
| 문항시작/답제출 | question_start / answer_submit | 코드 발행 확인. 제출 이벤트는 사용자/세션 수가 아님 |
| 결과/완료 | practice_result / practice_complete | 새 GA4 event export에 관측됨. 완료는 시작계측+미응답0+결과도달. 저장 결과 다시열기 제외. 실행ID 없어서 이벤트 총수 비율을 실행 완료율로 부를 수 없음 |
| 해설 | explanation_open | details 자동표시·재펼치기 포함 가능, 읽음/이해가 아님 |
| 복습/북마크 | practice_mode / bookmark_add | 새 GA4 export에서 bookmark_add는 관측, practice_mode는 미측정. 답제출·해설·북마크 payload에 mode 없음. 모드별 전체 퍼널 미측정 |
| 재방문 | 같은 정의의 7일 코호트 재방문/유지율 | 새 개요의 주별 returning users는 확인. 코호트 두 표가 같은 열 이름에 다른 단위를 사용해 신뢰할 수 있는 재방문율은 미측정. day0 학습자 중 day1~7 재학습 비율 후보는 정의·기간 확인 후 확정 |
| 품질 | open 신고 수, 확인된 오류 수, 접수→live검증 시간 | DB 조회 시점과 GitHub 별도 표시. resolved DB값만으로 답 정확성 재검수 완료 주장 금지 |
| 사용성 | 실패율/CWV/광고가림/모바일 완료 | 로컬 회귀와 실제 사용자 지표 구분; 운영 성능은 미측정 |

코드에 실제 발행하는 학습 이벤트는 7개다. `forum_post_created`, `locale_selected`는 허용목록에만 있고 발행 호출을 찾지 못했다. 이벤트 허용목록을 수집 성공으로 보고하지 않는다. 사용자 본문/이메일/토큰을 계측에 추가하지 않는다.

매 실행의 baseline은 source/property, 추출일, inclusive 기간, timezone, currency, 집계완료/지연, 정의·분모·segment·결측 이유를 포함한다. 최신 완결일은 실제 source에서 정하고 서로 다른 기간을 성장 비교로 섞지 않는다. 충분한 최신 자료 확보 전 성장 목표/광고 실험 효과는 판단 보류한다.
