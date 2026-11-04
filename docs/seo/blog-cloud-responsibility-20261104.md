# 세 번째 블로그: IaaS·PaaS·SaaS 공유 책임 연습

조사·작성일 2026-11-04. 두 사이트 각각 한 편 요청에 따른 Quizeey 글이다. 기존 SQLD·서브넷 글의 URL·발행일 유지.

## 선택과 실제 기능

- `/en/blog/iaas-paas-saas-shared-responsibility` — **IaaS vs PaaS vs SaaS: Shared Responsibility Practice**
- 영어, 미국의 IT 전환 학습자·AZ-900 입문자를 우선 가설로 설정하고 영국 직무교육 학습자 및 캐나다 IT 학생을 검토했다. 한국의 기존 검색 중심 외에 미국·영국 두 시장을 명시적으로 검토했다. 국가별 전환 우위를 확인한 선택은 아니다.
- 신규 수요 실험. 직전 캐나다 서브넷 글과 다른 개념을 실제로 푸는 글이며, 기존 AWS/Azure 가이드의 시험 선택·공부 계획과도 구분한다.
- 첫 문단에서 작업을 특정하고 서비스 모델을 판단하도록 답한다. 책임 비교표, 3단계 판단 방법, 가상의 예약 서비스 세 사례, 접었다 펼치는 해설, 오답 원인별 복습 방법을 제공한다. 공식 출제 문제·실제 고객 사례로 표시하지 않는다.
- CTA `/en/az-900`. `web/src/data/practice-2026-10.json`에 examId 170용 자체 제작 그룹 `azure` 3, `top10-en-azure` 20, `az900-depth-cloud-concepts` 23, `az900-depth-architecture-services` 22, `az900-depth-management-governance` 25 문항이 있다. 책임 분담과 세 모델 문항을 직접 확인했다. 총계가 배포의 모든 버전 문항 수라는 주장은 하지 않는다.
- 링크는 현재 영어 AZ-900 세트로 연결하며 본문의 3문항만 필터링하거나 전 범위 공식 모의고사라고 주장하지 않는다. 실제 문제 표시→답 선택→해설 확인 동선을 검증한다.

## 데이터

최신 제공 GSC는 `docs/report/google_search_console_report_20261102`, 2026-08-01~10-31 웹 검색. 더 최신 내보내기나 실시간 GSC/GA4 도구 없음. 동일 데이터의 총계는 [직전 분석](blog-expansion-20261102.md)에서 이어받고 원본 검색어·국가·기기를 재확인했다. [이번 기록](blog-research-20261104.json)은 독립 집계를 보존한다.

| 항목 | 클릭 | 노출 | CTR | 평균 순위 |
| --- | ---: | ---: | ---: | ---: |
| 전체 | 3,501 | 25,239 | 13.87% | 약 7.91 |
| 10/04~10/31 | 1,022 | 6,529 | 15.65% | 약 7.41 |
| 09/06~10/03 | 950 | 6,921 | 13.73% | 약 7.51 |
| 한국 | 3,465 | 24,101 | 14.38% | 7.15 |
| 미국 | 3 | 452 | 0.66% | 17.79 |
| 캐나다 | 6 | 68 | 8.82% | 30.69 |

데스크톱 1,888/14,241, 모바일 1,352/9,688, 태블릿 261/1,310(클릭/노출). 평균 순위는 일별 노출 가중 근사값이다. GSC 국가와 쿼리를 결합하지 않았다. 미국 노출이 클라우드 질문이라는 의미가 아니다.

`quizeey` 35클릭/51노출/1.10위는 명시 브랜드. `sqld 기출문제 cbt` 24/1,215/7.72위는 도구 의도이며 첫 글과 기존 문제 페이지가 이미 대응한다. `양식조리기능사 필기 기출문제` 279/524/2.06위, `3d프린터운용기능사 필기 cbt` 27/314/7.11위는 기존 고객 기회다. 신규 영어 주제는 이 검색량을 가져온다는 가정으로 고르지 않았다.

이번 원본 문자열 검사에서 iaas/paas/saas/shared responsibility/subnet/az-900/dns는 발견되지 않았다. azure 관련 두 행은 `azure 301` 0클릭/3노출/47위 및 긴 Azure Functions 선택 질문 0/1/11위다. 이를 공유 책임 수요 실적으로 합치지 않는다. 검색어 누락은 전체 수요 부재가 아니다.

기존 GA4 스냅샷 2026-09-26~10-23은 새 글 발행 전이며 글별 문제 응답 퍼널이 없다. 기존 1,222 활성 사용자·38,310 이벤트로 새 글 전환율을 만들지 않았다.

## 여섯 후보

각 확인일 2026-11-04. 4~6은 내보내기 밖의 수요다.

