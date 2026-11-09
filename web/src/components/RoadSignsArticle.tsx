import { roadSignsPost, subnetPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function RoadSignsArticle() {
  return <>
    <p className={styles.lead}>For Ontario G1 road sign practice, use <strong>shape → colour → symbol or words → required action</strong>. A red octagon means stop; an upside-down red-and-white triangle means yield. Yellow diamonds usually warn of hazards, while orange signs flag temporary conditions. Learn the action as well as the picture.</p>
    <p>This guide is for learners studying Ontario’s rules in English, including newcomers who learned different signs elsewhere. These are original study examples, not official G1 test questions. Use the <a href="https://www.ontario.ca/document/official-mto-drivers-handbook/signs">current MTO handbook’s full sign illustrations</a> alongside them.</p>
    <section aria-labelledby="sign-shapes"><h2 id="sign-shapes">Start with four visual clues</h2>
      <figure className={styles.figure}>
        <div className={styles.signGrid}>
          <div><svg viewBox="0 0 120 120" aria-hidden="true" focusable="false"><polygon points="36,4 84,4 116,36 116,84 84,116 36,116 4,84 4,36" fill="#b91c1c" stroke="#fff" strokeWidth="3"/><text x="60" y="69" textAnchor="middle" fill="#fff" fontSize="25" fontWeight="700">STOP</text></svg><strong>8 sides · Stop</strong><span>Red octagon</span></div>
          <div><svg viewBox="0 0 120 120" aria-hidden="true" focusable="false"><polygon points="8,10 112,10 60,108" fill="#fff" stroke="#b91c1c" strokeWidth="10"/><text x="60" y="47" textAnchor="middle" fill="#111827" fontSize="17" fontWeight="700">YIELD</text></svg><strong>3 sides · Yield</strong><span>Red border, white centre</span></div>
          <div><svg viewBox="0 0 120 120" aria-hidden="true" focusable="false"><polygon points="60,4 116,60 60,116 4,60" fill="#fde047" stroke="#111827" strokeWidth="3"/><path d="M60 29v62 M29 60h62" stroke="#111827" strokeWidth="12"/></svg><strong>Yellow · Warning</strong><span>Example: intersection ahead</span></div>
          <div><svg viewBox="0 0 120 120" aria-hidden="true" focusable="false"><polygon points="60,4 116,60 60,116 4,60" fill="#fb923c" stroke="#111827" strokeWidth="3"/><text x="60" y="54" textAnchor="middle" fill="#111827" fontSize="15" fontWeight="700">WORK</text><text x="60" y="74" textAnchor="middle" fill="#111827" fontSize="15" fontWeight="700">AHEAD</text></svg><strong>Orange · Temporary</strong><span>Example: work ahead</span></div>
        </div>
        <figcaption>Simplified learning sketches, not official sign artwork. The labels repeat the visual information; colour alone is never the answer.</figcaption>
      </figure>
      <div className={styles.tableWrap} role="region" aria-label="Road sign comparison" tabIndex={0}><table className={styles.table}>
        <caption>Read the message before deciding what to do</caption>
        <thead><tr><th scope="col">Clue</th><th scope="col">Meaning</th><th scope="col">Avoid this mistake</th></tr></thead>
        <tbody>
          <tr><th scope="row">STOP</th><td>Make a complete stop, then check and yield before proceeding.</td><td>“The road looks empty, so slowing is enough.”</td></tr>
          <tr><th scope="row">YIELD</th><td>Give way; stop when necessary.</td><td>“Yield guarantees I can keep moving.”</td></tr>
          <tr><th scope="row">Yellow warning diamond</th><td>Read the symbol to identify the hazard ahead.</td><td>“Every diamond requires a complete stop.”</td></tr>
          <tr><th scope="row">Orange temporary sign</th><td>Expect temporary road conditions; follow the displayed message.</td><td>“Orange is just another colour for the same permanent sign.”</td></tr>
          <tr><th scope="row">Red circle with a slash</th><td>The activity inside the circle is prohibited.</td><td>Ignoring the arrow, symbol or any posted time restriction.</td></tr>
        </tbody>
      </table></div>
    </section>
    <section aria-labelledby="sign-method"><h2 id="sign-method">A short practice routine that checks understanding</h2>
      <ol className={styles.studySteps}>
        <li><strong>01 · Describe it</strong><p>Cover the caption. Name the shape, colour and symbol without looking at the answer choices.</p></li>
        <li><strong>02 · Say the action</strong><p>Finish: “When I see this, I must…” For a warning, explain what to look for; do not invent an instruction the sign does not give.</p></li>
        <li><strong>03 · Change one clue</strong><p>Compare STOP with YIELD. Which part of your answer changes? If you can explain that difference, you have learned more than a label.</p></li>
      </ol>
    </section>
    <section className={styles.quiz} aria-labelledby="sign-questions"><h2 id="sign-questions">Five questions: answer before opening the explanation</h2>
      <p>The scenarios below are invented for practice. They test sign interpretation, not the complete rules for every road situation.</p>
      <h3>1. A red octagon faces you on a quiet road. Is a rolling slowdown enough?</h3>
      <details><summary>Show sign answer 1</summary><p><strong>No. Make a complete stop.</strong> An empty-looking road does not change STOP into YIELD. Check the intersection before proceeding.</p></details>
      <h3>2. At a yield sign, approaching traffic leaves no safe gap. Keep moving or stop?</h3>
      <details><summary>Show sign answer 2</summary><p><strong>Stop and give way.</strong> Yield can require stopping. The mistake is treating “not always a stop” as “never a stop”.</p></details>
      <h3>3. A yellow diamond shows a black cross. Does its shape alone tell you to stop?</h3>
      <details><summary>Show sign answer 3</summary><p><strong>No. It warns of an intersection ahead.</strong> Identify the hazard, then observe the controls and conditions at the intersection. A warning sign and a stop sign have different jobs.</p></details>
      <h3>4. You see an orange diamond with a road-work message. Which category is it?</h3>
      <details><summary>Show sign answer 4</summary><p><strong>Temporary conditions.</strong> Read the actual message. The category alone does not tell you which lane to use or give a new speed limit.</p></details>
      <h3>5. A left-turn arrow is covered by a red circle and slash. What is prohibited?</h3>
      <details><summary>Show sign answer 5</summary><p><strong>The left turn shown on the sign.</strong> Read any accompanying restrictions. The sign does not mean that every possible movement is prohibited.</p></details>
    </section>
    <section aria-labelledby="sign-mistakes"><h2 id="sign-mistakes">Keep a two-line mistake note</h2>
      <p><strong>Example:</strong> “I chose ‘always keep moving’ for YIELD. Correction: I must give way, stopping when needed.” Next time, hide the correction and explain it again.</p>
      <p>If you only remember a letter such as “B”, return to the sign and write the action. If a symbol is unfamiliar, look it up in the official illustrated handbook before doing another quiz.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="sign-practice"><h2 id="sign-practice">Continue with Ontario G1 study questions</h2>
      <p>Quizeey offers free original English G1 practice with answer explanations, including text descriptions of stop, yield and temporary-condition signs. The set also covers other Ontario driving topics. It is independent study material, not an official DriveTest or MTO exam, a complete sign-image bank or a full two-section test simulation.</p>
      <ExamLink href={roadSignsPost.practicePath}>Practise Ontario G1 questions →</ExamLink>
      <p>Choose an answer, select “Check answer”, and read why it fits. Use the current handbook for complete rules and illustrations.</p>
    </aside>
    <section className={styles.sources} aria-labelledby="sign-sources"><h2 id="sign-sources">Sources and further practice</h2>
      <p><a href="https://www.ontario.ca/document/official-mto-drivers-handbook/signs">Ontario MTO: Signs</a> — official sign categories, illustrations and instructions, checked 8 November 2026. This guide uses Ontario terminology; do not apply it as a handbook for another province or country.</p>
      <p>Also preparing for an IT certification? Our <a href={subnetPost.path}>IPv4 subnetting worked examples</a> use the same answer-first, explanation-second study approach.</p>
    </section>
  </>;
}
