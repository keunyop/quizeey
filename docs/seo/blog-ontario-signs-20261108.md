# 2026-11-08 블로그: Ontario G1 도로표지 연습

## 선정과 구현
- 제목: Ontario G1 Road Signs: Shapes, Colours and 5 Practice Questions
- URL: /en/blog/ontario-g1-road-signs-shapes-colours
- 타깃: 캐나다 Ontario의 영어 G1 학습자, 다른 나라에서 운전을 배운 신규 이주 학습자. 영어, 캐나다식 colours/practise 표기.
- 구분: **신규 질문군 실험**. G1 도로표지 모양·색상·행동 설명을 외부 조사에서 발굴했다. 기존 내보내기에 인접한 일반 쿼리 `g1 mock test free` 0클릭/1노출/71위가 있었다. G1 전체 노출이 0이라고 말하지 않는다.
- 실제 제품: /en/ontario-g1, 카탈로그 ID 250, 2026-10 자체 제작 영어 30문항. 실제 데이터에 STOP·YIELD·temporary-condition 텍스트 문항과 해설이 있다. 공식 시험·전체 두 섹션 모의고사·도로표지 이미지 문제은행으로 홍보하지 않는다.
- 독자 가치: 첫 문단의 판별 순서, 직접 만든 SVG 표지 도식 4개(공식 도안 아님), HTML 비교표, 3단계 복습 도식, 가상 5문제와 접는 해설, 오답 메모. 무료 풀이 조건은 현재 카탈로그·익명 fixture 문제풀이 코드에서 확인.
- 기존 글 4편(SQLD, subnetting, cloud responsibility, 3D printer)을 유지한다. 이전에 영어 IT 글 2편과 한국어 글 2편을 발행했으므로 이번에는 다른 고객군을 시험한다.

## 원본 데이터와 해석
조사일 2026-11-08. 최신 제공 자료는 [GSC 20261102](../report/google_search_console_report_20261102/), 웹 검색 2026-08-01~10-31. 더 최신 저장소 보고서와 사용 가능한 GSC/GA4 연결 도구는 발견되지 않았다. 재계산 근거는 [연구 데이터](blog-research-20261108.json). 일별 순위는 노출 가중 근삿값이다.

| 기간 | 클릭 | 노출 | CTR | 평균 순위 |
| --- | ---: | ---: | ---: | ---: |
| 전체 | 3,501 | 25,239 | 13.87% | 7.91 |
| 최근 28일 10/04~10/31 | 1,022 | 6,529 | 15.65% | 7.41 |
| 이전 28일 09/06~10/03 | 950 | 6,921 | 13.73% | 7.51 |

최근 구간 클릭은 72 증가했지만 노출은 392 감소했다. 새 블로그들은 이 기간 뒤 발행됐으므로 그 효과로 해석할 수 없다.
한국 3,465클릭/24,101노출/7.15위, 미국 3/452/17.79위, 캐나다 6/68/30.69위. 데스크톱 1,888/14,241/13.26%/9.28위, 모바일 1,352/9,688/13.96%/6.18위, 태블릿 261/1,310/19.92%/5.94위.
국가·기기·검색어·페이지는 독립 집계이며 임의로 조인하지 않았다. 캐나다의 6클릭을 G1 유입이라고 해석하지 않는다.
명시 브랜드 `quizeey`는 35/51/68.63%/1.10위. 일반 시험 검색과 구분한다. 브랜드 표기 변형 전체를 포괄한 수치는 아니다.

기존 GA4 스냅샷 09/26~10/23: 양식조리 페이지 961조회/413활성 사용자, SQLD 215/137. 이는 페이지 이용 근거이며 블로그→정답 제출 퍼널이 아니다. GSC와 기간이 달라 나누어 전환율을 만들지 않는다.

## 후보 6개 비교
모든 출처 확인일은 2026-11-08. 4~6의 구체적인 질문군은 GSC 실적 밖의 공개 자료에서 발굴했다. 일반 G1 인접 노출 1건은 위에 따로 밝혔다.

