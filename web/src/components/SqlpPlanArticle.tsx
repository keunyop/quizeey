import { sqlpPlanPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SqlpPlanArticle() {
  return <>
    <p className={styles.lead}>SQLP 문제에서 인덱스가 보인다고 실행계획에 반드시 <code>Index Scan</code>이 나오는 것은 아닙니다. PostgreSQL은 후보 계획의 <strong>예상 비용</strong>을 비교합니다. 아래 원본 사례에서 먼저 읽을 것은 인덱스의 존재 여부보다 검색 조건과 실제로 읽어야 할 행의 범위입니다.</p>

    <section aria-labelledby="sqlp-plan-order"><h2 id="sqlp-plan-order">실행계획을 읽는 세 단계</h2>
      <ol>
        <li><strong>접근 방식:</strong> <code>Seq Scan</code>, <code>Index Scan</code>, <code>Bitmap Index Scan</code> 중 어떤 노드로 행을 찾는지 봅니다.</li>
        <li><strong>조건 위치:</strong> <code>Index Cond</code>가 인덱스 범위를 좁히는 조건인지, <code>Filter</code>가 읽은 행을 다시 거르는 조건인지 구분합니다.</li>
        <li><strong>예상과 실제:</strong> 기본 <code>EXPLAIN</code>의 <code>rows</code>와 <code>cost</code>는 계획 시 추정치입니다. 실제 행 수를 보려면 안전한 읽기 쿼리에서 <code>EXPLAIN ANALYZE</code>를 사용합니다. 이 명령은 쿼리를 실제 실행하므로 쓰기 쿼리에는 주의해야 합니다.</li>
      </ol>
      <p>실행계획은 데이터 양·분포·통계와 쿼리에 따라 달라집니다. 아래 SQL은 개념을 설명하는 예시이며, 특정 서버에서 같은 계획이 출력된다고 주장하지 않습니다.</p>
    </section>

    <section aria-labelledby="sqlp-plan-cases"><h2 id="sqlp-plan-cases">인덱스가 있어도 먼저 확인할 세 상황</h2>
      <h3>1. 모든 주문을 읽는다면</h3>
      <pre className={styles.code}><code>{`CREATE INDEX orders_customer_idx ON orders (customer_id);
EXPLAIN SELECT * FROM orders;`}</code></pre>
      <p><code>customer_id</code> 인덱스가 있어도 <code>WHERE</code> 조건이 없는 쿼리는 모든 주문을 읽습니다. PostgreSQL 공식 문서의 전체 테이블 조회 예제도 <code>Seq Scan</code>을 선택합니다. 이때 인덱스가 사용되지 않았다는 사실만으로 결함이라 단정하지 마세요. 먼저 쿼리가 정말 전체 행을 필요로 하는지 확인합니다.</p>

      <h3>2. 인덱스 열을 함수로 바꿔 비교한다면</h3>
      <pre className={styles.code}><code>{`CREATE INDEX customers_email_idx ON customers (email);
EXPLAIN SELECT * FROM customers
WHERE lower(email) = 'learner@example.com';`}</code></pre>
      <p><code>email</code>에 만든 일반 인덱스와 <code>lower(email)</code>의 결과는 같은 검색 키가 아닙니다. PostgreSQL은 이 검색용으로 <code>lower(email)</code> 표현식 인덱스를 만들 수 있다고 설명합니다. 인덱스를 추가하기 전에 실제 쿼리 빈도와 쓰기 비용을 함께 확인하세요.</p>

      <h3>3. 다중 열 인덱스의 앞 열이 빠졌다면</h3>
      <pre className={styles.code}><code>{`CREATE INDEX orders_region_date_idx
ON orders (region, created_at);
EXPLAIN SELECT * FROM orders
WHERE created_at >= DATE '2026-11-01';`}</code></pre>
      <p><code>(region, created_at)</code> 인덱스는 앞쪽 열 <code>region</code>에 조건이 있을 때 검색 범위를 더 효율적으로 줄일 수 있습니다. <code>created_at</code>만 조건에 있어도 인덱스 사용이 불가능한 것은 아닙니다. 다만 읽어야 할 인덱스 범위가 넓어질 수 있으므로, <code>WHERE region = 'CA' AND created_at &gt;= ...</code>처럼 앞 열까지 제한하는 경우와 계획을 비교합니다.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="sqlp-plan-check"><p className={styles.eyebrow}>원본 확인 문제 · 실제 기출 문항 아님</p><h2 id="sqlp-plan-check">어느 판단부터 해야 할까요?</h2>
      <p><code>email</code> 열에 일반 B-tree 인덱스가 있습니다. 쿼리는 <code>WHERE lower(email) = 'a@example.com'</code>이고 실행계획에는 <code>Seq Scan</code>이 보입니다. 다음 행동으로 가장 알맞은 것은 무엇일까요?</p>
      <ol><li>인덱스가 고장 났다고 보고 즉시 삭제한다.</li><li>검색식이 인덱스 키와 일치하는지 확인하고, 실제 데이터에서 계획과 비용을 비교한다.</li><li>모든 쿼리의 순차 스캔을 강제로 금지한다.</li></ol>
      <details><summary>정답과 선택지별 이유 보기</summary><p><strong>정답은 2번입니다.</strong> 일반 <code>email</code> 인덱스와 <code>lower(email)</code> 검색식이 다르므로 먼저 조건과 인덱스 정의를 대조합니다. 필요하면 표현식 인덱스를 검토하되 비용·유지 부담을 같이 봅니다. 1번은 인덱스의 고장을 입증하지 못하며, 3번은 다른 쿼리에 유리한 순차 스캔까지 막을 수 있습니다.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="sqlp-plan-practice"><h2 id="sqlp-plan-practice">SQLP 원본 연습문제로 이어서 확인하세요</h2>
      <p>2026년 11월 SQLP 세트에는 B-tree 선택도와 옵티마이저 통계에 관한 원본 문항이 있습니다. 정답을 제출한 뒤 선택지와 해설을 대조해 보세요.</p>
      <ExamLink href={sqlpPlanPost.practicePath}>SQLP 11월 문제 풀기 →</ExamLink>
    </aside>

    <section className={styles.sources} aria-labelledby="sqlp-plan-sources"><h2 id="sqlp-plan-sources">공식 근거와 적용 범위</h2>
      <p><a href="https://www.postgresql.org/docs/17/using-explain.html">PostgreSQL 17: Using EXPLAIN</a>은 계획 노드와 예상 비용을, <a href="https://www.postgresql.org/docs/17/indexes-expressional.html">Indexes on Expressions</a>는 <code>lower()</code> 검색을, <a href="https://www.postgresql.org/docs/17/indexes-multicolumn.html">Multicolumn Indexes</a>는 앞 열 조건의 효율을 설명합니다.</p>
      <p><a href="https://www.dataq.or.kr/www/sub/a_03.do">DataQ SQLP 종목 안내</a>에서 자격 종목을 확인하세요. 이 글은 PostgreSQL로 원리를 연습하는 자체 학습 자료이며 SQLP의 공식 기출문제나 모든 DBMS의 동일한 실행계획을 재현한 자료가 아닙니다.</p>
    </section>
  </>;
}
