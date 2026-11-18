import { cookingInfectionPost, koreanCookingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function CookingInfectionArticle() {
  return <>
    <p className={styles.lead}>한식조리기능사 필기에서 감염병을 구분할 때는 <strong>병원체가 어디에서 나와 어떤 경로로 들어가는지</strong>를 연결해 보세요. 장티푸스·세균성이질·폴리오는 분변에 오염된 손·물·음식 등을 통한 경구 감염을 공부할 때 함께 살펴볼 수 있습니다. 유행성이하선염은 침과 호흡기 비말을 통한 전파가 중심입니다. 다만 입으로 들어온다는 공통점만으로 두 경로를 같은 것으로 묶으면 오답을 고르기 쉽습니다.</p>

    <section aria-labelledby="infection-route-rule"><h2 id="infection-route-rule">먼저 구분할 것: 분변-경구와 침·비말</h2>
      <p><strong>분변-경구 경로</strong>는 분변으로 나온 병원체가 손·물·음식 등을 거쳐 입으로 들어가는 흐름입니다. 눈에 보이는 분변을 직접 먹는 상황만 뜻하지 않습니다. 오염된 손으로 음식을 만져 병원체가 옮겨 가는 상황도 포함합니다.</p>
      <p><strong>침·호흡기 비말을 통한 전파</strong>는 감염된 사람의 침이나 입·코·목에서 나온 비말과의 접촉에 주목합니다. 유행성이하선염은 기침·재채기·대화뿐 아니라 침이 묻은 컵이나 물병을 함께 쓰는 행동으로도 전파될 수 있습니다. 따라서 “컵이 등장했으니 분변-경구 감염”이라고 판단할 수 없습니다.</p>
      <p>문제의 단서에서 <strong>오염원 → 매개물 → 입으로 들어가는 경로</strong>를 찾아보세요. 물·음식·컵이라는 물건 이름만으로 감염 경로를 결정하지 않는 것이 핵심입니다.</p>
    </section>

    <section aria-labelledby="infection-comparison"><h2 id="infection-comparison">네 감염병의 전파 경로 비교</h2>
      <div className={styles.tableWrap} role="region" aria-label="네 감염병 전파 경로 비교 표, 가로로 스크롤 가능" tabIndex={0}>
        <table className={styles.table}>
          <caption>공식 자료의 전파 설명을 식품위생 학습용으로 요약했습니다.</caption>
          <thead><tr><th scope="col">감염병</th><th scope="col">전파 경로의 핵심</th><th scope="col">헷갈리기 쉬운 점</th></tr></thead>
          <tbody>
            <tr><th scope="row">장티푸스</th><td>환자나 보균자의 분변에 오염된 물·음식 섭취</td><td>물·음식의 오염원을 분변과 연결합니다.</td></tr>
            <tr><th scope="row">세균성이질</th><td>분변에서 나온 이질균이 손·음식·물 등을 거쳐 입으로 들어옴</td><td>음식뿐 아니라 오염된 손에서 입으로 옮겨 갈 수도 있습니다.</td></tr>
            <tr><th scope="row">폴리오</th><td>주로 사람 간 분변-경구 전파, 덜 흔하게 오염된 물·음식이 매개</td><td>바이러스성이라는 이유로 경구 감염에서 제외하지 않습니다.</td></tr>
            <tr><th scope="row">유행성이하선염</th><td>침과의 직접 접촉 또는 호흡기 비말</td><td>침이 묻은 컵·물병 공유도 가능하므로 음식·물과 절대 무관하다고 단정하지 않습니다.</td></tr>
          </tbody>
        </table>
      </div>
      <p>이 표는 주요 전파 경로를 비교한 것입니다. 모든 감염병의 전파 방식을 빠짐없이 나열하거나, 물건 하나만으로 실제 감염 원인을 판정하는 표는 아닙니다.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="infection-cases"><p className={styles.eyebrow}>직접 만든 선택형 학습 사례 · 공식 기출문제 아님</p><h2 id="infection-cases">단서를 바꿔 가며 세 문제 풀기</h2>
      <h3>1. 주요 전파 경로가 다른 하나는?</h3>
      <p>다음 중 다른 세 감염병의 분변-경구 경로와 구별하여, 침·호흡기 비말을 통한 전파에 중심을 두고 학습할 것은 무엇인가요?</p>
      <ol><li>장티푸스</li><li>세균성이질</li><li>폴리오</li><li>유행성이하선염</li></ol>
      <details><summary>사례 1 정답과 선택지별 이유</summary>
        <p><strong>정답은 4번, 유행성이하선염입니다.</strong> CDC는 침과의 직접 접촉이나 호흡기 비말을 통한 전파를 설명합니다.</p>
        <ul><li><strong>1번:</strong> 장티푸스는 분변에 오염된 물·음식 섭취와 연결되므로 이 질문의 답이 아닙니다.</li><li><strong>2번:</strong> 세균성이질은 이질균이 묻은 손·음식·물 등에서 균을 삼켜 감염될 수 있습니다.</li><li><strong>3번:</strong> 폴리오는 주로 분변-경구 경로로 전파됩니다. 바이러스성 질환이라는 사실은 전파 경로를 구분하는 근거가 아닙니다.</li></ul>
      </details>

      <h3>2. 유행성이하선염과 컵 공유를 연결하는 설명은?</h3>
      <p>학습 자료에 “침이 묻은 컵을 함께 쓰는 행동으로 유행성이하선염 바이러스가 전파될 수 있다”는 설명이 있습니다. 이를 가장 정확하게 이해한 것은 무엇인가요?</p>
      <ol><li>물을 마시는 행동이므로 반드시 분변-경구 전파이다.</li><li>컵에 남은 침과의 접촉이 전파의 단서이다.</li><li>호흡기 비말로 전파되므로 컵 공유는 관련이 없다.</li><li>컵만 공유하지 않으면 다른 전파 경로는 없다.</li></ol>
      <details><summary>사례 2 정답과 선택지별 이유</summary>
        <p><strong>정답은 2번입니다.</strong> 물이나 컵이라는 이름보다 침이 묻었다는 오염원에 주목해야 합니다.</p>
        <ul><li><strong>1번:</strong> 분변이 오염원이라는 단서가 없습니다. 물을 마신다는 사실만으로 분변-경구 전파가 되지는 않습니다.</li><li><strong>3번:</strong> CDC는 호흡기 비말 외에 침과의 접촉, 침이 묻은 컵·물병 공유도 설명합니다.</li><li><strong>4번:</strong> 기침·재채기·대화와 밀접한 접촉 등 다른 전파 기회도 있습니다. 한 행동만으로 모든 경로를 설명할 수 없습니다.</li></ul>
      </details>

      <h3>3. 폴리오의 전파 경로를 요약한다면?</h3>
      <p>WHO의 설명에 맞는 요약을 하나 고르세요.</p>
      <ol><li>바이러스가 원인이므로 주된 전파 경로는 호흡기 비말이다.</li><li>신경계에 영향을 주므로 입으로 들어오는 경로는 없다.</li><li>주로 분변-경구 경로로 전파되며, 덜 흔하게 오염된 물·음식이 매개가 된다.</li><li>오염된 음식으로만 전파되며 사람 간 전파는 없다.</li></ol>
      <details><summary>사례 3 정답과 선택지별 이유</summary>
        <p><strong>정답은 3번입니다.</strong> WHO는 주로 사람 간 분변-경구 전파를 설명하고, 오염된 물·음식과 같은 공통 매개물을 통한 전파는 덜 흔하다고 설명합니다.</p>
        <ul><li><strong>1번:</strong> 병원체가 바이러스인지 세균인지와 전파 경로는 별도로 확인해야 합니다.</li><li><strong>2번:</strong> 영향을 받는 신체 부위와 병원체가 몸에 들어오는 경로는 서로 다른 개념입니다.</li><li><strong>4번:</strong> 음식만으로 한정하면 WHO가 설명한 사람 간 분변-경구 경로와 오염된 물을 빠뜨립니다.</li></ul>
      </details>
    </section>

    <section aria-labelledby="infection-review"><h2 id="infection-review">오답을 복습하는 한 줄 메모</h2>
      <p>“장티푸스·세균성이질·폴리오: 분변에서 입으로 이어지는 경로 확인 / 유행성이하선염: 침·호흡기 비말 확인”처럼 적어 보세요. 그다음 <strong>컵 공유의 침과 분변에 오염된 물은 같은 단서가 아니다</strong>라고 덧붙이면 단순 암기에서 놓치기 쉬운 차이를 확인할 수 있습니다.</p>
      <p>한식조리기능사 필기 기출문제를 복습할 때도 정답 번호보다 문제에서 묻는 “주요 경로”와 “가능한 경로”의 차이를 확인하세요. 이 글의 세 문항은 개념을 설명하기 위해 새로 만든 연습문제이며, 특정 회차의 기출이나 출제기관의 공식 해설이 아닙니다.</p>
      <p>손·도구를 통한 교차오염과 보관 온도는 <a href={koreanCookingPost.path}>한식조리기능사 식품위생 사례</a>에서 이어서 공부할 수 있습니다.</p>
    </section>

    <aside className={styles.cta} aria-labelledby="infection-practice"><h2 id="infection-practice">한식조리기능사 연습으로 이어 가세요</h2>
      <p>아래 링크는 2026년 10월 한식조리기능사 원본 연습 세트로 이어집니다. 여러 영역을 함께 다루므로 이 글의 감염병 문제만 모은 세트는 아닙니다. 답을 고른 뒤 정답과 해설로 판단 근거를 확인해 보세요.</p>
      <ExamLink href={cookingInfectionPost.practicePath}>한식조리기능사 10월 연습문제 풀기 →</ExamLink>
    </aside>

    <section className={styles.sources} aria-labelledby="infection-sources"><h2 id="infection-sources">공식 근거와 확인 범위</h2>
      <p>2026년 11월 18일 확인. 아래 공식 자료의 전파 경로 설명을 학습용으로 요약했습니다.</p>
      <ul>
        <li><a href="https://www.cdc.gov/typhoid-fever/hcp/clinical-overview/index.html">CDC: 장티푸스·파라티푸스 개요 — Transmission</a>: 환자나 보균자의 분변에 오염된 물·음식 섭취.</li>
        <li><a href="https://www.cdc.gov/shigella/causes/index.html">CDC: 세균성이질 전파 경로</a>: 손·음식·물 등을 통해 이질균이 입으로 들어오는 경로.</li>
        <li><a href="https://www.who.int/news-room/fact-sheets/detail/poliomyelitis">WHO: 폴리오 개요</a>: 주로 분변-경구 경로, 덜 흔하게 오염된 물·음식 등 공통 매개물.</li>
        <li><a href="https://www.cdc.gov/mumps/about/index.html">CDC: 유행성이하선염 개요 — How it spreads</a>: 침·호흡기 비말, 침이 묻은 물병·컵 공유.</li>
      </ul>
    </section>
  </>;
}
