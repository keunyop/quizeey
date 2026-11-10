# Quizeey 데이터 연결 방법

목표는 GSC·GA4·AdSense를 각각 최소 읽기 권한으로 연결해 최신 28일/이전 28일과 최근 7일을 일지에서 자동 비교하는 것이다. 비밀번호, OAuth client secret, refresh token, 서비스계정 JSON은 대화나 Git에 붙이지 않는다. 인증 파일은 운영환경의 안전한 secret 저장소만 사용한다.

## 1. GA4

권장 방식은 Quizeey GA4 property에 읽기 전용 주체를 추가하고 Google Analytics Data API를 사용하는 것이다.

1. GA4에서 Quizeey property를 선택하고 **관리 → 속성 세부정보**에서 숫자 Property ID, 보고 시간대, 통화를 확인한다.
2. **관리 → 속성 액세스 관리 → + → 사용자 추가**에서 연결에 사용할 Google 계정 또는 지원되는 서비스계정 이메일을 추가하고 **Viewer**만 부여한다. 계정 전체가 아니라 Quizeey property 수준에 추가한다.
3. Google Cloud의 전용 project에서 **Google Analytics Data API**를 활성화한다.
4. 사용자 OAuth를 쓸 경우 `analytics.readonly` 범위로 Application Default Credentials 또는 안전한 OAuth 연결을 만든다. 무인 실행이 필요하면 공식 Data API quickstart가 지원하는 service account를 사용하되 해당 service account가 Quizeey property Viewer인지 확인한다.
5. 연결 후 `properties/{PROPERTY_ID}:runReport`로 property ID·시간대·통화, 최근 완결일, 일별 사용자/페이지/이벤트와 학습 이벤트를 읽어 실제 수신을 검증한다.

