# RubriCheck·Quizeey 첫 블로그 운영안

2026-11-02 작성. 두 저장소의 `google_search_console_report_20261102` CSV를 분석했다. 기준은 웹 검색, 2026-08-01~2026-10-31이다. Search Console 실적에 근거한 첫 실험이며 전환 데이터로 확정한 최적 시장은 아니다. 수치 요약은 [분석 기준값](search-console-baseline-20261102.json)에 보관했다. 원본 CSV는 변경하지 않았다.

## 첫 글

| 사이트 | 첫 대상 | 검색 질문 | 새 경로 | 다음 행동 |
| --- | --- | --- | --- | --- |
| RubriCheck | 미국, 영어, 제출 전 과제를 점검하는 학생 | assignment requirements/instructions checker → 요구사항을 어떻게 확인할까? | /blog/assignment-requirements-checklist | 자기 과제·지시사항·루브릭 점검 |
| Quizeey | 한국, 한국어, SQLD 수험생 | sqld 기출문제 cbt → 온라인 문제를 어떻게 복습할까? | /blog/sqld-cbt-study-guide | /sqlp-developer에서 SQLD 문제풀이 |

RubriCheck는 미국 노출 5,364회·클릭 561회·CTR 10.46%·평균 순위 6.38이다. 말레이시아는 클릭이 더 많은 1,040회이나 노출 2,176회·CTR 47.79%·평균 순위 1.78로 이미 높은 검색 가시성을 보인다. 미국의 더 큰 노출 기반과 영어 제품의 적합성을 근거로 첫 확장 대상으로 골랐다. 말레이시아가 덜 가치 있다는 의미는 아니다. 국가별 검색어/전환 교차 데이터가 없으므로 이 판단은 검증해야 한다. 영어 글은 말레이시아·캐나다 등에서도 읽을 수 있다.

전 세계 검색어 기준 `assignment requirements checker` 44노출·0클릭·평균 5.48위, `assignment instructions checker` 46노출·0클릭·11.39위, `assignment criteria checker` 54노출·0클릭·8.44위, `check assignment against rubric` 67노출·2클릭·CTR 2.99%·7.43위다. 개별 표본은 작으므로 큰 시장이라고 단정하지 않는다. 신규 글은 **요구사항의 충족 여부·평가기준의 품질·제출 형식의 차이**와 복사해 쓸 수 있는 점검 항목에 집중한다. 기존 `/assignment-rubric-checker`는 서비스 사용 의도, 기존 루브릭 사용법은 점수 기준 적용 의도를 유지한다.

Quizeey는 전체 클릭 3,501회 중 한국 3,465회(98.97%)다. `sqld 기출문제 cbt` 1,215노출·24클릭·CTR 1.98%·7.72위, `sqld cbt` 578노출·10클릭·CTR 1.73%·10위, `sqld 기출문제 사이트` 300노출·10클릭·CTR 3.33%·6.7위로 개선 후보가 확인된다. SQLD의 기존 URL은 이름과 달리 `/sqlp-developer`가 맞다. 이 페이지는 1,401노출·43클릭·CTR 3.07%·평균 12.13위지만, 별도 페이지 표와 검색어 표만으로 특정 검색어의 유입 페이지를 확정할 수는 없다.

즉시 문제를 풀려는 검색 의도는 기존 SQLD 페이지가 담당하도록 해당 페이지의 제목·설명을 ‘무료 CBT·해설·오답 복습’에 맞게 개선했다. 블로그는 3단계 복습법을 보완하며 직접 만든 COUNT/NULL 도식을 실습 예제로 사용한다. COUNT 자체의 검색 수요가 CSV에서 확인됐다고 주장하지 않는다. 기존 조리기능사 페이지들은 이미 많은 클릭과 높은 CTR을 확보하고 있어 첫 글은 상대적으로 약한 SQLD 질문군을 보강한다.

## 조사 근거와 한계

- 실제 수요와 현재 성과의 근거는 사용자 Search Console CSV다. 공개 웹 검색은 설명 방식·공식 자료를 확인하는 데 사용했다. Search Console의 자사 노출수는 시장 전체 검색량이 아니다.
- Google 검색 결과 페이지를 국가·언어 매개변수와 함께 직접 열려고 했으나 사용 도구에서 접근하지 못했다. 공개 웹 검색 결과를 Google의 직접 실적이나 순위로 취급하지 않았다.
- Search Console/GA4 접근을 지원하는 Windsor.ai 연결 옵션을 찾았다. 아직 연결을 확인하지 못했지만 이번 분석에는 제공된 CSV로 충분했다. 지속 운영 시 연결 또는 주기적인 CSV 내보내기를 사용할 수 있다. 유료 도구를 도입하거나 결제하지 않았다.
- 국가·검색어·페이지·기기 CSV는 각각 별도 집계다. 서로 임의로 결합하지 않았다. 특히 RubriCheck의 선택 검색어가 미국에서만 발생했다고 주장하지 않는다. 표본이 작은 검색어의 0% CTR도 확정적인 이상 신호로 취급하지 않는다.