| 후보·질문 | 독자·국가·언어 / 구분 | 근거·검색 의도·보완할 부분 | 실제 연결·판단·불확실성 |
| --- | --- | --- | --- |
| 1. SQLD CBT 복습 | 한국 SQLD 수험생, 한국어 / 기존 | 24/1,215/7.72위. 도구 탐색·공부법 혼재 | `/sqlp-developer`·기존 첫 글. 중복 제외. 쿼리×페이지로 기존 랜딩 개선 검토 |
| 2. 양식 필기 개념 복습 | 한국 조리 수험생, 한국어 / 기존 | 279/524/2.06위. 이미 유입·기능 적합성 높음 | `/craftsman-cook-western-food`. 구체적 오답 단원 및 현행 출제기준 자료가 있어야 독자적인 글 가능 |
| 3. 3D프린터 필기 개념별 실수 | 한국 직업교육 학생, 한국어 / 기존 | 대표 CBT 27/314/7.11위. 단순 전체 공부법보다 한 개념 실습 필요 | `/craftsman-3D-printer-operation`. 다음 후보. 보유 문제와 현행 기준 대조 우선 |
| 4. IaaS/PaaS/SaaS shared responsibility | 미국·영국 AZ-900 입문자, 영어 / 신규·선정 | Microsoft 현행 학습 범위, 책임 매트릭스, 영국 NCSC, 실제 보유 문항. 정의를 구체적 작업으로 적용하는 의도 | `/en/az-900`. 세 가상 사례와 답의 근거→실제 응답. 적합성 높음, 국가별 검색량·전환 미확인 |
| 5. IPv4 network/broadcast/host range | 캐나다·미국 네트워크 학생, 영어 / 신규 수요의 기존 콘텐츠 | 공식 교육·기술 출처는 직전 보고서에 있음. 이미 11/02 글이 같은 문제를 해결 | `/en/blog/ipv4-subnetting-practice`→Network+. 새 글 제외, 이번 글과 상호 링크. 성과 관찰 기간 부족 |
| 6. cloud provider vs customer security in AWS | 미국·영국 AWS 입문자, 영어 / 신규 | AWS 공식 공유 책임 자료에 EC2 guest OS와 서비스별 책임 구분 | `/en/aws-certified-cloud-practitioner`. 이번 글과 공통 개념이 많이 겹쳐 별도 글 보류. 서비스별 사례·보유 문항·사용자 오답 근거 확보 후 재검토 |

선택 국가에서는 영어 UI와 영어 자체 제작 문항을 그대로 사용할 수 있다. 국가별 교육과정·자격 인정·가격·시험 일정을 동일시하지 않고 AZ-900 공통 개념만 다룬다. 영국 NCSC는 실제 작업 책임을 설명하는 근거, 미국 NIST는 모델 구분 근거다. 현지 검색 규모 근거로 사용하지 않았다. 직전 영어 글에 이어 영어가 선택됐지만 3개 한국어 후보를 함께 검토했으며, 이후에는 조리/제조 개념별 오답 자료를 얻어 시장 편중을 다시 평가한다.

## 출처·경쟁·한계

