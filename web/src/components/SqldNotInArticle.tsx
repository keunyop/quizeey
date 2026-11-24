import { blogPost, sqldLeftJoinPost, sqldNotInPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SqldNotInArticle() {
  return <>
    <p className={styles.lead}>제외 목록이 <code>101, NULL</code>일 때, <code>NOT IN</code>은 102와 103을 남길까요? <strong>NULL을 자동으로 건너뛰지 않습니다.</strong> 일치 여부를 알 수 없는 비교는 UNKNOWN이 되고, WHERE는 TRUE인 행만 남깁니다.</p>
    <p>Quizeey가 만든 SQLD 학습 사례와 확인 문제입니다. 공식 기출문제가 아닙니다. 단일 숫자 열을 비교하며, 첫 예제의 지원 코드 <code>candidates.code</code>는 NULL이 아니고 제외 코드 <code>excluded.code</code>에는 NULL이 들어갈 수 있다고 가정합니다.</p>
    <section aria-labelledby="not-in-data"><h2 id="not-in-data">같은 데이터로 결과를 먼저 예상하세요</h2>
      <p>지원 코드가 101·102·103, 제외 목록이 101·NULL입니다. 다음은 PostgreSQL에서 실행할 수 있는 원본 예제입니다.</p>
      <pre className={styles.code}><code>{`WITH candidates(code) AS (VALUES (101), (102), (103)),
excluded(code) AS (VALUES (101), (NULL))
SELECT code
FROM candidates
WHERE code NOT IN (SELECT code FROM excluded)
ORDER BY code;`}</code></pre>
      <p><strong>결과는 0행입니다.</strong> 그렇다고 세 코드의 조건이 모두 UNKNOWN인 것은 아닙니다. <code>NOT IN (101, NULL)</code>을 각 값과 같지 않아야 하는 AND 비교로 풀어 보세요.</p>
      <div className={styles.tableWrap} role="region" aria-label="NOT IN 판정 표, 가로로 스크롤 가능" tabIndex={0}><table className={styles.table}>
        <caption>같은 제외 목록에 대한 코드별 판정</caption><thead><tr><th scope="col">지원 코드</th><th scope="col">101과 같지 않음</th><th scope="col">NULL과 같지 않음</th><th scope="col">AND 결과</th><th scope="col">WHERE에 남음</th></tr></thead>
        <tbody><tr><th scope="row">101</th><td>FALSE</td><td>UNKNOWN</td><td>FALSE</td><td>아니요</td></tr><tr><th scope="row">102</th><td>TRUE</td><td>UNKNOWN</td><td>UNKNOWN</td><td>아니요</td></tr><tr><th scope="row">103</th><td>TRUE</td><td>UNKNOWN</td><td>UNKNOWN</td><td>아니요</td></tr></tbody>
      </table></div>
      <p>101은 제외 목록의 101과 일치하므로 FALSE입니다. 102와 103은 알려진 101과 다르지만 NULL과의 일반 비교 결과를 알 수 없습니다. <strong>UNKNOWN은 TRUE가 아니므로 WHERE를 통과하지 못합니다.</strong> NULL을 0이나 빈 목록으로 읽지 마세요.</p>
    </section>
    <section aria-labelledby="not-in-filter"><h2 id="not-in-filter">오른쪽 NULL을 걸러내면 무엇이 달라질까요?</h2>
      <p>같은 데이터에서 제외 서브쿼리의 NULL을 제거하면 비교 목록은 101만 남습니다. 위 쿼리의 WHERE를 다음처럼 바꾸면 결과는 <strong>102, 103</strong>입니다.</p>
      <pre className={styles.code}><code>{`WHERE code NOT IN (
  SELECT code FROM excluded WHERE code IS NOT NULL
)`}</code></pre>
      <p>이 설명에는 지원 코드가 NULL이 아니라는 전제가 있습니다. NULL 검사에는 <code>IS NOT NULL</code>을 사용합니다. <code>code &lt;&gt; NULL</code>로 바꾸면 NULL을 제거하는 올바른 조건이 되지 않습니다.</p>
    </section>
    <section aria-labelledby="not-exists"><h2 id="not-exists">NOT EXISTS는 바깥 행과의 연결 조건을 확인하세요</h2>
      <p>이번에는 각 지원 코드와 같은 제외 행이 존재하는지 묻습니다. <code>e.code = c.code</code>가 현재 바깥 행을 참조하는 상관 조건입니다.</p>
      <pre className={styles.code}><code>{`WITH candidates(code) AS (VALUES (101), (102), (103)),
excluded(code) AS (VALUES (101), (NULL))
SELECT c.code
FROM candidates c
WHERE NOT EXISTS (
  SELECT 1 FROM excluded e WHERE e.code = c.code
)
ORDER BY c.code;`}</code></pre>
      <p>101에는 일치하는 행이 있어 제외되고, 102와 103에는 일치하는 행이 없어 남습니다. EXISTS는 선택한 숫자 1의 값보다 <strong>조건을 만족하는 행의 존재</strong>를 검사합니다.</p>
      <p>상관 조건을 지워 <code>NOT EXISTS (SELECT 1 FROM excluded e)</code>로 쓰면 제외 표 전체가 비었는지를 묻습니다. 이 표에는 두 행이 있으므로 모든 지원 코드가 제외됩니다. NOT EXISTS가 언제나 더 빠르다거나 NOT IN과 무조건 같다고 외우지 마세요.</p>
    </section>
    <section aria-labelledby="not-in-boundary"><h2 id="not-in-boundary">왼쪽 NULL과 빈 서브쿼리는 별도 경계입니다</h2>
      <p>지원 코드에도 NULL을 허용하면, 오른쪽 NULL을 제거한 NOT IN과 위의 상관 NOT EXISTS는 달라집니다. 제외 목록에 101이 있는 상태에서 <code>NULL NOT IN (101)</code>은 UNKNOWN이라 남지 않습니다. 반면 상관 NOT EXISTS에서는 NULL과 같은 코드라고 판정되는 행이 없어서 왼쪽 NULL도 남습니다. 업무 규칙이 미정 코드를 제외한다면 <code>c.code IS NOT NULL AND NOT EXISTS (...)</code>처럼 그 규칙을 명시해야 합니다.</p>
      <p><strong>NULL 한 행과 0행은 다릅니다.</strong> 서브쿼리가 정말 0행이면 NOT IN은 TRUE이며 왼쪽 값이 NULL이어도 그렇습니다. 이 글은 단일 숫자 비교를 다루며 여러 열 비교나 DB별 빈 문자열 규칙으로 일반화하지 않습니다.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="not-in-quiz"><h2 id="not-in-quiz">세 문제로 판정과 상관 조건 확인하기</h2>
      <p>2026-11-24 Quizeey 원본 확인 문제입니다. 세 문제 모두 지원 코드는 101·102·103으로 NULL이 아니고, 제외 코드는 101·NULL입니다.</p>
      <h3>1. 첫 NOT IN 쿼리의 결과와 이유로 맞는 것은?</h3><ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}><li>102·103이 남는다. NULL은 자동으로 건너뛴다.</li><li>0행이다. 101은 FALSE, 102·103은 UNKNOWN이어서 남지 않는다.</li><li>101·102·103이 모두 남는다. NULL은 빈 목록을 뜻한다.</li></ol>
      <details><summary>1번 정답과 오답 이유</summary><p>정답은 2번입니다. WHERE는 TRUE만 남깁니다. 1번은 NULL이 자동 제거된다고 잘못 가정했고, 3번은 NULL이 들어 있는 행과 아예 행이 없는 서브쿼리를 혼동했습니다.</p></details>
      <h3>2. 제외 서브쿼리에 WHERE code IS NOT NULL을 추가하면 남는 코드는?</h3><ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}><li>102·103</li><li>0행. 어디에든 NULL이 있으면 필터와 무관하게 항상 실패한다.</li><li>101만 남는다.</li></ol>
      <details><summary>2번 정답과 오답 이유</summary><p>정답은 1번입니다. 비교 목록은 101만 남아 102·103의 조건이 TRUE입니다. 2번은 서브쿼리 안에서 NULL을 제거한 사실을 무시했고, 3번은 IN과 NOT IN의 방향을 뒤집었습니다. 여기서는 왼쪽 지원 코드가 NULL이 아니라는 가정을 유지합니다.</p></details>
      <h3>3. 일치하는 제외 행이 없는 102·103을 남기는 조건은?</h3><ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}><li><code>NOT EXISTS (SELECT 1 FROM excluded e)</code></li><li><code>EXISTS (SELECT 1 FROM excluded e WHERE e.code = c.code)</code></li><li><code>NOT EXISTS (SELECT 1 FROM excluded e WHERE e.code = c.code)</code></li></ol>
      <details><summary>3번 정답과 오답 이유</summary><p>정답은 3번입니다. 바깥 지원 코드와 같은 제외 행이 없는지를 묻습니다. 1번은 표 전체가 비었는지만 검사해 이 데이터에서는 아무 코드도 남기지 않습니다. 2번은 일치하는 행이 있는 101을 남깁니다.</p></details>
    </section>
    <section className={styles.cta} aria-labelledby="not-in-practice"><h2 id="not-in-practice">조건을 설명한 뒤 SQLD 문제로 확인하세요</h2><p>SQLD 2026-11 연습 20문항에는 NOT IN과 NULL을 다루는 문제가 포함돼 있습니다. 위 세 문제는 글 안 확인 문제이며 기존 회차에 추가한 문제가 아닙니다.</p><ExamLink href={sqldNotInPost.practicePath}>SQLD 11월 연습 20문항 풀기</ExamLink><p>기초 비교는 <a href={blogPost.path}>COUNT와 NULL 가이드</a>, 조인 결과의 NULL은 <a href={sqldLeftJoinPost.path}>LEFT JOIN 조건 가이드</a>에서 이어서 확인하세요.</p></section>
    <section aria-labelledby="not-in-sources"><h2 id="not-in-sources">공식 참고 자료</h2><ul><li><a href="https://www.postgresql.org/docs/18/functions-subquery.html">PostgreSQL 18: EXISTS와 NOT IN</a></li><li><a href="https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-WHERE">PostgreSQL 18: WHERE 조건</a></li><li><a href="https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/IN-Condition.html">Oracle SQL Reference: IN과 NOT IN</a></li></ul><p>2026-11-24 원문 확인. PostgreSQL 예제와 Oracle 조건 설명의 공통 의미를 대조했으며 Oracle 엔진에서 실행한 결과를 주장하지 않습니다.</p></section>
  </>;
}
