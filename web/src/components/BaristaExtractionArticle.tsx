import { baristaExtractionPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function BaristaExtractionArticle() {
  return <>
    <p className={styles.lead}>바리스타 2급 필기를 준비하며 에스프레소 수치를 볼 때는 <strong>원두 투입량, 컵에 나온 음료량, 추출 시간</strong>을 먼저 구분하세요. 18 g을 넣고 36 g을 받았다면 원두 대 음료 질량의 비율은 1:2입니다. 이 비율만으로 맛이나 추출의 좋고 나쁨이 결정되지는 않습니다. 아래 사례로 계산과 판단 순서를 익힌 뒤 실제 연습문제로 확인해 보세요.</p>

    <section aria-labelledby="barista-ratio"><h2 id="barista-ratio">1:2는 무엇을 나눈 값일까요?</h2>
      <p>에스프레소의 추출 비율을 원두 투입 질량 대 컵에 받은 음료 질량으로 적는다면, 오른쪽 숫자는 <strong>음료 질량 ÷ 원두 질량</strong>입니다. 같은 20 g의 원두에서 40 g을 받으면 1:2, 50 g을 받으면 1:2.5입니다. 이는 컵에 받은 양의 비교이며 녹아 나온 성분의 비율인 추출 수율과는 다릅니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="원두와 음료 질량에 따른 추출 비율" tabIndex={0}><table className={styles.table}>
        <caption>원두 대 음료 질량으로 계산한 학습 예시</caption>
        <thead><tr><th scope="col">원두</th><th scope="col">음료</th><th scope="col">계산</th><th scope="col">비율</th></tr></thead>
        <tbody><tr><th scope="row">18 g</th><td>36 g</td><td>36 ÷ 18 = 2</td><td>1:2</td></tr><tr><th scope="row">20 g</th><td>50 g</td><td>50 ÷ 20 = 2.5</td><td>1:2.5</td></tr></tbody>
      </table></div>
      <p>BGA·SCA 연구진이 소개한 2017년 설문에서 응답자의 평균 추출 비율은 1:2였지만, 조사 결과가 모든 원두와 장비에 적용되는 정답 비율이라는 뜻은 아닙니다. 문제에 주어진 질량과 비율의 방향을 먼저 읽고 계산하세요.</p>
    </section>

    <section aria-labelledby="barista-grind"><h2 id="barista-grind">분쇄도를 바꿀 때는 무엇을 함께 봐야 할까요?</h2>
      <p>같은 원두량과 장비에서 분쇄를 더 가늘게 하면 커피층의 물 흐름 저항이 커질 수 있습니다. 그러나 “가늘수록 무조건 추출 시간이 길고 맛이 좋아진다”는 결론은 성립하지 않습니다. 커피층이 한쪽으로 치우치면 물이 일부 통로로 몰리는 채널링이 생길 수 있고, 원두·도징·분포·장비 조건도 함께 작용합니다.</p>
      <ol className={styles.studySteps}>
        <li><strong>기준을 적습니다.</strong><p>원두량, 컵에 받은 음료량, 걸린 시간과 맛을 기록합니다. 예를 들어 18 g 투입, 36 g 음료, 25초처럼 각각 별도로 씁니다.</p></li>
        <li><strong>한 변수씩 조정합니다.</strong><p>흐름이 너무 빠르다고 판단했다면 분쇄도를 조금 바꾸고 나머지 조건을 가능한 한 유지해 다시 비교합니다. 먼저 커피층 분포가 고른지도 확인합니다.</p></li>
        <li><strong>결과를 비교합니다.</strong><p>시간 숫자 하나로 합격·불합격을 결정하지 말고 음료량과 맛, 흐름의 균일성까지 함께 봅니다. 바뀐 조건을 기록해야 다음 시도에서 원인을 찾기 쉽습니다.</p></li>
      </ol>
    </section>

    <section className={styles.quiz} aria-labelledby="barista-check"><p className={styles.eyebrow}>직접 만든 확인 문제 · 실제 기출문제 아님</p><h2 id="barista-check">20 g을 넣고 50 g을 받았다면?</h2>
      <p>원두 대 음료 질량의 비율을 고르세요.</p>
      <ol><li>1:0.4</li><li>1:2</li><li>1:2.5</li></ol>
      <details><summary>정답과 선택지별 이유 보기</summary><p><strong>정답은 3번, 1:2.5입니다.</strong> 50 ÷ 20 = 2.5입니다. 1번은 나누는 방향을 거꾸로 잡아 20 ÷ 50을 계산한 값입니다. 2번은 20 g을 넣고 40 g을 받았을 때의 비율입니다. 컵에 받은 50 g을 물 투입량이나 추출 수율로 바꾸어 읽지 마세요.</p></details>
    </section>

    <aside className={styles.cta} aria-labelledby="barista-practice"><h2 id="barista-practice">바리스타 2급 원본 연습문제로 확인하세요</h2>
      <p>Quizeey의 2026년 11월 연습문제에는 추출 비율, 분쇄도와 흐름 저항, 채널링을 구분하는 자체 제작 문항이 있습니다. 답을 제출한 뒤 해설에서 판단 근거를 비교해 보세요.</p>
      <ExamLink href={baristaExtractionPost.practicePath}>바리스타 2급 연습문제 풀기 →</ExamLink>
    </aside>

    <section className={styles.sources} aria-labelledby="barista-sources"><h2 id="barista-sources">출처와 적용 범위</h2>
      <p><a href="https://www.kca-coffee.org/cms/FrCon/index.do?MENU_ID=630">(사)한국커피협회 바리스타 2급 시험 규정</a>은 해당 협회 필기 범위에 커피 추출을 포함합니다. <a href="https://sca.coffee/education/courses">SCA Coffee Skills 과정</a>은 추출 변수와 바리스타 기술을 학습 주제로 안내합니다. 두 기관의 자격과 교육 과정은 서로 다릅니다.</p>
      <p><a href="https://sca.coffee/sca-news/25-magazine/issue-3/defining-ever-changing-espresso-25-magazine-issue-3-zyx36">SCA 에스프레소 현장 조사</a>는 원두 투입 질량과 음료 질량으로 비율을 설명합니다. <a href="https://sca.coffee/sca-news/coffee-decoded-14-dialling-in">SCA의 추출 변수 해설</a>은 도징·분쇄·추출을 조정하는 과정을 설명합니다. 이 글과 연결된 Quizeey 문항은 학습용 원본이며 어느 기관의 공식 기출문제나 시험 범위 전체를 재현한 것이 아닙니다. 실제 응시 규정은 본인이 선택한 발급기관에서 확인하세요.</p>
    </section>
  </>;
}
