import { readFileSync } from 'node:fs';
import { afterEach, expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import { createSupabaseTransport, SupabaseTransportError } from './supabase-transport';

const config = { QUIZEEY_ENV: 'preview', QUIZEEY_PREVIEW_USER: 'review', QUIZEEY_PREVIEW_PASSWORD: 'x'.repeat(24),
  QUIZEEY_SUPABASE_URL: 'https://tfkhnrbshvyfmrzxqfmq.supabase.co',
  QUIZEEY_SUPABASE_PUBLISHABLE_KEY: 'sb_publishable_mock', QUIZEEY_SUPABASE_SECRET_KEY: 'sb_secret_mock' };
const uuid = '00000000-0000-4000-8000-000000000101';
const digest = 'a'.repeat(64);
const json = (value: unknown, status = 200) => new Response(JSON.stringify(value), { status, headers: { 'Content-Type': 'application/json' } });
afterEach(() => vi.unstubAllGlobals());

it('requires protected preview and exact project before any network request', () => {
  const fetcher = vi.fn(); vi.stubGlobal('fetch', fetcher);
  for (const change of [{ QUIZEEY_ENV: 'local' }, { VERCEL_ENV: 'production' }, { QUIZEEY_PREVIEW_PASSWORD: '' },
    { QUIZEEY_SUPABASE_URL: 'https://other.supabase.co' }, { QUIZEEY_SUPABASE_SECRET_KEY: 'sb_publishable_mock' },
    { QUIZEEY_SUPABASE_PUBLISHABLE_KEY: 'sb_secret_mock' }]) {
    expect(() => createSupabaseTransport({ ...config, ...change })).toThrow(SupabaseTransportError);
  }
  expect(fetcher).not.toHaveBeenCalled();
});

it('uses the publishable key for public reads and preserves locale-shared imported explanations', async () => {
  const topic = { id: uuid, title: 'import', locale: 'ko', created_at: '2026-10-16T00:00:00Z' };
  const post = { id: uuid, topic_id: uuid, parent_id: null, display_name: null, body: '<script>plain text</script>', created_at: topic.created_at };
  const cursor = { createdAt: '2026-10-16T00:00:00.123456Z', id: uuid };
  const fetcher = vi.fn().mockResolvedValueOnce(json({ topics: [topic], posts: [post], next: cursor }));
  vi.stubGlobal('fetch', fetcher);
  expect(await createSupabaseTransport(config).publicForum('1', 'en', '123', cursor)).toMatchObject({ topics: [topic], posts: [post], nextCursor: expect.any(String) });
  const topicUrl = new URL(fetcher.mock.calls[0][0]);
  expect(topicUrl.pathname).toBe('/rest/v1/rpc/quizeey_forum_page');
  expect(JSON.parse(fetcher.mock.calls[0][1].body)).toEqual({ p_exam_id: '1', p_locale: 'en', p_question_id: '123', p_cursor_time: cursor.createdAt, p_cursor_id: uuid });
  for (const [url, init] of fetcher.mock.calls) {
    expect(new URL(url).pathname).toBe('/rest/v1/rpc/quizeey_forum_page');
    expect(new Headers(init.headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_PUBLISHABLE_KEY);
    expect(JSON.stringify(init)).not.toContain(config.QUIZEEY_SUPABASE_SECRET_KEY);
    expect(init).toMatchObject({ cache: 'no-store', redirect: 'error' });
    expect(init.signal).toBeInstanceOf(AbortSignal);
  }
});

it('does not query posts for empty topics and rejects filter injection without HTTP', async () => {
  const fetcher = vi.fn().mockResolvedValue(json({ topics: [], posts: [], next: null })); vi.stubGlobal('fetch', fetcher);
  const transport = createSupabaseTransport(config);
  expect(await transport.publicForum('1', 'ko', null)).toEqual({ topics: [], posts: [], nextCursor: null });
  expect(fetcher).toHaveBeenCalledTimes(1);
  await expect(transport.publicForum('1', 'ko', '1,visibility.eq.pending')).rejects.toThrow(SupabaseTransportError);
  expect(fetcher).toHaveBeenCalledTimes(1);
});

it('matches the existing SQL RPC parameter names and keeps server credentials out of results', async () => {
  const fetcher = vi.fn(); vi.stubGlobal('fetch', fetcher);
  const transport = createSupabaseTransport(config);
  const ddl = [2, 3, 4].map(number => readFileSync(new URL(`../../../supabase/migrations/${({2:'202610160002_native_forum',3:'202610160003_guest_private_preview',4:'202610160004_admin_moderation'} as Record<number,string>)[number]}.sql`, import.meta.url), 'utf8')).join('\n');
  const calls = [
    ['quizeey_forum_mutate', { p_capability_hash: digest, p_abuse_hash: digest, p_request_id: uuid, p_action: 'create', p_payload: { examId: '1', locale: 'ko', title: 'Review', body: 'Pending', displayName: '' } }, { status: 202 }],
    ['quizeey_forum_mine', { p_capability_hash: digest }, []],
    ['quizeey_admin_login_limit', { p_abuse_hash: digest }, true],
    ['quizeey_admin_queue', { p_kind: 'posts', p_state: 'pending', p_cursor_time: null, p_cursor_id: null }, { status: 200, items: [] }],
    ['quizeey_admin_moderate', { p_actor_id: uuid, p_request_id: uuid, p_action: 'approve', p_id: uuid }, { status: 200 }],
    ['quizeey_admin_session_create', { p_hash: digest, p_actor: uuid, p_expires: '2026-10-16T00:00:00Z' }, true],
    ['quizeey_admin_session_actor', { p_hash: digest }, uuid],
    ['quizeey_admin_session_revoke', { p_hash: digest }, null],
    ['quizeey_forum_cleanup', {}, null],
  ] as const;
  for (const [name, args, response] of calls) {
    fetcher.mockResolvedValueOnce(json(response));
    expect(await transport.rpc(name, args)).toEqual(response);
    const signature = ddl.match(new RegExp(`create function public\\.${name}\\(([^)]*)\\)`))![1];
    const sqlParams = signature.trim() ? signature.split(',').map(value => value.trim().split(/\s+/)[0]) : [];
    expect(Object.keys(args)).toEqual(sqlParams);
    const [url, init] = fetcher.mock.calls.at(-1)!;
    expect(url).toBe(config.QUIZEEY_SUPABASE_URL + '/rest/v1/rpc/' + name);
    expect(init.method).toBe('POST');
    expect(JSON.parse(init.body)).toEqual(args);
    expect(new Headers(init.headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_SECRET_KEY);
  }
});

it('rejects arbitrary RPCs, raw tokens, invalid payloads and incomplete cursors before HTTP', async () => {
  const fetcher = vi.fn(); vi.stubGlobal('fetch', fetcher);
  const transport = createSupabaseTransport(config);
  // Simulate a JavaScript caller bypassing the TS operation union.
  await expect(transport.rpc('arbitrary_sql' as never, {} as never)).rejects.toThrow(SupabaseTransportError);
  await expect(transport.rpc('quizeey_admin_session_actor', { p_hash: 'raw-token' })).rejects.toThrow(SupabaseTransportError);
  await expect(transport.rpc('quizeey_forum_mutate', { p_capability_hash: digest, p_abuse_hash: digest, p_request_id: uuid, p_action: 'create', p_payload: { body: '' } })).rejects.toThrow(SupabaseTransportError);
  await expect(transport.rpc('quizeey_admin_queue', { p_kind: 'posts', p_state: 'pending', p_cursor_time: null, p_cursor_id: uuid })).rejects.toThrow(SupabaseTransportError);
  expect(fetcher).not.toHaveBeenCalled();
});

it('does not retry writes or expose provider failures and rejects malformed success responses', async () => {
  const fetcher = vi.fn().mockResolvedValueOnce(json({ message: 'private-db-detail sb_secret_mock' }, 503))
    .mockRejectedValueOnce(new Error('private network detail')).mockResolvedValueOnce(json({ role: 'postgres' }));
  vi.stubGlobal('fetch', fetcher);
  const transport = createSupabaseTransport(config);
  for (let attempt = 1; attempt <= 3; attempt++) {
    await expect(transport.rpc('quizeey_admin_session_actor', { p_hash: digest })).rejects.toThrow('Supabase transport unavailable');
    expect(fetcher).toHaveBeenCalledTimes(attempt);
  }
});

it('sends exam counts through server-only RPCs and preserves bigint JSON precision', async () => {
  const fetcher = vi.fn().mockResolvedValueOnce(json(null)).mockResolvedValueOnce(json({ '5': '9007199254740993' }));
  vi.stubGlobal('fetch', fetcher);
  const transport = createSupabaseTransport(config);
  expect(await transport.rpc('quizeey_exam_click', { p_exam_id: '5' })).toBeNull();
  expect(await transport.rpc('quizeey_exam_popularity', { p_exam_ids: ['5'] })).toEqual({ '5': '9007199254740993' });
  expect(JSON.parse(fetcher.mock.calls[0][1].body)).toEqual({ p_exam_id: '5' });
  expect(JSON.parse(fetcher.mock.calls[1][1].body)).toEqual({ p_exam_ids: ['5'] });
  for (const [, init] of fetcher.mock.calls) {
    expect(new Headers(init.headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_SECRET_KEY);
    expect(init.cache).toBe('no-store');
  }
  await expect(transport.rpc('quizeey_exam_click', { p_exam_id: '0' })).rejects.toThrow(SupabaseTransportError);
  await expect(transport.rpc('quizeey_exam_popularity', { p_exam_ids: [] })).rejects.toThrow(SupabaseTransportError);
  expect(fetcher).toHaveBeenCalledTimes(2);
  fetcher.mockResolvedValueOnce(json({ '5': 9007199254740992 }));
  await expect(transport.rpc('quizeey_exam_popularity', { p_exam_ids: ['5'] })).rejects.toThrow(SupabaseTransportError);
});

it('keeps submission and management RPCs server-only and validates contexts before HTTP', async () => {
  const payload = { kind: 'question_report' as const, locale: 'ko' as const, path: '/sqlp-developer', body: 'Answer issue', examId: '5', questionId: '123' };
  const fetcher = vi.fn().mockResolvedValueOnce(json({ status: 201 })).mockResolvedValueOnce(json([]));
  vi.stubGlobal('fetch', fetcher); const transport = createSupabaseTransport(config);
  expect(await transport.rpc('quizeey_submit_feedback', { p_request_id: uuid, p_abuse_hash: digest, p_payload: payload })).toEqual({ status: 201 });
  expect(await transport.rpc('quizeey_admin_inbox', { p_kind: 'feedback', p_state: 'open', p_cursor_time: null, p_cursor_id: null })).toEqual([]);
  expect(JSON.parse(fetcher.mock.calls[0][1].body).p_payload).toEqual(payload);
  for (const [, init] of fetcher.mock.calls) expect(new Headers(init.headers).get('apikey')).toBe(config.QUIZEEY_SUPABASE_SECRET_KEY);
  await expect(transport.rpc('quizeey_submit_feedback', { p_request_id: uuid, p_abuse_hash: digest, p_payload: { ...payload, questionId: null } })).rejects.toThrow(SupabaseTransportError);
  await expect(transport.rpc('quizeey_admin_inbox', { p_kind: 'feedback', p_state: 'all', p_cursor_time: null, p_cursor_id: uuid })).rejects.toThrow(SupabaseTransportError);
  expect(fetcher).toHaveBeenCalledTimes(2);
});
