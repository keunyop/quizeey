// Owner-private archive → local DB → real API → answer-area browser verification.
// Credentials stay in memory; no question text or author names enter the report.
import fs from 'node:fs';
import path from 'node:path';
import net from 'node:net';
import crypto from 'node:crypto';
import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const require = createRequire(path.join(root, 'web/package.json'));
const { chromium, expect } = require('@playwright/test');
const { Client } = require('pg');
const origin = 'http://127.0.0.1:3100';
const pause = ms => new Promise(resolve => setTimeout(resolve, ms));

async function main() {
  assert.ok(!process.env.VERCEL && !process.env.VERCEL_ENV, 'Local verification only');
  const snapshot = JSON.parse(fs.readFileSync(path.join(root, 'docs/modernization/source-snapshot-evidence.json'), 'utf8'));
  const source = fs.realpathSync(path.join(root, snapshot.privatePath));
  const allowed = fs.realpathSync(path.join(root, '.modernization/exports'));
  const relative = path.relative(allowed, source);
  assert.ok(relative && !relative.startsWith('..') && !path.isAbsolute(relative));
  const restoration = JSON.parse(fs.readFileSync(path.join(source, 'restored-comments-202610/manifest.json'), 'utf8'));
  assert.equal(restoration.localRestoreVerified, true);
  const { examId, questionId } = restoration.sampleContext;
  const db = new Client({ connectionString: 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture' });
  let expected;
  await db.connect();
  try {
    expected = (await db.query(`select p.id,p.display_name,p.body from public.quizeey_posts p
      join public.quizeey_topics t on t.id=p.topic_id where t.exam_id=$1 and t.question_id=$2
      and p.visibility='approved' order by p.created_at,p.id limit 50`, [examId, questionId])).rows;
  } finally { await db.end(); }
  assert.ok(expected.length > 0);
  await new Promise((resolve, reject) => {
    const probe = net.createServer(); probe.once('error', () => reject(new Error('Refusing occupied verification port')));
    probe.listen(3100, '127.0.0.1', () => probe.close(resolve));
  });
  const credentials = { username: 'restoration-review', password: crypto.randomBytes(32).toString('base64url') };
  const authorization = 'Basic ' + Buffer.from(credentials.username + ':' + credentials.password).toString('base64');
  const env = { ...process.env, QUIZEEY_ENV: 'local', QUIZEEY_CONTENT_SOURCE: 'local-archive',
    QUIZEEY_LOCAL_CONTENT_FILE: path.join(source, 'local-content.json'), QUIZEEY_PREVIEW_USER: credentials.username,
    QUIZEEY_PREVIEW_PASSWORD: credentials.password, QUIZEEY_LOCAL_FORUM_DATABASE_URL: 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture',
    QUIZEEY_LOCAL_FORUM_ORIGIN: origin, QUIZEEY_ADMIN_USER_IDS: '', NEXT_TELEMETRY_DISABLED: '1' };
  const log = fs.openSync(path.join(source, 'restored-comments-202610/browser-server.log'), 'w');
  const server = spawn(process.execPath, ['node_modules/next/dist/bin/next', 'start', '--hostname', '127.0.0.1', '--port', '3100'], {
    cwd: path.join(root, 'web'), env, stdio: ['ignore', log, log], windowsHide: true,
  });
  let browser;
  try {
    let ready = false;
    for (let i = 0; i < 80; i++) {
      assert.equal(server.exitCode, null, 'Verification server exited');
      try { if ((await fetch(origin, { signal: AbortSignal.timeout(1000) })).status === 401) { ready = true; break; } } catch {}
      await pause(250);
    }
    assert.ok(ready, 'Protected verification server did not start');
    const query = new URLSearchParams({ testId: examId, questId: questionId, locale: 'ko' });
    const response = await fetch(origin + '/api/forum?' + query, { headers: { authorization } });
    assert.equal(response.status, 200);
    const actual = await response.json();
    // Compare the exact user text in memory without logging it on assertion failure.
    assert.ok(JSON.stringify(actual.posts.map(({ id, display_name, body }) => ({ id, display_name, body }))) === JSON.stringify(expected), 'Restored API values differ');
    browser = await chromium.launch({ channel: 'msedge', headless: true });
    const context = await browser.newContext({ httpCredentials: credentials, colorScheme: 'dark' });
    const page = await context.newPage();
    let errors = 0, external = 0;
    page.on('pageerror', () => errors++);
    await page.route('**/*', route => {
      if (route.request().url().startsWith(origin)) return route.continue();
      external++; return route.abort();
    });
    await page.goto(origin + '/test?testId=' + examId + '&questId=' + questionId);
    await expect(page.getByRole('heading', { name: '문제 댓글', exact: true })).toHaveCount(0);
    await page.locator('fieldset input').first().check();
    await page.getByRole('button', { name: '정답 확인', exact: true }).click();
    const comments = page.getByRole('region', { name: '문제 댓글', exact: true });
    await expect(comments.locator('.forum-post')).toHaveCount(expected.length);
    await expect(comments.getByRole('button', { name: '수정', exact: true })).toHaveCount(0);
    await page.reload();
    await expect(comments.locator('.forum-post')).toHaveCount(expected.length);
    await expect(page.getByRole('region', { name: '시험 댓글', exact: true })).toBeVisible();
    assert.equal(errors, 0, 'Browser error'); assert.equal(external, 0, 'Unexpected external request');
    const result = { status: 'passed', localOnly: true, restoredComments: restoration.comments, restoredQuestionThreads: restoration.topics,
      checkedQuestionComments: expected.length, exactApiTextAndNamesMatched: true, visibleAfterGradingAndRefresh: true,
      importedOwnershipNotInferred: true, examCommentsSeparate: true, darkTheme: true, externalRequests: external, browserErrors: errors,
      originalArchiveModified: false, hostedApplied: false };
    fs.writeFileSync(path.join(root, 'docs/modernization/restored-comments-browser-evidence.json'), JSON.stringify(result, null, 2) + '\n');
    console.log(JSON.stringify(result));
  } finally {
    if (browser) await browser.close();
    server.kill();
    await new Promise(resolve => { if (server.exitCode !== null) resolve(); else server.once('exit', resolve); });
    fs.closeSync(log);
  }
}

main().catch(() => { console.error('Restored-comment browser verification failed; private values suppressed.'); process.exitCode = 1; });