본문 검증 자료:

- [UNC Writing Center: Understanding Assignments](https://writingcenter.unc.edu/tips-and-tools/understanding-assignments/)
- [Carnegie Mellon University: Creating and Using Rubrics](https://www.cmu.edu/teaching/assessment/assesslearning/rubrics.html)
- [PostgreSQL 18: 집계 함수](https://www.postgresql.org/docs/18/functions-aggregate.html)
- [PostgreSQL 18: DISTINCT 집계 표현식](https://www.postgresql.org/docs/18/sql-expressions.html#SYNTAX-AGGREGATES)

## 사용자가 제안한 방식의 보완

유용한 질문에 답하고 기존 페이지와 서비스를 연결하는 방식은 타당하다. 다만 ‘노출은 많고 클릭은 적음 → 무조건 새 글’은 피한다.

1. Search Console에서 최근 3개월과 이전 3개월을 비교한다. 최근 며칠의 불완전한 데이터는 제외한다. 검색 유형은 웹으로 맞춘다.
2. 검색어를 페이지·국가·기기별로 살핀다. 브랜드 검색과 일반 검색을 분리하고, 순위가 비슷한 검색어끼리 CTR을 비교한다. 모든 검색어에 같은 CTR 합격선을 적용하지 않는다.
3. 노출이 충분하고 평균 순위가 대략 4~20인 질문부터 검토한다. 이는 작업 우선순위용 출발점이지 Google 기준이나 순위 보장이 아니다. 노출이 적으면 기간을 늘린다.
4. 이미 같은 질문에 답하는 URL이 있으면 해당 글의 답변·제목·설명을 먼저 개선한다. 낮은 CTR이 검색 의도 불일치, 순위, 광고·답변 상자 등 결과 구성 때문인지 확인한다.
5. 기존 페이지가 답하지 못하는 별도 질문이면 새 글을 만든다. 첫 문단에 답, 독자에게 필요한 예제, 공식 근거, 하나의 자연스러운 서비스 이동을 둔다. 비슷한 키워드마다 중복 페이지를 늘리지 않는다.
6. 주제와 관련된 기존 페이지에서 설명적인 링크를 추가한다. 내부 링크에는 UTM을 붙이지 않아 최초 유입 출처를 보존한다.
7. 배포 후 Search Console에서 사이트맵과 URL 검사를 확인한다. 색인은 보장되지 않는다. 28일 단위로 검색 성과를 비교하고, 신규 글은 8~12주 동안 같은 질문군의 변화를 관찰한다.

운영 시작은 사이트당 주 1편 정도로 한다. 데이터가 뒷받침되면 빈도를 늘리고, 기존 글 수정이 새 글보다 효과적일 때는 수정에 시간을 쓴다. 발행일·수정일은 실제 내용 변경 때만 갱신한다.

## 연결/자료 요청

이번 최근 3개월의 검색어·페이지·국가·기기·일별 CSV는 확보했다. 다음 분석에 유용한 것은 ① 이전 3개월 비교 ② RubriCheck 미국 필터의 검색어/페이지 실적 ③ Quizeey 한국·SQLD 페이지 필터의 검색어 실적 ④ 두 사이트 GA4의 실제 서비스 사용 전환이다. 별도 탭을 임의로 결합하지 말고 필터를 적용해 내보내거나 API로 교차 차원을 요청한다. 작은 검색어는 개인정보 보호로 누락될 수 있다.

GA4는 가능하면 읽기 권한으로 연결한다. 비밀번호·API 키를 대화에 붙일 필요는 없다. 이번 글은 Search Console에 근거해 구현했고, 실제 서비스 전환율 검증은 GA4/기존 제품 분석 데이터가 필요하다.

## 성과 측정

첫 지표는 전체 방문자 수보다 **자연검색으로 읽은 사람이 실제 서비스를 이용하는 비율**이다.

- Search Console: 해당 글/질문군의 비브랜드 노출, 클릭, 순위, 같은 국가·기기의 CTR.
- RubriCheck: 새 블로그 경로를 기존 `publicGrowthPath` 허용 목록에 추가했다. 기존 최초 유입/평가 이벤트를 이용해 글 유입 → workspace → 평가 시작/결과를 비교한다. 실제 운영 데이터 수집은 연결 후 확인해야 한다.
- Quizeey: 기존 동의 기반 GA4 page_view와 문제풀이 이벤트를 유지한다. `/blog/sqld-cbt-study-guide` 유입 → `/sqlp-developer` → `practice_start`/`answer_submit` 경로를 본다. 기존 ExamLink를 사용하며 내부 UTM은 추가하지 않았다.
- 서비스 이동 클릭은 실제 사용과 다르다. 평가 완료/문제 응답 등 실제 행동까지 확인한다. 동의 거부·차단에 따른 누락과 Search Console/GA4 집계 차이를 고려한다.

## 구현과 릴리스

양쪽 `/blog` 목록, 첫 글, 기존 페이지의 내부 링크, canonical, Open Graph/Twitter, BlogPosting/BreadcrumbList, 사이트맵을 추가했다. 본문·도식은 서버 HTML이며 번역하지 않은 언어의 hreflang을 만들지 않는다. Quizeey의 로컬/미리보기 noindex와 기존 배포 가드를 유지한다.

별도 릴리스 요청 전에는 로컬 변경으로 보관한다. Quizeey는 `web/npm run check:local`, RubriCheck는 운영 환경변수를 제외한 별도 작업본에서 타입·변경 파일 린트·분석 단위 테스트·빌드·SEO·블로그 브라우저 검증을 수행한다. 실제 DB/Auth/AI 평가/결제와 운영 분석 수집은 별도 검증 영역이다.

공식 SEO 근거: [Search Console 실적 보고서](https://support.google.com/webmasters/answer/7576553?hl=en), [CTR 개선 진단](https://support.google.com/webmasters/answer/10268906?hl=en), [Google의 유용한 콘텐츠 지침](https://developers.google.com/search/docs/fundamentals/creating-helpful-content), [SEO 기본 가이드](https://developers.google.com/search/docs/fundamentals/seo-starter-guide).

## 최종 로컬 검증 결과

- Quizeey: `npm run check:local`의 타입 검사·린트·단위 테스트 178건·빌드 통과. 브라우저 94건 중 80건 통과, DB/Auth 12건 제외, 기존 SQLD 제목·설명 기대값 2건 실패. 새 검색 문구에 맞게 기대값을 수정한 뒤 `npm run test:e2e:local -- practice.spec.ts seo.spec.ts`로 관련 29건 모두 통과했다. 재검사까지 합쳐 실행 가능한 82건의 최종 검증을 완료했다. 전체 명령을 수정 후 다시 실행했다고 주장하지 않는다.
- 새 블로그의 JavaScript 없는 읽기·SQLD 이동, 모바일 밝은/어두운 테마 접근성, 존재하지 않는 글의 404 검사가 통과했다. Windows에서 테스트 완료 후 남은 해당 로컬 Next 서버 프로세스를 종료해 테스트 종료 처리를 마쳤다.
- 전체 명령의 브라우저 실패 때문에 건너뛴 광고·동의 검사는 별도로 실행했다. 기존 React 컴포넌트 기반 모의 브라우저 시나리오 6건 통과, 실제 외부 네트워크 요청 0건. 결과는 기존 증거 파일과 시각 외에 동일했다.
- RubriCheck: 운영 환경변수를 제외한 별도 로컬 작업본에서 빌드·TypeScript·변경 파일 린트·성장 분석 테스트 7건 통과. SEO 검사 107개 공개 URL, 모바일/데스크톱·JavaScript 없는 읽기·기존 글 연결·작업공간 이동·404 검사를 통과했다. 검증한 구현 파일 15개의 해시가 실제 RubriCheck 저장소와 일치함을 확인했다.
- 운영 사이트/Vercel에 회귀 검사나 배포를 실행하지 않았다. 실제 DB/Auth, AI 평가, 결제, 운영 분석 수집을 검증한 결과는 아니다.

검토용 화면: [Quizeey 모바일](previews/quizeey-article-390.png), [Quizeey 데스크톱](previews/quizeey-article-1280.png), [RubriCheck 모바일](previews/rubricheck-article-390.png), [RubriCheck 데스크톱](previews/rubricheck-article-1280.png).
