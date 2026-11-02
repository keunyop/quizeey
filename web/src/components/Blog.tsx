import { headers } from 'next/headers';
import { blogIndex, blogPath, blogPost, blogPostPath, blogStructuredData } from '@/lib/blog';
import { environment } from '@/lib/environment';
import { ExamLink } from './ExamLink';
import { Monetization } from './Monetization';
import { SubmissionDialog } from './SubmissionDialog';
import { ThemeToggle } from './ThemeToggle';
import styles from './blog.module.css';

export function BlogDiscovery() {
  return <aside className={styles.discovery} aria-label="SQLD 개념 가이드">
    <p className={styles.eyebrow}>개념을 이해하고, 문제로 확인하세요</p>
    <h2><a href={blogPostPath}>{blogPost.title}</a></h2>
    <p>문제풀이 → 해설 확인 → 오답 복습. COUNT와 NULL 예제로 복습 방법을 익혀 보세요.</p>
  </aside>;
}

function CountArticle() {
  return <>
    <p className={styles.lead}>SQLD 기출문제 CBT는 <strong>답을 보지 않고 풀기 → 정답의 근거 확인하기 → 틀린 문제 다시 풀기</strong> 순서로 활용하세요. 맞혔어도 이유를 설명하지 못한 문제는 복습 대상으로 남깁니다.</p>
    <section aria-labelledby="study-method"><h2 id="study-method">한 번의 문제풀이를 3단계로</h2>
      <ol className={styles.studySteps}>
        <li><strong>01 · 먼저 풀기</strong><p>Quizeey에서 SQLD를 선택하고 원하는 회차·문제 수로 시작하세요. 정답을 보기 전에 선택 이유를 한 문장으로 생각합니다.</p></li>
        <li><strong>02 · 근거 확인</strong><p>정답과 해설을 읽고, 틀린 선택지는 어느 조건 때문에 틀렸는지 찾습니다. 해설을 외우기보다 계산 순서를 직접 설명해 보세요.</p></li>
        <li><strong>03 · 다시 풀기</strong><p>틀린 문제는 오답 복습으로, 맞혔지만 불안한 문제는 북마크로 모으세요. 다음 학습 때 답을 가리고 다시 풉니다.</p></li>
      </ol>
    </section>
    <section aria-labelledby="count-example">
      <h2 id="count-example">복습 예시: COUNT는 무엇을 셀까요?</h2>
      <p><strong>COUNT(*)는 모든 행</strong>, <strong>COUNT(컬럼)은 NULL이 아닌 값</strong>, <strong>COUNT(DISTINCT 컬럼)은 NULL과 중복을 제외한 값</strong>을 셉니다.</p>
      <p>다음은 직접 만든 학습용 <code>scores</code> 테이블입니다. <code>score</code>는 숫자형 컬럼이며, NULL은 값이 없음을 나타냅니다.</p>
      <table className={styles.table}>
        <caption>예제 테이블: scores</caption>
        <thead><tr><th scope="col">id</th><th scope="col">score</th></tr></thead>
        <tbody>{[[1, '80'], [2, '80'], [3, 'NULL'], [4, '0']].map(([id, value]) => <tr key={id}><th scope="row">{id}</th><td>{value}</td></tr>)}</tbody>
      </table>
      <figure className={styles.figure}>
        <div className={styles.comparison}>
          {[
            ['COUNT(*)', '4', '80 · 80 · NULL · 0', '모든 행'],
            ['COUNT(score)', '3', '80 · 80 · 0', 'NULL 제외'],
            ['COUNT(DISTINCT score)', '2', '80 · 0', 'NULL + 중복 제외'],
          ].map(([label, result, values, rule]) => <div key={label} className={styles.countCard}><code>{label}</code><strong>{result}</strong><span>{values}</span><small>{rule}</small></div>)}
        </div>
        <figcaption>0은 실제 값이므로 셉니다. NULL이 있는 행도 COUNT(*)에는 포함됩니다.</figcaption>
      </figure>
      <pre className={styles.code}><code>{'SELECT COUNT(*) AS all_rows,\n       COUNT(score) AS scored_rows,\n       COUNT(DISTINCT score) AS unique_scores\nFROM scores;\n\n-- 결과: 4, 3, 2'}</code></pre>
    </section>
    <section className={styles.quiz} aria-labelledby="count-quiz">
      <p className={styles.eyebrow}>30초 확인 문제</p>
      <h2 id="count-quiz">WHERE 조건을 추가하면?</h2>
      <p>같은 테이블에서 다음 쿼리의 결과를 먼저 생각해 보세요.</p>
      <pre className={styles.code}><code>{'SELECT COUNT(*), COUNT(score)\nFROM scores\nWHERE score IS NULL;'}</code></pre>
      <details><summary>정답과 해설 보기</summary><p><strong>정답: 1, 0.</strong> WHERE가 NULL인 행 하나만 남깁니다. COUNT(*)는 그 행을 세고, COUNT(score)는 NULL을 제외합니다. 조건으로 행을 고른 뒤 집계한다는 순서가 핵심입니다.</p></details>
      <p>오답 메모는 한 줄이면 충분합니다. <strong>«NULL도 값처럼 셌다 → COUNT(컬럼)은 NULL 제외»</strong>처럼 실수와 규칙을 함께 적어 보세요.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="count-practice">
      <h2 id="count-practice">이해했다면 SQLD 문제로 확인하세요</h2>
      <p>문제를 풀고 정답·해설을 확인하세요. 틀렸다면 «행을 세는가, 값을 세는가, 중복을 빼는가»부터 다시 점검해 보세요.</p>
      <ExamLink href={blogPost.practicePath}>SQLD 문제 풀기 →</ExamLink>
    </aside>
    <section className={styles.sources} aria-labelledby="count-sources">
      <h2 id="count-sources">공식 문서로 확인하기</h2>
      <p><a href="https://www.postgresql.org/docs/18/functions-aggregate.html">PostgreSQL 공식 문서: COUNT 집계 함수</a> · <a href="https://www.postgresql.org/docs/18/sql-expressions.html#SYNTAX-AGGREGATES">DISTINCT 집계 표현식</a></p>
      <p>이 글의 예제는 개념 학습용으로 작성했으며 실제 출제 문항이 아닙니다.</p>
    </section>
  </>;
}