공식 근거: [Analytics API quickstart](https://developers.google.com/analytics/devguides/reporting/data/v1/quickstart), [Analytics 사용자 관리](https://support.google.com/analytics/answer/9305788), [runReport 기본](https://developers.google.com/analytics/devguides/reporting/data/v1/basics).

## 2. Google Search Console

1. Search Console에서 Quizeey property를 선택하고 정확한 property 문자열이 `sc-domain:quizeey.com`인지 URL-prefix인지 기록한다.
2. **설정 → 사용자 및 권한 → 사용자 추가**에서 연결용 Google 계정을 추가한다. 성과 보고서 읽기에는 **Restricted**가 최소 후보지만 API로 필요한 모든 보고서가 보이는지 확인하고, 부족할 때만 **Full user**로 올린다. Owner 권한은 필요 없다.
3. Google Cloud 전용 project에서 **Search Console API**를 활성화하고 OAuth 2.0 client를 만든다.
4. OAuth 동의 시 `https://www.googleapis.com/auth/webmasters.readonly`만 요청한다.
5. `sites.list`로 Quizeey property와 권한을 확인한 다음 Search Analytics API로 날짜·query·page·country·device를 각각 조회한다. 서로 독립적인 집계를 임의 결합하지 않는다.

공식 근거: [Search Console API 인증](https://developers.google.com/webmaster-tools/v1/how-tos/authorizing), [API 접근 요구사항](https://developers.google.com/webmaster-tools/v1/prereqs), [사용자와 권한 관리](https://support.google.com/webmasters/answer/7687615).

## 3. Google AdSense

AdSense Management API는 service account를 지원하지 않는다. AdSense 로그인이 가능한 사용자 계정으로 Installed Application OAuth를 한 번 승인해야 한다.

1. AdSense에서 Quizeey 계정에 접근 가능한 기존 Google 사용자를 확인한다. UI의 Standard 역할도 여러 계정 설정을 관리할 수 있으므로 보고 전용 사용자 역할이 있다고 가정하지 않는다. API 읽기 제한은 OAuth의 `adsense.readonly` scope로 적용한다.
2. Google Cloud 전용 project에서 **AdSense Management API**를 활성화하고 **Desktop app/Installed application OAuth client**를 만든다.
3. 로컬의 안전한 OAuth 흐름으로 로그인하고 `https://www.googleapis.com/auth/adsense.readonly`만 승인한다. client secret·refresh token은 저장소 밖의 사용자 전용 보관소 또는 secret store에 저장하고 Git/대화에 노출하지 않는다.
4. `accounts.list`로 account resource를 확인하고 Quizeey site/ad client를 식별한다. 이후 예상수익·AdSense page views·Page RPM·노출·광고형식·기기 자료와 확정수익을 분리해 읽는다.
5. GA4–AdSense 연결은 이미 연결됐다는 과거 기록을 재생성하지 말고 GA4 Admin API/UI에서 현재 링크만 읽기 확인한다.

공식 근거: [AdSense 직접 요청과 인증](https://developers.google.com/adsense/management/direct_requests), [AdSense 시작하기](https://developers.google.com/adsense/management/getting_started), [accounts.list](https://developers.google.com/adsense/management/reference/rest/v2/accounts/list).

## 연결이 끝났다고 판단하는 기준

- 각 제품의 정확한 resource ID/property와 최소 권한을 readback했다.
- 비밀값 없이 sample read가 성공했다.
- source timezone·currency·최신 완결일·집계 지연을 기록했다.
- 최근 28일/이전 28일/최근 7일을 원천별로 조회할 수 있다.
- AdSense Page RPM 분모는 AdSense page views이고 GA4 page views를 섞지 않는다.
- credential 갱신 실패를 일지에 남길 방법이 있다.

연결 전에는 각 UI에서 최신 export를 `.modernization/quizeey-ops/imports/`에 저장해도 된다. 파일명에 source와 inclusive 날짜를 넣고, 대화에는 파일 경로와 숫자 Property ID/property 문자열만 알려준다.

---

## 상세 실행 절차

### 연결 구조

Google Cloud project 하나를 API 등록에 재사용할 수 있지만 인증은 합치지 않는다.

| 데이터 | 권장 인증 | Quizeey 리소스 권한 | API scope |
| --- | --- | --- | --- |
| GA4 | 자동 수집용 service account | 해당 Property의 Viewer | `analytics.readonly` |
| Search Console | Desktop app 사용자 OAuth | 해당 Property의 Restricted user부터 확인 | `webmasters.readonly` |
| AdSense | Desktop app 사용자 OAuth | 기존 AdSense 사용자로 승인 | `adsense.readonly` |

Search Console과 AdSense가 같은 OAuth client를 사용하더라도 refresh token은 원천별로 따로 발급하고 저장한다. 그러면 한 제품의 권한만 독립적으로 해제할 수 있다.

### 시작 전 준비

Owner가 다음 권한을 가진 계정을 준비한다.

- Quizeey GA4 Property에 사용자를 추가할 수 있는 계정
- Quizeey Search Console Property의 Owner
- Quizeey AdSense 계정에 로그인할 수 있는 기존 사용자
- Google Cloud project를 만들거나 API를 활성화할 수 있는 계정
- 기본 브라우저에서 Google OAuth 로그인을 완료할 수 있는 로컬 PC

#### 인증 파일 저장 위치

인증 정보는 다음 순서로 저장한다.

1. 실행 환경의 secret store 또는 OS 자격 증명 저장소
2. 사용자만 읽을 수 있는 저장소 밖의 암호화된 폴더
3. 다른 방법이 없을 때만 사용자 전용 로컬 파일

로컬 파일이 꼭 필요하면 저장소 밖에 원천별로 구분한다.

```text
%USERPROFILE%/.config/quizeey/google/
  ga4-service-account.json
  oauth-desktop-client.json
  oauth-gsc-token.json
  oauth-adsense-token.json
```

- 현재 Windows 사용자만 읽을 수 있게 제한한다.
- 이메일, 메신저, 공유 드라이브나 Git으로 복사하지 않는다.
- `.modernization/quizeey-ops/`에는 private 지표와 export를 저장할 수 있지만 인증 파일은 저장하지 않는다.
- token을 폐기하면 해당 token 파일도 삭제한다.

#### Google Cloud project와 API 준비

1. [Google Cloud Console](https://console.cloud.google.com/)을 연다.
2. 상단 project 선택기에서 기존 운영용 project를 선택하거나 **New Project**를 누른다.
3. 새 project 이름은 `Quizeey Ops Readonly`처럼 목적이 드러나게 정한다.
4. 생성 후 **Project ID**를 기록한다. Project name과 Project ID를 혼동하지 않는다.
5. **APIs & Services → Library**에서 다음 API를 각각 검색해 **Enable**한다.
   - Google Analytics Data API
   - Search Console API
   - AdSense Management API
6. **APIs & Services → Enabled APIs & services**에서 세 API가 모두 Enabled인지 확인한다.

API 활성화만으로 Quizeey 데이터 권한이 생기지는 않는다. 다음 절차에서 각 제품의 리소스 권한을 별도로 부여해야 한다.

## GA4 상세 연결

### A. Quizeey Property 확인

1. [Google Analytics](https://analytics.google.com/)에 로그인한다.
2. 좌측 하단 **Admin**을 연다.
3. 상단 Property 선택기에서 Quizeey 웹사이트 데이터가 들어오는 Property를 선택한다.
4. **Property settings** 또는 **Property details**에서 다음을 기록한다.
   - 숫자 Property ID
   - Reporting time zone
   - Currency
5. **Data collection and modification → Data streams**에서 웹 stream을 연다.
6. Stream URL이 `https://quizeey.com`과 일치하는지 확인한다.
7. Measurement ID는 계측 확인용으로만 기록한다.

API 요청에는 `G-...` 형식의 Measurement ID가 아니라 숫자 Property ID를 사용한다.

### B. GA4 service account 만들기

1. Google Cloud Console에서 앞서 선택한 project를 연다.
2. **IAM & Admin → Service Accounts**로 이동한다.
3. **Create service account**를 선택한다.
4. 이름을 `quizeey-ga4-readonly`처럼 목적이 드러나게 입력한다.
5. service account 이메일을 기록한다.
6. Google Cloud project 역할은 우선 추가하지 않는다. GA4 권한은 다음 단계에서 Property Viewer로 준다.
7. 생성 완료 후 service account 상세 화면을 연다.

키 없는 실행 환경을 마련할 수 있으면 Workload Identity Federation 같은 단기 자격 증명을 우선한다. 현재 로컬 수집기가 JSON key를 요구할 때만 다음을 진행한다.

1. service account 상세 화면에서 **Keys → Add key → Create new key**를 선택한다.
2. **JSON**을 선택해 한 번만 다운로드한다.
3. 파일을 저장소 밖의 사용자 전용 위치로 즉시 옮긴다.
4. 다운로드 폴더에 남은 복사본을 제거한다.
5. key ID와 생성일만 private 운영 상태에 기록한다. private key 값은 기록하지 않는다.

### C. GA4 Viewer 권한 부여

1. GA4에서 Quizeey Property를 선택한 상태로 **Admin**을 연다.
2. Property 열의 **Property access management**를 연다.
3. 우측 상단 **+ → Add users**를 선택한다.
4. 앞에서 기록한 service account 이메일을 입력한다.
5. 역할은 **Viewer**만 선택한다.
6. **Add**를 누른 뒤 사용자 목록에서 이메일과 Viewer 역할을 다시 확인한다.

Account access management에 추가하면 다른 Property까지 접근할 수 있으므로 Quizeey Property 수준에만 추가한다.

### D. 로컬 인증 지정

공식 client library를 사용할 때 현재 PowerShell 세션에서만 다음 환경 변수를 지정한다.

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS = "$env:USERPROFILE/.config/quizeey/google/ga4-service-account.json"
$env:QUIZEEY_GA4_PROPERTY_ID = "숫자_PROPERTY_ID"
```

`setx`로 시스템 전체에 영구 등록하거나 JSON 내용을 환경 변수에 직접 넣지 않는다.

### E. GA4 최초 readback

1. `properties/{PROPERTY_ID}:runReport`에 다음 최소 요청을 보낸다.

```json
{
  "dateRanges": [{"startDate": "7daysAgo", "endDate": "yesterday"}],
  "dimensions": [{"name": "date"}],
  "metrics": [{"name": "activeUsers"}, {"name": "screenPageViews"}]
}
```

2. HTTP 200과 row 수를 확인한다.
3. 응답 metadata의 `timeZone`과 `currencyCode`를 GA4 UI 설정과 비교한다.
4. 데이터가 없더라도 권한 오류와 0 row를 구분한다.
5. 다음 단계로 Quizeey 코드에 실제 존재하는 학습 event만 조회한다. 존재를 확인하지 않은 event를 0으로 보고하지 않는다.
6. sample 원문은 저장하지 않고 resource, 조회 기간, row 수, 시간대, 통화와 성공 시각만 private 상태에 기록한다.

GA4 연결 완료 조건은 숫자 Property ID에 대한 sample read가 성공하고 시간대와 통화를 확인한 상태다.

## Search Console 상세 연결

### A. Property 종류와 문자열 확인

1. [Search Console](https://search.google.com/search-console/)에 로그인한다.
2. 좌측 상단 Property 선택기에서 Quizeey를 선택한다.
3. Domain Property이면 API 문자열을 `sc-domain:quizeey.com`으로 기록한다.
4. URL-prefix Property이면 프로토콜과 마지막 `/`까지 포함한 정확한 문자열을 기록한다. 예: `https://quizeey.com/`.
5. **Settings → Ownership verification**에서 현재 권한과 Property 유형을 확인한다.
6. `http`, `https`, `www`, 비 `www`가 따로 등록돼 있다면 실제 canonical과 전체 검색 범위를 포함하는 Property를 선택한다.

Property가 없다면 Domain Property 추가를 우선 검토한다. Domain Property는 DNS TXT record로 소유권을 확인하며 모든 프로토콜과 하위 도메인을 포함한다. 기존 DNS record를 삭제하지 말고 Google이 제공한 TXT record를 추가한다.

### B. OAuth 계정에 읽기 권한 부여

기존 Search Console 사용자가 OAuth를 승인하면 새 사용자를 추가할 필요가 없다. 별도 운영 계정을 사용할 때만 다음을 진행한다.

1. Quizeey Property에서 **Settings → Users and permissions**를 연다.
2. **Add user**를 선택한다.
3. OAuth 로그인에 사용할 Google 계정 이메일을 입력한다.
4. 먼저 **Restricted**를 선택한다.
5. 저장한 뒤 해당 계정으로 Search Console에 로그인해 Performance 보고서를 열 수 있는지 확인한다.
6. API `sites.list`와 `searchAnalytics.query`가 권한 부족으로 실패할 때만 **Full user**로 올리고 이유를 일지에 기록한다.
7. Owner 권한은 API 읽기에 필요하지 않다.

### C. OAuth 동의 화면 구성

1. Google Cloud Console에서 API를 활성화한 project를 연다.
2. **Google Auth Platform → Branding**을 연다. 이전 UI에서는 **APIs & Services → OAuth consent screen**일 수 있다.
3. App name을 `Quizeey Ops`처럼 입력한다.
4. User support email과 Developer contact email을 입력한다.
5. **Audience**에서 계정 유형에 맞게 Internal 또는 External을 선택한다.
6. External/Testing이면 OAuth 로그인 계정을 **Test users**에 추가한다.
7. Search Console 승인에서는 다음 scope만 요청한다.

```text
https://www.googleapis.com/auth/webmasters.readonly
```

External 앱이 Testing 상태이면 profile 계열 이외 scope의 refresh token이 7일 뒤 만료될 수 있다. 반복 운영 전에 publishing status와 Google 검증 요구사항을 확인한다. 새 token을 반복 생성하면 계정당 client별 refresh token 제한으로 오래된 token이 취소될 수 있다.

### D. Desktop OAuth client 만들기

1. **Google Auth Platform → Clients** 또는 **APIs & Services → Credentials**를 연다.
2. **Create client → Desktop app**을 선택한다.
3. 이름을 `Quizeey Ops Desktop`으로 입력한다.
4. 생성 후 client JSON을 다운로드한다.
5. 저장소 밖의 사용자 전용 위치에 `oauth-desktop-client.json`으로 저장한다.
6. OAuth client secret을 대화나 Git에 넣지 않는다.

Desktop OAuth는 기본 브라우저와 `127.0.0.1` loopback redirect를 사용하는 공식 client library 흐름을 사용한다. 수동 copy/paste 방식인 OOB flow는 지원 종료됐으므로 사용하지 않는다.

### E. Search Console token 발급

1. 로컬 수집기의 GSC 인증 명령을 실행한다.
2. 브라우저가 열리면 위에서 권한을 확인한 Google 계정을 선택한다.
3. 동의 화면에서 앱 이름과 요청 scope가 `webmasters.readonly`인지 확인한다.
4. 승인 후 브라우저가 로컬 loopback 주소로 돌아오면 수집기가 token을 저장할 때까지 기다린다.
5. refresh token을 `oauth-gsc-token.json`처럼 AdSense와 분리해 저장한다.
6. authorization code나 token 값을 복사해 대화에 보내지 않는다.

현재 저장소에는 인증용 수집 명령이 아직 검증되지 않았다. 연결 도구가 준비되기 전에는 client/token 파일만 안전하게 보관하고 임의의 온라인 OAuth 도구에 업로드하지 않는다.

### F. Search Console 최초 readback

1. `GET https://www.googleapis.com/webmasters/v3/sites`를 호출한다.
2. 응답에서 정확한 Quizeey Property 문자열과 `permissionLevel`을 확인한다.
3. Property가 없으면 OAuth에 로그인한 계정과 Search Console에 추가한 계정이 같은지 확인한다.
4. 다음 최소 Search Analytics 요청을 수행한다.

```json
{
  "startDate": "완결된_시작일",
  "endDate": "완결된_종료일",
  "dimensions": ["date"],
  "type": "web",
  "rowLimit": 1000
}
```

5. clicks, impressions, ctr, position이 들어오는지 확인한다.
6. `query`, `page`, `country`, `device`는 각각 별도 집계로 조회한다. 차원이 다른 결과를 행 단위로 임의 결합하지 않는다.
7. 최근 데이터는 예비값일 수 있고 일반적으로 2~3일 지연된다. 정기 기준선은 API가 제공하는 최신 완결일을 끝으로 사용한다.
8. 24시간 보고서를 제외한 Search Console 일별 데이터는 Pacific Time 기준이다. GA4 Property 시간대와 같다고 가정하지 않는다.

Search Console 연결 완료 조건은 `sites.list`에서 Quizeey Property와 권한을 확인하고 완결된 기간의 Search Analytics sample read가 성공한 상태다.

## AdSense 상세 연결

AdSense Management API는 service account를 지원하지 않는다. AdSense 접근 권한이 있는 사용자가 Installed Application/Desktop OAuth를 승인해야 한다.

### A. 승인할 AdSense 사용자 확인

1. [Google AdSense](https://adsense.google.com/)에 로그인한다.
2. 좌측 메뉴에서 **Account → Access and authorization → User management**를 연다.
3. OAuth를 승인할 Google 계정이 Active인지 확인한다.
4. 기존 account owner 또는 신뢰할 수 있는 기존 사용자를 우선 사용한다.

AdSense UI 사용자 역할은 Standard와 Admin이며 Standard도 계정의 여러 부분을 관리할 수 있다. 보고 전용 UI 사용자를 만들 수 있다고 가정하지 않는다. 최소 권한은 OAuth에서 `adsense.readonly`만 승인해 적용한다.

새 사용자가 꼭 필요할 경우:

1. **+ New user**를 선택한다.
2. Google 계정 이메일을 입력하고 초대한다.
3. 초대받은 사용자가 30일 안에 수락한다.
4. Admin이 아닌 Standard로 유지한다.
5. 해당 Google 계정이 다른 활성 또는 폐쇄 AdSense 계정과 연결돼 있으면 초대가 거절될 수 있다.

### B. AdSense OAuth 준비

1. 앞서 사용한 Google Cloud project를 열어도 된다.
2. **AdSense Management API**가 Enabled인지 확인한다.
3. OAuth consent screen에서 AdSense 승인 계정이 Test user 또는 허용된 사용자인지 확인한다.
4. 기존 Desktop app OAuth client를 재사용하거나 AdSense 전용 Desktop client를 만든다.
5. 승인 시 다음 scope만 요청한다.

```text
https://www.googleapis.com/auth/adsense.readonly
```

`https://www.googleapis.com/auth/adsense`는 읽기/쓰기 scope이므로 요청하지 않는다.

### C. AdSense token 발급

1. 로컬 수집기의 AdSense 인증 명령을 실행한다.
2. 브라우저에서 Active AdSense 사용자로 로그인한다.
3. 동의 화면의 앱 이름과 `adsense.readonly` scope를 확인한다.
4. 승인 후 token을 `oauth-adsense-token.json`처럼 GSC token과 별도로 저장한다.
5. background 수집에 필요한 refresh token이 생성됐는지는 비밀이 아닌 상태값으로만 확인한다.
6. access token과 refresh token 원문을 출력하거나 대화에 보내지 않는다.

현재 저장소의 수집 명령이 검증되기 전에는 OAuth 파일을 임의 도구에 입력하지 않는다.

### D. Account와 Quizeey site readback

1. `GET https://adsense.googleapis.com/v2/accounts`를 호출한다.
2. 사용할 `accounts/{ACCOUNT_ID}` resource를 확인한다.
3. 관리 account와 child account가 함께 보이면 `listChildAccounts`로 실제 Quizeey 수익 account를 선택한다.
4. `GET /v2/accounts/{ACCOUNT_ID}/sites`에서 `quizeey.com`을 확인한다.
5. `GET /v2/accounts/{ACCOUNT_ID}/adclients`로 Content용 ad client를 확인한다.
6. resource ID는 공개 저장소에 넣지 않고 private 운영 상태에 저장한다.

### E. AdSense 최초 보고서 readback

어제 하루에 대해 `accounts.reports.generate`를 먼저 호출한다.

- dimension: `DATE`
- metrics: `ESTIMATED_EARNINGS`, `PAGE_VIEWS`, `PAGE_VIEWS_RPM`, `IMPRESSIONS`
- reporting time zone: account 기본값을 우선 사용하고 응답에서 확인
- currency: account 기본 통화를 우선 사용하고 응답에서 확인

확인 순서는 다음과 같다.

1. HTTP 200과 header/row 수를 확인한다.
2. 응답의 start/end date가 요청 날짜와 일치하는지 확인한다.
3. currency와 reporting time zone을 기록한다.
4. `totalMatchedRows`와 반환 row 수를 비교해 잘림 여부를 확인한다.
5. 어제 값이 아직 집계되지 않았으면 마지막으로 값이 있는 날짜를 찾아 지연을 기록한다.
6. 예상 수익은 예상 수익으로 표시한다. `payments.list`의 지급 내역이나 UI 확정 항목과 같은 값으로 취급하지 않는다.
7. Page RPM의 분모는 AdSense page views다. GA4 `screenPageViews`를 섞어 새 RPM을 만들지 않는다.

AdSense 연결 완료 조건은 `accounts.list`, Quizeey site 확인과 최소 보고서 read가 모두 성공한 상태다.

## Google 제품 간 기존 링크 확인

제품 간 링크는 각 원천 API 연결을 대신하지 않는다. 링크에서 보이는 데이터는 원천 데이터와 구분해 기록한다.

### GA4–AdSense 링크

1. GA4에서 Quizeey Property를 선택한다.
2. **Admin → Product links → Google AdSense Links**를 연다.
3. 연결된 AdSense account와 web stream이 Quizeey인지 확인한다.
4. 링크가 없다면 생성 전에 다음 권한을 확인한다.
   - AdSense Admin
   - GA4 Property Editor
   - Quizeey 페이지의 정상 Google tag 수집
5. 새 링크는 수익 계측 범위를 바꾸는 운영 설정이므로 현재 account/stream, 영향과 복구 방법을 기록한 후 수행한다.
6. 새 링크는 데이터가 보이기까지 최대 24시간 걸릴 수 있고 링크 이전 데이터는 GA4에 소급 표시되지 않는다.

### GA4–Search Console 링크

1. GA4에서 **Admin → Product links → Search Console Links**를 연다.
2. Quizeey Search Console Property와 `https://quizeey.com` web stream이 연결됐는지 확인한다.
3. 새 링크에는 GA4 Property Editor와 Search Console verified owner 권한이 필요하다.
4. **Link → Choose accounts → Quizeey Property → Confirm → Next → Quizeey web stream → Review and submit** 순서로 설정한다.
5. 한 web stream은 Search Console Property 하나에만 연결할 수 있다. 기존 링크가 있으면 삭제하기 전에 현재 연결을 기록한다.
6. Search Console 데이터는 보통 수집 후 약 48시간 뒤 GA4에서 보인다.

## Owner가 전달할 값

Owner가 대화에 전달할 값은 다음으로 제한한다.

```text
GA4_PROPERTY_ID=<숫자>
GA4_REPORTING_TIME_ZONE=<시간대>
GA4_CURRENCY=<ISO 통화>
GSC_PROPERTY=<sc-domain:quizeey.com 또는 정확한 URL-prefix>
ADSENSE_ACCOUNT_RESOURCE=<accounts/...>
ADSENSE_REPORTING_TIME_ZONE=<시간대>
ADSENSE_CURRENCY=<ISO 통화>
```

service account 이메일과 확인된 권한 등급도 전달할 수 있다. JSON key, OAuth client JSON, token 파일 내용과 authorization code는 전달하지 않는다.

연결 확인 후 private 상태에는 다음만 기록한다.

- source
- resource ID 또는 Property 문자열
- 확인된 권한 등급
- 인증 방식
- 마지막 성공 read 시각
- 마지막 완결 데이터 날짜
- 시간대와 통화
- token/key 생성일과 폐기 예정일
- 실패 상태와 재인증 필요 여부

## API 연결 전 수동 export 대안

API 연결이 지연돼도 기준선 분석은 수동 export로 시작할 수 있다.

### GA4 export

1. Reports 또는 Explore에서 정확한 날짜 범위를 설정한다.
2. timezone과 currency를 기록한다.
3. 국가, 언어, 기기, landing page와 현재 존재하는 학습 event를 각각 export한다.

### Search Console export

1. Performance → Search results에서 완결된 날짜 범위를 설정한다.
2. Search type과 filter를 기록한다.
3. Queries, Pages, Countries, Devices와 Dates 탭을 각각 export한다.
4. UI export 표는 대표 행 1,000개로 제한될 수 있고 총계와 표 합계가 다를 수 있음을 기록한다.

### AdSense export

1. Reports에서 같은 날짜 범위와 account 시간대/통화를 확인한다.
2. 예상 수익, AdSense page views, Page RPM, impressions를 export한다.
3. 지급/확정 정보는 예상 수익 export와 분리한다.

파일은 private ignored 위치에 저장한다.

```text
.modernization/quizeey-ops/imports/{source}/{exported-at}_{start}_{end}_{view}.csv
```

파일명에 source, 양끝을 포함한 날짜와 view를 넣는다. 원본 export를 Git에 추가하지 않는다.

## 연결 완료 체크리스트

### 공통

- [ ] 정확한 Quizeey resource와 권한을 UI와 API 양쪽에서 확인했다.
- [ ] secret은 저장소와 대화 밖에 저장했다.
- [ ] sample read가 성공했다.
- [ ] source 시간대, 통화, 최신 완결일과 집계 지연을 기록했다.
- [ ] 실패 시 재인증 담당과 확인 위치를 기록했다.

### GA4

- [ ] 숫자 Property ID와 Quizeey web stream을 확인했다.
- [ ] service account는 Property Viewer이고 account-level 권한이 없다.
- [ ] `runReport`가 성공하고 응답 metadata를 확인했다.

### Search Console

- [ ] 정확한 Domain 또는 URL-prefix Property 문자열을 확인했다.
- [ ] `sites.list`에서 Property와 permissionLevel을 확인했다.
- [ ] 완결된 기간의 `searchAnalytics.query`가 성공했다.

### AdSense

- [ ] 사용자 OAuth가 `adsense.readonly`만 승인했다.
- [ ] `accounts.list`와 Quizeey site read가 성공했다.
- [ ] 예상 수익 보고서의 시간대, 통화와 AdSense 분모를 확인했다.

## 자주 발생하는 오류

### `403 PERMISSION_DENIED`

- API가 Google Cloud project에서 Enabled인지 확인한다.
- 인증 주체와 제품 UI에 추가한 이메일이 같은지 확인한다.
- GA4는 숫자 Property ID, GSC는 정확한 Property 문자열을 사용했는지 확인한다.
- 권한을 올리기 전에 최소 권한으로 필요한 보고서가 실제로 제한되는지 확인한다.

### OAuth 동의 화면의 `access_denied`

- External/Testing 앱이면 로그인 계정이 Test user인지 확인한다.
- Google Workspace 관리자가 scope를 차단했는지 확인한다.
- AdSense 승인 계정이 실제 AdSense Active user인지 확인한다.

### `redirect_uri_mismatch`

- OAuth client 유형이 **Desktop app**인지 확인한다.
- 공식 client library의 loopback redirect를 사용한다.
- OOB/manual copy-paste 흐름을 사용하지 않는다.

### 7일마다 다시 로그인이 필요함

- OAuth consent screen이 External/Testing인지 확인한다.
- Testing refresh token은 일반적으로 7일 뒤 만료될 수 있다.
- 반복 자동화 전에 publishing status와 필요한 Google 검증 절차를 검토한다.

### API와 UI 숫자가 다름

- 날짜 양끝 포함 여부와 최신 완결일을 확인한다.
- GA4 Property 시간대, Search Console Pacific Time, AdSense reporting timezone 차이를 확인한다.
- GSC 개인정보 보호 생략, 표 row 제한과 집계 차원을 확인한다.
- AdSense 예상 수익과 확정/지급 데이터를 구분한다.
- GA4 page view를 AdSense Page RPM 분모로 사용하지 않는다.

## 연결 해제와 복구

1. 수집 작업을 중지하고 마지막 성공 read 시각을 기록한다.
2. OAuth token은 Google 계정의 third-party access 또는 앱 권한에서 취소한다.
3. 로컬 GSC/AdSense token 파일을 삭제한다.
4. GA4 service account key를 비활성화하고 사용 중이 아님을 확인한 뒤 삭제한다.
5. GA4 Property access management와 Search Console Users and permissions에서 운영 주체를 제거한다.
6. Google Cloud OAuth client나 project를 삭제하기 전에 다른 운영 작업이 사용하지 않는지 확인한다.
7. 제품 간 GA4 link를 삭제할 경우 삭제 전 resource와 영향 범위를 기록한다.
8. public state에는 `disconnected`만 남기고 resource ID, 사용자 이메일과 실패 원문은 private 상태에 보관한다.

## 추가 공식 근거

- [Google Analytics Data API quickstart](https://developers.google.com/analytics/devguides/reporting/data/v1/quickstart)
- [GA4 사용자와 Property 권한 관리](https://support.google.com/analytics/answer/9305788)
- [Search Console 데이터 지연과 시간대](https://support.google.com/webmasters/answer/17010575)
- [AdSense 사용자 추가](https://support.google.com/adsense/answer/2659101)
- [AdSense report 생성](https://developers.google.com/adsense/management/reference/rest/v2/accounts.reports/generate)
- [GA4와 AdSense 연결](https://support.google.com/analytics/answer/13610380)
- [GA4와 Search Console 연결](https://support.google.com/analytics/answer/10737381)
- [Desktop OAuth](https://developers.google.com/identity/protocols/oauth2/native-app)
- [OAuth token 만료 조건](https://developers.google.com/identity/protocols/oauth2)
- [Service account key 관리](https://docs.cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys)
