import { expect, it } from 'vitest';
import { localEnvironment } from '../../scripts/local-workflow';
import { environment } from '../lib/environment';

it('isolates local checks from inherited production credentials and release flags', () => {
  const input = {
    PATH: 'local-tools', VERCEL: '1', VERCEL_ENV: 'production', VERCEL_TOKEN: 'private-token',
    QUIZEEY_ENV: 'production', QUIZEEY_CONTENT_SOURCE: 'supabase', QUIZEEY_RELEASE_READY: 'true',
    QUIZEEY_SUPABASE_SECRET_KEY: 'private-key', QUIZEEY_ADMIN_AUTH_PROVIDER: 'supabase',
    NEXT_PUBLIC_SUPABASE_URL: 'https://cloud.invalid', CRON_SECRET: 'private-cron',
    DATABASE_URL: 'postgresql://cloud.invalid/production', NODE_ENV: 'production',
  };
  const local = localEnvironment(input);
  expect(environment(local)).toMatchObject({ stage: 'local', contentSource: 'fixture', adsEnabled: false, analyticsEnabled: false });
  expect(local.PATH).toBe('local-tools');
  expect(JSON.stringify(local)).not.toMatch(/private-|cloud\.invalid/);
  expect(local.VERCEL_ENV).toBeUndefined();
  expect(local.QUIZEEY_ADMIN_AUTH_PROVIDER).toBeUndefined();
  expect(input.QUIZEEY_ENV).toBe('production');
});

it('accepts only the established loopback DB and Auth fixtures', () => {
  expect(() => localEnvironment({ QUIZEEY_LOCAL_FORUM_DATABASE_URL: 'postgresql://cloud.invalid/db' })).toThrow('isolated');
  expect(() => localEnvironment({ QUIZEEY_AUTH_FIXTURE_URL: 'http://127.0.0.1:55433' })).toThrow('isolated');
  const local = localEnvironment({
    QUIZEEY_LOCAL_FORUM_DATABASE_URL: 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture',
    QUIZEEY_AUTH_FIXTURE_URL: 'http://127.0.0.1:55433',
  });
  expect(local.QUIZEEY_ADMIN_AUTH_PROVIDER).toBe('fixture');
  expect(local.QUIZEEY_LOCAL_FORUM_ORIGIN).toBe('http://127.0.0.1:3100');
  expect(localEnvironment({}, true).QUIZEEY_LOCAL_FORUM_ORIGIN).toBe('http://127.0.0.1:3000');
});
