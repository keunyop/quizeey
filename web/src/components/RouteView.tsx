import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { headers } from 'next/headers';
import { ExamSearch } from "./ExamSearch";
import { ExamLink } from "./ExamLink";
import { ExamHeading } from "./ExamHeading";
import { SubmissionDialog } from "./SubmissionDialog";
import { examPopularity } from "@/server/exam-popularity";
import { Practice } from "./Practice";
import { ExamComments } from "./ExamComments";
import { ThemeToggle } from "./ThemeToggle";
import { forumConfigured } from "@/server/forum-database";
import { findRoute, legacy, parseQuery, routesForExam, type Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";
import { loadLearningStore } from '@/server/learning-store';
import { learningHtml,staticPage } from "@/lib/content";
import { environment } from "@/lib/environment";
import { examName } from "@/lib/exam-catalog";
import { authoredSetSummary, authoredVersion } from "@/lib/authored-practice";
import { Icon } from "./Icon";
import { canonicalPath,searchMetadata,pageStructuredData,serializeStructuredData } from '@/lib/seo';
import { Monetization,AdSlot } from './Monetization';

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
  const { exam } = resolve(path, query);
  const env=environment(process.env);
  return searchMetadata(path,queryParams(query),exam,env.origin,env.stage==='production'&&!env.protectedReview);
}

