import { createHash } from 'node:crypto';
import { expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import manifest from '../../content/certifications-2026-10.manifest.json' with { type: 'json' };
import originalRoutes from '../../fixtures/legacy-contract.json' with { type: 'json' };
import content from '@/data/practice-2026-10.json' with { type: 'json' };
import { authoredCatalog, authoredDefaultLocale, authoredQuestions, findAuthoredQuestion } from '@/lib/authored-practice';
import { certifications, isRetiredExam } from '@/lib/certifications';
import { findRoute, legacyPageRedirect, routesForExam } from '@/lib/contracts';
import { examCategory, matchesExam } from '@/lib/exam-catalog';
import { grade } from '@/lib/quiz';
import { publicSitemap, searchMetadata } from '@/lib/seo';
import { LearningStore } from './learning-store';
import { coreStudyStore } from './study-store';

const hash = (value: unknown) => createHash('sha256').update(JSON.stringify(value)).digest('hex');

it('preserves all existing catalog, question payloads, route identities and direct-query URLs', () => {
  expect(hash(authoredCatalog.slice(0, manifest.previousCatalog.count))).toBe(manifest.previousCatalog.sha256);
  expect(hash(content.groups.slice(0, manifest.previousGroups.count))).toBe(manifest.previousGroups.sha256);
  for (const previous of originalRoutes.routes.filter(route => route.locale === 'en' && route.testId)) {
    expect(findRoute(previous.path)?.testId).toBe(previous.testId);
    expect(legacyPageRedirect(previous.path, new URLSearchParams('questId=123&verNbr=1&page=2'))).toBeUndefined();
  }
  const allQuestions = authoredCatalog.flatMap(exam => authoredQuestions(exam.id, authoredDefaultLocale(exam.id)));
  expect(new Set(allQuestions.map(q => q.id)).size).toBe(allQuestions.length);
  expect(new Set(allQuestions.flatMap(q => q.choices.map(c => c.id))).size).toBe(allQuestions.length * 4);
});

it('serves 84 new English scenarios with detailed explanations and isolated identities', () => {
  const store = new LearningStore(coreStudyStore({ schema: 1, tables: { exams: [], versions: [], questions: [], choices: [], legacy_counters: [] }, pendingExplanationCounts: {} }, 'fixture'));
  const oldPrompts = new Set(content.groups.slice(0, manifest.previousGroups.count).flatMap(g => g.questions.map(q => q.prompt)));
  const newGroups = content.groups.slice(manifest.previousGroups.count);
  const added = newGroups.flatMap(g => g.questions);
  expect(added).toHaveLength(manifest.addedQuestionCount);
  expect(new Set(added.map(q => q.prompt)).size).toBe(added.length);
  for (const item of added) {
    expect(oldPrompts.has(item.prompt)).toBe(false);
    expect(item.explanation.length).toBeGreaterThan(160);
    expect(item.prompt + item.explanation).not.toMatch(/[\uac00-\ud7a3]/);
    expect(new Set(item.choices).size).toBe(4);
  }
  const sitemap = new Set(publicSitemap('https://example.test').map(entry => entry.url));
  for (const id of manifest.examIds) {
    const questions = authoredQuestions(id, 'en');
    expect(questions).toHaveLength(12);
    expect(authoredQuestions(id, 'ko')).toEqual([]);
    expect(store.pagination(id, 'en', 202610)).toMatchObject({ total: 12, pages: 1 });
    expect(store.questions(id, 'en', 202610)).toEqual(questions);
    expect(store.questions(id, 'en', 202610, undefined, 2)).toEqual([]);
    const route = routesForExam(id, 'en')[0];
    expect(sitemap.has(`https://example.test${route.path}?verNbr=202610`)).toBe(true);
    expect(matchesExam(route, certifications[id].code)).toBe(true);
    for (const question of questions) {
      expect(findAuthoredQuestion(question.id, 'en')).toEqual(question);
      expect(store.questions(id, 'en', 202610, question.id)).toEqual([question]);
      expect(store.questions('168', 'en', 202610, question.id)).toEqual([]);
      expect(question.choices.filter(c => c.correct)).toHaveLength(1);
      expect(grade(question, [question.choices.find(c => c.correct)!.id])).toBe(true);
      expect(grade(question, [question.choices.find(c => !c.correct)!.id])).toBe(false);
      expect(question.reference).toContain('https://');
    }
  }
});

it('labels retired versions consistently in search while preserving canonical discoverability', () => {
  const retired = Object.entries(certifications).filter(([, info]) => info.status === 'retired');
  expect(retired).toHaveLength(15);
  for (const [id, info] of retired) {
    expect(isRetiredExam(id)).toBe(true);
    const route = routesForExam(id, 'en')[0];
    for (const suffix of ['', 'verNbr=202610', 'questId=123&verNbr=1']) {
      const metadata = searchMetadata(route.path, new URLSearchParams(suffix), route, 'https://example.test', true);
      expect(metadata.title).toMatchObject({ absolute: expect.stringContaining('Retired Exam Archive') });
      expect(metadata.description).toContain(info.note);
      expect(metadata.alternates?.canonical).toContain(route.path);
    }
    for (const target of [...info.related, ...(info.replacement ? [info.replacement] : [])]) {
      expect(isRetiredExam(target)).toBe(false);
      expect(routesForExam(target, 'en')[0]).toBeDefined();
      expect(authoredQuestions(target, 'en').length).toBeGreaterThan(0);
    }
  }
  expect(certifications['198'].note).toContain('August 31, 2026');
  expect(certifications['190'].note).toContain('November 30, 2026');
  expect(examCategory(findRoute('/en/comptia-sy0-701')!)).toBe('security');
  expect(examCategory(findRoute('/en/az-104')!)).toBe('cloud');
  expect(examCategory(findRoute('/en/comptia-n10-009')!)).toBe('networking');
  expect(examCategory(findRoute('/en/comptia-220-1201')!)).toBe('it-support');
  expect(examCategory(findRoute('/en/dp-900')!)).toBe('data');
  expect(examCategory(findRoute('/en/pmi-pmp')!)).toBe('business');
  expect(examCategory(findRoute('/comptia-sy0-501')!)).toBe('it');
});
