# 네 번째 블로그: 3D프린터운용기능사 설정 판단 연습

조사·작성일 2026-11-05. 기존 SQLD·서브넷·클라우드 글의 URL과 발행일을 유지하고 새 글 한 편을 추가한다.

## 선택과 실제 기능

- `/blog/3d-printer-operation-written-test` — **3D프린터운용기능사 필기: 레이어 높이·서포트·인필 5문제**
- 한국어, 한국의 3D프린터운용기능사 필기 수험생과 직업교육 학습자를 대상으로 한다.
- **기존 검색 수요 개선**이다. 이전 세 글 중 한국어 글은 SQLD 한 편뿐이었고 최근 두 편은 영어 IT 자격이었다. 이번 글은 이미 검색과 서비스 이용이 확인되는 한국 직업자격 고객군으로 확장한다.
- 첫 문단에서 층 수 공식, 레이어 높이의 일반적 절충, 서포트와 인필의 역할을 바로 답한다. 24 mm 모델의 0.30/0.20/0.10 mm 계산표, 설정 판단법, 자체 제작 5문제와 접는 해설, 오답 메모법을 제공한다.
- 실제 연결은 `/craftsman-3D-printer-operation`. `web/src/data/exam-catalog.json`과 `practice-2026-10.json`에서 시험 ID 122, 자체 제작 한국어 23문항을 확인했다. 레이어 높이, 서포트, 인필, 슬라이서, 배치 방향과 안전 문항이 있다.
- 글의 5문제와 서비스 문항은 실제 국가시험 기출문제가 아니며 전체 시험 모의고사·합격 보장으로 안내하지 않는다. 현재 제공 문항 수를 모든 배포 시점의 영구 수량으로 주장하지 않는다.

## 제공 데이터와 해석

최신 제공 GSC는 `docs/report/google_search_console_report_20261102`, 웹 검색, 2026-08-01~10-31이다. 2026-11-05 확인 시 더 최신 내보내기나 연결된 GSC·GA4 조회 도구가 없었다. 검색어·페이지·국가·기기 CSV는 독립 집계이며 서로 조인하지 않았다.

| 구분 | 클릭 | 노출 | CTR | 평균 순위 |
| --- | ---: | ---: | ---: | ---: |
| 전체 | 3,501 | 25,239 | 13.87% | 약 7.91 |
| 최근 28일 10/04~10/31 | 1,022 | 6,529 | 15.65% | 약 7.41 |
| 이전 28일 09/06~10/03 | 950 | 6,921 | 13.73% | 약 7.51 |
| 한국 | 3,465 | 24,101 | 14.38% | 7.15 |
| 미국 | 3 | 452 | 0.66% | 17.79 |
| 캐나다 | 6 | 68 | 8.82% | 30.69 |

`3d프린터운용기능사 필기 cbt`는 27클릭/314노출/8.60%/7.11위, `3d프린터운용기능사 필기`는 20/292/6.85%/8.71위, `3d프린터운용기능사 기출문제`는 17/237/7.17%/7.23위다. 페이지 `/craftsman-3D-printer-operation`은 별도 페이지 집계에서 303클릭/3,627노출/8.35%/7.65위다. 이를 한국 쿼리×페이지 수치로 결합하지 않았다.

기존 GA4 스냅샷은 2026-09-26~10-23이며 3D프린터운용기능사 페이지 34조회·26활성 사용자를 기록한다. 기간과 측정 조건이 GSC와 달라 서로 나누거나 전환율로 계산하지 않았다. 신규 글 발행 전 자료이며 글→문제풀이 퍼널은 없다.

## 후보 여섯 개

확인일은 모두 2026-11-05. 4~6은 GSC 검색어 내보내기 밖에서 발굴했다.

