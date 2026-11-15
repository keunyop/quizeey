import { makeupHygienePost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function MakeupHygieneArticle() {
  return <>
    <p className={styles.lead}>메이크업 필기 위생 문제에서는 <strong>손, 도구, 제품을 각각 확인</strong>하세요. 손을 씻었다고 사용한 도구가 깨끗해지는 것은 아니며, 마른 마스카라에 물을 넣는 행동도 제품의 오염 문제를 해결하지 못합니다. 눈 화장품을 사용하는 세 가지 상황으로 판단의 근거를 익혀 봅시다.</p>
    <section aria-labelledby="makeup-checkpoints"><h2 id="makeup-checkpoints">손·도구·제품: 무엇을 확인하는 문제일까요?</h2>
      <div className={styles.tableWrap} role="region" aria-label="메이크업 위생 판단 기준" tabIndex={0}><table className={styles.table}>
        <caption>같은 위생 문제라도 관리 대상은 다릅니다</caption>
        <thead><tr><th scope="col">대상</th><th scope="col">확인할 점</th><th scope="col">잘못된 판단</th></tr></thead>
        <tbody><tr><th scope="row">손</th><td>눈 화장 전 손 위생을 했는가?</td><td>깨끗해 보이면 씻을 필요가 없다.</td></tr><tr><th scope="row">도구</th><td>눈 주위에 사용하는 도구가 깨끗한가?</td><td>손을 씻었으니 사용한 도구도 그대로 쓴다.</td></tr><tr><th scope="row">제품</th><td>공유·오염·변질 가능성을 점검했는가?</td><td>마른 마스카라에 물을 넣으면 다시 안전해진다.</td></tr></tbody>
      </table></div>
      <p>미국 FDA의 눈 화장품 안전 안내는 사용 전 손을 씻고, 눈 주위에 사용하는 도구를 깨끗하게 관리하며, 눈 화장품을 다른 사람과 공유하지 말라고 설명합니다. 아래 예제는 이 일반 안전 원칙을 판단 연습으로 바꾼 것입니다. 국내 자격시험의 공식 기출문제나 법정 소독 기준을 재현한 것이 아닙니다.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="makeup-mascara"><p className={styles.eyebrow}>직접 만든 확인 문제 · 실제 기출문제 아님</p><h2 id="makeup-mascara">사례 1: 마른 마스카라에 물을 넣어도 될까요?</h2>
      <p>마스카라가 말라 잘 발리지 않습니다. 가장 적절한 행동을 고르세요.</p>
      <ol><li>물을 조금 넣고 흔들어 계속 사용한다.</li><li>침을 묻히면 원래 점도로 돌아오므로 계속 사용한다.</li><li>물을 섞어 되살리려 하지 않고 마른 마스카라를 폐기한다.</li></ol>
      <details><summary>사례 1 정답과 선택지별 이유</summary><p><strong>정답은 3번입니다.</strong> FDA는 마른 마스카라를 버리고 물이나 침을 넣지 말라고 안내합니다. 1번은 물이 세균을 유입할 수 있고 미생물 증식을 막는 보존제를 희석할 수 있어 부적절합니다. 2번은 입안의 세균이 제품에서 자라 감염을 일으킬 수 있어 부적절합니다. 발림성이 돌아왔다는 사실은 안전성이 회복됐다는 근거가 아닙니다.</p></details>
    </section>
    <section aria-labelledby="makeup-hands"><h2 id="makeup-hands">손을 씻는 과정도 나누어 읽으세요</h2>
      <p>CDC가 제시하는 손씻기는 <strong>적시기 → 비누 거품 내기 → 문지르기 → 헹구기 → 말리기</strong>의 순서입니다. 손등, 손가락 사이, 손톱 밑도 씻으며, <strong>문지르는 시간은 최소 20초</strong>입니다. 손을 잠깐 물에 대는 것과 비누로 구석구석 문지르는 것을 같은 행동으로 읽지 마세요.</p>
      <p>이 절차는 손의 위생을 위한 것입니다. 사용한 도구나 오염된 제품까지 처리해 주지는 않습니다. 도구 관리 문제라면 용도·재질과 해당 제품의 사용 지침을 별도로 확인해야 합니다. 손 위생 하나만으로 모든 오염 관리가 끝난다는 선택지는 관리 대상을 혼동한 것입니다.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="makeup-tester"><h2 id="makeup-tester">사례 2: 매장 눈 화장품을 시험해 본다면?</h2>
      <p>눈 화장품 테스터를 사용하려고 합니다. FDA 안내에 맞는 방법을 고르세요.</p>
      <ol><li>앞사람이 사용한 어플리케이터를 겉만 닦아 사용한다.</li><li>깨끗한 면봉 같은 일회용 어플리케이터로 적용한다.</li><li>손만 씻었으면 다른 사람의 마스카라를 함께 사용한다.</li></ol>
      <details><summary>사례 2 정답과 선택지별 이유</summary><p><strong>정답은 2번입니다.</strong> FDA는 매장에서 눈 화장품을 시험할 때 깨끗한 면봉 같은 일회용 어플리케이터를 사용하도록 안내합니다. 1번은 겉을 닦는 것만으로 도구가 깨끗하게 관리됐다고 단정합니다. 3번은 손 위생과 제품 공유 문제를 혼동합니다. 일회용 도구를 쓴다는 사실도 이미 오염된 제품을 안전하게 만들어 주지는 않습니다.</p></details>
    </section>
    <section aria-labelledby="makeup-irritation"><h2 id="makeup-irritation">사례 3: 눈 화장품을 쓰다가 자극이 생겼다면?</h2>
      <p>같은 제품을 더 덧바르거나 다른 색으로 가리는 대신 <strong>해당 제품 사용을 즉시 중단</strong>합니다. FDA는 자극이 계속되면 의사를 보라고 안내합니다. 또한 눈에 감염이 있거나 눈 주위 피부에 염증이 있으면 회복될 때까지 눈 화장품 사용을 피하도록 설명합니다.</p>
      <p>문제를 풀 때는 “평소 쓰던 제품이므로 계속 사용한다”보다 지금 나타난 반응을 먼저 확인하세요. 메이크업 작업자가 증상만 보고 질환을 확정하거나 치료하는 것으로 해석하지 않습니다.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="makeup-practice"><h2 id="makeup-practice">세 가지 기초 위생 문항으로 이어가세요</h2>
      <p>Quizeey 미용사(메이크업)의 2026년 10월 연습 세트에는 도구 관리, 손 위생, 화장품 사용 전 이상 반응 경험 확인을 다루는 자체 제작 문항 3개가 있습니다. 미용 분야 공통 기초 문항이며 메이크업 필기 전체 범위를 다루지는 않습니다. 답을 고른 뒤 손·도구·제품 중 무엇을 묻는지 해설과 비교해 보세요.</p>
      <ExamLink href={makeupHygienePost.practicePath}>메이크업 기초 위생 3문제 풀기 →</ExamLink>
    </aside>
    <section className={styles.sources} aria-labelledby="makeup-sources"><h2 id="makeup-sources">출처와 적용 범위</h2>
      <p><a href="https://www.fda.gov/cosmetics/cosmetic-products/eye-cosmetic-safety">미국 FDA: Eye Cosmetic Safety</a> — 눈 화장 전 손 위생, 도구 청결, 화장품 공유 금지, 테스터의 일회용 도구, 마른 마스카라 및 자극 발생 시 대응을 확인했습니다.</p>
      <p><a href="https://www.cdc.gov/clean-hands/about/index.html">미국 CDC: About Handwashing</a> — 비누와 흐르는 물을 사용하는 손씻기 과정과 최소 20초 문지르기를 확인했습니다.</p>
      <p>출처 확인일: 2026년 11월 15일. 두 자료는 일반 위생 학습을 위한 공식 보건 자료이며 한국 미용사(메이크업) 시험의 출제기준이나 국내 영업장 법규를 대신하지 않습니다. 이 글의 사례와 연결된 연습문항은 공식 기출문제가 아닙니다.</p>
    </section>
  </>;
}
