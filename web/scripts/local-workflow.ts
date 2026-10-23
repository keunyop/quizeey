import { spawn } from 'node:child_process';
import { existsSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const web = fileURLToPath(new URL('../', import.meta.url));
const localDatabase = 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture';
const localAuth = 'http://127.0.0.1:55433';

/** Never inherit hosted app configuration into a local fixture process. */
export function localEnvironment(input: Record<string, string | undefined>, development = false): Record<string, string | undefined> {
  if (input.QUIZEEY_LOCAL_FORUM_DATABASE_URL && input.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== localDatabase) {
    throw new Error('Only the isolated local forum database is allowed (values redacted).');
  }
  if (input.QUIZEEY_AUTH_FIXTURE_URL &&
      (input.QUIZEEY_AUTH_FIXTURE_URL !== localAuth || input.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== localDatabase)) {
    throw new Error('Auth tests require the isolated local database and Auth fixture.');
  }
  const env = Object.fromEntries(Object.entries(input).filter(([key]) =>
    !/^(QUIZEEY_|VERCEL(?:_|$)|NEXT_PUBLIC_|SUPABASE_|CRON_SECRET$|DATABASE_URL$|NODE_ENV$)/i.test(key)));
  Object.assign(env, {
    QUIZEEY_ENV: 'local', QUIZEEY_CONTENT_SOURCE: 'fixture',
    QUIZEEY_RELEASE_READY: 'false', QUIZEEY_ADS_VERIFIED: 'false',
    QUIZEEY_PRODUCTION_REVIEW: 'false', NEXT_TELEMETRY_DISABLED: '1',
    QUIZEEY_LOCAL_FORUM_ORIGIN: `http://127.0.0.1:${development ? 3000 : 3100}`,
  });
  if (input.QUIZEEY_LOCAL_FORUM_DATABASE_URL) env.QUIZEEY_LOCAL_FORUM_DATABASE_URL = localDatabase;
  if (input.QUIZEEY_AUTH_FIXTURE_URL) Object.assign(env, {
    QUIZEEY_AUTH_FIXTURE_URL: localAuth, QUIZEEY_ADMIN_AUTH_PROVIDER: 'fixture',
    QUIZEEY_ADMIN_USER_IDS: '00000000-0000-4000-8000-000000000101',
  });
  if (process.platform === 'win32' && !env.PLAYWRIGHT_CHANNEL) env.PLAYWRIGHT_CHANNEL = 'msedge';
  return env;
}

async function main() {
  const [mode, ...extra] = process.argv.slice(2);
  if (!['dev', 'build', 'test', 'e2e', 'check'].includes(mode) || (extra.length && mode !== 'e2e')) {
    throw new Error('Usage: local-workflow.ts dev|build|test|e2e|check (e2e accepts Playwright arguments).');
  }
  // Next loads these files after process startup. Refuse automatic dotenv input
  // rather than accidentally restoring hosted credentials stripped below.
  const automaticFiles = ['.env', '.env.local', ...['development', 'production', 'test']
    .flatMap(stage => [`.env.${stage}`, `.env.${stage}.local`])];
  if (automaticFiles.some(name => existsSync(resolve(web, name)))) {
    throw new Error('Isolated local commands require no automatic .env files. Keep deployment configuration in an explicitly loaded file such as .env.forum.production.local.');
  }
  const env = localEnvironment(process.env, mode === 'dev');
  const next = 'node_modules/next/dist/bin/next';
  const build = [['scripts/preflight-production.ts'], [next, 'build']];
  // Multi-tab journeys share a developer workstation with other applications.
  const browser = ['node_modules/@playwright/test/cli.js', 'test', '--timeout=60000', ...extra];
  const unit = ['node_modules/vitest/vitest.mjs', 'run'];
  const plans: Record<string, string[][]> = {
    dev: [[next, 'dev', '--hostname', '127.0.0.1']], build, test: [unit],
    e2e: [...build, browser],
    check: [['node_modules/typescript/bin/tsc', '--noEmit'],
      ['node_modules/eslint/bin/eslint.js', '.'], unit, ...build, browser, ['../tools/modernization/test_monetization.mjs']],
  };
  console.log('Local fixture workflow: no Vercel deployment; browser server http://127.0.0.1:3100.');
  if (['check', 'e2e'].includes(mode)) {
    console.log(`Forum DB fixture: ${env.QUIZEEY_LOCAL_FORUM_DATABASE_URL ? 'enabled' : 'absent (DB tests skip)'}. Auth fixture: ${env.QUIZEEY_AUTH_FIXTURE_URL ? 'enabled' : 'absent (Auth tests skip)'}.`);
  }
  for (const args of plans[mode]) {
    console.log(`Local: ${args.join(' ')}`);
    const code = await new Promise<number>((done, fail) => {
      const child = spawn(process.execPath, args, {
        cwd: web, env: { ...env, NODE_ENV: args === unit ? 'test' : mode === 'dev' ? 'development' : 'production' },
        stdio: 'inherit', windowsHide: true,
      });
      child.once('error', fail);
      child.once('exit', code => done(code ?? 1));
    });
    if (code !== 0) { process.exitCode = code; return; }
  }
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch(error => { console.error(error.message); process.exitCode = 1; });
}
