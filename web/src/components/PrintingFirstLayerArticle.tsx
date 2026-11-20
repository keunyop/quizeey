import { printingFirstLayerPost, printingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function PrintingFirstLayerArticle() {
  return <>
    <p className={styles.lead}>3D프린터에서 “바닥에 안 붙는다”는 현상은 언제 시작됐는지부터 살펴보세요. <strong>처음부터 선이 떨어지는지, 몇 층을 쌓은 뒤 모서리가 들리는지</strong>에 따라 먼저 확인할 조건이 달라집니다. FDM/FFF 방식의 첫 층을 관찰하는 원본 학습 예제로, 3D프린터운용기능사 필기를 준비할 때 설정 이름과 역할을 구분하는 데 활용할 수 있습니다.</p>
    <p>선의 모양만으로 원인을 확정할 수는 없습니다. 출력판 표면·재료·기종을 함께 확인하고, 제조사 절차에 따라 한 조건씩 비교하세요. 모든 장비에 같은 온도나 Z 오프셋 숫자를 적용하는 방법은 제시하지 않습니다.</p>

    <section aria-labelledby="first-layer-observe"><h2 id="first-layer-observe">첫 층 실패와 워핑: 관찰부터 구분하기</h2>
      <div className={styles.tableWrap} role="region" aria-label="첫 층 관찰 표, 가로로 스크롤 가능" tabIndex={0}>
        <table className={styles.table}>
          <caption>증상은 원인을 좁히는 단서입니다</caption>
          <thead><tr><th scope="col">보이는 현상</th><th scope="col">먼저 확인할 후보</th><th scope="col">피해야 할 단정</th></tr></thead>
          <tbody>
            <tr><th scope="row">출력 시작부터 둥근 선과 선 사이 틈</th><td>노즐과 출력면 간격, 표면 상태, 압출 상태</td><td>온도만 높이면 해결된다</td></tr>
            <tr><th scope="row">지나치게 눌린 선과 솟은 능선</th><td>너무 좁은 노즐 간격, 압출 조건</td><td>안 붙으면 더 낮춰야 한다</td></tr>
            <tr><th scope="row">몇 층 뒤 모서리부터 들림</th><td>워핑 가능성, 재료·형상·냉각·바닥 접착</td><td>바람 하나가 유일한 원인이다</td></tr>
          </tbody>
        </table>
      </div>
      <p>노즐이 너무 높으면 선이 충분히 눌리지 않아 붙지 않을 수 있습니다. 반대로 너무 가까우면 재료가 나올 공간이 부족해 압출을 방해하거나 판을 긁을 수 있습니다. 적절한 간격에서는 선이 알맞게 눌리고 이웃한 선이 고르게 이어지는지 확인합니다. 막힘이나 압출량 문제도 비슷한 모양을 만들 수 있으므로 간격만으로 확진하지 않습니다.</p>
      <p><strong>워핑(warping)</strong>은 출력물의 수축과 온도 차 등이 관여해 모서리가 휘거나 들리는 현상입니다. 특히 넓은 바닥이나 수축이 큰 재료에서 문제가 될 수 있습니다. 첫 층 접착 불량도 들뜸에 영향을 주므로 두 범주가 완전히 독립된 원인은 아닙니다.</p>
    </section>

    <section aria-labelledby="first-layer-cases"><h2 id="first-layer-cases">두 상황에서 점검 순서를 정해 보세요</h2>
      <h3>사례 A · 출력판을 바꾼 뒤 첫 선이 둥글게 놓입니다</h3>
      <p>같은 모델과 필라멘트를 쓰되 출력판을 교체했습니다. 첫 선이 잘 눌리지 않고 옆 선과 틈이 생깁니다. 먼저 올바른 판을 장착했는지, 장비에서 필요한 판 설정과 보정 절차를 적용했는지 확인합니다. 표면은 해당 판·재료에 맞는 제조사 방법으로 준비합니다.</p>
      <p>그다음 노즐 간격과 압출 상태를 확인합니다. 판이 바뀌었다고 반드시 수동 보정을 해야 하는 것은 아닙니다. 자동 보정 기종과 수동 보정 기종의 절차가 다르며, 특정 프린터의 보정값을 다른 장비에 복사하지 않습니다. 첫 층 간격 보정과 슬라이서의 레이어 높이 설정도 같은 항목이 아닙니다.</p>
      <h3>사례 B · 처음에는 붙었지만 넓은 모델의 모서리가 들립니다</h3>
      <p>출력 초반은 괜찮았는데 몇 층 뒤 모서리가 들리고, 이번에는 창문에서 바람이 들어옵니다. 워핑과 주변 온도 변화를 후보로 기록하되, 창문만 원인이라고 결론 내리지 않습니다. 재료 프로파일, 바닥 접착, 모델 형상과 팬 설정도 함께 비교해야 합니다.</p>
      <p>냉각은 재료별 권장 조건에서 점검합니다. 팬을 항상 최대로 하거나 모든 재료를 밀폐하면 된다는 규칙은 없습니다. 브림으로 바닥 접착을 도울 수도 있지만 표면·보정 문제를 대신 해결하는 만능 설정은 아닙니다.</p>
    </section>

    <section aria-labelledby="first-layer-tools"><h2 id="first-layer-tools">스커트·브림·서포트는 역할이 다릅니다</h2>
      <ul>
        <li><strong>스커트:</strong> 보통 모델과 떨어진 둘레선을 먼저 출력해 재료 흐름을 안정시키고 첫 층 상태를 확인합니다. 별도 드래프트 실드 같은 옵션은 슬라이서 설정을 확인하세요.</li>
        <li><strong>브림:</strong> 첫 층 주변 면적을 늘려 바닥 접착을 돕습니다. 모델과의 분리 간격 등 설정에 따라 모양과 제거 특성이 달라집니다.</li>
        <li><strong>서포트:</strong> 허공의 돌출부 등을 출력 중 임시로 받칩니다. 바닥 모서리 접착을 돕는 브림과 목적을 구분합니다.</li>
      </ul>
      <p><a href={printingPost.path}>레이어 높이·서포트·인필 기본 가이드</a>에서 층 수 계산과 내부 구조를 복습한 뒤, 이번에는 바닥에서 관찰한 증상에 어떤 설정이 관련되는지 설명해 보세요.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="first-layer-quiz"><h2 id="first-layer-quiz">새 상황 세 가지로 판단 확인하기</h2>
      <p>Quizeey가 2026-11-20에 직접 작성한 개념 확인 문제입니다. 공식 기출문제가 아니며 전체 출제 범위를 대신하지 않습니다. 답을 고른 이유부터 말한 뒤 해설을 펼치세요.</p>
      <h3>1. 더 낮추기 전에 무엇을 확인할까요?</h3>
      <p>첫 층이 잘 나오지 않아 간격을 줄였더니 선이 지나치게 눌리고 능선이 생겼습니다. 가장 적절한 다음 행동은?</p>
      <ol><li>붙을 때까지 노즐을 계속 낮춘다.</li><li>추가로 낮추지 않고 기종별 보정 절차와 압출 상태를 점검한다.</li><li>브림만 켜면 노즐 간격도 자동으로 맞춰진다.</li></ol>
      <details><summary>1번 정답과 오답 이유</summary><p><strong>정답은 2번입니다.</strong> 너무 가까운 노즐은 압출을 방해하거나 판에 손상을 줄 수 있습니다. 1번은 과근접 가능성을 무시하고, 3번은 바닥 접착을 돕는 브림을 간격 보정과 혼동합니다. Prusa의 First layer issues와 First Layer Calibration 설명을 근거로 했습니다.</p></details>
      <h3>2. 넓은 바닥의 모서리가 나중에 들린다면?</h3>
      <p>같은 재료로 작은 모델은 잘 출력했지만 넓은 모델은 몇 층 뒤 모서리가 들립니다. 무엇을 먼저 판단해야 할까요?</p>
      <ol><li>워핑을 후보로 두고 형상·접착·재료 프로파일·냉각 조건을 비교한다.</li><li>재료와 관계없이 팬을 항상 최대로 설정한다.</li><li>첫 층이 붙었으므로 바닥 접착은 점검할 필요가 없다.</li></ol>
      <details><summary>2번 정답과 오답 이유</summary><p><strong>정답은 1번입니다.</strong> 형상과 열수축·온도 조건, 바닥 접착을 함께 확인해야 합니다. 2번은 재료별 냉각 차이를 무시하고, 3번은 출력 중에도 접착과 수축이 들뜸에 영향을 준다는 점을 놓칩니다. Prusa의 Warping 설명을 근거로 했습니다.</p></details>
      <h3>3. 바닥 접착을 도울 설정은?</h3>
      <p>표면과 노즐 간격을 확인한 뒤, 바닥 면적이 작은 모델 주변의 첫 층 면적을 늘리려 합니다. 가장 직접적인 설정은?</p>
      <ol><li>모델과 떨어진 스커트만 추가한다.</li><li>허공의 돌출부에 서포트만 추가한다.</li><li>브림을 검토하고 분리 간격과 제거 조건을 확인한다.</li></ol>
      <details><summary>3번 정답과 오답 이유</summary><p><strong>정답은 3번입니다.</strong> 브림은 첫 층 면적을 늘려 접착을 돕습니다. 1번의 일반적인 스커트는 재료 흐름과 첫 층 상태 확인에 쓰이고, 2번의 서포트는 돌출부 지지가 목적입니다. 브림이 모든 들뜸을 방지한다고 보장할 수는 없습니다. Prusa의 Skirt and Brim 설명을 근거로 했습니다.</p></details>
    </section>

    <section aria-labelledby="first-layer-order"><h2 id="first-layer-order">오답 메모도 관찰 → 조건 → 재확인 순서로</h2>
      <ol className={styles.studySteps}>
        <li><strong>01 · 실패한 시점을 적습니다</strong><p>첫 선부터인지 몇 층 뒤인지, 선 모양과 들린 위치를 기록합니다. “잘 안 됨”보다 비교 가능한 관찰을 남기세요.</p></li>
        <li><strong>02 · 판·재료·기종을 확인합니다</strong><p>제조사가 허용하는 표면 준비와 프로파일을 확인합니다. 세척제와 접착제도 표면·재료에 따라 달라지므로 하나의 처방으로 통일하지 않습니다.</p></li>
        <li><strong>03 · 보정과 압출, 냉각 후보를 좁힙니다</strong><p>노즐 간격·압출 상태와 재료별 냉각을 점검합니다. 과도한 노즐 내림이나 범용 온도 숫자로 증상을 덮지 않습니다.</p></li>
        <li><strong>04 · 한 조건씩 같은 예제로 비교합니다</strong><p>변경한 조건과 결과를 기록합니다. 한꺼번에 바꾸면 무엇이 원인인지 판단하기 어려워집니다.</p></li>
      </ol>
    </section>

    <aside className={styles.cta} aria-labelledby="first-layer-practice"><h2 id="first-layer-practice">3D프린터운용기능사 11월 문제로 연습하세요</h2>
      <p>2026-11 자체 제작 한국어 세트는 20문항입니다. 첫 층 청결·노즐 간격·워핑뿐 아니라 FDM 부품과 다른 기초 개념도 포함합니다. 이 글의 세 문제만 모은 세트나 공식 기출문제는 아닙니다.</p>
      <ExamLink href={printingFirstLayerPost.practicePath}>3D프린터 11월 연습문제 풀기 →</ExamLink>
      <p>정답을 제출하고 해설에서 자신의 판단과 다른 지점을 확인하세요. 틀린 문제는 “브림과 서포트의 목적을 혼동함”처럼 이유를 남겨 복습할 수 있습니다.</p>
    </aside>

    <section className={styles.sources} aria-labelledby="first-layer-sources"><h2 id="first-layer-sources">공식 기술 자료와 확인 범위</h2>
      <p>2026-11-20 확인한 제조사 공식 자료입니다. 특정 기종의 메뉴·보정 수치를 모든 프린터에 적용하지 않으며, 국내 시험의 현재 적용 출제기준을 대신하는 자료는 아닙니다.</p>
      <ul>
        <li><a href="https://help.prusa3d.com/article/first-layer-issues_1804">Prusa: First layer issues</a> — 표면·간격·압출 등 점검 후보.</li>
        <li><a href="https://help.prusa3d.com/article/first-layer-calibration-i3_112364">Prusa: First Layer Calibration (i3)</a> — 너무 높거나 낮은 간격의 단서와 기종별 보정.</li>
        <li><a href="https://help.prusa3d.com/article/warping_2011">Prusa: Warping</a> — 수축·형상·냉각과 모서리 들뜸.</li>
        <li><a href="https://help.prusa3d.com/article/skirt-and-brim_133969">Prusa: Skirt and Brim</a> — 스커트와 브림의 역할.</li>
      </ul>
    </section>
  </>;
}
