import { describe, expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import { loadLearningStore } from './learning-store';
import { sampleQuestions } from './sample-questions';
import { authoredQuestions, authoredVersion } from '@/lib/authored-practice';
import { questions } from '@/lib/fixtures';
import { readSessionSettings } from '@/lib/practice-session';
import { parseQuery } from '@/lib/contracts';

const seed = 'b75d8c32-a053-4d50-9465-c84d430d6dd8';
describe('practice sessions', () => {
  it('samples the complete archive and authored pool without duplicates and restores exact order', async () => {
    const store = await loadLearningStore();
    const pool = [...questions.filter(q => q.testId === '5'), ...authoredQuestions('5', 'ko')];
    const selected = store.sessionQuestions('5', 'ko', 0, 20, seed);
    expect(selected.map(q => q.id)).toEqual(sampleQuestions(pool, 20, seed).map(q => q.id));
    expect(new Set(selected.map(q => q.id)).size).toBe(20);
    expect(store.sessionQuestions('5', 'ko', 0, 20, seed)).toEqual(selected);
    expect(store.sessionQuestions('5', 'ko', 0, 20, '9e03847d-087f-4d35-81e8-57cb015db2e8')).not.toEqual(selected);
    expect(new Set(store.sessionQuestions('5', 'ko', 0, 100, seed).map(q => q.version))).toEqual(new Set([1, 2, authoredVersion]));
    const visited = new Set<string>();
    for (let i = 0; i < 100; i++) for (const question of store.sessionQuestions('5', 'ko', 0, 5, String(i))) visited.add(question.id);
    expect(visited).toEqual(new Set(pool.map(q => q.id)));
  });
  it('honors a selected set and supports more than the old 20-question page', async () => {
    const store = await loadLearningStore();
    expect(store.sessionQuestions('5', 'ko', 1, 100, seed).map(q => q.id)).toEqual(['900000001', '900000002']);
    expect(store.sessionQuestions('5', 'ko', authoredVersion, 40, seed)).toEqual(authoredQuestions('5', 'ko').slice(0, 40));
  });
  it('rejects tampered settings and ambiguous or unbounded counts', () => {
    expect(readSessionSettings(`${seed}.40`)).toEqual({ seed, count: 40 });
    for (const value of ['', 'broken.20', `${seed}.0`, `${seed}.101`, `${seed}.-1`]) expect(readSessionSettings(value)).toBeUndefined();
    for (const value of ['count=0', 'count=101', 'count=2.5', 'count=20&count=40']) expect(() => parseQuery(new URLSearchParams(value))).toThrow();
  });
});
