import { sqldUnionPost, sqldLeftJoinPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SqldUnionArticle() {
  return <>
    <p className={styles.lead}>SQLD에서 <code>UNION</code>과 <code>UNION ALL</code>의 결과 행 수를 셀 때는 <strong>조회한 열 전체가 같은 행인지</strong>부터 확인하세요. 회원 번호가 같아도 함께 조회한 채널이 다르면 다른 결과 행입니다. 아래 원본 예제에서는 같은 입력이 <strong>UNION ALL 6행, UNION 3행</strong>이 되고, 회원 번호만 선택하면 UNION 결과가 2행으로 달라집니다.</p>
    <p>직접 만든 개념 연습이며 공식 기출문제가 아닙니다. 실행 예제는 PostgreSQL 18 기준입니다. 다른 DB의 문법과 세부 동작은 해당 제품 문서를 함께 확인하세요.</p>
    <section aria-labelledby="union-input"><h2 id="union-input">입력은 여섯 행, 중복 기준은 선택한 열</h2>
      <p>두 조회 결과 A와 B가 같은 순서의 두 열 <code>member_id</code>(정수), <code>channel</code>(문자열)을 반환한다고 가정합니다. 표의 입력 표시는 설명용이며 첫 SQL에서는 조회하지 않습니다. NULL은 문자열 “NULL”이 아닌 SQL의 NULL입니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="집합 연산 입력 표, 가로로 스크롤 가능" tabIndex={0}><table className={styles.table}>
        <caption>두 조회가 반환하는 입력 여섯 행</caption><thead><tr><th scope="col">입력 표시</th><th scope="col">member_id</th><th scope="col">channel</th></tr></thead>
        <tbody><tr><th scope="row">A1</th><td>101</td><td>web</td></tr><tr><th scope="row">A2</th><td>102</td><td>NULL</td></tr><tr><th scope="row">A3</th><td>102</td><td>NULL</td></tr><tr><th scope="row">B1</th><td>101</td><td>web</td></tr><tr><th scope="row">B2</th><td>102</td><td>NULL</td></tr><tr><th scope="row">B3</th><td>101</td><td>app</td></tr></tbody>
      </table></div>
      <pre className={styles.code}><code>{"WITH a(member_id, channel) AS (\n  VALUES (101, 'web'), (102, NULL), (102, NULL)\n), b(member_id, channel) AS (\n  VALUES (101, 'web'), (102, NULL), (101, 'app')\n)\nSELECT member_id, channel FROM a\nUNION\nSELECT member_id, channel FROM b;"}</code></pre>
      <p>이 SQL은 테이블을 만들거나 기존 자료를 변경하지 않습니다. 두 SELECT 사이의 <code>UNION</code>을 <code>UNION ALL</code>로 바꾸면 아래 결과를 비교할 수 있습니다. 열 개수가 같고 대응하는 열의 자료형이 호환된다는 전제가 필요합니다.</p>
    </section>
    <section aria-labelledby="union-result"><h2 id="union-result">UNION ALL은 6행, UNION은 3행인 이유</h2>
      <p><code>UNION ALL</code>은 입력의 중복을 보존하므로 3 + 3 = <strong>6행</strong>입니다. <code>(101, web)</code>은 두 번, <code>(102, NULL)</code>은 세 번, <code>(101, app)</code>은 한 번 남습니다.</p>
      <p><code>UNION</code>은 결합 결과에서 같은 행을 제거하므로 다음 <strong>3행</strong>만 남습니다. B와 겹치는 행뿐 아니라 A 안에서 반복된 행도 중복 제거 대상입니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="UNION 결과 표, 가로로 스크롤 가능" tabIndex={0}><table className={styles.table}>
        <caption>UNION 결과: 순서를 지정하지 않은 세 행의 예시 나열</caption><thead><tr><th scope="col">member_id</th><th scope="col">channel</th></tr></thead><tbody><tr><td>101</td><td>web</td></tr><tr><td>102</td><td>NULL</td></tr><tr><td>101</td><td>app</td></tr></tbody>
      </table></div>
      <p>101이 두 번 보이는 것은 오류가 아닙니다. <code>(101, web)</code>과 <code>(101, app)</code>은 채널 값이 달라 다른 행입니다. 두 SELECT 모두 <code>member_id</code>만 선택하도록 바꾸면 중복 기준도 한 열이 되어 <strong>101과 102, 총 2행</strong>만 남습니다.</p>
      <p>결과 표의 나열 순서는 설명을 위한 것입니다. <code>ORDER BY</code>가 없으면 UNION이 정렬된 순서로 반환된다거나 UNION ALL이 A 다음 B 순서를 보장한다고 판단하지 마세요. 원하는 순서는 최종 결과에 명시적으로 지정합니다.</p>
    </section>
    <section aria-labelledby="union-null"><h2 id="union-null">NULL 중복 제거와 “= NULL”은 다른 판단입니다</h2>
      <p>이 예제의 <code>(102, NULL)</code> 세 행은 UNION의 중복 제거 비교에서 하나로 남습니다. 그렇다고 일반 조건식 <code>NULL = NULL</code>이 TRUE가 되는 것은 아닙니다. 일반적인 NULL 비교 결과는 미지값(UNKNOWN)이므로 NULL을 찾을 때는 <code>IS NULL</code>을 씁니다.</p>
      <p>입력 여섯 행을 UNION ALL로 결합한 뒤 <code>WHERE channel IS NULL</code>로 걸러내면 3행입니다. 같은 입력에 <code>WHERE channel = NULL</code>을 쓰면 일반적인 SQL NULL 비교 규칙에서 TRUE인 행이 없어 0행입니다. 반면 두 열 UNION 결과에서 IS NULL로 거르면 이미 중복이 제거돼 1행입니다. <strong>어떤 결과에 조건을 적용하는지</strong> 함께 적으세요.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="union-quiz"><h2 id="union-quiz">세 문제로 판단 근거 확인하기</h2>
      <p>2026-11-21 Quizeey 원본 확인 문제입니다. 위 여섯 행을 기준으로 선택한 열과 적용 순서를 먼저 확인한 뒤 답을 골라 보세요.</p>
      <h3>1. 두 열을 모두 선택하면 결과는?</h3><p>UNION 행 수와 UNION ALL 행 수의 올바른 쌍은 무엇일까요?</p>
      <ol><li>2행, 6행</li><li>3행, 6행</li><li>6행, 6행</li></ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 두 열 전체가 다른 결과는 세 종류입니다. 1번은 회원 번호만 중복 기준으로 삼았고, 3번은 UNION의 중복 제거를 빠뜨렸습니다. UNION ALL은 여섯 입력 행을 모두 보존합니다.</p></details>
      <h3>2. 중복된 발생 이력도 빠짐없이 보존하려면?</h3><p>같은 회원·채널의 기록이 여러 번 발생했고, 이번에는 각각의 발생 행을 유지해 결합하려 합니다. 가장 적절한 선택은?</p>
      <ol><li>UNION ALL을 사용하고, 순서가 필요하면 ORDER BY도 지정한다.</li><li>UNION을 사용하면 중복 발생 횟수도 자동으로 보존된다.</li><li>UNION ALL만 쓰면 입력 A 다음 B 순서까지 항상 보장된다.</li></ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> UNION ALL은 중복 행을 보존하지만 반환 순서는 별도 문제입니다. 2번은 중복 제거로 발생 횟수가 줄어들 수 있고, 3번은 ORDER BY 없는 순서를 보장한다고 오해했습니다. 행 개수 보존과 정렬을 구분하세요.</p></details>
      <h3>3. UNION ALL 결과에서 NULL 채널을 찾으면?</h3><p>위 입력 여섯 행을 결합한 결과에서 <code>WHERE channel IS NULL</code> 조건을 적용한 행 수와 설명 중 맞는 것은?</p>
      <ol><li>1행이다. NULL이 포함된 행은 ALL에서도 하나만 남는다.</li><li>0행이다. NULL이 있는 행은 자동 삭제된다.</li><li>3행이다. NULL 검사는 IS NULL을 쓰며, 중복 제거 비교와 일반 등호 비교는 구분한다.</li></ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> A2·A3·B2가 조건에 해당합니다. 1번은 UNION과 UNION ALL을 혼동했고, 2번은 NULL이 자동 삭제된다고 가정했습니다. 이 중복 판정 때문에 NULL = NULL이 TRUE가 되는 것은 아닙니다.</p></details>
    </section>
    <aside className={styles.cta} aria-labelledby="union-practice"><h2 id="union-practice">SQLD 11월 원본 문제로 이어서 연습하세요</h2>
      <p>한국어 자체 제작 20문항 세트에서 UNION ALL, JOIN, 집계 등 여러 기초 개념을 연습할 수 있습니다. 공식 기출이나 UNION만 모은 세트가 아니며, 글 안 세 문제를 새로 등록한 세트도 아닙니다.</p>
      <ExamLink href={sqldUnionPost.practicePath}>SQLD 11월 연습문제 풀기 →</ExamLink>
      <p>답 제출 후 해설에서 전체 행과 한 열을 혼동했는지 확인하세요. 행 수 판단이 어렵다면 <a href={sqldLeftJoinPost.path}>LEFT JOIN의 ON·WHERE 조건 비교</a>도 함께 복습할 수 있습니다.</p>
    </aside>
    <section className={styles.sources} aria-labelledby="union-sources"><h2 id="union-sources">공식 근거와 예제 범위</h2>
      <p>2026-11-21 확인한 PostgreSQL 18 공식 문서입니다. SQLD 공식 출제문항이나 모든 DB의 실행계획을 재현한 자료는 아닙니다. UNION ALL이 어떤 환경에서나 반드시 더 빠르다는 성능 보장도 하지 않습니다.</p>
      <ul><li><a href="https://www.postgresql.org/docs/18/queries-union.html">Combining Queries</a> — 집합 연산과 중복 제거·열 호환 조건.</li><li><a href="https://www.postgresql.org/docs/18/queries-select-lists.html#QUERIES-DISTINCT">Select Lists: DISTINCT</a> — 선택 행 전체와 NULL의 중복 판정.</li><li><a href="https://www.postgresql.org/docs/18/functions-comparison.html">Comparison Functions and Operators</a> — 일반 NULL 비교와 IS NULL.</li><li><a href="https://www.postgresql.org/docs/18/queries-order.html">Sorting Rows</a> — 명시적인 반환 순서.</li></ul>
    </section>
  </>;
}
