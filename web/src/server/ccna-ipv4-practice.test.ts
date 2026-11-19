import { createHash } from 'node:crypto';
import { expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import october from '@/data/practice-2026-10.json' with { type: 'json' };
import { allAuthoredQuestions, authoredQuestions, authoredSetSummaries, authoredSetSummary, findAuthoredQuestion } from '@/lib/authored-practice';
import { emptyProgress, readProgress, regradeProgress } from '@/lib/progress';
import { grade } from '@/lib/quiz';
import { findRoute } from '@/lib/contracts';
import { pageStructuredData, publicSitemap, searchCopy } from '@/lib/seo';
import { loadLearningStore } from './learning-store';

const examId = '204';
const version = 202611;
const correctTexts = ['192.0.2.129', '10.40.4.0 / 10.40.7.255', 'A는 다른 서브넷, B는 같은 서브넷으로 판단한다.', '198.51.100.42/30', '10.0.8.128/26'];

it('isolates the five Korean IPv4 questions from English and preserves every October payload and identity', () => {
  const previous = october.groups.filter(group => group.examIds.includes(examId));
  expect(createHash('sha256').update(JSON.stringify(previous)).digest('hex')).toBe('a2e2508e4fb232f763d190e179f7a5d993f6e4c499842dda2716767e18023da1');
  const old = authoredQuestions(examId, 'ko', 202610);
  expect(old).toHaveLength(23);
  expect(old.every(question => question.contentLocale === 'en')).toBe(true);
  expect(authoredQuestions(examId, 'en', 202610).map(question => ({ ...question, locale: 'ko', reference: undefined })))
    .toEqual(old.map(question => ({ ...question, reference: undefined })));
  expect(old.map(question => question.id)).toEqual(Array.from({ length: 23 }, (_, i) => String(8_000_020_401 + i)));
  expect(old.map(question => question.choices.find(choice => choice.correct)!.id)).toEqual(Array.from({ length: 23 }, (_, i) => String(9_000_204_000 + i * 10)));
  expect(authoredQuestions(examId, 'en', version)).toEqual([]);
  expect(authoredSetSummary(examId, 'en', version)).toBeUndefined();
  expect(authoredSetSummaries(examId, 'ko').map(set => set.version)).toEqual([version, 202610]);
  expect(authoredSetSummaries(examId, 'en').map(set => set.version)).toEqual([202610]);
  const all = allAuthoredQuestions(examId, 'ko');
  expect(all).toHaveLength(28);
  expect(new Set(all.map(question => question.id)).size).toBe(28);
  expect(new Set(all.flatMap(question => question.choices.map(choice => choice.id))).size).toBe(112);
});

it('keeps correct answers attached to rotated choices, with stable IDs and exact score restoration', () => {
  const questions = authoredQuestions(examId, 'ko', version);
  expect(questions).toHaveLength(5);
  expect(questions.map(question => question.choices.findIndex(choice => choice.correct))).toEqual([0, 3, 2, 1, 0]);
  for (const [index, question] of questions.entries()) {
    expect(question).toMatchObject({ id: String(8_300_204_001 + index), testId: examId, locale: 'ko', contentLocale: 'ko', version, questionNumber: index + 1, preserveOrder: true });
    const correct = question.choices.find(choice => choice.correct)!;
    expect(correct).toMatchObject({ text: correctTexts[index], id: String(9_202_040_000 + index * 10) });
    expect(question.choices.filter(choice => choice.correct)).toHaveLength(1);
    expect(grade(question, [correct.id])).toBe(true);
    for (const distractor of question.choices.filter(choice => !choice.correct)) expect(grade(question, [distractor.id])).toBe(false);
    expect(grade(question, [correct.id, correct.id])).toBe(false);
    expect(question.reference).toContain('https://www.cisco.com/');
    expect(findAuthoredQuestion(question.id)).toEqual(question);
    expect(findAuthoredQuestion(question.id, 'en')).toBeUndefined();
  }
  expect(findAuthoredQuestion('8300204000')).toBeUndefined();
  expect(findAuthoredQuestion('8300204006')).toBeUndefined();
  for (const [set, locale] of [[questions, 'ko'], [authoredQuestions(examId, 'en', 202610), 'en']] as const) {
    const ids = set.map(question => question.id);
    const saved = emptyProgress(ids, 'fixture-content');
    saved.index = 1;
    saved.attempts[ids[0]] = { selected: [set[0].choices.find(choice => choice.correct)!.id], correct: true };
    saved.bookmarks = [ids[1]];
    saved.choiceOrders[ids[0]] = set[0].choices.map(choice => choice.id);
    const restored = readProgress(JSON.stringify(saved), ids, 'fixture-content');
    expect(restored, locale).toEqual(saved);
    expect(regradeProgress(restored!, [...set]), locale).toEqual(saved);
  }
});

it('serves the correct locale, set, page and direct-link boundaries through the learning store', async () => {
  const store = await loadLearningStore();
  const questions = authoredQuestions(examId, 'ko', version);
  expect(store.pagination(examId, 'ko', version)).toEqual({ page: 1, total: 5, pages: 1 });
  expect(store.questions(examId, 'ko', version)).toEqual(questions);
  expect(store.questions(examId, 'ko', version, undefined, 2)).toEqual([]);
  expect(store.sessionQuestions(examId, 'ko', version, 100, 'seed')).toEqual(questions);
  expect(store.versions(examId, 'en').some(set => set.number === version)).toBe(false);
  expect(store.sessionQuestions(examId, 'en', 0, 100, 'seed').some(question => question.version === version)).toBe(false);
  expect(store.random(examId, 'ko', version)?.version).toBe(version);
  expect(store.random(examId, 'en', version)).toBeUndefined();
  for (const question of questions) {
    expect(store.hasQuestion(question.id)).toBe(true);
    expect(store.questions(examId, 'ko', version, question.id)).toEqual([question]);
    expect(store.questions(examId, 'en', version, question.id)).toEqual([]);
    expect(store.questions(examId, 'ko', 202610, question.id)).toEqual([]);
    expect(store.questions('5', 'ko', version, question.id)).toEqual([]);
  }
});

it('advertises only the Korean November route and describes its actual five-question language', () => {
  const path = '/ccna-200-301';
  const route = findRoute(path)!;
  expect(route.testId).toBe(examId);
  const query = new URLSearchParams('verNbr=202611');
  expect(searchCopy(path, query, route)).toMatchObject({ title: expect.stringContaining('2026-11'), description: expect.stringContaining('5개') });
  const structured = JSON.stringify(pageStructuredData(path, query, route, 'https://example.test'));
  expect(structured).toContain('LearningResource');
  expect(structured).toContain('"inLanguage":["ko"]');
  const urls = new Set(publicSitemap('https://example.test').map(entry => entry.url));
  expect(urls.has('https://example.test/ccna-200-301?verNbr=202611')).toBe(true);
  expect(urls.has('https://example.test/en/ccna-200-301?verNbr=202611')).toBe(false);
});