export async function BlogView({ article = false }: { article?: boolean }) {
  const env = environment(process.env);
  const path = article ? blogPostPath : blogPath;
  const enabled = env.adsEnabled && env.analyticsEnabled && (await headers()).get('host') === new URL(env.origin).host;
  return <Monetization enabled={enabled} measurementId={env.ga4MeasurementId} cmpScriptUrl={env.cmpScriptUrl} locale="ko" pagePath={path}>
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(blogStructuredData(env.origin, article)).replace(/</g, '\\u003c') }} />
    <a className="skip-link" href="#main">본문으로 건너뛰기</a>
    <header className="site-header"><a className="brand" href="/" translate="no">Quizeey</a><nav aria-label="주 메뉴"><ThemeToggle locale="ko" /><a href="/">자격증 문제풀이</a></nav></header>
    <main id="main" className={`container ${styles.container}`}>
      <nav className={styles.breadcrumb} aria-label="현재 위치"><a href="/">홈</a><span aria-hidden="true"> / </span>{article ? <><a href={blogPath}>블로그</a><span aria-hidden="true"> / </span><span aria-current="page">SQLD CBT 공부법</span></> : <span aria-current="page">블로그</span>}</nav>
      {article ? <article className={styles.article}>
        <header><p className={styles.eyebrow}>{blogPost.category}</p><h1>{blogPost.title}</h1><p className={styles.byline}><a href="/about">Quizeey</a> · <time dateTime={blogPost.date}>2026년 11월 2일</time> · 3분 읽기</p></header>
        <CountArticle />
      </article> : <>
        <header className={styles.indexHeader}><p className={styles.eyebrow}>QUIZEEY BLOG</p><h1>작은 개념 하나가,<br />다음 정답으로.</h1><p>{blogIndex.description}</p></header>
        <article className={styles.postCard}><p className={styles.eyebrow}>{blogPost.category} · 3분 읽기</p><h2><a href={blogPostPath}>{blogPost.title}</a></h2><p>{blogPost.description}</p><time dateTime={blogPost.date}>2026년 11월 2일</time></article>
      </>}
    </main>
    <footer className="site-footer"><a className="brand" href="/" translate="no">Quizeey</a><nav aria-label="사이트 정보"><a href={blogPath}>블로그</a><a href="/about">소개</a><a href="/privacy">개인정보처리방침</a><SubmissionDialog locale="ko" /></nav></footer>
  </Monetization>;
}
