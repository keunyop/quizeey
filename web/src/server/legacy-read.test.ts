import { afterEach, expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
vi.mock('./study-loader', () => ({ loadStudyStore: vi.fn() }));
import { loadStudyStore } from './study-loader';
import { coreStudyStore } from './study-store';
import { legacyRead } from './legacy-read';

const store = coreStudyStore({ schema: 1, tables: {
  exams: [{ exam_id: '1', name_ko: 'Synthetic', name_en: null, legacy_slug: 'synthetic', priority: 1 }],
  versions: [{ version_id: '11', exam_id: '1', number: 1, name: 'Synthetic set' }],
  questions: [{ question_id: '123', version_id: '11', number: 1, body: 'Synthetic question', explanation: 'Built-in solution', reference: null, multiple_answers: false }],
  choices: [{ choice_id: '124', question_id: '123', number: 1, body: 'Synthetic choice', correct: true }],
  legacy_counters: [],
}, pendingExplanationCounts: { '123': 2 } }, 'synthetic-only', 'supabase');
const request = (body: unknown) => new Request('https://quizeey.com/explanations', {
  method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify(body),
});
afterEach(() => vi.resetAllMocks());

it('keeps deferred user posts private while preserving the built-in solution and stable legacy question wire', async () => {
  vi.mocked(loadStudyStore).mockResolvedValue(store);
  const deferred = await legacyRead(request({ questId: '123' }), 'explanations');
  expect(deferred.status).toBe(200);
  expect(await deferred.json()).toEqual([]);
  expect(deferred.headers.get('cache-control')).toBe('no-store');
  expect(deferred.headers.get('x-robots-tag')).toContain('noindex');
  const question = await legacyRead(request({ testId: '1', questId: '123' }), 'question');
  expect(question.status).toBe(200);
  expect(await question.json()).toMatchObject({ questId: 123, explanation: 'Built-in solution', multiAnswer: false });
});

it('continues to distinguish unknown questions, invalid identities and actual data outages', async () => {
  vi.mocked(loadStudyStore).mockResolvedValue(store);
  expect((await legacyRead(request({ questId: '999' }), 'explanations')).status).toBe(404);
  expect((await legacyRead(request({ questId: 'invalid' }), 'explanations')).status).toBe(400);
  vi.mocked(loadStudyStore).mockRejectedValueOnce(new Error('Unavailable'));
  expect((await legacyRead(request({ questId: '123' }), 'explanations')).status).toBe(503);
});
