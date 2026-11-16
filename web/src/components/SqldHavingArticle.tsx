import { sqldHavingPost, blogPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SqldHavingArticle() {
  return <>
    <p className={styles.lead}>SQLD에서 <code>GROUP BY</code> 문제를 풀 때는 조건이 <strong>개별 행</strong>에 붙는지, 묶어서 계산한 <strong>그룹</strong>에 붙는지 먼저 보세요. 결제가 끝난 주문만 모으는 조건은 <code>WHERE</code>, 그 주문들의 팀별 합계가 기준 이상인지 확인하는 조건은 <code>HAVING</code>에 둡니다.</p>

    <section aria-labelledby="sqld-having-data"><h2 id="sqld-having-data">주문 여섯 건에서 직접 계산하기</h2>
      <p>아래는 이 글을 위해 만든 학습용 자료입니다. 표의 “결제 완료”는 SQL에서 <code>status = 'paid'</code>로 저장된 상태입니다. 취소 주문도 원본 표에는 남아 있지만, 결제 완료 매출에는 넣지 않습니다.</p>
      <div className={styles.tableWrap} tabIndex={0} role="region" aria-label="팀별 주문 예시 표, 가로로 스크롤할 수 있음">
        <table className={styles.table}><caption>원본 주문: 팀, 결제 상태, 금액</caption>
          <thead><tr><th scope="col">주문</th><th scope="col">팀</th><th scope="col">상태</th><th scope="col">금액</th></tr></thead>
          <tbody>
            <tr><th scope="row">1</th><td>A</td><td>결제 완료</td><td>60</td></tr>
            <tr><th scope="row">2</th><td>A</td><td>결제 완료</td><td>50</td></tr>
            <tr><th scope="row">3</th><td>A</td><td>취소</td><td>80</td></tr>
            <tr><th scope="row">4</th><td>B</td><td>결제 완료</td><td>70</td></tr>
            <tr><th scope="row">5</th><td>B</td><td>취소</td><td>30</td></tr>
            <tr><th scope="row">6</th><td>C</td><td>결제 완료</td><td>40</td></tr>
          </tbody>
        </table>
      </div>
      <p><code>WHERE status = 'paid'</code>를 먼저 적용하면 취소된 3번과 5번 주문은 빠집니다. 남은 행의 팀별 합계는 A 110, B 70, C 40입니다. 여기서 <code>HAVING SUM(amount) &gt;= 100</code>을 적용하면 A팀만 남습니다.</p>
      <pre className={styles.code}><code>{`SELECT team, SUM(amount) AS paid_total
FROM orders
WHERE status = 'paid'
GROUP BY team
HAVING SUM(amount) >= 100;`}</code></pre>
      <p>취소 주문을 빼지 않고 <code>HAVING</code>만 쓰면 A 190, B 100, C 40으로 계산돼 B팀까지 남습니다. 문법상 실행 가능한 쿼리라도 질문의 “결제 완료 매출”과 다른 답을 낼 수 있습니다.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="sqld-having-check"><p className={styles.eyebrow}>원본 확인 문제 · 공식 기출 문항 아님</p><h2 id="sqld-having-check">상태와 합계 조건을 어디에 둘까요?</h2>
      <p>같은 표에서 결제 완료 주문의 합계가 100 이상인 팀만 찾는 쿼리의 조건 조합은 무엇일까요?</p>
      <ol>
        <li><code>WHERE status = 'paid'</code> 다음 <code>GROUP BY team</code>, 그리고 <code>HAVING SUM(amount) &gt;= 100</code></li>
        <li><code>WHERE SUM(amount) &gt;= 100</code> 다음 <code>GROUP BY team</code></li>
        <li><code>GROUP BY team</code> 다음 <code>HAVING SUM(amount) &gt;= 100</code>만 사용</li>
      </ol>
      <details><summary>정답과 오답 이유 보기</summary><p><strong>정답은 1번입니다.</strong> 결제 상태로 행을 먼저 걸러 A팀의 결제 완료 합계 110만 기준을 넘깁니다. 2번의 <code>WHERE</code>에서는 그룹 집계값 <code>SUM(amount)</code>으로 행을 거를 수 없습니다. 3번은 취소 주문도 합계에 넣어 B팀을 잘못 포함합니다.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="sqld-having-practice"><h2 id="sqld-having-practice">SQLD 원본 연습문제로 확인하세요</h2>
      <p>2026년 11월 SQLD 연습 세트에는 부서별 평균을 조건으로 거르는 <code>HAVING</code> 문항이 있습니다. 이 글의 주문 예시와 자료는 다르지만 “행을 먼저 거를지, 그룹을 나중에 거를지”라는 판단을 다시 연습할 수 있습니다.</p>
      <ExamLink href={sqldHavingPost.practicePath}>SQLD 11월 문제 풀기 →</ExamLink>
      <p>풀이 순서를 익히고 싶다면 <a href={blogPost.path}>SQLD CBT 3단계 가이드와 COUNT 예제</a>도 확인하세요.</p>
    </aside>

    <section className={styles.sources} aria-labelledby="sqld-having-sources"><h2 id="sqld-having-sources">공식 근거와 적용 범위</h2>
      <p><a href="https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-WHERE">PostgreSQL 18의 WHERE 설명</a>과 <a href="https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-GROUP">GROUP BY·HAVING 설명</a>은 행 조건과 그룹 조건의 적용 단계를 구분합니다.</p>
      <p>이 글은 PostgreSQL 문서로 SQL 집계 원리를 설명하는 자체 학습 자료입니다. 표와 확인 문제는 Quizeey가 새로 만들었으며, SQLD의 공식 기출문제나 특정 시험의 출제 범위를 재현했다는 뜻은 아닙니다.</p>
    </section>
  </>;
}
