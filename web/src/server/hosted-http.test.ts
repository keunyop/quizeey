import { createHash } from 'node:crypto';
import { afterEach, beforeEach, expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
vi.mock('./study-loader', () => ({ loadStudyStore: vi.fn(async ({ examId, questionId }: { examId: string; questionId?: string }) => ({
  exams: [], source: 'supabase', version: 'synthetic',
  hasExam: (id: string) => id === '1', questions: () => examId === '1' && questionId === '123' ? [{}] : [],
})) }));
import { forumGet, forumPost } from './forum-http';
import { adminLogin, adminLogout, adminModerate, adminQueue, adminSession } from './admin-http';
import { cleanupGet } from './cleanup-http';
import { adminCookieName } from './admin-auth';
import { guestCookieName } from './guest-policy';

const config = {
  VERCEL: '1', VERCEL_ENV: 'preview', VERCEL_URL: 'quizeey-review.vercel.app', QUIZEEY_ENV: 'preview',
  QUIZEEY_PREVIEW_USER: 'review', QUIZEEY_PREVIEW_PASSWORD: 'x'.repeat(24), QUIZEEY_CONTENT_SOURCE: 'supabase',
  QUIZEEY_CONTENT_DATASET_SHA256: '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f',
  QUIZEEY_SUPABASE_URL: 'https://tfkhnrbshvyfmrzxqfmq.supabase.co',
  QUIZEEY_SUPABASE_PUBLISHABLE_KEY: 'sb_publishable_mock', QUIZEEY_SUPABASE_SECRET_KEY: 'sb_secret_mock',
  QUIZEEY_FORUM_BACKEND: 'supabase', QUIZEEY_TRUSTED_PROXY: 'vercel-direct', QUIZEEY_ABUSE_HMAC_KEY: 'h'.repeat(43),
  QUIZEEY_ADMIN_AUTH_PROVIDER: 'supabase', QUIZEEY_ADMIN_USER_IDS: '00000000-0000-4000-8000-000000000101', CRON_SECRET: 'c'.repeat(43),
};
const uuid = config.QUIZEEY_ADMIN_USER_IDS;
const base = 'https://quizeey-review.vercel.app';
const json = (value: unknown, status = 200) => new Response(JSON.stringify(value), { status, headers: { 'Content-Type': 'application/json' } });
const fetcher = vi.fn();
const request = (path = '/api/forum', body?: unknown, headers: Record<string, string> = {}) => new Request(base + path, {
  method: body === undefined ? 'GET' : 'POST', body: body === undefined ? undefined : JSON.stringify(body),
  headers: { origin: base, 'sec-fetch-site': 'same-origin', 'content-type': 'application/json', 'idempotency-key': uuid,
    'x-vercel-forwarded-for': '192.0.2.1', ...headers },
});
const create = { action: 'create', examId: '1', questionId: '123', locale: 'ko', title: 'Review', body: 'Synthetic explanation' };
const cookie = `${guestCookieName}=${'a'.repeat(43)}`;
beforeEach(() => { for (const [key, value] of Object.entries(config)) vi.stubEnv(key, value); fetcher.mockReset(); vi.stubGlobal('fetch', fetcher); });
afterEach(() => { vi.unstubAllEnvs(); vi.unstubAllGlobals(); });

it('keeps hosted routes closed unless explicitly configured and rejects forged origins before any DB calls', async () => {
  vi.stubEnv('QUIZEEY_FORUM_BACKEND', undefined);
  expect((await forumPost(request('/api/forum', create))).status).toBe(503);
  expect((await forumGet(request('/api/forum?testId=1&locale=ko'))).status).toBe(503);
  vi.stubEnv('QUIZEEY_FORUM_BACKEND', 'supabase');
  expect((await forumPost(request('/api/forum', create, { origin: 'https://evil.vercel.app' }))).status).toBe(403);
  expect((await adminLogin(request('/api/admin/login', { email: 'operator@example.test', password: 'mock' }, { origin: 'https://evil.vercel.app' }))).status).toBe(403);
  expect(fetcher).not.toHaveBeenCalled();
});

it('validates actual question context, bounds public reads and never uses the privileged key for public tables', async () => {
  expect((await forumGet(request('/api/forum?testId=1&locale=ko&questId=999'))).status).toBe(404);
  expect((await forumGet(request('/api/forum?testId=1&testId=2&locale=ko'))).status).toBe(400);
  expect(fetcher).not.toHaveBeenCalled();
  fetcher.mockResolvedValueOnce(json([]));
  const result = await forumGet(request('/api/forum?testId=1&locale=ko&questId=123'));
  expect(result.status).toBe(200); expect(await result.json()).toEqual({ topics: [], posts: [] });
  expect(result.headers.get('cache-control')).toBe('private, no-store');
  const [url, init] = fetcher.mock.calls[0];
  expect(new URL(url).searchParams.get('question_id')).toBe('eq.123');
  expect(new URL(url).searchParams.get('limit')).toBe('20');
  expect(new Headers(init.headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_PUBLISHABLE_KEY);
});

it('issues secure guest ownership only on accepted writes, hashes capabilities and shares the peer bucket across cookie rotation', async () => {
  fetcher.mockImplementation(async () => json({ status: 202, postId: uuid, topicId: uuid, secret: 'must be stripped' }));
  const result = await forumPost(request('/api/forum', create));
  expect(result.status).toBe(202); expect(await result.json()).toEqual({ status: 202, postId: uuid, topicId: uuid });
  const setCookie = result.headers.get('set-cookie')!;
  for (const part of [guestCookieName, 'HttpOnly', 'Secure', 'SameSite=strict', 'Path=/']) expect(setCookie).toContain(part);
  const args = JSON.parse(fetcher.mock.calls[0][1].body);
  expect(args.p_capability_hash).toMatch(/^[a-f0-9]{64}$/); expect(args.p_abuse_hash).toMatch(/^[a-f0-9]{64}$/);
  expect(JSON.stringify(args)).not.toContain('192.0.2.1');
  await forumPost(request('/api/forum', create, { cookie }));
  const second = JSON.parse(fetcher.mock.calls[1][1].body);
  expect(second.p_capability_hash).toBe(createHash('sha256').update('a'.repeat(43)).digest('hex'));
  expect(second.p_abuse_hash).toBe(args.p_abuse_hash);
  expect(new Headers(fetcher.mock.calls[0][1].headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_SECRET_KEY);
  fetcher.mockResolvedValueOnce(json({ status: 429 }));
  const limited = await forumPost(request('/api/forum', create));
  expect(limited.status).toBe(429); expect(limited.headers.get('set-cookie')).toBeNull();
  const count = fetcher.mock.calls.length;
  expect((await forumPost(request('/api/forum', { action: 'delete', postId: uuid }))).status).toBe(403);
  expect((await forumPost(request('/api/forum', create, { 'x-vercel-forwarded-for': '' }))).status).toBe(503);
  expect(fetcher).toHaveBeenCalledTimes(count);
});

it('returns private owned posts only through a capability hash and redacts provider failures without retrying writes', async () => {
  fetcher.mockResolvedValueOnce(json([]));
  const owned = await forumGet(request('/api/forum/mine', undefined, { cookie }), true);
  expect(await owned.json()).toEqual({ posts: [] });
  expect(fetcher.mock.calls[0][0]).toMatch(/\/rpc\/quizeey_forum_mine$/);
  expect(JSON.parse(fetcher.mock.calls[0][1].body)).toEqual({ p_capability_hash: createHash('sha256').update('a'.repeat(43)).digest('hex') });
  fetcher.mockResolvedValueOnce(json({ message: 'private detail sb_secret_mock' }, 503));
  const failed = await forumPost(request('/api/forum', create));
  expect(failed.status).toBe(503); expect(await failed.text()).not.toContain('sb_secret'); expect(fetcher).toHaveBeenCalledTimes(2);
});

it('verifies provider identity and registered sessions for moderation, preserves cursor paging and rejects replay after logout', async () => {
  const token = 'mock-access.token.signature';
  const user = { id: uuid, aud: 'authenticated', role: 'authenticated', email: 'operator@example.test', is_anonymous: false };
  let registered = false;
  fetcher.mockImplementation(async (raw: string, init: RequestInit) => {
    const path = new URL(raw).pathname;
    if (path === '/rest/v1/rpc/quizeey_admin_login_limit') return json(true);
    if (path === '/auth/v1/token') return json({ access_token: token, refresh_token: 'mock-refresh', token_type: 'bearer', expires_in: 3600, user });
    if (path === '/auth/v1/user') return json(user);
    if (path === '/rest/v1/rpc/quizeey_admin_session_create') { registered = true; return json(true); }
    if (path === '/rest/v1/rpc/quizeey_admin_session_actor') return json(registered ? uuid : null);
    if (path === '/rest/v1/rpc/quizeey_admin_queue') return json({ status: 200, items: Array.from({ length: 21 }, () => ({ id: uuid, created_at: '2026-10-18T10:00:00Z', topic_id: uuid, title: 'Synthetic', exam_id: '1', question_id: null, locale: 'ko' })) });
    if (path === '/rest/v1/rpc/quizeey_admin_moderate') {
      expect(JSON.parse(init.body as string).p_actor_id).toBe(uuid); return json({ status: 200 });
    }
    if (path === '/rest/v1/rpc/quizeey_admin_session_revoke') { registered = false; return json(null); }
    if (path === '/auth/v1/logout') return new Response(null, { status: 204 });
    throw new Error('Unexpected request');
  });
  const login = await adminLogin(request('/api/admin/login', { email: user.email, password: 'mock-only' }));
  expect(login.status).toBe(200); expect(login.headers.get('set-cookie')).toContain(adminCookieName);
  const headers = { cookie: `${adminCookieName}=${token}` };
  expect((await adminSession(request('/api/admin/session', undefined, headers))).status).toBe(200);
  const queue = await adminQueue(request('/api/admin/queue', undefined, headers));
  expect(queue.status).toBe(200); const page = await queue.json(); expect(page.items).toHaveLength(20); expect(page.nextCursor).toBeTruthy();
  await adminQueue(request('/api/admin/queue?cursor=' + page.nextCursor, undefined, headers));
  const calls = fetcher.mock.calls.filter(([url]) => url.endsWith('/rpc/quizeey_admin_queue'));
  expect(JSON.parse(calls[1][1].body as string)).toMatchObject({ p_cursor_time: '2026-10-18T10:00:00Z', p_cursor_id: uuid });
  expect((await adminModerate(request('/api/admin/moderate', { action: 'approve', id: uuid, actorId: uuid }, headers))).status).toBe(400);
  expect((await adminModerate(request('/api/admin/moderate', { action: 'approve', id: uuid }, headers))).status).toBe(200);
  expect((await adminLogout(request('/api/admin/logout', {}, headers))).status).toBe(200);
  const beforeReplay = fetcher.mock.calls.filter(([url]) => url.endsWith('/auth/v1/user')).length;
  expect((await adminSession(request('/api/admin/session', undefined, headers))).status).toBe(401);
  expect(fetcher.mock.calls.filter(([url]) => url.endsWith('/auth/v1/user'))).toHaveLength(beforeReplay);
  expect(fetcher.mock.calls.some(([url]) => url.includes('signup'))).toBe(false);
  for (const [, init] of fetcher.mock.calls.filter(([url]) => url.includes('/rpc/quizeey_admin_session_'))) expect(init.body).not.toContain(token);
});

it('authenticates cleanup separately and never grants access based on a user-agent or cron header', async () => {
  const invalidHeaders: Record<string, string>[] = [{}, { authorization: 'Bearer wrong' }, { 'user-agent': 'vercel-cron/1.0', 'x-vercel-cron-schedule': '0 9 * * *' }];
  for (const headers of invalidHeaders) {
    expect((await cleanupGet(request('/api/internal/cleanup', undefined, headers))).status).toBe(401);
  }
  expect(fetcher).not.toHaveBeenCalled();
  fetcher.mockResolvedValueOnce(json(null));
  const cleanup = await cleanupGet(request('/api/internal/cleanup', undefined, { authorization: 'Bearer ' + config.CRON_SECRET }));
  expect(cleanup.status).toBe(200); expect(cleanup.headers.get('cache-control')).toBe('private, no-store');
  expect(fetcher.mock.calls[0][0]).toMatch(/\/rpc\/quizeey_forum_cleanup$/);
});
