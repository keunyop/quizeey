import { blogPost, printingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function PrintingArticle() {
  return <>
    <p className={styles.lead}>3D프린터운용기능사 필기에서 레이어 설정 문제를 풀 때는 <strong>층 수 = 모델 높이 ÷ 레이어 높이</strong>로 계산하세요. 레이어 높이를 줄이면 보통 층 수와 출력 시간이 늘고, 서포트는 허공에 놓이는 돌출부를 임시로 지지하며, 인필 밀도를 높이면 대체로 재료 사용량과 시간이 증가합니다. 다만 강도와 표면 품질은 배치 방향·외벽·재료에도 좌우되므로 “항상”이라는 선택지는 한 번 더 확인해야 합니다.</p>
    <p>아래 5문제는 개념 연습을 위해 직접 만든 문항이며 한국산업인력공단의 실제 출제 문항이 아닙니다. 먼저 답을 정하고 해설을 연 뒤, 같은 원리를 Quizeey 문제풀이에서 다시 확인해 보세요.</p>

    <section aria-labelledby="printing-layer-count"><h2 id="printing-layer-count">레이어 수는 나눗셈으로 비교하세요</h2>
      <p>높이 24 mm인 모델을 일정한 레이어 높이로 출력한다고 가정하면 기본 층 수는 다음과 같습니다. 실제 출력에서는 첫 층 높이나 가변 레이어 설정에 따라 달라질 수 있습니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="레이어 높이별 기본 층 수" tabIndex={0}><table className={styles.table}>
        <caption>모델 높이 24 mm일 때의 단순 계산</caption>
        <thead><tr><th scope="col">레이어 높이</th><th scope="col">계산</th><th scope="col">기본 층 수</th><th scope="col">일반적인 절충</th></tr></thead>
        <tbody>
          <tr><th scope="row">0.30 mm</th><td>24 ÷ 0.30</td><td>80층</td><td>층 수가 적고 계단 무늬가 더 보일 수 있음</td></tr>
          <tr><th scope="row">0.20 mm</th><td>24 ÷ 0.20</td><td>120층</td><td>시간과 세부 표현의 중간 선택</td></tr>
          <tr><th scope="row">0.10 mm</th><td>24 ÷ 0.10</td><td>240층</td><td>층 수가 많고 출력 시간이 늘 수 있음</td></tr>
        </tbody>
      </table></div>
      <p>레이어 높이를 절반으로 줄이면 이 단순 예제의 층 수는 두 배가 됩니다. 그렇다고 모든 형상의 품질이나 강도가 정확히 두 배가 되는 것은 아닙니다. 노즐 직경, 벽 두께, 속도와 재료 조건을 함께 봐야 합니다.</p>
    </section>

    <section aria-labelledby="printing-settings"><h2 id="printing-settings">서포트와 인필은 목적부터 구분하세요</h2>
      <ol className={styles.studySteps}>
        <li><strong>서포트 · 외부 임시 구조</strong><p>허공에 놓이는 돌출부나 브리지가 처지지 않도록 출력 중 받칩니다. 제거 흔적과 재료·시간 비용이 있으므로 모든 면에 무조건 쓰지 않고 슬라이싱 미리보기를 확인합니다.</p></li>
        <li><strong>인필 · 모델 내부 구조</strong><p>모델 내부를 채우는 패턴과 밀도입니다. 밀도를 높이면 보통 재료와 시간이 늘지만, 필요한 강도는 외벽 수와 힘이 작용하는 방향에도 영향을 받습니다.</p></li>
        <li><strong>배치 방향 · 둘을 바꾸는 결정</strong><p>모델을 돌리면 서포트량, 보이는 표면, 적층 방향에 따른 강도와 출력 시간이 함께 달라질 수 있습니다. 한 조건만 보고 정답을 고르지 않습니다.</p></li>
      </ol>
    </section>

    <section className={styles.quiz} aria-labelledby="printing-quiz"><h2 id="printing-quiz">5문제로 바로 확인하기</h2>
      <p>정답 글자를 외우기보다 계산이나 판단 근거를 한 문장으로 말한 뒤 해설을 여세요.</p>

      <h3>1. 24 mm를 0.2 mm씩 쌓으면?</h3>
      <p>첫 층도 같은 높이라고 가정할 때 기본 층 수는 몇 층일까요?</p>
      <details><summary>1번 정답과 해설</summary><p><strong>120층.</strong> 24 ÷ 0.2 = 120입니다. 단위를 먼저 맞추고 모델 높이를 레이어 높이로 나눕니다.</p></details>

      <h3>2. 레이어 높이를 0.2 mm에서 0.1 mm로 줄이면?</h3>
      <p>같은 높이의 모델에서 일반적으로 예상할 수 있는 변화는 무엇일까요?</p>
      <details><summary>2번 정답과 해설</summary><p><strong>층 수가 늘고 출력 시간이 길어질 수 있으며, 표면의 계단 효과는 줄어들 수 있습니다.</strong> 세부 표현에는 유리할 수 있지만 모든 강도와 품질이 자동으로 좋아진다고 단정할 수는 없습니다.</p></details>

      <h3>3. 서포트의 주된 역할은?</h3>
      <p>FDM 출력에서 서포트를 추가하는 대표적인 이유를 생각해 보세요.</p>
      <details><summary>3번 정답과 해설</summary><p><strong>허공에 놓이는 돌출부의 적층을 임시로 지지하기 위해서입니다.</strong> 서포트는 모델 내부를 채우는 인필과 다르며, 출력 후 제거와 표면 흔적도 고려합니다.</p></details>

      <h3>4. 인필 밀도를 높이면 일반적으로?</h3>
      <p>다른 설정이 같을 때 가장 먼저 예상할 수 있는 변화는 무엇일까요?</p>
      <details><summary>4번 정답과 해설</summary><p><strong>재료 사용량과 출력 시간이 늘어납니다.</strong> 강도도 달라질 수 있지만 외벽과 적층 방향, 재료가 함께 영향을 주므로 인필만으로 강도를 단정하지 않습니다.</p></details>

      <h3>5. 모델의 배치 방향을 정할 때 함께 볼 것은?</h3>
      <p>다음 중 가장 완전한 판단 기준은 “서포트량”, “보이는 표면”, “힘이 작용하는 방향” 중 무엇일까요?</p>
      <details><summary>5번 정답과 해설</summary><p><strong>세 가지를 함께 봐야 합니다.</strong> 방향을 바꾸면 필요한 서포트와 표면 흔적뿐 아니라 적층선에 대한 힘의 방향도 달라질 수 있습니다. 목적에 맞는 절충이 필요합니다.</p></details>
    </section>

    <section aria-labelledby="printing-review"><h2 id="printing-review">틀린 이유를 설정 하나로 줄이세요</h2>
      <ul>
        <li><strong>계산 실수:</strong> “모델 높이 ÷ 레이어 높이” 순서를 식으로 다시 씁니다.</li>
        <li><strong>서포트와 인필 혼동:</strong> 외부 임시 지지인지 내부 구조인지 구분합니다.</li>
        <li><strong>‘항상’ 선택:</strong> 외벽·방향·재료처럼 함께 변하는 조건이 없는지 확인합니다.</li>
        <li><strong>정답은 맞았지만 설명이 안 됨:</strong> 숫자나 용어를 바꾼 유사 문제를 한 번 더 풉니다.</li>
      </ul>
      <p>오답 메모는 “0.1 mm가 무조건 강하다고 생각함 → 레이어 높이는 주로 층 수·시간·수직 해상도와 비교”처럼 내 판단과 수정할 원리를 함께 적으면 됩니다.</p>
    </section>

    <aside className={styles.cta} aria-labelledby="printing-practice"><h2 id="printing-practice">3D프린터운용기능사 문제로 이어서 연습하세요</h2>
      <p>Quizeey의 2026-10 자체 제작 세트에는 레이어 높이, 서포트, 인필, 슬라이서와 안전을 다루는 한국어 연습문제 23개와 해설이 있습니다. 공식 기출문제나 전체 시험 모의고사가 아닙니다.</p>
      <ExamLink href={printingPost.practicePath}>3D프린터운용기능사 문제 풀기 →</ExamLink>
      <p>답을 제출하고 해설을 확인한 뒤, 틀린 문제는 설정 이름보다 원리부터 다시 설명해 보세요.</p>
    </aside>

    <section className={styles.sources} aria-labelledby="printing-sources"><h2 id="printing-sources">출제 범위와 설정 원리 확인하기</h2>
      <p><a href="https://www.q-net.or.kr/cst006.do?id=cst00601&amp;code=1202">Q-Net 출제기준 자료실</a>에서 현재 적용 기간의 3D프린터운용기능사 기준을 직접 확인하세요. 시험 일정이나 범위는 변경될 수 있습니다.</p>
      <p><a href="https://help.prusa3d.com/article/layers-and-perimeters_1748">Prusa Knowledge Base: Layers and perimeters</a> · <a href="https://help.prusa3d.com/article/support-material_1698">Support material</a> · <a href="https://help.prusa3d.com/article/infill_42">Infill</a></p>
      <p>데이터베이스 시험도 준비한다면 <a href={blogPost.path}>SQLD CBT 공부법과 COUNT 예제</a>를 확인하세요.</p>
    </section>
  </>;
}
