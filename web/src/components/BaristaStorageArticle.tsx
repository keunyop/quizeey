import { baristaStoragePost, baristaExtractionPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function BaristaStorageArticle() {
  return <>
    <p className={styles.lead}>원두를 밀폐했는데도 창가에 두면 괜찮을까요? 바리스타 기초를 공부할 때는 <strong>용기의 밀폐·차광과 보관 장소를 함께</strong> 판단하세요. 아래 세 배치를 비교하고, 필요한 양을 언제 갈지 결정한 뒤 디개싱과 산화를 구분해 봅니다.</p>
    <p>Quizeey가 만든 개념 사례와 확인 문제이며 협회 공식 기출문제가 아닙니다. 특정 제품의 품질시험이나 모든 원두에 적용되는 보관 기한을 제시하는 자료도 아닙니다.</p>
    <section aria-labelledby="storage-cases"><h2 id="storage-cases">같은 원두, 세 보관 배치 비교하기</h2>
      <p>오늘 사용할 같은 원두를 세 곳에 나눴다고 가정합니다. 공기·습기·열·빛의 영향을 줄이려는 목적에서 어느 배치가 더 적절한지 판단해 보세요. 표는 조건을 드러낸 학습 사례입니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="원두 보관 배치 표, 가로로 스크롤 가능" tabIndex={0}><table className={styles.table}>
        <caption>원두 보관 배치 세 가지</caption><thead><tr><th scope="col">배치</th><th scope="col">용기와 위치</th><th scope="col">판단 근거</th></tr></thead>
        <tbody><tr><th scope="row">A</th><td>밀폐한 투명통, 오후 햇빛이 드는 창가</td><td>밀폐해도 빛과 주변 열의 영향이 남습니다.</td></tr><tr><th scope="row">B</th><td>적합한 밀폐 불투명통, 열원에서 떨어진 서늘하고 어두운 자리</td><td>밀폐·차광·위치 조건을 함께 관리합니다.</td></tr><tr><th scope="row">C</th><td>뚜껑이 느슨한 불투명통, 따뜻한 기계 위</td><td>차광만으로 공기와 열 문제를 해결하지 못합니다.</td></tr></tbody>
      </table></div>
      <p>이 조건에서는 <strong>B</strong>를 고릅니다. “밀폐”나 “불투명”이라는 단어 하나로 판단을 끝내지 않는 것이 핵심입니다. NCA는 밀폐·차광과 서늘하고 어두운 보관 위치를 안내합니다. B도 원두 상태와 개봉·사용 방식에 관계없이 일정 기간의 품질을 보장하는 선택은 아닙니다.</p>
    </section>
    <section aria-labelledby="storage-grind"><h2 id="storage-grind">내일 쓸 양까지 미리 갈아 둘까요?</h2>
      <p>같은 원두를 쓰는 두 작업을 비교해 봅니다. 하나는 며칠 쓸 양을 미리 전부 갈아 두는 작업이고, 다른 하나는 원두를 적합하게 보관하다가 <strong>필요한 양을 추출 직전에 분쇄</strong>하는 작업입니다. 향미 변화를 줄이는 관리 원칙으로는 뒤의 작업이 적절합니다.</p>
      <p>SCA의 설명에서는 분쇄 후 CO₂ 방출이 통원두보다 빠르게 진행됩니다. 입도를 맞추는 일과 보관·분쇄 시점을 관리하는 일은 함께 필요합니다. “더 곱게 갈면 오래 보관해도 변화가 멈춘다”는 뜻은 아닙니다. 특정 분 수가 지나면 사용할 수 없다는 기준이나 새 장비 구매 조건으로 해석하지 마세요.</p>
    </section>
    <section aria-labelledby="storage-degassing"><h2 id="storage-degassing">디개싱과 산화는 같은 말이 아닙니다</h2>
      <dl><dt><strong>디개싱</strong></dt><dd>로스팅된 원두에 남은 이산화탄소(CO₂)가 밖으로 나오는 과정입니다.</dd><dt><strong>산화</strong></dt><dd>산소가 원두의 오일·향 성분 등과 반응하는 과정으로, 향미 변화와 관련됩니다.</dd></dl>
      <p>가스가 나온다는 관찰을 “산소를 넣는 작업”으로 설명하면 두 개념을 혼동하게 됩니다. CO₂ 방출이 끝났다고 다른 변화까지 모두 멈추는 것도 아닙니다. 크레마나 블룸의 양 하나만으로 모든 원두의 품질과 안전을 확정하지 마세요.</p>
      <p>작은 관리 기록에는 로스팅·개봉 정보, 용기의 닫힘, 빛·열을 받는 위치, 분쇄 시점을 적어 보세요. 창가에서 자리를 옮기는 것처럼 한 조건을 바꿔 비교하되, 이 글의 배치가 실제 비교 실험 결과라고 해석하지 않습니다. 냉장·냉동의 세부 절차와 보관 기한은 여기서 다루지 않습니다.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="storage-quiz"><h2 id="storage-quiz">세 문제로 판단 근거 확인하기</h2>
      <p>2026-11-22 Quizeey 원본 확인 문제입니다. 앞 사례의 조건을 기준으로 답을 고르세요.</p>
      <h3>1. 세 배치 중 관리 목적에 가장 맞는 선택은?</h3><ol><li>B: 적합한 밀폐 불투명통을 서늘하고 어두운 곳에 둔다.</li><li>A: 밀폐했으므로 투명통을 햇빛 드는 창가에 둬도 조건은 같다.</li><li>C: 불투명통이면 뚜껑과 따뜻한 위치는 살피지 않아도 된다.</li></ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> B는 여러 조건을 함께 봅니다. 2번은 밀폐가 빛·열까지 해결한다고 오해했고, 3번은 차광이 느슨한 뚜껑·열원 문제도 없앤다고 가정했습니다. 이 선택이 무기한 품질 보장은 아닙니다.</p></details>
      <h3>2. 필요한 양을 추출 직전에 분쇄하는 이유는?</h3><ol><li>원두를 갈면 이후 향미 변화가 완전히 멈추기 때문이다.</li><li>분쇄만 하면 보관 용기와 위치는 품질에 영향을 주지 않기 때문이다.</li><li>분쇄 후 빠르게 진행될 수 있는 가스 방출과 향미 변화를 고려하기 때문이다.</li></ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> 분쇄 시점을 관리하는 목적을 설명합니다. 1번은 분쇄가 변화를 정지시킨다는 오해이고, 2번은 분쇄가 보관 관리를 대신한다는 오해입니다. 향미 관리 원칙과 일률적인 사용 가능 시간을 구분하세요.</p></details>
      <h3>3. 두 용어를 바르게 구분한 설명은?</h3><ol><li>디개싱은 외부 산소를 원두에 넣는 과정이며 산화와 동의어다.</li><li>디개싱은 CO₂ 방출이고, 산화는 산소가 원두 성분과 반응하는 과정이다.</li><li>원두에서 CO₂가 빠져나오면 모든 성분 변화가 끝난다.</li></ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 방출되는 가스와 산소 반응을 구분합니다. 1번은 가스의 종류와 이동을 혼동했고, 3번은 가스 방출을 모든 변화의 종료로 확대했습니다. 두 용어만으로 특정 원두의 잔존 가스량이나 품질을 확정할 수는 없습니다.</p></details>
    </section>
    <aside className={styles.cta} aria-labelledby="storage-practice"><h2 id="storage-practice">바리스타 2급 11월 연습으로 확인하세요</h2>
      <p>보관·분쇄 시점 외에도 추출과 위생 등을 포함하는 한국어 자체 제작 20문항입니다. 보관 문제만 모은 세트나 글의 세 문제를 새로 등록한 세트가 아니며 공식 기출문제로 제공하지 않습니다.</p>
      <ExamLink href={baristaStoragePost.practicePath}>바리스타 2급 11월 연습문제 풀기 →</ExamLink>
      <p>답을 제출한 뒤 해설에서 선택 이유를 확인하세요. 추출 수치를 복습하려면 <a href={baristaExtractionPost.path}>에스프레소 추출 비율·분쇄도 판단</a> 글로 이어갈 수 있습니다.</p>
    </aside>
    <section className={styles.sources} aria-labelledby="storage-sources"><h2 id="storage-sources">공식 근거와 범위</h2>
      <p>2026-11-22 확인한 커피 협회 지식 자료입니다. NCA·SCA의 안내가 특정 바리스타 2급 자격시험의 공식 문항이나 출제 범위를 보증한다는 뜻은 아닙니다.</p>
      <ul><li><a href="https://www.aboutcoffee.org/beans/storage-and-shelf-life/">NCA — Storage and shelf life</a>: 보관 조건과 분쇄 시점.</li><li><a href="https://sca.coffee/sca-news/coffee-decoded-9-fresh-coffee">SCA — What is “freshly roasted” coffee?</a>: 디개싱·산화와 분쇄 후 변화.</li></ul>
    </section>
  </>;
}
