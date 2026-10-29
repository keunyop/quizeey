import { headers } from 'next/headers';
import { authoredSetSummary } from '@/lib/authored-practice';
import { findRoute } from '@/lib/contracts';
import { examName } from '@/lib/exam-catalog';
import { environment } from '@/lib/environment';
import { studyGuideIndex, studyGuidePath, studyGuides, type StudyGuide } from '@/lib/study-guides';
import { ExamLink } from './ExamLink';
import { Monetization } from './Monetization';
import { SubmissionDialog } from './SubmissionDialog';
import { ThemeToggle } from './ThemeToggle';

export function StudyGuideCards() {
  return <section className="study-guide-discovery" aria-labelledby="study-guide-heading">
    <h2 id="study-guide-heading">Choose a study path</h2>
    <p>Find the right English practice set, review answer explanations and make a plan for the skills you need to improve.</p>
    <ul className="study-guide-cards">{studyGuides.map(guide => <li key={guide.slug}>
      <h3><a href={studyGuidePath(guide.slug)}>{guide.title}</a></h3>
      <p>{guide.description}</p>
    </li>)}</ul>
    <p><a href={studyGuidePath()}>All English study guides</a></p>
  </section>;
}

export function RelatedStudyGuide({ examPath }: { examPath: string }) {
  const guide = studyGuides.find(item => item.exams.some(exam => exam.path === examPath));
  if (!guide) return null;
  const subject = guide.exams.find(exam => exam.path === examPath)!;
  return <aside className="related-study-guide" aria-label="Study guide">
    <strong>Plan your review</strong>
    <p>{subject.focus}</p>
    <p><a href={studyGuidePath(guide.slug)}>{guide.title}</a></p>
    <p>Choose your subject, review mistakes and find official learning resources.</p>
  </aside>;
}

function GuidePracticeLinks({ guide }: { guide: StudyGuide }) {
  return <section aria-labelledby="guide-practice-heading">
    <h2 id="guide-practice-heading">Start a practice set</h2>
    <ul className="guide-practice-links">{guide.exams.map(item => {
      const exam = findRoute(item.path);
      if (!exam?.testId) return null;
      const set = authoredSetSummary(exam.testId, 'en');
      return <li key={item.path}>
        <h3><ExamLink href={item.path}>{examName(exam)} practice</ExamLink></h3>
        <p>{item.focus}</p>
        {set && <p className="guide-question-count"><a data-google-vignette="false" href={`${item.path}?verNbr=${set.version}`}>{set.count} questions with answers and explanations</a></p>}
      </li>;
    })}</ul>
  </section>;
}

export async function StudyGuideView({ guide }: { guide?: StudyGuide }) {
  const env = environment(process.env);
  const path = studyGuidePath(guide?.slug);
  const copy = guide ?? studyGuideIndex;
  const enabled = env.adsEnabled && env.analyticsEnabled && (await headers()).get('host') === new URL(env.origin).host;
  const url = env.origin + path;
  const breadcrumb = [
    { '@type': 'ListItem', position: 1, name: 'Practice exams', item: env.origin + '/en' },
    { '@type': 'ListItem', position: 2, name: 'Study guides', item: env.origin + studyGuidePath() },
    ...(guide ? [{ '@type': 'ListItem', position: 3, name: guide.title, item: url }] : []),
  ];
  const structuredData = {
    '@context': 'https://schema.org',
    '@graph': [
      { '@type': guide ? 'WebPage' : 'CollectionPage', '@id': url + '#webpage', url, name: copy.title, description: copy.description, inLanguage: 'en', isAccessibleForFree: true, breadcrumb: { '@id': url + '#breadcrumb' } },
      { '@type': 'BreadcrumbList', '@id': url + '#breadcrumb', itemListElement: breadcrumb },
    ],
  };
  return <Monetization enabled={enabled} measurementId={env.ga4MeasurementId} cmpScriptUrl={env.cmpScriptUrl} locale="en" pagePath={path}>
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(structuredData).replace(/</g, '\\u003c') }} />
    <a className="skip-link" href="#main">Skip to main content</a>
    <header className="site-header">
      <a className="brand" href="/en" translate="no"><img src="/img/letter-q.svg" width="30" height="30" alt="" />Quizeey</a>
      <nav aria-label="Main navigation"><ThemeToggle locale="en" /><a href="/en">Practice exams</a><a className="language-link" href="/?lang=ko" lang="ko">한국어</a></nav>
    </header>
    <main id="main" className="container guide-container">
      <nav className="guide-breadcrumb" aria-label="Breadcrumb"><a href="/en">Practice exams</a><span aria-hidden="true"> / </span>{guide ? <><a href={studyGuidePath()}>Study guides</a><span aria-hidden="true"> / </span><span aria-current="page">{guide.title}</span></> : <span aria-current="page">Study guides</span>}</nav>
      <article className="study-guide-article">
        <h1>{copy.title}</h1>
        <p className="guide-introduction">{guide?.introduction ?? 'Choose a subject below to find practice questions, a review method and official resources. Each guide connects a study goal to the English question sets available on Quizeey.'}</p>
        {guide ? <>
          <GuidePracticeLinks guide={guide} />
          {guide.sections.map(section => <section key={section.heading}>
            <h2>{section.heading}</h2>
            {section.paragraphs.map(paragraph => <p key={paragraph}>{paragraph}</p>)}
            {section.steps && <ol>{section.steps.map(step => <li key={step}>{step}</li>)}</ol>}
          </section>)}
          <section aria-labelledby="guide-resources-heading"><h2 id="guide-resources-heading">Official learning resources</h2>
            <ul>{guide.resources.map(resource => <li key={resource.url}><a href={resource.url} rel="noopener noreferrer">{resource.title}</a></li>)}</ul>
          </section>
          <nav className="guide-related" aria-label="More study guides"><h2>More study guides</h2><ul>{studyGuides.filter(item => item.slug !== guide.slug).map(item => <li key={item.slug}><a href={studyGuidePath(item.slug)}>{item.title}</a></li>)}</ul></nav>
        </> : <>
          <StudyGuideCards />
          <section><h2>How practice works</h2><p>Open a subject, choose a set and answer a few questions. Check each answer, read its explanation and use the linked reference when a concept is unfamiliar. Bookmark difficult questions and revisit them after reviewing the topic.</p>
            <p>Use the answer explanations to review your reasoning and the resources in each guide to check the full requirements for your chosen exam.</p>
          </section>
        </>}
      </article>
    </main>
    <footer className="site-footer"><div><a className="brand footer-brand" href="/en" translate="no">Quizeey</a><span className="footer-note">One question closer.</span></div>
      <nav aria-label="Site information"><a href={studyGuidePath()}>Study guides</a><a href="/en/about">About</a><a href="/en/privacy">Privacy</a><SubmissionDialog locale="en" /></nav>
    </footer>
  </Monetization>;
}
