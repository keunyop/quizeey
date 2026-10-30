import { authoredQuestions, authoredVersion } from '@/lib/authored-practice';
import { certificationFor, certificationReviewDate } from '@/lib/certifications';
import { routesForExam } from '@/lib/contracts';
import { examName } from '@/lib/exam-catalog';

export function CertificationNotice({ examId }: { examId: string }) {
  const info = certificationFor(examId);
  if (!info) return null;
  const next = info.replacement ? routesForExam(info.replacement, 'en')[0] : undefined;
  return <aside className={`certification-notice ${info.status}`} aria-label="Exam version information">
    <h2>{info.status === 'retired' ? `Retired exam: ${info.code}` : `Exam version: ${info.code}`}</h2>
    <p>{info.note}</p>
    {next && <p><a href={`${next.path}?verNbr=${authoredVersion}`}>Continue with {examName(next)}</a></p>}
    <p className="certification-review">Reviewed <time dateTime={certificationReviewDate}>{certificationReviewDate}</time> · <a href={info.source} rel="noopener noreferrer">Official exam guidance</a></p>
  </aside>;
}

// The familiar popular URLs gain links to real questions without replacing or
// relabeling the questions that returning learners have already saved.
const popularRelated: Record<string, string[]> = {
  '1': ['239', '254'], '143': ['239', '257'], '170': ['254', '258', '259'],
  '204': ['255', '253'], '208': ['204', '255'], '238': ['256', '255'], '239': ['170', '254'],
};

export function CertificationPracticeLinks({ examId, directId }: { examId: string; directId?: string }) {
  const info = certificationFor(examId);
  const related = info ? [...(info.replacement ? [info.replacement] : []), ...info.related] : popularRelated[examId];
  if (!related) return null;
  const questionExam = info?.replacement ?? examId;
  const route = routesForExam(questionExam, 'en')[0];
  const questions = authoredQuestions(questionExam, 'en').filter(q => q.id !== directId).slice(0, 3);
  return <nav className="certification-practice-links" aria-label="Related certification practice">
    <h2>Related practice and explanations</h2>
    <ul>{related.map(id => {
      const target = routesForExam(id, 'en')[0];
      return target ? <li key={id}><a href={`${target.path}?verNbr=${authoredVersion}`}>{examName(target)} practice</a></li> : null;
    })}</ul>
    {route && questions.length > 0 && <>
      <h3>{examName(route)}: questions to review</h3>
      <ul>{questions.map(question => <li key={question.id}><a data-google-vignette="false" href={`${route.path}?questId=${question.id}&verNbr=${authoredVersion}`}>{question.text.replace(/<[^>]*>/g, '').replaceAll('&amp;', '&')}</a></li>)}</ul>
    </>}
  </nav>;
}
