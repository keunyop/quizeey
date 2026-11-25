import { baristaMilkSteamingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function BaristaMilkSteamingArticle() {
  return <>
    <p className={styles.lead}>우유가 충분히 따뜻해졌는데도 표면에 큰 기포가 남았다면, 먼저 <strong>공기가 들어갈 때 팁이 어디에 있었는지, 그 뒤 우유가 고르게 돌았는지</strong>를 떠올려 보세요. 라테에서 원하는 마이크로폼은 잔기포가 우유에 고르게 섞여 표면에 윤기가 있고, 따를 때 함께 흐르는 질감입니다.</p>

    <section aria-labelledby="steaming-stages">
      <h2 id="steaming-stages">부피를 만드는 구간과 질감을 만드는 구간</h2>
      <p>수동 스팀 완드를 쓰는 라테 연습을 가정합니다. 초반에는 팁을 우유 표면 가까이에 두어 공기가 조금씩 들어가도록 합니다. 부드러운 소리와 함께 우유의 부피가 늘어나는지 관찰합니다. 팁이 표면에서 지나치게 드러나 우유가 튀면, 피처를 조금 올려 팁 위치를 안정시키세요.</p>
      <p>원하는 만큼 공기가 들어갔다면 피처를 조금 올려 팁을 표면 아래에 둡니다. 새 공기 유입을 줄인 상태에서 우유가 부드럽게 회전하도록 위치와 각도를 조정하면, 들어간 기포를 우유 전체에 고르게 섞기 쉽습니다. 끝까지 부피만 늘리면 두껍고 거친 거품이 생길 수 있습니다. 목표 거품량과 조작은 메뉴, 우유, 기계에 따라 달라지므로 실제 장비의 지침을 따르세요.</p>
      <p><a href="https://au.lamarzoccohome.com/blog/how-to-steam-milk-with-a-home-espresso-machine/">La Marzocco의 수동 스티밍 안내</a>, <a href="https://www.kitchenaid.com/countertop-appliances/pinch-of-help/how-to-steam-milk-for-a-latte">KitchenAid의 라테용 스티밍 안내</a></p>
    </section>

    <section aria-labelledby="steaming-cases">
      <h2 id="steaming-cases">같은 우유와 기계로 비교하는 세 가지 상황</h2>
      <div className={styles.tableWrap} role="region" aria-label="우유 스티밍 관찰 표, 가로로 스크롤 가능" tabIndex={0}>
        <table className={styles.table}>
          <caption>우유 스티밍 중 관찰과 점검 항목</caption>
          <thead><tr><th scope="col">관찰한 결과</th><th scope="col">우선 확인할 변수</th><th scope="col">다음 연습에서 한 가지 바꿔 보기</th></tr></thead>
          <tbody>
            <tr><th scope="row">초반에 우유가 튀면서 큰 기포가 생겼다</th><td>표면에 팁이 얼마나 드러났는지</td><td>초반 팁 위치를 조금 더 안정시킨다</td></tr>
            <tr><th scope="row">초반부터 팁이 깊었고, 따뜻해지는 동안 부피는 거의 늘지 않았다</th><td>공기 유입에 필요한 표면 가까운 구간이 있었는지</td><td>다음 피처의 초반에만 팁을 표면 가까이 둔다</td></tr>
            <tr><th scope="row">초반 부피는 충분했지만 우유가 거의 돌지 않고 거품이 표면에 모였다</th><td>공기 주입 뒤 회전이 이어졌는지</td><td>추가 공기 유입을 줄인 상태에서 피처 각도를 조정한다</td></tr>
          </tbody>
        </table>
      </div>
      <p>한 번의 관찰로 원인을 확정하기는 어렵습니다. 같은 우유·분량·기계로 비교하고 팁 위치나 각도 중 하나만 바꾸면, 결과가 달라진 이유를 추적하기 쉽습니다. 공기 유입과 회전의 단서는 제조사 설명서에서도 따로 제시합니다. <a href="https://www.breville.co.uk/media/useandcare/instruction/breville/vcf160.pdf">Breville VCF160 설명서의 우유 질감 항목</a></p>
    </section>

    <section className={styles.quiz} aria-labelledby="steaming-quiz">
      <h2 id="steaming-quiz">확인 문제 세 개</h2>
      <p>Quizeey가 위 상황을 바탕으로 만든 연습 문제입니다.</p>
      <h3>1. 라테용 우유의 부피가 목표에 도달했다. 표면에 거품이 띠처럼 모이고 피처 안의 우유가 거의 돌지 않는다. 지금 무엇을 점검할까?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li>팁을 더 드러내 공기를 계속 넣는다.</li><li>팁을 표면 아래에 두고 피처 각도를 조정해 회전을 만든다.</li><li>피처 각도는 그대로 두고 온도만 더 높인다.</li>
      </ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 부피가 이미 충분하므로 거품을 고르게 섞는 회전이 우선입니다. 1번은 공기량을 더 늘려 두꺼운 거품을 만들 수 있습니다. 3번은 가열을 늘려도 회전이 약한 원인을 점검할 수 없습니다.</p></details>

      <h3>2. 같은 우유와 장비를 두 번 사용했다. 첫 번째 피처는 팁이 표면에서 크게 드러나며 우유가 튀고 초반부터 큰 기포가 생겼다. 두 번째 시도에서 가장 먼저 바꿀 것은?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li>초반 피처 높이를 조금 조정해 팁에서 공기가 소량씩 들어가게 한다.</li><li>초반부터 팁을 깊이 잠근 채 가열이 끝날 때까지 둔다.</li><li>팁 위치를 그대로 두고 온도 목표만 낮춘다.</li>
      </ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> 초반 팁 위치를 먼저 바꾸면 한 변수를 비교할 수 있습니다. 2번은 튐을 줄일 수 있어도 공기가 충분히 들어갈 구간까지 없앱니다. 3번은 목표 온도만 바꾸므로 관찰된 팁 위치와 거친 공기 유입은 그대로입니다.</p></details>

      <h3>3. 스티밍을 끝까지 하는 동안 팁은 깊이 잠겨 있었다. 우유가 따뜻해졌지만 부피 변화가 거의 없었다. 다음 연습의 비교 조건으로 가장 알맞은 것은?</h3>
      <ol style={{ listStyleType: 'decimal', paddingInlineStart: 24 }}>
        <li>같은 깊이에서 가열 시간만 늘린다.</li><li>우유 종류와 분량, 팁 위치를 모두 동시에 바꾼다.</li><li>같은 우유·분량·기계를 쓰고 초반에만 팁을 표면 가까이 둔다.</li>
      </ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> 공기 주입 구간을 추가해 부피와 질감이 달라지는지 확인할 수 있습니다. 1번은 공기 유입 조건을 바꾸지 않고 열만 더합니다. 2번은 결과가 달라져도 어느 변수가 작용했는지 판단하기 어렵습니다.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="steaming-practice">
      <h2 id="steaming-practice">바리스타 2급 11월 연습으로 확인하세요</h2>
      <p>기포가 보인 시점과 이후 회전 여부를 구분한 뒤, 11월 세트의 큰 기포 관련 문제에서 관찰과 원인을 연결해 보세요.</p>
      <ExamLink href={baristaMilkSteamingPost.practicePath}>바리스타 2급 11월 연습 20문항 풀기</ExamLink>
    </aside>
  </>;
}