| 후보·핵심 질문 | 고객·국가·언어 / 구분 | 근거·검색 의도·현재 결과의 부족한 점 | 실제 연결·판단·불확실성 |
| --- | --- | --- | --- |
| 1. 양식조리기능사 필기 개념 복습 | 한국 조리 수험생, 한국어 / 기존 | 대표 쿼리 279/524/2.06위, 페이지 1,486/5,179/3.91위, GA4 961조회·413사용자. 실제 이용 가능성이 가장 큼 | `/craftsman-cook-western-food`. 현재 격리 fixture에 같은 시험의 검증 가능한 자체 제작 문항이 없어 개념→답 제출 흐름을 이번 작업에서 보증하기 어려움. 현행 출제기준과 문항 보강 후 우선 재검토 |
| 2. 3D프린터 레이어·서포트·인필 | 한국 직업교육·필기 수험생, 한국어 / 기존·선정 | 관련 쿼리와 페이지가 6~9위권에서 실제 클릭을 얻음. Google `3D프린터운용기능사 필기 공부법` 결과는 일정·합격률·넓은 요약·영상이 많고 공개 질문은 공부 기간과 기출 암기 가능 여부를 묻는다 | `/craftsman-3D-printer-operation`. 현재 자체 제작 23문항과 직접 연결. 계산·설정 절충을 5문제로 좁혀 broad guide와 구별. 개념별 검색량·오답 빈도는 미확인 |
| 3. SQLD CBT 다음 개념 드릴 | 한국 SQLD 수험생, 한국어 / 기존 | `sqld 기출문제 cbt` 24/1,215/7.72위. 첫 글과 `/sqlp-developer`가 이미 COUNT 예제·오답 복습을 제공 | 기존 글 성과 관찰과 랜딩 개선이 우선. 새 글은 정규화·JOIN 등 실제 오답 집계가 생긴 뒤 결정 |
| 4. Ontario G1 right-of-way·road signs | 캐나다 신규 운전자, 영어 / 신규 | GSC에 관련 문자열 없음. Google 결과에 Ontario 공식 MTO handbook과 다수 독립 practice 사이트가 함께 나타나 경쟁이 높음. 공개 질문은 handbook과 practice test의 차이·road rules 난점을 반복해서 묻지만 사실 근거로 사용하지 않음 | `/en/ontario-g1`, 현재 공식 handbook 기반 자체 제작 30문항. 제품 적합성 높음. 국가별 검색량·Quizeey 전환 미확인, 독립 문제의 최신 법규 유지 부담 있음 |
| 5. ServSafe 교차오염·시간/온도 | 미국 식품서비스 입문자, 영어 / 신규 | GSC에 관련 문자열 없음. ServSafe 공식 학습목표가 cross-contamination과 time/temperature를 포함하고 검색 결과에 공식·상업 practice가 다수 | `/en/servsafe-food-handler`, 자체 제작 60문항과 설명. 실제 ServSafe 시험 문항이 아님. 경쟁과 상표 표기·Food Code 갱신을 계속 관리해야 함 |
| 6. California DMV right-of-way·표지판 | 미국 learner permit 응시자, 영어 / 신규 | GSC에 관련 문자열 없음. California DMV 공식 handbook과 다수 practice 사이트가 검색 결과에 나타남. 도로 규칙은 검색 의도가 명확하지만 경쟁이 높음 | `/en/california-dmv-permit`, 자체 제작 30문항. 법규·handbook 갱신 유지 부담과 국가별 성과 미확인. 다음 영어 시장 후보 |

한국 외에는 캐나다와 미국, 기존 IT 자격과 다른 신규 운전자·식품안전 종사자 고객군을 검토했다. 영어 UI와 실제 영어 문항이 있어 이용은 가능하지만, 검색 결과 존재를 Quizeey의 수요나 전환으로 간주하지 않았다.

## 공개 근거·경쟁·한계

