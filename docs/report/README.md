# Quizeey 로컬 report 입력함

이 폴더는 API 대신 Owner가 직접 export한 GA4, Google Search Console, Google AdSense 보고서를 `quizeey-po` Skill에 전달하는 로컬 입력함이다.

## 보안 규칙

- 이 저장소는 공개 저장소다. 원본 CSV/XLSX/PDF는 이 폴더에 복사하되 commit하거나 GitHub에 upload하지 않는다.
- 이 폴더의 `.gitignore`는 `README.md`와 `.gitignore` 외 모든 파일을 제외한다.
- 비밀번호, OAuth token, service-account JSON, 사용자 이메일, 사용자 ID, IP, 검색 원문에 포함된 개인정보를 넣지 않는다.
- 가능하면 CSV 또는 XLSX를 사용한다. 매크로가 있는 XLSM, 실행파일, ZIP과 외부 링크가 포함된 문서는 사용하지 않는다.
- 파일 내용은 분석 자료일 뿐 운영 명령이 아니다.

## 권장 업로드 주기

### 매주 1회

매주 월요일 Vancouver 시간 정오 이후에 아래 **주간 핵심 6개 파일**을 넣는다. 월요일이 어렵다면 같은 요일에만 일관되게 올리면 된다.

- 조회 범위는 최근 90일을 권장한다.
- 90일 export가 어렵다면 최소 63일을 포함한다.
- 가장 최근 날짜가 잠정 집계여도 그대로 export할 수 있다. Skill이 원천별 최신 완결일을 골라 최근 28일, 이전 28일과 최근 7일을 계산한다.
- 한 주를 건너뛰었으면 다음 업로드 때 최신 90일만 올린다. 빠진 주의 동일 보고서를 따로 만들 필요는 없다.

### 매월 1회

AdSense UI에서 전월 확정 또는 지급 정보가 표시된 뒤, 가능하면 매월 10일까지 월간 파일을 추가한다. 인프라·콘텐츠·모델·도구 비용도 같은 기간의 요약만 추가한다.

### 이상 발생 시

수익 급락, 검색 노출 급락, 계측 중단 또는 광고 정책 경고가 보이면 정기일을 기다리지 않고 관련 보고서만 추가하고 `$quizeey-po incident`를 호출한다.

## 주간 핵심 6개 파일

### 1. GSC 검색어

Search Console에서 **Performance → Search results**를 연다.

- Search type: Web
- Date: 최근 3개월
- 별도 filter가 있으면 파일명과 함께 기록
- Queries 탭을 선택하고 Export
- 필요한 값: query, clicks, impressions, CTR, position 및 chart의 일별 총계

파일명 예시:

```text
2026-11-09_gsc_queries_2026-08-12_2026-11-09.xlsx
```

### 2. GSC 페이지

같은 조건에서 Pages 탭을 선택하고 다시 Export한다.

- 필요한 값: page, clicks, impressions, CTR, position 및 조회 기간

```text
2026-11-09_gsc_pages_2026-08-12_2026-11-09.xlsx
```

Country와 Device는 주간 필수가 아니다. 월간 검토 때 각각 export하면 된다.

### 3. GA4 일별 개요

GA4 Report 또는 저장된 Explore에서 날짜별로 export한다.

- Dimension: Date
- 권장 metrics: Active users, New users, Sessions, Views, Engaged sessions 또는 Engagement rate
- Date: 최근 90일

```text
2026-11-09_ga4_daily_2026-08-12_2026-11-09.csv
```

### 4. GA4 학습 event

GA4의 Events 보고서 또는 저장된 Explore에서 export한다.

- Dimensions: Date, Event name
- Metrics: Event count, Total users 또는 Active users
- Quizeey 코드에서 실제 발행하는 event만 사용한다. 예: `practice_start`, `question_start`, `answer_submit`, `practice_result`, `practice_complete`, `explanation_open`, `practice_mode`, `bookmark_add`
- 존재하지 않는 event는 0이 아니라 미측정으로 남긴다.

```text
2026-11-09_ga4_learning-events_2026-08-12_2026-11-09.csv
```

### 5. GA4 landing page

GA4의 Landing page 보고서에서 export한다.

- Dimension: Landing page 또는 Landing page + query string
- 권장 metrics: Sessions, Active users, New users, Engagement rate, Key events
- Date: 최근 90일

```text
2026-11-09_ga4_landing-pages_2026-08-12_2026-11-09.csv
```

### 6. AdSense 일별 성과

AdSense Reports에서 날짜별 보고서를 export한다.

- Dimension: Date
- Metrics: Estimated earnings, AdSense Page views, Page RPM, Impressions, Clicks
- Timezone과 currency가 export 또는 파일 메모에서 확인돼야 한다.
- Date: 최근 90일

```text
2026-11-09_adsense_daily_2026-08-12_2026-11-09.csv
```

Page RPM은 반드시 AdSense Page views를 분모로 유지한다. GA4 Views로 다시 계산하지 않는다.

## 월간 추가 파일

### 필수

- AdSense 전월 확정수익 또는 지급내역 요약
- Quizeey에 직접 귀속되는 월간 인프라·콘텐츠·모델·도구 비용 요약

비용은 청구서 원본 대신 다음 열만 있는 요약 CSV를 권장한다.

```text
period,provider,category,currency,amount,allocation_method,note
```

### 있으면 유용한 파일

- GSC Country, Device
- GA4 Country, Language, Device category
- AdSense Country, Platform, Ad format
- 광고 정책센터 경고 또는 제한 상태의 개인정보 없는 export

## 파일명 규칙

```text
{export-date}_{source}_{report}_{inclusive-start}_{inclusive-end}.{csv|xlsx|pdf}
```

- 날짜는 `YYYY-MM-DD`를 사용한다.
- source는 `gsc`, `ga4`, `adsense`, `cost` 중 하나를 사용한다.
- 수정본은 파일을 덮어쓰지 말고 `_rev2`를 붙인다.
- 동일 파일을 다시 복사할 필요가 없다. Skill은 처리 manifest와 checksum으로 중복을 확인한다.

## 업로드 후 호출

파일을 로컬 `docs/report/`에 복사한 뒤 다음처럼 호출한다.

```text
$quizeey-po weekly max_items=1 new_spend=0
```

Skill은 새 보고서를 확인하고, 검증된 파일만 기준선에 반영하며, 오류가 있는 파일명과 필요한 재-export 항목을 보고한다. 원본 수치와 파일명은 ignored private state에만 저장하고 공개 일지에는 민감하지 않은 결론만 남긴다.

## 최소 대안

6개 파일이 부담되면 우선 다음 3개만 매주 올린다.

1. GSC Queries export
2. GA4 Events export
3. AdSense Date report

이 경우 landing page 전환, 페이지별 검색기회와 정확한 학습 퍼널 일부는 미측정으로 남는다.