| 후보·키워드 | 고객·국가·언어 / 구분 | 근거·검색 의도·결과의 부족한 점 | 제품 연결·판단·확실성 |
| --- | --- | --- | --- |
| 1. 양식조리기능사 필기 개념 복습 | 한국 조리 수험생·한국어 / 기존 | 대표 검색 279클릭/524노출/2.06위; 실제 GA4 이용 강함. 기출 암기에서 개념 설명으로 연결 가능 | /craftsman-cook-western-food. 검색 근거 강함. 현행 범위와 검증 가능한 fixture 문항 보강이 먼저. 식품안전 규칙을 타국 기준과 혼합하지 않음 |
| 2. SQLD CBT COUNT·NULL·오답 복습 | 한국 SQLD 수험생·한국어 / 기존 | `sqld 기출문제 cbt` 24/1,215/1.98%/7.72위. 낮은 CTR이지만 첫 글이 이미 COUNT와 복습을 설명 | /sqlp-developer 및 기존 글. 새 글 중복보다 검색어×페이지·발행 후 자료로 제목·설명·내용 적합성 확인을 우선 |
| 3. 3D프린터 필기 설정 판단 | 한국 직업교육 학습자·한국어 / 기존 | `3d프린터운용기능사 필기 cbt` 27/314/8.60%/7.11위. 11/05 글이 레이어·서포트·인필에 이미 답함 | /craftsman-3D-printer-operation. 새 글 대신 관찰. 동일 질문의 낮은 CTR만으로 추가하지 않음 |
| 4. Ontario G1 road signs shapes / colours / stop vs yield | 캐나다 Ontario 신규 운전자·영어 / 신규·선정 | Google CA에서 공식 MTO, 운전학원, 다수 무료 연습과 영상 확인. 관련 검색에 road signs practice test Ontario, G1 signs test Ontario, road signs Ontario PDF. 그림 식별을 실제 행동으로 설명하는 짧은 연습을 제공 | /en/ontario-g1. 공식 규칙·실제 영어 문항 근거 높음. 경쟁 강함. 국가별 검색량·전환 미확인. 전체 시험을 대체하지 않음 |
| 5. ServSafe cross-contamination scenarios | 미국 식품서비스 입문자·영어 / 신규 | 공식 ServSafe food handler 자료가 교차오염을 다룸. 공개 검색에서 공식·상업 연습 결과 확인. 구체 상황에서 예방 조치를 고르는 의도 | /en/servsafe-food-handler, 실제 자체 제작 60문항. 제품 적합성 높지만 광고경쟁도·검색량 자료 없음. 음식 안전과 현행 범위 갱신 부담을 고려해 후속 후보 |
| 6. California DMV warning signs | 미국 California learner permit 학습자·영어 / 신규 | California DMV Handbook §7와 Caltrans 표지 자료 확인. Ontario와 같은 영어라도 주별 규칙·색상 용어·시험명이 다름 | /en/california-dmv-permit, 자체 제작 30문항. 공식 근거 높음, 검색 경쟁·전환 수치 없음. Ontario 글을 이름만 바꿔 재발행하지 말고 독립 질문 확인 후 선택 |

한국 밖 캐나다와 미국을 검토했다. 신규 고객군은 IT 자격 학습자가 아닌 운전면허 입문자와 식품서비스 종사자다. Ontario G1은 캐나다 전체 면허시험이 아니며 다른 주·국가에 적용한다고 안내하지 않는다. 영어 제품·문항이 이미 존재해 제품 번역이나 외부 서비스 추가 없이 실험할 수 있다. 운전면허는 학기형 시험 일정과 다르므로 특정 시험 시즌의 트래픽을 가정하지 않는다.