- [Q-Net 출제기준 자료실](https://www.q-net.or.kr/cst006.do?id=cst00601&code=1202): 최신 적용 기간의 공식 기준을 확인하는 1차 경로. 시험 일정·출제 범위 수치를 글에 고정하지 않았다.
- [Prusa layers and perimeters](https://help.prusa3d.com/article/layers-and-perimeters_1748), [support material](https://help.prusa3d.com/article/support-material_1698), [infill](https://help.prusa3d.com/article/infill_42): 레이어 높이와 시간·수직 해상도, 서포트, 인필 절충을 확인하는 제조사 문서. 특정 프린터 설정을 모든 장비의 정답으로 일반화하지 않았다.
- Google 한국 결과 `3D프린터운용기능사 필기 공부법`을 직접 확인했다. 블로그·영상·교육업체·공개 사용자 질문이 주로 broad study guide를 제공했다. 사용자 질문은 고민 발견에만 쓰고 시험 형식·합격률·학습 기간의 사실 근거로 쓰지 않았다.
- 신규 후보는 [Ontario MTO handbook](https://www.ontario.ca/document/official-mto-drivers-handbook), [ServSafe Food Handler ILO](https://www.servsafe.com/ServSafe/media/ServSafe/Documents/ServSafe-Food-Handler-ILOs.pdf), [California DMV handbooks](https://www.dmv.ca.gov/portal/driver-handbooks/)를 우선 확인했다. 검색 결과에는 다수 독립 문제풀이 사이트가 있어 낮은 경쟁을 주장하지 않는다.
- 자동완성 전체·국가별 PAA·Google Trends·Keyword Planner·절대 검색량·예상 트래픽·전환율 자료는 없다. 공개 Google 결과는 2026-11-05 한 시점의 표본이다.

## 구현·내부 링크·SEO

- 기존 글 레지스트리와 동적 언어별 route를 재사용해 한국어 글을 추가했다. 한국어 blog index의 수정일만 2026-11-05로 갱신하고, 새 영어 글이 없으므로 `/en/blog` 수정일은 2026-11-04로 유지한다.
- 한국어 홈과 `/craftsman-3D-printer-operation`에서 새 글로 연결한다. 기존 SQLD 글에서도 새 글로 연결한다. 새 글은 실제 3D프린터 문제 페이지와 기존 SQLD 글로 연결한다. 내부 UTM 없음.
- 고유 URL·title·description·canonical, Open Graph/Twitter, BlogPosting/Breadcrumb, sitemap, 발행·수정일 2026-11-05를 사용한다. 한국어판만 존재하므로 영어 hreflang을 만들지 않는다.
- 핵심 설명·표·5문제·해설은 서버 HTML이며 `<details>`는 JavaScript 없이 열 수 있다. 존재하지 않는 영어판과 미등록 slug는 404여야 한다.

## 검증·배포

`web`에서 필수 전체 검증 `npm run check:local`과 같은 Windows 명령 `npm.cmd run check:local`을 실행했다. 타입체크와 린트, 35개 파일의 단위 테스트 180개, Next.js 프로덕션 빌드, 브라우저 테스트 86개가 통과했다. 격리 PostgreSQL/Auth fixture가 없어 의존 테스트 13개는 명시적으로 제외됐으므로 실제 DB/Auth 흐름을 검증한 결과가 아니다. 수익화 시나리오 6개도 통과했고 실제 외부 네트워크 요청은 0이었다.

기존의 별도 로컬 Next 서버가 3100 포트를 사용하고 있어 그 프로세스는 건드리지 않았다. 검증 중에만 로컬 전용 포트를 3110으로 기계적으로 바꿔 동일한 전체 명령을 실행한 뒤 모든 포트 문자열을 3100으로 원복했다. 새 글 E2E는 제목·H1·설명·로컬 noindex/canonical 비노출 경계·BlogPosting·주요 내부 링크·무자바스크립트·fixture 문제 채점을 확인했다. 390/1280 px 미리보기와 라이트·다크 접근성 검사에서 오버플로, 런타임 오류, Axe 위반은 0이었다. 운영 사이트에는 전체 회귀·접근성·크롤링·스크린샷·부하 검사를 실행하지 않는다.

커밋·Vercel 배포 ID·운영 스모크 결과는 Git 배포 완료 후 별도 2026-11-05 릴리스 기록에 남긴다.

## 성과 측정과 다음 세션

- GSC: 새 URL과 `3d프린터운용기능사 필기`, `3d프린터 레이어 높이`, `서포트 인필 차이`, `3d프린터 층수 계산` 질문군의 클릭·노출·순위·기기를 본다. 새 글과 기존 시험 페이지의 의도 이동도 함께 확인한다.
- GA4: 동의된 새 글 landing 세션에서 같은 사용자 흐름의 `practice_start` → `answer_submit` → `explanation_open` → `practice_complete`를 본다. `/api/exams/click`이나 CTA 클릭만으로 문제풀이가 발생했다고 판단하지 않는다.
- 배포 후 첫 28일은 색인·초기 관찰, 다음 28일과 비교하되 8~12주까지 시험 일정·계절성·순위·기기 변동을 고려한다. 검색 증가를 보장하지 않는다.
- 다음 글 후보: 현행 문항과 출제기준을 보강한 양식조리기능사 개념 드릴, 또는 실제 landing별 practice 퍼널이 확인되는 Ontario G1/ServSafe/California DMV 중 하나.
- 추가 자료: 최신 GSC 국가×쿼리×페이지, 글 landing별 실제 practice 이벤트, 개인정보를 제외한 시험별 개념 오답 집계.