- [Microsoft AZ-900 study guide](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-900): 현재 범위에 공유 책임·서비스 모델 포함.
- [Microsoft shared responsibility](https://learn.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility): Azure 책임 경계. applications/network controls를 무조건 한 주체로 단정하지 않았다.
- [UK NCSC shared responsibility](https://www.ncsc.gov.uk/collection/cloud/understanding-cloud-services/cloud-security-shared-responsibility-model): 서비스 구현별 차이.
- [AWS shared responsibility](https://aws.amazon.com/compliance/shared-responsibility-model/): guest OS/인프라 구분과 서비스별 책임 차이.
- [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final): 서비스 모델과 배포 모델 구분.
- 웹 검색 `IaaS PaaS SaaS practice questions responsibility`에서 [ITPracticeExams](https://itpracticeexams.com/kb/az-900/shared-responsibility-model-explained/), [CertSharp](https://www.certsharp.com/micro-quizzes/shared-responsibility), [SaveMyCert](https://www.savemycert.com/revision/azure-fundamentals/iaas-paas-saas-azure/)를 발견했다. 표와 연습문제를 제공하는 경쟁 결과가 이미 있어, 정보 공백이나 낮은 경쟁을 단정하지 않는다. 사실 확인에는 공식 출처만 사용했다. 독자적인 한 조직의 예약 시스템 선택 사례를 작성해 기존 제목·구조를 복제하지 않았다.
- Google 국가별 SERP 화면·자동완성·PAA 직접 확인 없음. 대체 웹 검색과 공식 자료 사용. Trends·Keyword Planner·검색량·예상 트래픽·전환율 데이터 없음. 영어 신규 시장은 검증할 가설이다.

## 구현·검증·배포

글 레지스트리에 추가해 언어별 라우트, 목록, canonical, Open Graph/Twitter, BlogPosting/Breadcrumb, sitemap에 반영한다. 실제 영어판만 존재하며 한국어 대체 URL은 404다. 영어 홈·AZ-900 문제 페이지·AWS/Azure 가이드·기존 서브넷 글에서 새 글로 연결했다. 새 글→AZ-900, 기존 가이드·서브넷 글. 내부 UTM 없음.

사전 운영 확인: production READY `dpl_Gq12PFqttRB1hu3c6XQKQMREsqfs`, master `a308f7687b900c89aeee502ec4c1c964d6810fca`, quizeey.com 별칭. 첫 SQLD·서브넷 글이 포함된 운영 커밋이다. 새 변경 배포는 로컬 검사 완료 후 한 번의 Git 배포로 진행한다.

필수 검증은 `web`의 `npm run check:local`. fixture 콘텐츠 사용, 자동 로딩 운영 환경 파일 없음. DB/Auth fixtures가 없으므로 해당 검사는 제외되고 명시적으로 skip된다. 검증 결과와 배포 ID는 완료 후 기록한다. 운영 사이트에 회귀·접근성·스크린샷·부하 검사하지 않는다.

### 완료한 로컬 검증

- `npm run check:local` 실행: TypeScript·전체 ESLint·단위 테스트 179건/35파일·production fixture build 통과. 브라우저 최초 실행 98개 중 84통과, DB/Auth fixture 의존 13제외, 기존 테스트 1실패.
- 실패는 기존 `practice-session.spec.ts`가 저장한 `innerText`와 기본 `textContent`를 비교하여 표가 있는 문제의 줄바꿈에서 발생했다. 실제 복원 문항은 동일했다. `useInnerText: true` 한 줄로 비교 기준을 맞췄다. 제품 학습 로직은 수정하지 않았다.
- 수정 후 `npm run test:e2e:local -- e2e/practice-session.spec.ts`: 빌드·TypeScript 재확인 및 해당 테스트 묶음 6/6통과. 수정 테스트 ESLint 통과. 따라서 실행 가능한 브라우저 85개는 최초 실행 또는 수정 후 재실행에서 모두 통과했다. 전체 98개를 수정 후 다시 실행했다고 보고하지 않는다.
- 최초 실패로 check:local이 도달하지 못한 `node tools/modernization/test_monetization.mjs`도 별도 완료: 6개 시나리오 통과, 실제 네트워크 요청 0.
- 새 블로그 테스트: 영어 홈/관련 가이드/목록→글→AZ-900→답 제출→해설 표시, 390/1280px·overflow 없음, no-JavaScript 본문·해설, 존재하지 않는 언어판 404, canonical·schema·sitemap 단위 검사 통과. 모바일 light/dark axe 위반 0, 새 흐름 pageerror 0.
- 미리보기: [모바일](previews/cloud-responsibility-390.png), [데스크톱](previews/cloud-responsibility-1280.png). 실제 DB/Auth·운영 GA4 수집은 검증하지 않았다. 실행이 갱신한 기존 스크린샷·Next 생성 타입·이전 monetization 기록은 초기 상태로 복원해 이번 변경 범위를 유지했다.
- 발행 메타데이터 2026-11-04. 배포 완료·커밋·새 경로 읽기 확인 결과는 별도 `blog-release-20261104.json`에 기록한다. 해당 기록 없이 새 글 배포를 추정하지 않는다.

## 측정·인계

GSC 새 URL과 iaas/paas/saas/shared responsibility/cloud responsibility 질문군, 국가·기기·순위를 관찰한다. 기존 Azure 문제 페이지·AWS/Azure 가이드와 의도 이동도 함께 본다. 별도 집계를 결합하지 않는다.

동의 기반 기존 GA4의 글 landing 세션→`practice_start`→`answer_submit`→`explanation_open`/`practice_complete`를 구분한다. `ExamLink`의 `/api/exams/click`만으로 문제풀이 발생을 판단하지 않는다. 로컬에서는 실제 fixture 답 선택·해설 표시까지 검사하되 운영 GA4 수집과 실제 방문자 전환은 검증하지 않는다.

배포 후 첫 28일 색인·유입을 관찰하고 다음 28일과 비교하되 8~12주 충분한 기간, 시험 범위 갱신·국가·기기·순위 변화를 고려한다. 증가 보장 없음. 다음 자료: 최신 GSC 국가×질문×페이지, 새 landing별 응답 퍼널, 한국어 조리/제조의 개념별 오답 집계. 민감한 사용자 원문 불필요.
