# SQLD NOT IN·NULL 원본 학습 글 검수

- 상태: 독립 내용 검수·최종 전체 로컬 검사 통과한 로컬 초안. 이번 요청은 게시/push/운영 변경을 허용하지 않는다. 최종 파일 해시와 승인 영수증은 비공개에 보존한다.
- 글: [본문](../../web/src/components/SqldNotInArticle.tsx), 예정 경로 `/blog/sqld-not-in-null-not-exists`.
- 대상: 한국어 SQLD 학습자. 현재 보고서의 한국어 SQLD CBT 검색어와 별도 연습 페이지 근거를 사용한다. 국가 필터 없는 2026-08-24~11-23 자료이며 국가×시험·좁은 NOT IN 검색 수요·동일 방문 전환은 미측정이다. 과거 한국 필터 근거는 당시 검증 기록이고 오늘 원본 재조회로 표시하지 않는다.
- 기존 COUNT·LEFT JOIN·WHERE/HAVING·UNION 글과 비교해 제외 목록의 NULL·상관 조건·왼쪽 NULL/빈 서브쿼리 경계를 선택했다. 원본 수치와 출처 식별자는 비공개 연구 기록에 둔다.
- 실제 연습 연결: `/sqlp-developer?verNbr=202611`, SQLD 2026-11 원본 연습 20문항. 글 안 세 문제는 회차 등록과 구분하며 기존 문항·정답·점수를 바꾸지 않는다. 실제 로컬 시험명/보기/채점 readback은 최종 결과에서 확인한다.

## 공식 원문과 범위

2026-11-24 작성자와 별도 조사자가 원문을 읽었다. 단일 숫자 비교에 한정하며 아래 PostgreSQL 예제는 격리 로컬 DB로 실행 검증한다. Oracle 엔진 실행·DB별 성능 우위·여러 열 비교·빈 문자열 특성은 주장하지 않는다.

- [PostgreSQL 18 Subquery Expressions](https://www.postgresql.org/docs/18/functions-subquery.html): EXISTS의 행 존재와 상관 참조, NOT IN의 FALSE/UNKNOWN·빈 서브쿼리.
- [PostgreSQL 18 WHERE](https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-WHERE): TRUE인 행만 유지.
- [Oracle IN Condition](https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/IN-Condition.html): NULL 포함 NOT IN과 빈 서브쿼리의 차이. 요약표보다 FALSE 또는 UNKNOWN을 구분한 본문으로 대조.

## 문항별 기록

공통: SQLD/시험 코드5/202611/한국어, SQL 조건·서브쿼리, Quizeey 원본 확인 문제, revision `20261124-not-in-v1`. 작성 PO/root, 원천 조사/문항 제안 `content_research_20261124`, 최종 검수자는 작성에 참여하지 않은 별도 담당이다. 기존 글·회차와 완전 동일 문제를 새로 등록하지 않는다.

| 문제/난도 | 정답 | 근거와 모든 오답 이유 |
| --- | --- | --- |
| 1 NULL 포함 제외 목록/기초 | 2 | 101은 FALSE, 102/103은 UNKNOWN으로 0행. 1은 NULL 자동 제거를 가정, 3은 NULL 행과 빈 표를 혼동 |
| 2 오른쪽 NULL 제거/기초 | 1 | 비NULL 지원 코드에서 102/103이 남음. 2는 서브쿼리 필터를 무시, 3은 IN/NOT IN 방향 반전 |
| 3 상관 NOT EXISTS/중급 | 3 | 같은 코드의 행이 없음. 1은 표 전체 비었는지 검사, 2는 일치하는 101을 선택 |

왼쪽 NULL에서는 필터 NOT IN과 상관 NOT EXISTS가 다름을 명시한다. NULL 한 행과 0행도 구분하며 ORDER BY가 있는 결과만 순서로 제시한다. 원본 CTE와 경계 검증은 비공개 실행 영수증에 보존한다.

## 검증·출시·관측

- 예정 검증: 원본 SQL·진리값/빈 표/왼쪽 NULL 경계의 격리 PostgreSQL 실행, JS 없는 목록→글/해설→실제 연습, 390px 양 테마·접근성·채점, 전체 `npm run check:local`의 DB/Auth 포함 결과.
- 게시/운영 미반영이며 승인 필요. 최종 내용·코드 해시와 독립 검수 및 실제 검사 결과는 [오늘 일지](../quizeey-ops/journal/2026-11-24.md)를 따른다. 복구는 이번 글/등록/회귀의 로컬 변경 범위다.
- 효과 미측정. 향후 승인된 운영 확인 다음 날부터 완결28일 GSC 글/검색어와 GA4 SQLD 학습 시작을 별도 관측한다. 시간대·수신/시험 차원·확정 기준 전에는 전환율이나 인과 효과를 계산하지 않는다.

로컬 사전 검증: 실제 SQLD 시험명·11월 20문항·첫 보기·정답 제출/해설을 브라우저에서 확인했다. 본문에서 추출한 세 SQL 형태와 비상관·왼쪽 NULL·빈 서브쿼리 경계까지 격리 PostgreSQL 17에서 아홉 쿼리를 실행해 기대 결과와 일치했다. 진리값은 FALSE/UNKNOWN/UNKNOWN과 빈 오른쪽의 왼쪽 NULL=TRUE를 대조했다. 별도 검수자가 공식 원문·세 정답/모든 오답·실제 SQL/브라우저 영수증을 확인했고 최종 전체 검사 결과를 대기한다. Oracle 엔진은 실행하지 않았다.

최종 모바일 사전 확인: 전역 스타일로 숨겨진 보기 번호를 새 글의 세 목록에만 보완했다. 최종 빌드의 밝은/어두운 390px 캡처·목록 번호의 계산된 스타일·페이지 폭을 대조했고 기존 문항/SQL/정답은 불변이다. 실제 SQLD 11월 NOT IN 문항으로 이동해 채점/해설도 확인했다. 중단한 이전 전체 검사와 최종 진행 중인 검사를 합쳐 성공으로 표시하지 않는다.

최종 검증 결과: 최종 코드의 전체 `npm run check:local` 한 회차가 종료0으로 타입·lint·단위190/38파일·빌드·브라우저153·모의 광고6을 모두 통과했다. 격리 DB/Auth를 포함했고 테스트 생략0, 실제 외부 광고 요청0이다. JS 없는 새 글→실제 연습·모바일 양 테마/접근성·채점도 이 전체 회차에서 통과했다. fixture 모드의 운영 자격증명 preflight 생략은 테스트 생략과 구분한다. 중단 실행·개별 진단의 통과를 합산하지 않았다. 생성된 기존 미리보기/모의 광고 산출물은 검증 증거를 비공개에 보존한 뒤 작업 변경에서 제외했다. 게시·운영 반영과 효과 관측은 미실행이다.