## 공개 근거와 한계
- [Ontario MTO Signs](https://www.ontario.ca/document/official-mto-drivers-handbook/signs): 브라우저에서 직접 원문 확인. 검색 도구의 최초 403은 브라우저 읽기로 보완했다. 도형·색·기호·행동과 공식 일러스트의 1차 근거.
- [California DMV §7](https://www.dmv.ca.gov/portal/handbook/california-driver-handbook/laws-and-rules-of-the-road/), [Caltrans sign charts](https://dot.ca.gov/programs/safety-programs/sign-charts): 미국 후보의 현지 범위.
- [ServSafe cross-contamination](https://www.servsafe.com/downloads/demos/fh/foodhandler): 식품안전 후보의 공식 범위.
- Google 직접 확인: `Ontario G1 road signs shapes colours practice`, hl=en, gl=ca. 결과에 공식 MTO, 운전학원 설명, 연습 사이트와 영상이 있다. 모든 경쟁 결과가 부족하다고 주장하지 않는다. 차별점은 짧은 시각 비교→행동 설명→실제 학습 흐름이다.
- [공개 Ontario 학습자 질문](https://www.reddit.com/r/Ontariodrivetest/comments/10i3ydg): 표지 조건과 give-way 해석 혼동을 발견하는 용도에만 사용. 도로 규칙 근거는 공식 handbook.
- Google은 한 시점·한 설정의 표본이다. 전체 자동완성/PAA, Trends 시계열, Keyword Planner 및 검증 가능한 국가별 검색량 자료는 확보하지 못했다. 검색량·예상 유입·전환율을 추정하지 않는다.

## 내부 링크와 SEO
/en 홈, /en/ontario-g1, 기존 subnetting 글, /blog 및 /en/blog에서 새 글로 연결한다. 새 글은 /en/ontario-g1, subnetting 글, 공식 handbook으로 연결한다. 내부 UTM 없음.
레지스트리 기반 URL·title·description·canonical·OG/Twitter·BlogPosting/Breadcrumb·sitemap을 재사용했다. 게시·수정일은 2026-11-08로 고정. 기존 게시일과 URL은 유지했다. /blog 목록은 영어 글도 보여주므로 두 목록의 sitemap 수정일은 실제 표시 콘텐츠에 맞춰 11/08로 갱신한다. 존재하지 않는 한국어 번역이나 hreflang을 만들지 않는다.
기존 /blog/sqld-cbt-study-guide는 11/08 운영 페이지에서 제목·본문·2026-11-02 게시일을 직접 확인했다. 과거 추가 글 배포 기록도 읽었으며 추정으로 새 글 배포를 완료 처리하지 않는다.

## 로컬 검증·배포
검증 명령: web에서 npm run dev:local, npm run check:local. 운영 dotenv를 로딩하지 않는 기존 격리 실행기를 사용한다.
결과는 작업 완료 시 아래에 보완하고, 커밋·배포 ID·운영 최소 읽기 확인은 별도 blog-release-20261108.json에 저장한다. 해당 기록 전에는 새 글 배포를 완료로 보지 않는다.

## 측정과 인계
- GSC: 새 URL 및 ontario g1 road signs, sign shapes/colours, stop vs yield 질문군을 페이지·질문별로 추적. 기존 /en/ontario-g1과 검색 의도 이동도 확인. 국가별 쿼리는 결합된 원본이 있을 때만 해석.
- GA4: 해당 글 landing 세션에서 practice_start → answer_submit → explanation_open을 우선. CTA나 /api/exams/click만으로 실제 문제풀이 성공이라고 하지 않는다. 현재 GA4 스냅샷에는 이 퍼널이 없다.
- 발행 후 첫 28일은 색인·초기 관찰, 다음 28일과 비교. 8~12주까지 노출·순위·기기·지역·계절성 변화를 같이 본다. 0 또는 작은 분모의 전환율은 과잉 해석하지 않는다.
- 다음 우선 후보: 최신 출제기준과 검증용 문항을 확보한 양식조리 개념 드릴, 미국 ServSafe 상황 연습, 독립적으로 검증한 California 표지 사례.
- 필요한 자료: 최신 GSC 페이지×질문×국가, 글 landing별 실제 풀이 이벤트, 시험별 익명 오답 유형. 자료 부족은 수요 부재가 아니다.


## 최종 검증과 동시 작업 보존
- npm run dev:local로 새 페이지를 확인했고, 최종 격리 worktree의 web에서 npm run check:local(Windows npm.cmd)을 완료했다. 타입 검사·ESLint·단위 테스트 180개/35파일·기본 Next.js production build·브라우저 87개·수익화 시나리오 6개 통과. 실제 외부 네트워크 요청 0건.
- 격리 PostgreSQL/Auth fixture가 없어 의존 테스트 13개 제외. 실제 DB/Auth 및 운영 분석 수집을 검증한 결과가 아니다.
- 새 글의 서버 HTML, title/description, BlogPosting, 390/1280px, 라이트/다크 Axe 위반 0, JS 없는 본문/해설, 영어 페이지·목록·문제풀이 간 이동, 정답 제출, 미등록 글과 없는 한국어판 404 확인. page error 0.
- 미리보기: [모바일](previews/ontario-signs-390.png), [데스크톱](previews/ontario-signs-1280.png).
- 초기 공유 작업 폴더에서 검증 도중 다른 작업의 2026-11 문항·학습 기능 변경이 나타났다. 이를 수정·커밋하지 않고 572e9d3 기반 격리 worktree로 블로그 변경만 옮겼다. RouteView는 파일 전체를 복사하지 않고 이번 discovery 변경 세 곳만 재적용했다.
- 격리 실행 중에만 포트 3110 및 Turbopack의 로컬 의존성 탐색 root를 사용했다. 관련 테스트의 포트 단언도 맞춘 뒤 전체 검증을 다시 실행했고, 모든 임시 설정은 커밋 전에 원복한다.
- 기존 ServSafe Manager 90문항 시나리오는 기본 60초 한도에서 시간 초과가 있어 다른 긴 시험 여정과 같이 120초로 맞췄다. 검사 내용은 유지했으며 최종 실행은 약 44초에 통과했다.
- Windows fixture 서버가 모든 검사가 끝난 뒤 종료 대기해 이번 실행의 서버 PID만 종료했다. 이후 필수 workflow가 브라우저 87통과/13제외를 출력하고 수익화 6개까지 완료하여 exit 0으로 종료했다. 운영 서버는 건드리지 않았다.
- 원래 작업 폴더의 진행 중 변경은 그대로 유지한다. 이번 배포 커밋과 원격 master를 기준으로 다음 개발을 이어가되, 진행 중 문항 변경을 자동으로 덮어쓰거나 일괄 커밋하지 않는다.
