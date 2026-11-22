# SQLD UNION·UNION ALL 원본 학습 콘텐츠 검수

- 작성/확인일: 2026-11-21. 콘텐츠 revision: `sqld-union-v1`.
- 시험/언어: SQLD / 한국어. 집합 연산·전체 선택 행·NULL 기초. 실행 예제는 PostgreSQL 18이며 공식 기출이나 특정 SQLD 시험 버전의 전체 범위가 아니다.
- 작성자: primary PO/Engineering. 독립 검수자: 별도 Content `content_research`. 최종 검수 상태와 실행/출시 결과는 [당일 일지](../quizeey-ops/journal/2026-11-21.md)를 따른다.
- [본문](../../web/src/components/SqldUnionArticle.tsx)에 세 원본 문항·보기·정답·해설·모든 오답 이유를 보존한다. 블로그 확인 문제이며 기존 연습 DB에 새 검수 필드를 추가한 것으로 해석하지 않는다.

| 항목 | 영역/난이도 | 정답 집합 | 근거와 오답 구분 |
| --- | --- | --- | --- |
| 1. 두 열의 UNION/UNION ALL 행 수 | 전체 행 중복/기초 | 2 | 3행/6행. 2행은 회원 번호만 비교한 오류, 6행/6행은 중복 제거 누락 |
| 2. 중복 발생 이력 보존 | 중복·정렬/기초 | 1 | ALL과 명시적 정렬 구분. UNION은 발생 횟수를 줄일 수 있고 ALL도 입력 순서를 보장하지 않음 |
| 3. ALL 이후 NULL 채널 필터 | NULL 판단/기초 | 3 | IS NULL 3행. 1행은 UNION과 혼동, 0행은 NULL 자동 삭제를 가정한 오류 |

공식 근거(2026-11-21): [Combining Queries](https://www.postgresql.org/docs/18/queries-union.html), [Select Lists: DISTINCT](https://www.postgresql.org/docs/18/queries-select-lists.html#QUERIES-DISTINCT), [Comparison Functions](https://www.postgresql.org/docs/18/functions-comparison.html), [Sorting Rows](https://www.postgresql.org/docs/18/queries-order.html). 작성자와 별도 검수자가 원문을 각각 직접 확인한다. 중복 제거의 NULL 취급과 일반 등호 조건, 열 수/자료형 호환, ORDER BY 없는 순서, 방언/성능 범위를 구분한다.

본문 SQL을 실제 컴포넌트 문자열에서 추출해 격리 PostgreSQL 18의 CTE/SELECT로 실행했다. 전체 두 열 UNION 3행·ALL 6행·회원 번호만 UNION 2행, ALL 후 IS NULL 3행·UNION 후 IS NULL 1행·등호 NULL 필터 0행, 일반 NULL 등호 UNKNOWN 확인을 모두 통과했다. 운영 DB에는 실행하지 않았다.

기존 COUNT·집계·LEFT JOIN 글과 달리 선택한 열에 따른 집합 중복과 NULL 판정의 차이를 다룬다. 입력·확인 문제는 새로 작성했고 기존 bank 문항을 복사하지 않았다. 관련 개념의 공유가 전체 인터넷에서 유일한 문항임을 뜻하지 않는다.

실제 로컬 `/sqlp-developer?verNbr=202611`의 정식 SQLD 시험명·11월 원본 20문항·첫 LEFT JOIN 문항과 네 보기를 확인했다. SQLP는 별도 시험이다. 글의 세 문제만 필터한 세트나 공식 기출을 약속하지 않는다. 새 문항 DB·채점·저장 점수는 바꾸지 않는다.

세부 검색어·기간별 수치·원본 식별자는 비공개 기록에 보존한다. 넓은 한국어 SQLD 연습 수요를 근거로 하며 UNION 전용 검색 수요와 학습 효과는 미측정이다. 11월 21일 운영 확인 시 11월 22일~12월 19일 완결 28일을 관측한다. 복구는 글·등록·연결 변경의 Git revert다.
