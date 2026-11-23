import { cookingYieldPost, koreanCookingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function CookingYieldArticle() {
  return <>
    <p className={styles.lead}>30인분에 손질한 채소가 1.8 kg 필요하고 수율이 75%라면, 구입량도 1.8 kg일까요? <strong>구입량에서 가식부량을 구할 때는 수율을 곱하고, 필요한 가식부량에서 구입량을 구할 때는 수율로 나눕니다.</strong> 같은 작업을 앞뒤로 계산해 보세요.</p>
    <p>Quizeey가 만든 학습 사례와 확인 문제입니다. 공식 기출문제가 아니며 아래 수율은 계산을 위해 주어진 가정입니다. 이 글의 가식부량은 <strong>손질 후, 조리 전의 사용할 수 있는 중량</strong>으로 통일합니다.</p>
    <section aria-labelledby="yield-terms"><h2 id="yield-terms">먼저 구입량과 가식부량을 나누세요</h2>
      <p>채소 2 kg을 구입해 손질한 뒤 1.5 kg이 남았다고 가정합니다. 제거한 부분은 0.5 kg입니다. 분모를 무엇으로 삼는지에 따라 계산의 뜻이 달라집니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="구입량과 가식부 수율 표, 가로로 스크롤 가능" tabIndex={0}><table className={styles.table}>
        <caption>같은 손질 작업의 중량과 비율</caption><thead><tr><th scope="col">구분</th><th scope="col">계산</th><th scope="col">결과</th></tr></thead>
        <tbody><tr><th scope="row">구입량</th><td>손질하기 전 전체 중량</td><td>2 kg</td></tr><tr><th scope="row">가식부량</th><td>손질 후 사용할 수 있는 중량</td><td>1.5 kg</td></tr><tr><th scope="row">가식부 수율</th><td>1.5 ÷ 2 × 100</td><td>75%</td></tr><tr><th scope="row">손실률</th><td>0.5 ÷ 2 × 100</td><td>25%</td></tr></tbody>
      </table></div>
      <p>이 사례에서는 가식부량과 제거량을 더하면 구입량이 되므로 수율과 손실률의 합은 100%입니다. <strong>손실률 25%를 수율 자리에 넣지 마세요.</strong> 구입형태(AP, as purchased)와 가식부(EP, edible portion)를 구분하는 것은 USDA Food Buying Guide에서도 쓰는 원칙입니다.</p>
    </section>
    <section aria-labelledby="yield-forward"><h2 id="yield-forward">구입량을 알면 수율을 곱합니다</h2>
      <p>주어진 수율 75%를 계산에 넣을 때는 <strong>0.75</strong>로 씁니다. 같은 조건에서 2.4 kg을 구입했다면 다음과 같이 계산합니다.</p>
      <p><strong>가식부량 = 구입량 × 수율 = 2.4 kg × 0.75 = 1.8 kg</strong></p>
      <p>구입량 전체를 사용할 수 있는 것은 아니므로 결과가 더 작아집니다. 2.4 × 75로 계산하면 백분율을 소수로 바꾸는 단계를 빠뜨린 것입니다. 이 결과는 조리 후 음식의 중량이 아닙니다.</p>
    </section>
    <section aria-labelledby="yield-reverse"><h2 id="yield-reverse">필요한 가식부량을 알면 수율로 나눕니다</h2>
      <p>이번에는 한 사람에게 손질한 채소 60 g씩, 30인분이 필요합니다. 먼저 필요한 양을 같은 단위로 모읍니다.</p>
      <ol><li>필요한 가식부량: 60 g × 30 = 1,800 g = 1.8 kg</li><li>예상 구입량: 1.8 kg ÷ 0.75 = <strong>2.4 kg</strong></li><li>역으로 확인: 2.4 kg × 0.75 = 1.8 kg</li></ol>
      <p>1.8 × 0.75 = 1.35 kg을 구입하면 손질 손실을 보충하지 못합니다. 또 1.8 kg에 25%를 더한 2.25 kg도 충분하지 않습니다. 이 양의 75%는 1.6875 kg이기 때문입니다. 손실률을 단순히 더하는 대신 <strong>남는 비율로 나눈 뒤 다시 곱해 검산</strong>하세요.</p>
      <p>USDA 가이드의 Method 3도 조리 준비에 필요한 중량을 해당 수율로 나누어 구입량을 구합니다. 실제 발주에서는 재료의 구입형태·품질·손질 조건과 포장 단위, 여유량을 별도로 확인해야 합니다. 위 75%는 모든 채소에 적용되는 고정 수율이나 실제 발주 보장치가 아닙니다.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="yield-quiz"><h2 id="yield-quiz">세 문제로 계산 방향 확인하기</h2>
      <p>2026-11-23 Quizeey 원본 확인 문제입니다. 모두 앞서 정한 손질 단계와 주어진 수율을 사용하며 조리 중 수분 변화는 계산하지 않습니다.</p>
      <h3>1. 구입량 2 kg 중 손질 후 1.5 kg이 남았다면 가식부 수율은?</h3><ol><li>25%</li><li>133.3%</li><li>75%</li></ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> 1.5 ÷ 2 × 100 = 75%입니다. 1번은 제거한 부분의 손실률이고, 2번은 구입량과 가식부량의 분자·분모를 뒤집은 값입니다.</p></details>
      <h3>2. 60 g씩 30인분, 가식부 수율 75%일 때 계산상 필요한 구입량은?</h3><ol><li>2.4 kg</li><li>1.35 kg</li><li>2.25 kg</li></ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> 필요한 가식부 1.8 kg을 0.75로 나눕니다. 2번은 역산해야 할 때 수율을 곱했고, 3번은 필요한 가식부량에 손실률 25%를 단순 가산했습니다. 어느 오답도 손질 후 1.8 kg을 확보하지 못합니다.</p></details>
      <h3>3. 구입량 3 kg, 가식부 수율 75%로 60 g씩 온전하게 나누면 최대 몇 인분인가요?</h3><ol><li>50인분</li><li>37인분</li><li>38인분</li></ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 가식부는 3 × 0.75 = 2.25 kg = 2,250 g입니다. 2,250 ÷ 60 = 37.5이므로 60 g을 채운 인분은 최대 37개이고 30 g이 남습니다. 1번은 손질 손실을 무시했고, 3번은 부족한 반 인분을 올림해 38 × 60 = 2,280 g이 필요한 점을 놓쳤습니다.</p></details>
    </section>
    <aside className={styles.cta} aria-labelledby="yield-practice"><h2 id="yield-practice">한식조리 11월 연습에서 직접 계산해 보세요</h2>
      <p>첫 수율 문제부터 답을 고르고 해설의 분자·분모를 확인하세요. 한식조리기능사 11월 자체 제작 회차는 여러 주제의 80문항이며 기본 화면은 20문항으로 시작합니다. 글의 세 확인 문제를 새로 등록한 전용 세트는 아닙니다.</p>
      <ExamLink href={cookingYieldPost.practicePath}>한식조리 11월 연습문제 풀기 →</ExamLink>
      <p>위생 판단도 복습하려면 <a href={koreanCookingPost.path}>교차오염·보관온도 사례</a>로 이어가세요.</p>
    </aside>
    <section className={styles.sources} aria-labelledby="yield-sources"><h2 id="yield-sources">공식 근거와 범위</h2>
      <p>2026-11-23 확인한 식품 구매·수율 자료입니다. 한국 자격시험의 공식 기출문항이나 출제 범위를 보증하는 자료는 아닙니다. 중량 단위와 손질·조리 단계를 통일하고 주어진 수율을 적용하는 원칙을 참고했습니다.</p>
      <ul><li><a href="https://foodbuyingguide.fns.usda.gov/Content/TablesFBG/USDA_FBG_Introduction.pdf">USDA — Food Buying Guide, Introduction (PDF)</a>: 인쇄 쪽 I-20의 AP/EP 정의, I-48 Method 3의 구입량 역산, I-5의 수율 변동 요인.</li></ul>
    </section>
  </>;
}