export async function RouteView({ path, query }: { path: string; query: Query }) {
  const { route, exam, input } = resolve(path, query);
  const locale = route.locale as Locale;
  const m = messages[locale];
  const home = locale === "en" ? "/en" : "/";
  const isHome = ["/", "/kr", "/en", "/app"].includes(path);
  const examRoutes = legacy.routes.filter((r) => r.testId && r.locale === locale && !r.path.startsWith("/kr/"));
  const [store, popularity] = await Promise.all([
    loadLearningStore({examId:exam.testId??undefined,questionId:input.questId,version:input.verNbr,page:input.page}),
    isHome ? examPopularity(examRoutes) : Promise.resolve({}),
  ]);
  const previewSamples=environment(process.env).stage==='preview'&&store.source==='fixture';
  // Direct IDs are resolved before the bounded practice batch is selected.
  const batch = exam.testId ? store.questions(exam.testId,locale,input.verNbr,input.questId,input.page) : [];
  const pagination=exam.testId&&!input.questId?store.pagination(exam.testId,locale,input.verNbr,input.page):undefined;
  if(pagination&&input.page>pagination.pages)notFound();
  function pageLink(page:number){const params=new URLSearchParams();if(path.endsWith('/test'))params.set('testId',exam.testId!);if(input.verNbr)params.set('verNbr',String(input.verNbr));if(page>1)params.set('page',String(page));return `${path}${params.size?'?'+params:''}`;}
  if(input.questId&&!batch.length)notFound();
  const publicBatch = batch.map((q) => ({ ...q, text: learningHtml(q.text), explanation:q.explanation===null?null:learningHtml(q.explanation),
    reference:q.reference?learningHtml(q.reference):q.reference,
    choices: q.choices.map((c) => ({ ...c, text: learningHtml(c.text) })) }));
  const versions = exam.testId ? store.versions(exam.testId,locale) : [];
  if (exam.testId && input.verNbr && !versions.some(version => version.number === input.verNbr)) notFound();
  const authoredSet = exam.testId ? authoredSetSummary(exam.testId, locale) : undefined;
  const examPath = exam.testId ? routesForExam(exam.testId, locale).find(route => !route.path.endsWith('/test'))?.path ?? path : path;
  const copy=staticPage(path);
  const env=environment(process.env);
  const commentsEnabled = forumConfigured();
  const integrations=env.adsEnabled&&env.analyticsEnabled&&(isHome||publicBatch.length>0)&&(await headers()).get('host')===new URL(env.origin).host;
  const pageContent = <>
        {copy ? <article className="static-copy" lang={copy.lang} dangerouslySetInnerHTML={{__html:copy.html}}/> : !exam.testId && exam.headings.length > 1 && <details className="exam-intro"><summary>{locale === "ko" ? "시험 소개" : "About this exam"}</summary>{exam.headings.slice(1).map((copy, i) => <p key={i}>{copy}</p>)}</details>}
        {exam.testId && <>
          {versions.length > 0 && <form className="version-form" method="get">
            {path.endsWith("/test") && <input type="hidden" name="testId" value={exam.testId} />}
            <label htmlFor="version">{locale === "ko" ? "시험 회차" : "Exam set"}</label>
            <select id="version" name="verNbr" defaultValue={input.verNbr}><option value="0">{m.all}</option>{versions.map(v => <option key={v.id} value={v.number}>{v.name}</option>)}</select>
            <button type="submit">{locale === "ko" ? "적용" : "Apply"}</button>
          </form>}
          {publicBatch.length ? <Practice key={`${path}:${input.verNbr}:${input.page}:${input.questId ?? "all"}`} questions={publicBatch} locale={locale} testId={exam.testId} contentVersion={store.version} directId={input.questId} pageNumber={input.page} commentsEnabled={commentsEnabled} nextPage={pagination&&input.page<pagination.pages?pageLink(input.page+1):undefined} /> : <div className="empty-state" role="status"><div className="empty-icon"><Icon name="book" /></div><h2>{locale === "ko" ? "문제를 준비하고 있어요" : "Questions are not available yet"}</h2><p>{m.unavailable}</p><a className="button-link" href={home}>{m.home}<Icon name="arrow" /></a></div>}
          {pagination&&pagination.pages>1&&<nav className="practice-pages" aria-label={locale==='ko'?'문제 묶음':'Practice pages'}>
            {input.page>1?<a href={pageLink(input.page-1)} rel="prev" data-google-vignette="false">{locale==='ko'?'이전 문제':'Previous questions'}</a>:<span/>}
            <span>{input.page} / {pagination.pages}</span>
            {input.page<pagination.pages?<a href={pageLink(input.page+1)} rel="next" data-google-vignette="false">{locale==='ko'?'다음 문제':'Next questions'}</a>:<span/>}
          </nav>}
          {authoredSet && <section className="practice-set-summary" aria-label={locale === "ko" ? "연습 회차 안내" : "Practice set information"}>
            <a href={`${examPath}?verNbr=${authoredSet.version}`}>
              {locale === "ko" ? `${authoredSet.name} 회차 · 연습문제 ${authoredSet.count}개와 해설` : `${authoredSet.name} · ${authoredSet.count} practice questions with explanations`}
            </a>
            <p>{locale === "ko" ? "공식 기출 회차와 구분되는 자체 제작 학습 자료입니다." : "Original, independent study material. This is not an official exam paper."}</p>
            {authoredSet.scope && <p lang="en">{authoredSet.scope}</p>}
          </section>}
          {input.verNbr === authoredVersion && !input.questId && publicBatch.length > 0 && <details className="practice-outline">
            <summary>{locale === "ko" ? `이 페이지의 연습문제 ${publicBatch.length}개` : `${publicBatch.length} questions on this page`}</summary>
            <ol start={(input.page - 1) * 20 + 1}>{publicBatch.map(question => <li key={question.id}>
              <a lang={question.contentLocale ?? locale} href={`${examPath}?questId=${question.id}&verNbr=${authoredVersion}`} dangerouslySetInnerHTML={{ __html: question.text }} />
            </li>)}</ol>
          </details>}
          {publicBatch.length>0&&<AdSlot kind="display" locale={locale}/>}
        </>}
        {exam.links.length > 0 && <nav className="legacy-links" aria-label={locale === "ko" ? "관련 링크" : "Related links"}><ul>{exam.links.filter((l) => l.label).map((l, i) => <li key={i}><a href={l.href}>{l.label}</a></li>)}</ul></nav>}
  </>;
  return <Monetization enabled={integrations} measurementId={env.ga4MeasurementId} cmpScriptUrl={env.cmpScriptUrl} locale={locale} pagePath={canonicalPath(path,queryParams(query))}>
    <script type="application/ld+json" dangerouslySetInnerHTML={{__html:serializeStructuredData(pageStructuredData(path,queryParams(query),exam,env.origin))}} />
    <a className="skip-link" href="#main">{m.main}</a>
    <header className="site-header"><a className="brand" href={home} translate="no"><img src="/img/letter-q.svg" width="30" height="30" alt="" />Quizeey</a>
      <nav aria-label={locale === "ko" ? "메인 메뉴" : "Main navigation"}>
        <ThemeToggle locale={locale} />
        <a className="language-link" href={locale === "en" ? "/" : "/en"} lang={locale === "en" ? "ko" : "en"}><Icon name="globe" />{locale === "en" ? "한국어" : "English"}</a>
      </nav>
    </header>
    <main id="main" className={`container ${isHome ? "home-container" : exam.testId ? `study-container google-anno-skip${commentsEnabled ? " study-with-comments" : ""}` : ""}`}>
      {previewSamples && <aside className="preview-notice" aria-label={locale==='ko'?'미리보기 안내':'Preview notice'}>
        <strong>{locale==='ko'?'미리보기 · 샘플 문항':'Preview · Sample questions'}</strong>
        <p>{locale==='ko'?'샘플 문항과 연습문항으로 학습할 수 있습니다. 실제 기출문항은 이 미리보기에 연결하지 않았습니다.':'Study with samples and practice sets. The full exam archive is not connected to this preview.'}</p>
        <a href="/sqlp-developer">한국어 샘플 연습</a>{' · '}<a href="/en/aws-certified-developer-associate">Try English samples</a>
      </aside>}
      {isHome ? <><ExamSearch routes={examRoutes} locale={locale} popularity={popularity} advertisement={<AdSlot kind="infeed" locale={locale}/>} />
        <details className="exam-directory"><summary>{locale==='ko'?'전체 자격증 시험 목록':'All certification practice exams'}</summary>
          <nav aria-label={locale==='ko'?'전체 시험 바로가기':'All exam links'}><ul>{examRoutes.map(r=><li key={r.path}><ExamLink href={r.path}>{examName(r)}</ExamLink></li>)}</ul></nav>
        </details></> : exam.testId && commentsEnabled ?
        <ExamComments key={`${exam.testId}:${locale}`} examId={exam.testId} locale={locale} title={examName(exam)} description={exam.headings.slice(1)}>{pageContent}</ExamComments> : <>
        {!exam.testId && <a className="back-link" href={home}><Icon name="back" />{m.home}</a>}
        {exam.testId ? <ExamHeading title={examName(exam)} locale={locale} description={exam.headings.slice(1)} /> : <div className="page-heading"><h1>{exam.headings[0] || exam.title || "Quizeey"}</h1></div>}
        {pageContent}
      </>}
    </main>
    <footer className="site-footer"><div><a className="brand footer-brand" href={home} translate="no"><img src="/img/letter-q.svg" width="22" height="22" alt="" />Quizeey</a><span className="footer-note">{locale === "ko" ? "한 문제씩, 더 가까이." : "One question closer."}</span></div><nav aria-label={locale === "ko" ? "사이트 정보" : "Site information"}><a href="/about">{locale === "ko" ? "소개" : "About"}</a><a href="/privacy">{locale === "ko" ? "개인정보처리방침" : "Privacy"}</a><SubmissionDialog locale={locale}/></nav></footer>
  </Monetization>;
}
