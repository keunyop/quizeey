import { afterEach, expect, it, vi } from 'vitest';
vi.mock('server-only', () => ({}));
import { forumAbuseHash, forumConfiguration, forumOriginAllowed } from './forum-config';

const hostedConfig = {
  VERCEL: '1', VERCEL_ENV: 'preview', VERCEL_URL: 'quizeey-review.vercel.app', VERCEL_BRANCH_URL: 'quizeey-git-review.vercel.app',
  QUIZEEY_ENV: 'preview', QUIZEEY_PREVIEW_USER: 'review', QUIZEEY_PREVIEW_PASSWORD: 'x'.repeat(24),
  QUIZEEY_CONTENT_SOURCE: 'supabase', QUIZEEY_CONTENT_DATASET_SHA256: '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f',
  QUIZEEY_SUPABASE_URL: 'https://tfkhnrbshvyfmrzxqfmq.supabase.co',
  QUIZEEY_SUPABASE_PUBLISHABLE_KEY: 'sb_publishable_mock', QUIZEEY_SUPABASE_SECRET_KEY: 'sb_secret_mock',
  QUIZEEY_FORUM_BACKEND: 'supabase', QUIZEEY_TRUSTED_PROXY: 'vercel-direct', QUIZEEY_ABUSE_HMAC_KEY: 'h'.repeat(43), CRON_SECRET: 'c'.repeat(43),
};
const production = { ...hostedConfig, VERCEL_ENV: 'production', QUIZEEY_RELEASE_READY: 'true', QUIZEEY_ADS_VERIFIED: 'true',
  QUIZEEY_GA4_MEASUREMENT_ID: 'G-TESTONLY123', QUIZEEY_CMP_SCRIPT_URL: 'https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1' };
const request = (origin: string, headers = {}) => new Request(origin + '/api/forum', { headers: { origin, ...headers } });
afterEach(() => vi.useRealTimers());

it('requires explicit verified hosted configuration and refuses fixture fallback on Vercel', () => {
  expect(forumConfiguration({})).toBeNull();
  expect(forumConfiguration(hostedConfig)?.kind).toBe('supabase');
  for (const key of ['VERCEL', 'VERCEL_ENV', 'VERCEL_URL', 'VERCEL_BRANCH_URL', 'QUIZEEY_FORUM_BACKEND', 'QUIZEEY_TRUSTED_PROXY', 'QUIZEEY_ABUSE_HMAC_KEY', 'CRON_SECRET', 'QUIZEEY_SUPABASE_PUBLISHABLE_KEY', 'QUIZEEY_SUPABASE_SECRET_KEY']) {
    const changed: Record<string, string | undefined> = { ...hostedConfig, [key]: undefined };
    if (key === 'VERCEL_URL') changed.VERCEL_BRANCH_URL = undefined;
    if (key === 'VERCEL_BRANCH_URL') changed.VERCEL_URL = undefined;
    expect(forumConfiguration(changed)).toBeNull();
  }
  const local = { QUIZEEY_LOCAL_FORUM_DATABASE_URL: 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture' };
  expect(forumConfiguration(local)?.kind).toBe('local');
  expect(forumConfiguration({ ...local, VERCEL: '1' })).toBeNull();
  expect(forumConfiguration({ ...hostedConfig, ...local, QUIZEEY_FORUM_BACKEND: undefined })).toBeNull();
  expect(forumConfiguration({ ...hostedConfig, CRON_SECRET: hostedConfig.QUIZEEY_ABUSE_HMAC_KEY })).toBeNull();
});

it('trusts exact server-configured origins and ignores forged Host/forwarded headers', () => {
  expect(forumOriginAllowed(request('https://quizeey-review.vercel.app'), hostedConfig)).toBe(true);
  expect(forumOriginAllowed(request('https://quizeey-git-review.vercel.app'), hostedConfig)).toBe(true);
  for (const origin of ['https://evil.vercel.app', 'https://quizeey.com', 'null']) {
    expect(forumOriginAllowed(new Request('https://quizeey-review.vercel.app/api/forum', { headers: { origin, host: 'quizeey-review.vercel.app', 'x-forwarded-host': 'quizeey-review.vercel.app' } }), hostedConfig)).toBe(false);
  }
  expect(forumOriginAllowed(request('https://quizeey-review.vercel.app', { 'sec-fetch-site': 'cross-site' }), hostedConfig)).toBe(false);
  expect(forumOriginAllowed(request('https://quizeey.com'), production)).toBe(true);
  expect(forumOriginAllowed(request('https://quizeey-git-review.vercel.app'), production)).toBe(false);
  expect(forumConfiguration({ ...hostedConfig, VERCEL_URL: 'evil.com/path', VERCEL_BRANCH_URL: undefined })).toBeNull();
});

it('hashes only verified platform peers, isolates purposes and rotates daily without retaining raw IPs', () => {
  vi.useFakeTimers(); vi.setSystemTime(new Date('2026-10-18T10:00:00Z'));
  const peer = request('https://quizeey-review.vercel.app', { 'x-vercel-forwarded-for': '192.0.2.1' });
  const first = forumAbuseHash(peer, 'forum', hostedConfig);
  expect(first).toMatch(/^[a-f0-9]{64}$/);
  expect(forumAbuseHash(request('https://quizeey-review.vercel.app', { 'x-vercel-forwarded-for': '192.0.2.1', 'cf-connecting-ip': '203.0.113.2', 'x-forwarded-for': '203.0.113.3' }), 'forum', hostedConfig)).toBe(first);
  expect(forumAbuseHash(peer, 'admin', hostedConfig)).not.toBe(first);
  vi.setSystemTime(new Date('2026-10-19T10:00:00Z'));
  expect(forumAbuseHash(peer, 'forum', hostedConfig)).not.toBe(first);
  for (const headers of [{}, { 'x-forwarded-for': '192.0.2.1' }, { 'x-vercel-forwarded-for': '192.0.2.1, 203.0.113.1' }]) {
    expect(() => forumAbuseHash(request('https://quizeey-review.vercel.app', headers), 'forum', hostedConfig)).toThrow();
  }
  const ipv6 = (ip: string) => forumAbuseHash(request('https://quizeey-review.vercel.app', { 'x-vercel-forwarded-for': ip }), 'forum', hostedConfig);
  expect(ipv6('2001:db8::1')).toBe(ipv6('2001:0db8:0000:0000:0000:0000:0000:0001'));
});
