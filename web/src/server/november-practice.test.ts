import { createHash } from 'node:crypto';
import { expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import october from '@/data/practice-2026-10.json' with { type: 'json' };
import november from '@/data/practice-2026-11.json' with { type: 'json' };
import manifest from '../../content/practice-2026-11.manifest.json' with { type: 'json' };
import { allAuthoredQuestions, authoredCatalog, authoredDefaultLocale, authoredQuestions, authoredSetSummaries, findAuthoredQuestion } from '@/lib/authored-practice';
import { findRoute, type Locale } from '@/lib/contracts';
import { examCategory, matchesExam } from '@/lib/exam-catalog';
import { publicSitemap, searchCopy, pageStructuredData } from '@/lib/seo';
import { grade } from '@/lib/quiz';
import { versionDisplayName } from '@/lib/version-label';
import { loadLearningStore } from './learning-store';

const hash = (value: unknown) => createHash('sha256').update(JSON.stringify(value)).digest('hex');

it('preserves the complete October catalog and payloads while isolating November identities', () => {
  expect(hash(october.groups)).toBe(manifest.previousGroupsSha256);
  expect(hash(authoredCatalog.slice(0, manifest.previousCatalogCount))).toBe(manifest.previousCatalogSha256);
  const questions = authoredCatalog.flatMap(exam => allAuthoredQuestions(exam.id, authoredDefaultLocale(exam.id)));
  expect(questions).toHaveLength(2534);
  expect(new Set(questions.map(q => q.id)).size).toBe(questions.length);
  expect(new Set(questions.flatMap(q => q.choices.map(c => c.id))).size).toBe(questions.length * 4);
  expect(november.groups.flatMap(group => group.questions)).toHaveLength(320);
});

it('serves, grades and resolves all 320 November questions without cross-set or cross-exam leakage', async () => {
  const store = await loadLearningStore();
  for (const exam of manifest.exams) {
    const locale = exam.locale as Locale;
    const questions = authoredQuestions(exam.examId, locale, 202611);
    expect(questions).toHaveLength(exam.count);
    expect(store.versions(exam.examId, locale)[0]).toMatchObject({ number: 202611, name: '2026-11' });
    expect(store.pagination(exam.examId, locale, 202611)).toMatchObject({ total: exam.count, pages: exam.count / 20 });
    expect(Array.from({ length: exam.count / 20 }, (_, page) => store.questions(exam.examId, locale, 202611, undefined, page + 1)).flat()).toEqual(questions);
    expect(store.questions(exam.examId, locale, 202611, undefined, exam.count / 20 + 1)).toEqual([]);
    expect(store.sessionQuestions(exam.examId, locale, 202611, 100, 'seed')).toEqual(questions);
    expect(store.random(exam.examId, locale, 202611)?.version).toBe(202611);
    for (const q of questions) {
      expect(q.contentLocale).toBe(locale);
      expect(q.explanation!.length).toBeGreaterThan(35);
      expect(q.reference).toContain('href="https://');
      expect(q.choices.filter(c => c.correct)).toHaveLength(1);
      expect(grade(q, [q.choices.find(c => c.correct)!.id])).toBe(true);
      expect(grade(q, [q.choices.find(c => !c.correct)!.id])).toBe(false);
      expect(findAuthoredQuestion(q.id, locale)).toEqual(q);
      expect(store.questions(exam.examId, locale, 202611, q.id)).toEqual([q]);
      expect(store.questions(exam.examId, locale, 202610, q.id)).toEqual([]);
      expect(store.questions('999', locale, 202611, q.id)).toEqual([]);
    }
  }
  expect(authoredQuestions('260', 'en', 202611)).toEqual([]);
  expect(authoredQuestions('261', 'ko', 202611)).toEqual([]);
  expect(authoredSetSummaries('260', 'ko').map(set => set.version)).toEqual([202611]);
  expect(findAuthoredQuestion('8300260021')).toBeUndefined();
});

it('discovers both new exams and every November set with accurate metadata and dates', () => {
  const urls = new Set(publicSitemap('https://example.test').map(entry => entry.url));
  for (const exam of manifest.exams) {
    const catalog = authoredCatalog.find(entry => entry.id === exam.examId)!;
    const path = `${exam.locale === 'en' ? '/en' : ''}/${catalog.slug}`;
    const route = findRoute(path)!;
    expect(route.testId).toBe(exam.examId);
    expect(urls.has(`https://example.test${path}?verNbr=202611`)).toBe(true);
    const query = new URLSearchParams('verNbr=202611');
    const copy = searchCopy(path, query, route);
    expect(copy.title).toContain('2026-11');
    expect(copy.description).toContain(String(exam.count));
    expect(copy.description).not.toContain('2026-10');
    expect(JSON.stringify(pageStructuredData(path, query, route, 'https://example.test'))).toContain('LearningResource');
  }
  expect(matchesExam(findRoute('/adsp')!, '데이터분석 준전문가')).toBe(true);
  expect(matchesExam(findRoute('/en/aws-ai-practitioner-aif-c01')!, 'AIF-C01')).toBe(true);
  expect(examCategory(findRoute('/adsp')!)).toBe('it');
  expect(examCategory(findRoute('/en/aws-ai-practitioner-aif-c01')!)).toBe('cloud');
  expect(urls.has('https://example.test/adsp?verNbr=202610')).toBe(false);
  expect(versionDisplayName('2026-11', 202611, 'ko')).toBe('2026-11 연습문제');
});
