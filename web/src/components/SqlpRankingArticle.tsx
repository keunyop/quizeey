import { sqlpRankingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

const results = [
  ['A', 11, 95, 1, 1, 1],
  ['A', 13, 95, 2, 1, 1],
  ['A', 12, 88, 3, 3, 2],
  ['A', 14, 80, 4, 4, 3],
  ['B', 21, 90, 1, 1, 1],
  ['B', 22, 85, 2, 2, 2],
  ['B', 23, 85, 3, 2, 2],
  ['B', 24, 70, 4, 4, 3],
] as const;

export function SqlpRankingArticle() {
  return <>
    <p className={styles.lead}>SQLP 학습에서 순위 함수를 고를 때는 먼저 결과에 필요한 규칙을 정하세요. <strong>행마다 번호를 매길지, 같은 점수에 같은 순위를 줄지, 동점 다음 순위를 건너뛸지</strong>에 따라 함수가 달라집니다. 팀별로 점수가 같은 선수가 있을 때 세 함수가 어떤 값을 만드는지 살펴봅니다.</p>

    <section aria-labelledby="ranking-example">
      <h2 id="ranking-example">같은 점수표에 세 함수 적용하기</h2>
      <p>각 팀에서 선수 번호는 고유하며, 이 예제의 점수와 선수 번호에는 NULL이 없습니다. 점수가 높을수록 앞에 두고, 행 번호를 매길 때는 동점 선수 중 번호가 작은 선수를 먼저 배치합니다.</p>
      <pre className={styles.code}><code>{`WITH scores(team, player_id, points) AS (
  VALUES ('A', 11, 95), ('A', 13, 95), ('A', 12, 88), ('A', 14, 80),
         ('B', 21, 90), ('B', 23, 85), ('B', 22, 85), ('B', 24, 70)
)
SELECT team, player_id, points,
       ROW_NUMBER() OVER (
         PARTITION BY team ORDER BY points DESC, player_id
       ) AS rn,
       RANK() OVER (
         PARTITION BY team ORDER BY points DESC
       ) AS rnk,
       DENSE_RANK() OVER (
         PARTITION BY team ORDER BY points DESC
       ) AS dense_rnk
FROM scores
ORDER BY team, points DESC, player_id;`}</code></pre>
      <div className={styles.tableWrap} role="region" aria-label="팀별 순위 계산 결과 표, 가로로 스크롤 가능" tabIndex={0}>
        <table className={styles.table}>
          <caption>팀별 점수와 세 순위 함수의 결과</caption>
          <thead><tr><th scope="col">팀</th><th scope="col">선수 번호</th><th scope="col">점수</th><th scope="col">행 번호</th><th scope="col">RANK</th><th scope="col">DENSE_RANK</th></tr></thead>
          <tbody>
            {results.map(([team, player, points, rowNumber, rank, denseRank]) => (
              <tr key={`${team}-${player}`}><td>{team}</td><th scope="row">{player}</th><td>{points}</td><td>{rowNumber}</td><td>{rank}</td><td>{denseRank}</td></tr>
            ))}
          </tbody>
        </table>
      </div>
      <p><code>ROW_NUMBER()</code>는 팀 안에서 행마다 다른 번호를 줍니다. <code>RANK()</code>는 같은 점수의 첫 행 위치를 순위로 사용합니다. A팀의 88점보다 앞에 두 행이 있으므로 3위입니다. <code>DENSE_RANK()</code>는 점수 묶음에 차례로 번호를 붙입니다. 88점은 A팀에서 두 번째로 높은 점수이므로 2위입니다. <code>PARTITION BY team</code>으로 B팀의 계산은 다시 1부터 시작합니다.</p>
      <p><a href="https://www.postgresql.org/docs/18/functions-window.html">PostgreSQL 창 함수 문서</a></p>
    </section>

    <section aria-labelledby="ranking-tiebreaker">
      <h2 id="ranking-tiebreaker">보조 정렬 키는 필요한 함수에만 넣기</h2>
      <p>점수만으로 <code>ROW_NUMBER()</code>를 계산하면 동점 행에도 서로 다른 번호가 붙지만, 어느 선수가 앞 번호를 받을지는 그 정렬 조건만으로 결정되지 않습니다. 위 예제에서는 팀 안에서 고유한 <code>player_id</code>를 두 번째 키로 두어 A팀 95점 선수의 순서를 정했습니다.</p>
      <p>점수 동점을 유지해야 하는 <code>RANK()</code>와 <code>DENSE_RANK()</code>의 창 정렬에는 점수만 넣었습니다. 여기에 고유한 <code>player_id</code>까지 넣으면 점수가 같아도 전체 정렬 키가 달라 두 행에 서로 다른 순위가 붙습니다. 최종 출력에서 동점 행을 선수 번호 순으로 보여 주려면 쿼리 끝의 <code>ORDER BY</code>에서 정렬하세요. 이 정렬은 이미 계산된 창 함수 결과를 바꾸지 않습니다.</p>
      <p><a href="https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/Analytic-Functions.html">Oracle 분석 함수의 정렬 규칙</a></p>
    </section>

    <section className={styles.quiz} aria-labelledby="ranking-quiz">
      <h2 id="ranking-quiz">세 문제로 조건 확인하기</h2>
      <p>아래는 Quizeey가 위 점수표를 바탕으로 만든 연습 문제입니다.</p>

      <h3>1. B팀의 70점 선수에게 계산되는 RANK와 DENSE_RANK의 조합은?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li>RANK 3, DENSE_RANK 3</li><li>RANK 4, DENSE_RANK 3</li><li>RANK 4, DENSE_RANK 4</li>
      </ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 70점보다 높은 행은 세 개이므로 RANK는 4이고, 70점은 세 번째 점수 묶음이므로 DENSE_RANK는 3입니다. 1번은 RANK도 묶음 수를 세는 것으로 해석했습니다. 3번은 DENSE_RANK에도 동점 행 수에 따른 빈 순위가 생긴다고 가정했습니다.</p></details>

      <h3>2. A팀의 95점 두 선수 가운데 선수 번호가 작은 행에 ROW_NUMBER 1을 부여하는 조건은?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li><code>ROW_NUMBER() OVER (PARTITION BY team ORDER BY points DESC, player_id ASC)</code></li>
        <li><code>ROW_NUMBER() OVER (PARTITION BY team ORDER BY points DESC)</code>를 사용한 뒤 최종 출력에만 <code>player_id ASC</code>를 추가한다.</li>
        <li><code>ROW_NUMBER() OVER (PARTITION BY team ORDER BY points DESC, player_id DESC)</code></li>
      </ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> 창 함수 안의 오름차순 보조 키로 11번 선수를 13번보다 앞에 놓습니다. 2번은 출력 순서만 바꾸며 두 행의 번호 배정을 정하지 않습니다. 3번은 동점에서 큰 번호가 먼저 오도록 지정해 13번 선수에게 행 번호 1을 줍니다.</p></details>

      <h3>3. 팀별로 가장 높은 점수와 두 번째로 높은 서로 다른 점수를 받은 모든 선수를 남기려면?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li>위 예제의 <code>rn</code>을 계산한 뒤 바깥 쿼리에서 <code>rn &lt;= 2</code>를 적용한다.</li>
        <li>위 예제의 <code>rnk</code>를 계산한 뒤 바깥 쿼리에서 <code>rnk &lt;= 2</code>를 적용한다.</li>
        <li>위 예제의 <code>dense_rnk</code>를 계산한 뒤 바깥 쿼리에서 <code>dense_rnk &lt;= 2</code>를 적용한다.</li>
      </ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> 팀마다 상위 두 점수 묶음과 그 묶음에 속한 동점 행이 모두 남습니다. 1번은 팀마다 두 행까지만 남겨 B팀의 85점 동점 행 하나를 빼게 됩니다. 2번은 A팀의 88점이 RANK 3이므로 두 번째 점수 묶음 전체를 빼게 됩니다.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="ranking-practice">
      <h2 id="ranking-practice">SQLP 11월 세트에서 동점 처리 연습하기</h2>
      <p>순위 규칙을 정한 뒤 SQLP 11월 세트에서 동점 처리와 정렬 기준을 묻는 문제를 풀어 보세요.</p>
      <ExamLink href={sqlpRankingPost.practicePath}>SQLP 11월 연습문제 풀기</ExamLink>
    </aside>
  </>;
}
