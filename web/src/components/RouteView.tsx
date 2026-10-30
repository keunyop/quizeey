import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { headers, cookies } from 'next/headers';
import { randomUUID } from 'node:crypto';
import { ExamSearch } from "./ExamSearch";
import { RelatedStudyGuide, StudyGuideCards } from './StudyGuides';
import { ExamLink } from "./ExamLink";
import { ExamHeading } from "./ExamHeading";
import { CertificationNotice, CertificationPracticeLinks } from './CertificationContext';
import { isRetiredExam } from '@/lib/certifications';
import { SubmissionDialog } from "./SubmissionDialog";
import { examPopularity } from "@/server/exam-popularity";
import { Practice } from "./Practice";
import { PracticeSettings } from './PracticeSettings';
import { readSessionSettings, sessionCookie, lastSetCookie, readLastSet } from '@/lib/practice-session';
import { ExamComments } from "./ExamComments";
import { ThemeToggle } from "./ThemeToggle";
import { forumConfigured } from "@/server/forum-database";
import { findRoute, legacy, parseQuery, routesForExam, type Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";
import { loadLearningStore } from '@/server/learning-store';
import { learningHtml,staticPage } from "@/lib/content";
import { environment } from "@/lib/environment";
import { examName } from "@/lib/exam-catalog";
import { authoredVersion } from "@/lib/authored-practice";
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
  const cookieStore = exam.testId ? await cookies() : undefined;
  const implicitSet = !!exam.testId && query.verNbr === undefined && !input.questId && input.page === 1;
  if (implicitSet) input.verNbr = readLastSet(cookieStore?.get(lastSetCookie(locale, exam.testId!))?.value);
  let cookieName = exam.testId ? sessionCookie(locale, exam.testId, input.verNbr) : '';
  let savedSettings = cookieName ? readSessionSettings(cookieStore?.get(cookieName)?.value) : undefined;
  let count = input.count ?? savedSettings?.count ?? 20;
  let session = exam.testId && !input.questId && input.page === 1
    ? { seed: savedSettings?.count === count ? savedSettings.seed : randomUUID(), count } : undefined;
  const [initialStore, popularity, initialPreviousStore] = await Promise.all([
    loadLearningStore({examId:exam.testId??undefined,questionId:input.questId,version:input.verNbr,page:input.page,session:session?.seed === 'legacy' ? undefined : session}),
    isHome ? examPopularity(examRoutes) : Promise.resolve({}),
    session && !input.verNbr && !savedSettings && count === 20 ? loadLearningStore({examId:exam.testId!,page:1}) : Promise.resolve(undefined),
  ]);
  let store = initialStore;
  let previousStore = initialPreviousStore;
  // A stale or edited preference must not turn a valid exam URL into a 404.
  if (implicitSet && input.verNbr && !store.versions(exam.testId!, locale).some(version => version.number === input.verNbr)) {
    input.verNbr = 0;
    cookieName = sessionCookie(locale, exam.testId!, 0);
    savedSettings = readSessionSettings(cookieStore?.get(cookieName)?.value);
    count = input.count ?? savedSettings?.count ?? 20;
    session = { seed: savedSettings?.count === count ? savedSettings.seed : randomUUID(), count };
    store = await loadLearningStore({examId:exam.testId!,session:session.seed === 'legacy' ? undefined : session});
    previousStore = undefined;
  }
  const previewSamples=environment(process.env).stage==='preview'&&store.source==='fixture';
  // Direct IDs are resolved before the bounded practice batch is selected.
  const batch = exam.testId ? session && session.seed !== 'legacy' ? store.sessionQuestions(exam.testId,locale,input.verNbr,count,session.seed) : store.questions(exam.testId,locale,input.verNbr,input.questId,input.page) : [];
  const pagination=exam.testId&&!input.questId?store.pagination(exam.testId,locale,input.verNbr,input.page):undefined;
  if(pagination&&input.page>pagination.pages)notFound();
  const nextPage = pagination && input.verNbr && count === 20 && input.page < pagination.pages
    ? `${path}?${new URLSearchParams({ ...(path.endsWith('/test') ? { testId: exam.testId! } : {}), verNbr: String(input.verNbr), page: String(input.page + 1) })}` : undefined;
  if(input.questId&&!batch.length)notFound();
  const sanitizeQuestion = (q: (typeof batch)[number]) => ({ ...q, text: learningHtml(q.text), explanation:q.explanation===null?null:learningHtml(q.explanation),
    reference:q.reference?learningHtml(q.reference):q.reference,
    choices: q.choices.map((c) => ({ ...c, text: learningHtml(c.text) })) });
  const publicBatch = batch.map(sanitizeQuestion);
  const previousBatch = previousStore?.questions(exam.testId!,locale).map(sanitizeQuestion);
  const versions = exam.testId ? store.versions(exam.testId,locale) : [];
  if (exam.testId && input.verNbr && !versions.some(version => version.number === input.verNbr)) notFound();
  const examPath = exam.testId ? routesForExam(exam.testId, locale).find(route => !route.path.endsWith('/test'))?.path ?? path : path;
  const copy=staticPage(path);
  const env=environment(process.env);
  const commentsEnabled = forumConfigured();
  const integrations=env.adsEnabled&&env.analyticsEnabled&&(isHome||publicBatch.length>0)&&(await headers()).get('host')===new URL(env.origin).host;
  const pageContent = <>
        {copy ? <article className="static-copy" lang={copy.lang} dangerouslySetInnerHTML={{__html:copy.html}}/> : !exam.testId && exam.headings.length > 1 && <details className="exam-intro"><summary>{locale === "ko" ? "시험 소개" : "About this exam"}</summary>{exam.headings.slice(1).map((copy, i) => <p key={i}>{copy}</p>)}</details>}
        {exam.testId && <>
          {locale === 'en' && <CertificationNotice examId={exam.testId} />}
          {versions.length > 0 && <PracticeSettings locale={locale} versions={versions} version={input.verNbr} testId={path.endsWith('/test') ? exam.testId : undefined} count={count} />}
          {publicBatch.length ? <Practice key={`${path}:${input.verNbr}:${input.page}:${input.questId ?? "all"}:${session?.seed ?? ''}:${count}`} questions={publicBatch} previousQuestions={previousBatch} locale={locale} testId={exam.testId} contentVersion={store.version} directId={input.questId} pageNumber={input.page} nextPage={nextPage} commentsEnabled={commentsEnabled} session={session ? { ...session, cookieName, version: input.verNbr, total: pagination?.total ?? publicBatch.length } : undefined} /> : <div className="empty-state" role="status"><div className="empty-icon"><Icon name="book" /></div><h2>{locale === "ko" ? "문제를 준비하고 있어요" : "Questions are not available yet"}</h2><p>{m.unavailable}</p><a className="button-link" href={home}>{m.home}<Icon name="arrow" /></a></div>}
          {input.verNbr === authoredVersion && !input.questId && publicBatch.length > 0 && <details className="practice-outline">
            <summary>{locale === "ko" ? `이 페이지의 연습문제 ${publicBatch.length}개` : `${publicBatch.length} questions on this page`}</summary>
            <ol start={(input.page - 1) * 20 + 1}>{publicBatch.map(question => <li key={question.id}>
              <a lang={question.contentLocale ?? locale} data-google-vignette="false" href={`${examPath}?questId=${question.id}&verNbr=${authoredVersion}`} dangerouslySetInnerHTML={{ __html: question.text }} />
            </li>)}</ol>
          </details>}
          {locale === 'en' && <RelatedStudyGuide examPath={examPath} />}
          {locale === 'en' && <CertificationPracticeLinks examId={exam.testId} directId={input.questId} />}
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
        <a className="language-link" href={locale === "en" ? "/?lang=ko" : "/en?lang=en"} lang={locale === "en" ? "ko" : "en"}><Icon name="globe" />{locale === "en" ? "한국어" : "English"}</a>
      </nav>
    </header>
    <main id="main" className={`container ${isHome ? "home-container" : exam.testId ? `study-container google-anno-skip${commentsEnabled ? " study-with-comments" : ""}` : ""}`}>
      {previewSamples && <aside className="preview-notice" aria-label={locale==='ko'?'미리보기 안내':'Preview notice'}>
        <strong>{locale==='ko'?'미리보기 · 샘플 문항':'Preview · Sample questions'}</strong>
        <p>{locale==='ko'?'샘플 문항과 연습문항으로 학습할 수 있습니다. 실제 기출문항은 이 미리보기에 연결하지 않았습니다.':'Study with samples and practice sets. The full exam archive is not connected to this preview.'}</p>
        <a href="/sqlp-developer">한국어 샘플 연습</a>{' · '}<a href="/en/aws-certified-developer-associate">Try English samples</a>
      </aside>}
      {isHome ? <><ExamSearch routes={examRoutes} locale={locale} popularity={popularity} />
        {locale === 'en' && <StudyGuideCards />}
        <details className="exam-directory"><summary>{locale==='ko'?'전체 자격증 시험 목록':'All practice exams'}</summary>
          <nav aria-label={locale==='ko'?'전체 시험 바로가기':'All exam links'}><ul>{examRoutes.filter(r => locale !== 'en' || !isRetiredExam(r.testId)).map(r=><li key={r.path}><ExamLink href={r.path}>{examName(r)}</ExamLink></li>)}</ul></nav>
        </details>
        {locale === 'en' && <details className="exam-directory retired-directory"><summary>Retired exam archives</summary><p>Original URLs and questions remain available. Open an archive for retirement information and related study paths.</p><nav aria-label="Retired exam links"><ul>{examRoutes.filter(r => isRetiredExam(r.testId)).map(r => <li key={r.path}><ExamLink href={r.path}>{examName(r)} — Retired</ExamLink></li>)}</ul></nav></details>}
        </> : exam.testId && commentsEnabled ?
        <ExamComments key={`${exam.testId}:${locale}`} examId={exam.testId} locale={locale} title={examName(exam)} description={exam.headings.slice(1)}>{pageContent}</ExamComments> : <>
        {!exam.testId && <a className="back-link" href={home}><Icon name="back" />{m.home}</a>}
        {exam.testId ? <ExamHeading title={examName(exam)} locale={locale} description={exam.headings.slice(1)} /> : <div className="page-heading"><h1>{exam.headings[0] || exam.title || "Quizeey"}</h1></div>}
        {pageContent}
      </>}
    </main>
    <footer className="site-footer"><div><a className="brand footer-brand" href={home} translate="no"><img src="/img/letter-q.svg" width="22" height="22" alt="" />Quizeey</a><span className="footer-note">{locale === "ko" ? "한 문제씩, 더 가까이." : "One question closer."}</span></div><nav aria-label={locale === "ko" ? "사이트 정보" : "Site information"}><a href={locale === "en" ? "/en/about" : "/about"}>{locale === "ko" ? "소개" : "About"}</a><a href={locale === "en" ? "/en/privacy" : "/privacy"}>{locale === "ko" ? "개인정보처리방침" : "Privacy"}</a><SubmissionDialog locale={locale}/></nav></footer>
  </Monetization>;
}
