import { koreanCookingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function KoreanCookingArticle() {
  return <>
    <p className={styles.lead}>한식조리기능사 필기 문제에서 위생 조치를 고를 때는 재료 이름보다 <strong>오염이 어디에서 어디로 옮겨 갈 수 있는지</strong>를 먼저 보세요. 생닭을 손질한 도마에서 곧바로 오이무침용 오이를 썰면, 오이를 나중에 가열하지 않아 오염을 제거할 단계가 없습니다. 아래 세 상황으로 손·도구·보관 순서를 점검해 보세요.</p>

    <section aria-labelledby="cooking-rule"><h2 id="cooking-rule">위생 판단의 순서: 분리 → 세척·소독 → 온도 확인</h2>
      <ol>
        <li><strong>분리:</strong> 생닭과 바로 먹을 오이무침 재료에 서로 다른 칼·도마를 사용합니다. 생닭을 만진 손이나 장갑으로 채소를 옮기지 않습니다.</li>
        <li><strong>세척·소독:</strong> 재료가 바뀌면 손을 흐르는 물과 비누로 30초 이상 씻고, 사용한 칼·도마는 세척·소독합니다. 장갑을 꼈다는 사실만으로 손씻기나 도구 교체를 생략할 수 없습니다.</li>
        <li><strong>보관:</strong> 날음식은 익힌 음식 아래에, 서로 닿거나 육즙이 떨어지지 않게 보관합니다. 냉장식품은 5°C 이하로 관리한다는 식약처 지침을 확인합니다.</li>
      </ol>
      <p>핵심은 <strong>생재료 → 손·도구·육즙 → 바로 먹는 음식</strong>의 경로를 끊는 것입니다. 조리 후의 보관과 가열은 각각 다른 문제이므로, 한 조치로 모든 위험이 사라진다고 생각하지 마세요.</p>
    </section>

    <section className={styles.quiz} aria-labelledby="cooking-cases"><p className={styles.eyebrow}>원본 학습 사례 · 실제 기출 원문 아님</p><h2 id="cooking-cases">세 상황에서 먼저 할 조치는?</h2>
      <h3>1. 생닭을 썬 도마에서 바로 오이무침용 오이를 썰어도 될까요?</h3>
      <p>도마 표면이 말라 보이지만, 생닭을 손질한 뒤 세척하지 않았습니다.</p>
      <details><summary>사례 1 정답과 이유 보기</summary><p><strong>안 됩니다.</strong> 바로 먹을 오이에 생닭의 오염이 옮겨 갈 수 있습니다. 별도 도마를 쓰거나 기존 도마를 충분히 세척·소독한 뒤 사용하세요. 표면이 말랐다는 사실은 소독의 근거가 아닙니다.</p></details>

      <h3>2. 생닭을 만진 장갑으로 익힌 음식을 접시에 담아도 될까요?</h3>
      <p>조리자는 맨손으로 음식을 만지지 않았습니다.</p>
      <details><summary>사례 2 정답과 이유 보기</summary><p><strong>안 됩니다.</strong> 오염된 장갑도 익힌 음식에 오염을 옮길 수 있습니다. 작업을 바꿀 때 장갑을 교체하고 손을 씻은 뒤 깨끗한 도구로 담으세요. 장갑 착용만으로 교차오염이 막히지는 않습니다.</p></details>

      <h3>3. 냉장고에 익힌 음식과 생닭을 함께 넣어야 한다면?</h3>
      <p>익힌 음식은 다시 가열하지 않고 제공할 예정입니다.</p>
      <details><summary>사례 3 정답과 이유 보기</summary><p><strong>생닭을 밀폐해 아래쪽에, 익힌 음식은 덮어 위쪽에 보관하세요.</strong> 육즙이 익힌 음식에 떨어지는 경로를 막아야 합니다. 냉장 보관 온도도 5°C 이하인지 확인하세요.</p></details>
    </section>

    <section aria-labelledby="cooking-review"><h2 id="cooking-review">한식조리기능사 필기 CBT를 풀 때</h2>
      <p>식품위생 문제를 틀렸다면 정답 문장만 외우기보다 <strong>오염원, 옮겨 가는 경로, 바로 먹는 음식, 차단 조치</strong>를 한 줄로 적어 보세요. 예를 들어 “생닭 → 도마 → 오이무침 → 도마 구분”처럼 정리하면 비슷한 상황에도 적용할 수 있습니다.</p>
      <p>Quizeey의 문제에는 기존 자료를 바탕으로 한 문제와 연습문제가 섞여 있을 수 있습니다. 이 글의 세 사례는 설명을 위해 새로 작성했으며 공식 기출문제나 출제기관의 해설이 아닙니다.</p>
    </section>

    <aside className={styles.cta} aria-labelledby="cooking-practice"><h2 id="cooking-practice">이제 한식조리기능사 문제로 확인하세요</h2>
      <p>문제를 푼 뒤 정답과 해설을 보고, 위생 조치가 막는 오염 경로를 직접 설명해 보세요.</p>
      <ExamLink href={koreanCookingPost.practicePath}>한식조리기능사 문제 풀기 →</ExamLink>
    </aside>

    <section className={styles.sources} aria-labelledby="cooking-sources"><h2 id="cooking-sources">공식 근거와 범위</h2>
      <p><a href="https://www.mfds.go.kr/brd/m_827/view.do?itm_seq_1=0&amp;itm_seq_2=0&amp;multi_itm_seq=0&amp;page=5&amp;seq=3609">식품의약품안전처: 식중독 예방 6대 요령과 음식점 안전조리</a>는 손씻기, 칼·도마 구분, 날음식 아래쪽 보관, 냉장 5°C 이하를 안내합니다.</p>
      <p><a href="https://www.q-net.or.kr/crf005.do?id=crf00503&amp;jmCd=7910">Q-net: 한식조리기능사 종목 정보</a>에서 시험 안내를 확인하고, 필기 출제기준은 Q-net 자료실에서 별도로 확인하세요. 이 글은 식품위생의 일부 사례를 다루며 시험 범위 전체를 대체하지 않습니다.</p>
    </section>
  </>;
}
