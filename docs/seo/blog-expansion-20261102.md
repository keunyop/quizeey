# 두 번째 블로그: IPv4 서브넷 계산 실습

조사·작성일: 2026-11-02. 새 글은 사이트당 한 편이며, 기존 SQLD 글의 URL·제목·발행일은 유지했다. 데이터는 [이번 분석 원본 집계](search-opportunities-20261102.json), 이전 판단은 [첫 글 기록](blog-launch-20261102.md)을 참조한다.

## 선택과 실제 제품 적합성

- URL: `/en/blog/ipv4-subnetting-practice`
- 제목: **IPv4 Subnetting Practice: Find the Network, Broadcast and Host Range**
- 영어, 캐나다의 네트워킹 전공 학생·Network+ 입문자를 우선 대상으로 한다. 미국의 직업교육·IT 전환 학습자도 검토했다. 신규 검색 수요·시장 실험이며 국가별 전환 우위를 확인한 선택은 아니다.
- `/26`, `/27`, `/20`의 직접 만든 예제, 주소 경계 도식, 해답을 펼치는 세 문제, 실수별 복습 방법을 제공한다. 단순 시험 선택 안내인 기존 `/en/study-guides/current-certification-exam-versions`와 달리 한 계산 방법을 끝까지 연습한다.
- `src/data/practice-2026-10.json`과 `exam-catalog.json`에서 Network+ N10-009의 영어 자체 제작 문제 12개와 IPv4 계산 문항을 확인했다. `/en/comptia-n10-009`로 연결한다. 전체 시험 모의고사·전 범위 문제은행이라고 홍보하지 않는다. CCNA의 기존 데이터와 출처를 새로 보증하지 않고, 확인 가능한 자체 제작 세트를 선택했다.
- 캐나다 [Seneca NET455](https://www.senecapolytechnic.ca/ssos/printOutline.do?schoolCode=SICT&state=both&subjectCode=NET455&termCode=20261)는 Network+ 기반 네트워킹·서브넷 교육을 명시한다. 미국 [UWF 교육과정](https://uwf.edu/media/university-of-west-florida/centers/cybersecurity/workforce-development/fctp-course-outlines/fctp-spring-2025-course-outlines/UWF-FCTP-Network--Test-Prep-N10-009-Syllabus-02-10-2025-to-04-18-2025.pdf)은 학생·초급 IT 실무자를 대상으로 한다. 이는 교육 수요의 정성적 근거이며 검색량 자료가 아니다. UWF 문서는 2025년 과정으로, 현재 모집 일정의 근거로 사용하지 않았다.

## 기존 검색 수요와 변화

최신 제공 자료: `docs/report/google_search_console_report_20261102`, 웹 검색, 2026-08-01~10-31. 이후 보고서 없음. 실시간 GSC/GA4 도구는 연결되지 않았다. Windsor.ai가 검색되었으나 미설치이며 앞선 세션에서 이미 제안된 연결이라 다시 설치를 요구하지 않았다.

| 항목 | 클릭 | 노출 | CTR | 평균 순위 |
| --- | ---: | ---: | ---: | ---: |
| 전체 기간 | 3,501 | 25,239 | 13.87% | 약 7.91 |
| 최근 28일: 10/04~10/31 | 1,022 | 6,529 | 15.65% | 약 7.41 |
| 이전 28일: 09/06~10/03 | 950 | 6,921 | 13.73% | 약 7.51 |
| 한국 | 3,465 | 24,101 | 14.38% | 7.15 |
| 캐나다 | 6 | 68 | 8.82% | 30.69 |
| 미국 | 3 | 452 | 0.66% | 17.79 |
| 데스크톱 | 1,888 | 14,241 | 13.26% | 9.28 |
| 모바일 | 1,352 | 9,688 | 13.96% | 6.18 |
| 태블릿 | 261 | 1,310 | 19.92% | 5.94 |

기간 평균 순위는 일별 노출로 가중한 근사값이며 원본 반올림의 영향을 받는다. 국가·기기와 검색어는 독립 집계다. 캐나다의 여섯 클릭이 서브넷 검색에서 왔다고 해석할 수 없다. 두 28일 구간은 새 글 발행 전이므로 새 글 효과를 나타내지 않는다.

엄격한 브랜드 문자열 `quizeey`는 35클릭/51노출/1.10위다. 나머지를 모두 확실한 비브랜드라고 단정하지 않았다. `sqld 기출문제 cbt`는 24클릭/1,215노출/7.72위, `3d프린터운용기능사 필기 cbt`는 27/314/7.11위, `양식조리기능사 필기 기출문제`는 279/524/2.06위다. 낮은 CTR만으로 새 글을 정하지 않았다. 특히 SQLD 도구 검색은 기존 문제 페이지와 첫 글이 이미 담당한다.

기존 GA4 스냅샷은 2026-09-26~10-23의 활성 사용자 1,222명, 이벤트 38,310건을 포함하지만 새 글별 실제 문제 응답 퍼널은 없다. 이 숫자로 글 전환율을 계산하지 않았다.

## 여섯 후보 비교

조사일은 모두 2026-11-02. 4~6번은 기존 GSC 검색어 목록 밖에서 발견했다. 해당 문자열군이 내보내기에 없다는 사실은 시장 검색량이 0이라는 뜻이 아니다.

| 후보·질문 묶음 | 고객·국가·언어 / 구분 | 근거·검색 의도·자료의 빈틈 | 실제 기능·다음 행동 / 판단·불확실성 |
| --- | --- | --- | --- |
| 1. SQLD CBT 오답 복습 | 한국 SQLD 수험생, 한국어 / 기존 | `sqld 기출문제 cbt` 24/1,215/7.72위. 즉시 풀기와 공부법 의도 혼재 | `/sqlp-developer` + 기존 `/blog/sqld-cbt-study-guide`. 중복 새 글 대신 기존 제목·설명과 유입 페이지 교차자료 확인 우선. 표본·페이지별 기여 미확인 |
| 2. 양식 필기 문제 복습 순서 | 한국 조리 수험생, 한국어 / 기존 | 관련 대표 검색어 279/524/2.06위, 기존 페이지 1,486클릭. 이미 강한 도구 의도이며 일반 공부법만 추가할 근거는 약함 | `/craftsman-cook-western-food`. 다음 후보로 남김. 어떤 개념에서 실제 오답이 많은지와 현행 출제기준 대조가 필요 |
| 3. 3D프린터 필기: 개념별 실수 | 한국 제조·직업훈련 입문자, 한국어 / 기존 | 대표 CBT 검색어 27/314/7.11위. [Q-net 종목 안내](https://www.q-net.or.kr/crf005.do?gId=&gSite=Q&id=crf00503s02&jmCd=7785&jmInfoDivCcd=A0)에 2024~2027 출제기준 표시 | `/craftsman-3D-printer-operation`. 기존 문제 페이지 개선 먼저. 구체적 실패 개념·보유 문항 현행성 검증 후 작성 |
| 4. IPv4 subnetting practice / network broadcast host range | 캐나다·미국 학생과 IT 전환 학습자, 영어 / 신규·선정 | 공식 교육과정, Cisco 설명, [공개 학습 질문](https://www.reddit.com/r/ccna/comments/1sjkb5d/subnetting_didnt_click_until_i_stopped_starting/). 블록 크기와 다른 옥텟(/20)에서 혼란이 나타남 | `/en/comptia-n10-009`의 실제 영어 문제·해설. 계산→검산→오답 원인→문제 응답의 짧은 흐름을 제공. 제품 적합성 높음, 캐나다 검색량·전환 검증은 낮음 |
| 5. IaaS/PaaS/SaaS: 누가 무엇을 관리하나 | 미국·영국 클라우드 입문자, 영어 / 신규 | [Microsoft 공유 책임](https://learn.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility), [영국 NCSC](https://www.ncsc.gov.uk/collection/cloud/understanding-cloud-services/cloud-security-shared-responsibility-model). 정의와 실제 상황 연결 필요 | `/en/az-900`, 기존 AWS/Azure 가이드. 제품 적합성 높지만 기존 클라우드 안내와 겹침. 후속 글은 구체적 상황·보유 문제 중복 점검 후 |
| 6. Red Seal Cook 준비 | 캐나다 경력 조리사·해외 경력 인정 학습자, 영어·불어 / 신규 | [Red Seal 공식 시험 안내](https://red-seal.ca/eng/trades/cooks/exam-information.shtml), [SkilledTradesBC](https://skilledtradesbc.ca/cook-professional-cook-3-red-seal). 한국 조리기능사와 별도 자격·직무 기준 | 대응 Red Seal 문제풀이를 확인하지 못했으므로 발행 제외, 제품 개선 후보. 한국 조리·ServSafe 세트를 캐나다 자격 준비와 동등하게 안내하지 않음 |

캐나다와 미국은 같은 영어 Network+ 내용을 사용할 수 있고 본문에 지역별 가격·시험 일정·취업 보장을 넣을 필요가 없다. 캐나다식 `practise`를 사용했다. 대학 학사 일정은 기관별이므로 특정 국가 전체의 시험 시즌으로 일반화하지 않는다. 호주·영국은 RubriCheck 조사에서 별도로 검토했다. 기존 영어 study-guides가 이미 여러 국가의 주제를 다루므로, “Quizeey 콘텐츠가 한국어만 있다”는 가정도 하지 않았다.

## 검색 결과와 근거의 한계

- Google 국가 설정 검색 화면 직접 열기는 실패했다. 대체 자료는 웹 검색 도구의 검색 결과·공식 페이지·공개 질문이다. Google의 실제 국가별 순위, 자동완성, 관련 질문 목록을 수집한 것으로 보고하지 않는다.
- 검색 결과에는 공식 장문 설명, 계산 도구, 훈련 글이 이미 많다. “경쟁 콘텐츠가 설명을 하지 않는다”는 주장은 하지 않는다. 짧은 예제에서 실수 분류와 사이트 내 실제 응답까지 이어지는 흐름이 이번 차별점이다.
- Trends·Keyword Planner의 국가별 수치, 광고 경쟁 지표, 예상 검색량·트래픽·전환율은 확보하지 못했으며 생성하지 않았다. 공개 질문은 고민 확인용이며 규모 근거가 아니다.
- [Cisco](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html), [RFC 3021](https://www.rfc-editor.org/rfc/rfc3021.html), [RFC 5737](https://datatracker.ietf.org/doc/html/rfc5737), [CompTIA 자체 발행 N10-009 목표 PDF](https://assets.ctfassets.net/82ripq7fjls2/113XqW3JHT7AlIU33M63I0/af42da2af7383a38f318bad10aa9afbd/Network_Plus_N10-009_Exam_Objectives.pdf)를 사실 확인에 사용했다. 기존 comptia.jp PDF 주소가 일본어 홈페이지로 이동하는 것을 발견해 새 글에는 열리는 문서 주소를 사용했다.

## 구현과 내부 링크

`blogPosts` 레지스트리와 언어별 실제 경로로 확장했다. `/blog`에서 두 글을 찾을 수 있고 `/en/blog`에는 영어 글만 표시한다. `/blog/ipv4-subnetting-practice`, `/en/blog/sqld-cbt-study-guide`는 번역본이 없으므로 404다. canonical·소셜 메타데이터·BlogPosting·BreadcrumbList·사이트맵과 발행/수정일이 각각의 글을 따른다. 실제 번역이 없으므로 언어 대체 태그는 추가하지 않았다. 로컬 noindex와 기존 배포 가드는 유지한다.

유입 링크: 영어 홈, Network+ 문제 페이지, 기존 시험 버전 가이드, `/blog`, `/en/blog`, 기존 SQLD 글. 새 글 → Network+ 문제, 기존 시험 버전 가이드, 한국어 SQLD 글(언어 표시). 내부 UTM 없음. 본문·표·해설은 서버 HTML이며 `<details>`는 JavaScript 없이 열린다.

## 검증·배포 기록

작업 전 운영 확인: Vercel 생산 별칭 `quizeey.com`, `READY`, Git `master`의 `c9f946881973f49a3291c065ac125177837c4f0d`, 배포 `dpl_92n2zBzzb7McLYzv3yc2hVjecViA`. 따라서 첫 글은 이전 기록의 “미배포” 상태 이후 실제 배포되었다.

새 글은 개발 브랜치에서 아래 로컬 검증을 완료했다. `master`로 한 번 병합·push하는 Git 배포만 사용하며 로컬 fixture 빌드는 업로드하지 않는다. 배포 상태는 별도 릴리스 기록으로 확인한다.

### 완료된 로컬 검증

- `web`에서 `npm run check:local`: 최종 종료 코드 0. 타입 검사·전체 린트·단위 테스트 179건·fixture 빌드·브라우저 84건·광고/동의 모의 시나리오 6건 통과. 마지막 시나리오들의 실제 외부 네트워크 요청은 0건이다.
- 첫 실행에서 기존 사이트맵 테스트가 `/en/blog`의 발행일과 번역 없는 페이지를 고려하지 못해 실패했다. 블로그만 명시적으로 분리하고 기존 자격증 언어 대체 검증은 유지한 뒤 전체 필수 명령을 다시 실행했다.
- 브라우저 96건 중 DB/Auth fixture 의존 12건은 제외했다. 실제 운영 DB/Auth·분석 수집을 검증한 결과가 아니다.
- 마지막 브라우저 시나리오까지 통과한 뒤 Windows에서 Next 서버 종료가 대기했다. 해당 실행 로그의 PID·명령·부모 PID를 대조한 후 그 로컬 서버만 종료했고, 같은 `check:local` 프로세스가 이어서 나머지 검사까지 통과했다.
- 신규 글: 서버 HTML·JavaScript 없는 읽기·해답 펼치기·영어 목록·기존 문제 페이지에서의 발견·실제 문제 응답 UI·없는 글/없는 번역 404 통과. 모바일 밝은/어두운 테마 axe WCAG A/AA 위반 0. 본문의 다섯 주소 계산은 Python `ipaddress`로 별도 대조했다.
- [모바일 미리보기](previews/subnetting-390.png), [데스크톱 미리보기](previews/subnetting-1280.png)를 로컬에서 생성하고 확인했다. 모바일의 표는 키보드로 접근 가능한 가로 스크롤 영역이다.
- `web/vercel.json`, 콘텐츠/인증/릴리스 가드, 운영 환경 파일은 변경하지 않았다. 배포 후 결과는 `blog-expansion-release-20261102.json`에 별도 기록한다.

## 관찰 계획과 다음 세션

첫 28일은 발견·색인·초기 유입 관찰 구간이다. 다음 28일과 비교하고, 8~12주 정도의 관찰 기간을 두되 계절성·순위·기기 구성 변화를 함께 확인한다. 순위나 트래픽 증가를 보장하지 않는다.

- GSC: 정확한 새 URL에 `subnet`, `subnetting`, `network address`, `broadcast address`, `host range` 질문군 필터. 캐나다와 미국, 기기를 별도로 필터링해 노출·클릭·CTR·순위 비교. 쿼리×페이지×국가 자료가 있어야 국가별 질문군을 설명할 수 있다.
- GA4: 동의한 자연검색 유입 세션의 새 글 `page_view` → `/en/comptia-n10-009`의 `practice_start` → `answer_submit`을 확인한다. 기존 이벤트와 `test_id=255`를 이용한다. 링크 클릭은 실제 문제 응답으로 세지 않는다. 실제 운영 수집은 이번 로컬 검증의 범위가 아니다.
- 다음 우선순위: 3D프린터의 오답 개념 자료 확보, 기존 SQLD 유입 페이지별 의도 점검, AZ-900 책임 경계 시나리오. Red Seal은 콘텐츠 발행보다 제품 적합성 검토가 먼저다.
- 필요한 자료: 읽기 전용 GSC/GA4 연결 또는 페이지·국가·기기 필터를 적용한 CSV, 글별 서비스 행동 퍼널, 시험 세트별 오답 개념 집계. 사용자의 개인 응답 원문은 필요하지 않다.
