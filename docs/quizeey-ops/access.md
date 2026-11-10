# 접근 현황과 소유자 연결 요청

2026-11-09 확인. 비밀번호·토큰·비밀키는 대화에 요청하지 않는다. 읽기부터 사용하고 쓰기는 별도 승인 범위를 적용한다.

| 자원 | 현재 상태 | 필요한 최소 범위와 소유자 조치 | 연결 전 대안 |
| --- | --- | --- | --- |
| GitHub keunyop/quizeey | connector 조회 성공, public/master, 열린 이슈 조회 가능 | 새 도구 불필요. 비공개 데이터는 public issue에 올리지 않음 | 로컬 문서/기존 이슈 참조 |
| Supabase quizeey | 프로젝트·schema·집계 읽기 성공, us-west-2/PG17 | 신규 키 불필요. DB 변경은 준비/검수 후 구체적 승인 | 현재 읽기 유지 |
| Vercel quizeey | 프로젝트/로그 읽기 성공 | 최근 7일은 plan retention 제한. 기존 log drain/보존 자료가 있으면 읽기 제공, 유료 확장 자동구매 금지 | 최근23시간 제한 결과와 코드 조사 |
| GSC quizeey.com | 10/31까지 기존 CSV, 현재 connector 없음 | 실제 등록 속성 문자열(sc-domain 또는 URL-prefix)을 확인. 해당 속성의 읽기 권한/공식 API 읽기 인증 또는 최신 export | Performance에서 최신 완결 56일+최근7일, date/query/page/country/device CSV를 ignored 경로에 저장 |
| GA4 Quizeey - GA4 | 측정ID G-XM8XM4CHX7 및 과거 export, 숫자 Property ID 미확인 | Admin→Property details에서 숫자ID/시간대/통화 확인. Viewer 수준 읽기와 공식 API analytics.readonly 후보 검증. 기존 AdSense 연결 목록 조회 | 같은 기간 일별 사용자/페이지/이벤트/기기/국가, 학습 퍼널·코호트 export |
| AdSense quizeey.com | 기존 publisher/과거 USD export, 현재 계정 조회 없음 | 지원되는 사용자 OAuth 읽기(adsense.readonly 후보)를 우선 검토. API 계정 resource/시간대/사이트 필터 확인; 서비스계정 공용 사용 가정 금지 | Reports에서 일별 예상수익/PV/Page RPM/형식/기기, 별도 확정수익·정책 상태 export |
| 비용/백업 | 과거 비용모델/로컬 복원 이력만 있음 | Vercel/Supabase/잔여AWS·모델·도구의 최근 청구서와 usage, 백업 보존/최근복원 기록 읽기 | 미측정으로 두고 새 유료 도입 보류 |

Google 공식 인증 문서는 이번 실행에서 HTTPS 제한과 권한 확대 거절로 읽지 못했다. 위 API scope/역할은 **연결 설계 후보**이며 최신 공식 인증 절차 검증 완료가 아니다. 실제 인증 전에 각 제품 문서를 다시 확인해야 한다. 모든 제품에 하나의 서비스계정을 적용하지 않는다.

소유자가 이미 GA4–AdSense 연결과 맞춤정의 등록을 확인한 과거 기록이 있다. 재연결을 요구하지 말고 현재 링크/이벤트 수신을 조회한다. 설치 가능한 외부 마케팅 connector 후보는 검색됐으나 비용·범위 미확인으로 설치하지 않았다. 먼저 기존 계정의 안전한 export를 활용한다.

비밀 아닌 숫자 Property ID/속성명은 알려줄 수 있지만 인증정보는 환경의 안전한 로그인·비밀 저장만 사용한다. 최신 export는 `.modernization/quizeey-ops/imports/`에 저장하고 파일 경로만 알려준다. 원천별 날짜·시간대·통화·집계완료 여부를 함께 기록한다.
