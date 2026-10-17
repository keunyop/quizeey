import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { ExamSearch } from "./ExamSearch";
import { Practice } from "./Practice";
import { Forum } from "./Forum";
import { forumConfigured } from "@/server/forum-database";
import { findRoute, legacy, parseQuery, routesForExam, type Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";
import { loadStudyStore } from '@/server/study-loader';
import { learningHtml,staticPage } from "@/lib/content";
import { environment } from "@/lib/environment";

export type Query = Record<string, string | string[] | undefined>;
export function queryParams(query: Query) {
  const result = new URLSearchParams();
  for (const [key, value] of Object.entries(query)) {
    if (Array.isArray(value)) value.forEach((v) => result.append(key, v));
    else if (value !== undefined) result.set(key, value);
  }
  return result;
}
function resolve(path: string, query: Query) {
  const route = findRoute(path);
  if (!route) notFound();
  const input = parseQuery(queryParams(query), path.endsWith("/test"));
  const exam = path.endsWith("/test") && input.testId ? routesForExam(input.testId, route.locale as Locale)[0] : route;
  if (!exam) notFound();
  if (input.testId && exam.testId && input.testId !== exam.testId) notFound();
  return { route, exam, input };
}
export function routeMetadata(path: string, query: Query): Metadata {
  const { route, exam } = resolve(path, query);
  environment(process.env);
  // Question indexing and canonical host are deliberately unresolved; preview has no canonical.
  const title = exam.title || (exam.headings[0] ? `${exam.headings[0]} - Quizeey` : "Quizeey");
  return {
    title: { absolute: title }, description: exam.description || undefined,
    robots: { index: false, follow: false },
    openGraph: { title, description: exam.description || undefined, locale: route.locale === "en" ? "en_US" : "ko_KR" },
  };
}

export async function RouteView({ path, query }: { path: string; query: Query }) {
  const { route, exam, input } = resolve(path, query);
  const locale = route.locale as Locale;
  const m = messages[locale];
  const home = locale === "en" ? "/en" : "/";
  const store=await loadStudyStore({examId:exam.testId??undefined,questionId:input.questId,version:input.verNbr});
  const previewSamples=environment(process.env).stage==='preview'&&store.source==='fixture';
  // Direct IDs are resolved before the bounded practice batch is selected.
  const batch = exam.testId ? store.questions(exam.testId,locale,input.verNbr,input.questId) : [];
  if(input.questId&&!batch.length)notFound();
  const publicBatch = batch.map((q) => ({ ...q, text: learningHtml(q.text), explanation:q.explanation===null?null:learningHtml(q.explanation),
    reference:q.reference?learningHtml(q.reference):q.reference,
    choices: q.choices.map((c) => ({ ...c, text: learningHtml(c.text) })) }));
  const versions = exam.testId ? store.versions(exam.testId,locale) : [];
  const isHome = ["/", "/kr", "/en", "/app"].includes(path);
  const examRoutes = legacy.routes.filter((r) => r.testId && r.locale === locale && !r.path.startsWith("/kr/"));
  const copy=staticPage(path);
  return <>
    <a className="skip-link" href="#main">{m.main}</a>
    <header className="site-header"><a className="brand" href={home} translate="no">Quizeey<span>.</span></a>
      <nav aria-label={locale === "ko" ? "메인 메뉴" : "Main navigation"}>
        <a href={home}>{m.home}</a>
        <a href={locale === "en" ? "/" : "/en"} lang={locale === "en" ? "ko" : "en"}>{locale === "en" ? "한국어" : "English"}</a>
      </nav>
    </header>
    <main id="main" className="container">
      {previewSamples && <aside className="preview-notice" aria-label={locale==='ko'?'미리보기 안내':'Preview notice'}>
        <strong>{locale==='ko'?'미리보기 · 샘플 문항':'Preview · Sample questions'}</strong>
        <p>{locale==='ko'?'샘플 문항으로 채점, 해설, 학습 기록 저장을 확인할 수 있습니다. 실제 기출문항은 아직 연결하지 않았습니다.':'Try grading, explanations and saved progress with sample questions. The full exam archive is not connected yet.'}</p>
        <a href="/sqlp-developer">한국어 샘플 연습</a>{' · '}<a href="/en/aws-certified-developer-associate">Try English samples</a>
      </aside>}
      <h1>{isHome ? locale === "ko" ? "자격증 기출문제" : "Practice exams" : exam.headings[0] || exam.title || "Quizeey"}</h1>
      {isHome ? <ExamSearch routes={examRoutes} locale={locale} /> : <>
        {copy ? <article className="static-copy" lang={copy.lang} dangerouslySetInnerHTML={{__html:copy.html}}/> : exam.headings.slice(1).map((copy, i) => <p className="exam-description" key={i}>{copy}</p>)}
        {exam.testId && <>
          {versions.length > 0 && <form className="version-form" method="get">
            {path.endsWith("/test") && <input type="hidden" name="testId" value={exam.testId} />}
            <label htmlFor="version">{m.version}</label>
            <select id="version" name="verNbr" defaultValue={input.verNbr}><option value="0">{m.all}</option>{versions.map(v => <option key={v.id} value={v.number}>{v.name}</option>)}</select>
            <button type="submit">{m.practice}</button>
          </form>}
          {publicBatch.length ? <Practice key={`${path}:${input.verNbr}:${input.questId ?? "all"}`} questions={publicBatch} locale={locale} testId={exam.testId} contentVersion={store.version} directId={input.questId} /> : <p role="status">{m.unavailable}</p>}
          {store.source==='fixture'&&forumConfigured() && <Forum key={`${exam.testId}:${locale}:${input.questId ?? "exam"}`} examId={exam.testId} locale={locale} questionId={input.questId} />}
        </>}
        {exam.links.length > 0 && <nav className="legacy-links" aria-label={locale === "ko" ? "관련 링크" : "Related links"}><ul>{exam.links.filter((l) => l.label).map((l, i) => <li key={i}><a href={l.href}>{l.label}</a></li>)}</ul></nav>}
      </>}
    </main>
    <footer><a href="/privacy">{locale === "ko" ? "개인정보처리방침" : "Privacy"}</a></footer>
  </>;
}
