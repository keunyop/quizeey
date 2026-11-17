import { sqldLeftJoinPost, blogPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SqldLeftJoinArticle() {
  return <>
    <p className={styles.lead}>회원은 모두 보이되 결제 완료 주문만 붙이고 싶다면, 주문 상태 조건을 어디에 놓아야 할까요? <code>LEFT JOIN</code>의 <code>ON</code>에 놓으면 회원을 남기고, 조인 뒤 <code>WHERE</code>에 놓으면 결제 완료 주문이 없는 회원 행은 사라집니다. 직접 만든 작은 표로 두 결과를 비교해 보세요.</p>

    <section aria-labelledby="sqld-join-data"><h2 id="sqld-join-data">회원 3명과 주문 3건으로 결과 세기</h2>
      <p>다음 표는 이 글을 위해 만든 예제입니다. <code>paid</code>는 결제 완료, <code>cancelled</code>는 취소를 뜻합니다. 회원 3번은 주문이 없습니다.</p>
      <div className={styles.tableWrap} tabIndex={0} role="region" aria-label="회원과 주문 예제 표, 가로로 스크롤할 수 있음">
        <table className={styles.table}><caption>회원</caption><thead><tr><th scope="col">member_id</th><th scope="col">이름</th></tr></thead><tbody><tr><th scope="row">1</th><td>가람</td></tr><tr><th scope="row">2</th><td>나래</td></tr><tr><th scope="row">3</th><td>다온</td></tr></tbody></table>
        <table className={styles.table}><caption>주문</caption><thead><tr><th scope="col">order_id</th><th scope="col">member_id</th><th scope="col">status</th></tr></thead><tbody><tr><th scope="row">101</th><td>1</td><td>paid</td></tr><tr><th scope="row">102</th><td>1</td><td>cancelled</td></tr><tr><th scope="row">103</th><td>2</td><td>cancelled</td></tr></tbody></table>
      </div>
    </section>

    <section aria-labelledby="sqld-join-on"><h2 id="sqld-join-on">조건을 ON에 두면 회원 3명이 남습니다</h2>
      <pre className={styles.code}><code>{`SELECT m.member_id, o.order_id
FROM members AS m
LEFT JOIN orders AS o
  ON o.member_id = m.member_id AND o.status = 'paid'
ORDER BY m.member_id;`}</code></pre>
      <p>회원 1번은 결제 완료 주문 101번과 매칭됩니다. 회원 2번은 주문 103번이 있지만 취소 상태라 이 <code>ON</code> 조건에는 맞지 않습니다. 회원 3번은 주문 자체가 없습니다. <code>LEFT JOIN</code>은 매칭되지 않은 두 회원도 오른쪽 열을 <code>NULL</code>로 채워 각각 한 행씩 남깁니다.</p>
      <table className={styles.table}><caption>ON에 주문 상태 조건을 둔 결과: 3행</caption><thead><tr><th scope="col">member_id</th><th scope="col">order_id</th></tr></thead><tbody><tr><th scope="row">1</th><td>101</td></tr><tr><th scope="row">2</th><td>NULL</td></tr><tr><th scope="row">3</th><td>NULL</td></tr></tbody></table>
      <p>여기서 <code>order_id IS NULL</code>은 “결제 완료 주문과 매칭되지 않았다”는 뜻입니다. 회원 2번처럼 취소 주문이 있을 수도 있으므로 “주문이 전혀 없다”와 혼동하지 마세요.</p>
    </section>

    <section aria-labelledby="sqld-join-where"><h2 id="sqld-join-where">같은 조건을 WHERE에 두면 1행만 남습니다</h2>
      <pre className={styles.code}><code>{`SELECT m.member_id, o.order_id
FROM members AS m
LEFT JOIN orders AS o ON o.member_id = m.member_id
WHERE o.status = 'paid'
ORDER BY m.member_id;`}</code></pre>
      <p>먼저 조인하면 회원 1번의 두 주문, 회원 2번의 취소 주문, 회원 3번의 <code>NULL</code> 확장 행이 만들어집니다. 그다음 <code>WHERE</code>는 결제 완료 행만 남깁니다. 취소 주문은 조건이 거짓이고, 회원 3번의 <code>NULL = 'paid'</code>도 참이 아니므로 제외됩니다. 최종 결과는 회원 1번과 주문 101번 한 행입니다.</p>
      <p>따라서 “결제 완료 주문이 있는 회원만” 찾는다면 이 쿼리도 맞습니다. “모든 회원을 보이며 결제 완료 주문만 붙이기”가 목적이라면 앞의 <code>ON</code> 방식이 맞습니다.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="sqld-join-check"><p className={styles.eyebrow}>원본 확인 문제 · 공식 기출문항 아님</p><h2 id="sqld-join-check">취소 주문만 있는 회원도 결과에 남기려면?</h2>
      <p>모든 회원을 출력하고, 결제 완료 주문이 있을 때만 해당 주문번호를 붙이려 합니다. 어떤 방법이 맞을까요?</p>
      <ol><li><code>LEFT JOIN orders ON 회원번호 일치 AND status = 'paid'</code></li><li><code>LEFT JOIN orders ON 회원번호 일치 WHERE status = 'paid'</code></li><li><code>INNER JOIN orders ON 회원번호 일치 AND status = 'paid'</code></li><li><code>CROSS JOIN orders</code> 뒤 주문 상태는 확인하지 않기</li></ol>
      <details><summary>정답과 오답 이유 보기</summary><p><strong>정답은 1번입니다.</strong> 결제 완료 주문에 매칭되지 않아도 왼쪽 회원 행이 남습니다. 2번은 조인 후 필터가 취소·미매칭 행을 제거합니다. 3번은 내부 조인이므로 매칭되지 않은 회원을 남기지 않습니다. 4번은 모든 회원·주문 조합을 만들며 결제 완료 주문만 붙인다는 조건을 만족하지 않습니다.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="sqld-join-practice"><h2 id="sqld-join-practice">2026년 11월 SQLD 연습문제로 이어가기</h2>
      <p>2026년 11월 SQLD 연습 세트는 회원과 주문을 <code>LEFT JOIN</code>했을 때의 행 수, 주문이 없는 회원을 찾는 조건을 묻습니다. 이 글과 숫자는 다르지만 “매칭 수와 미매칭 행을 따로 세기”라는 순서를 적용해 보세요. 회차에는 주제별 필터가 없습니다.</p>
      <ExamLink href={sqldLeftJoinPost.practicePath}>SQLD 11월 연습문제 풀기 →</ExamLink>
      <p>집계 조건이 헷갈린다면 <a href={blogPost.path}>COUNT와 NULL 복습 가이드</a>부터 확인하세요.</p>
    </aside>

    <section className={styles.sources} aria-labelledby="sqld-join-sources"><h2 id="sqld-join-sources">공식 근거와 학습 범위</h2>
      <p><a href="https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-JOIN">PostgreSQL 18의 조인 설명</a>은 왼쪽 외부 조인의 미매칭 행을 오른쪽 <code>NULL</code>로 확장한다고 설명합니다. 같은 문서의 <a href="https://www.postgresql.org/docs/18/queries-table-expressions.html#QUERIES-WHERE">WHERE 설명</a>은 조건 결과가 참이 아닌 행을 제외하고, 외부 조인의 <code>ON</code>과 <code>WHERE</code> 조건이 동등하지 않다는 예제를 보여줍니다.</p>
      <p>이 글의 회원·주문과 확인 문제는 원리를 설명하기 위해 직접 만든 자료입니다. SQLD 공식 기출문항이나 전체 시험 범위 재현을 뜻하지 않습니다.</p>
    </section>
  </>;
}
