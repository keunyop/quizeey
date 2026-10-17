// Verify the approved protected deployment against owner-private source values.
// Credentials, share URLs, response bodies and screenshots stay owner-private.
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
import { learningHtml } from '../../web/src/lib/content.ts';
import { messages } from '../../web/src/lib/i18n.ts';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const source = path.join(root, '.modernization/exports/source-265c3ca16e');
const require = createRequire(path.join(root, 'web/package.json'));
const { chromium } = require('@playwright/test');
const check = (value, step) => { if (!value) throw Object.assign(Error('Preview verification failed'), { verificationStep: step }); };
const hash = value => crypto.createHash('sha256').update(value).digest('hex');

async function main() {
  const access = JSON.parse(fs.readFileSync(path.join(source, 'preview-access.json'), 'utf8'));
  const origin = new URL(access.origin).origin;
  check(origin === access.origin && new URL(origin).hostname.endsWith('.vercel.app'), 'exact deployment origin');
  const share = new URL(access.shareUrl);
  check(share.origin === origin && share.searchParams.has('_vercel_share'), 'origin-scoped temporary share URL');
  const bytes = fs.readFileSync(path.join(source, 'local-content.json'));
  const manifest = JSON.parse(fs.readFileSync(path.join(source, 'local-content-manifest.json'), 'utf8'));
  check(hash(bytes) === manifest.contentSha256, 'private source hash');
  const { tables: t } = JSON.parse(bytes);
  const contract = JSON.parse(fs.readFileSync(path.join(root, 'web/fixtures/legacy-contract.json'), 'utf8'));
  const routeFor = (id, locale = 'ko') => contract.routes.find(r => r.testId === id && r.locale === locale && !r.path.startsWith('/kr/') && !r.path.endsWith('/test'));
  const versionCounts = new Map();
  for (const q of t.questions) versionCounts.set(q.version_id, (versionCounts.get(q.version_id) ?? 0) + 1);
  const candidates = t.versions.filter(v => versionCounts.get(v.version_id) > 22 && routeFor(v.exam_id));
  const version = candidates.find(v => v.exam_id === '5') ?? candidates[0];
  check(version, 'source version beyond twenty');
  const examId = version.exam_id;
  const examRoute = routeFor(examId).path;
  const group = t.questions.filter(q => q.version_id === version.version_id).sort((a, b) => a.number - b.number || Number(a.question_id) - Number(b.question_id));
  const selectedQuestion = group[22];
  const choicesByQuestion = new Map();
  for (const c of t.choices) {
    if (!choicesByQuestion.has(c.question_id)) choicesByQuestion.set(c.question_id, []);
    choicesByQuestion.get(c.question_id).push(c);
  }
  const deleted = JSON.parse(fs.readFileSync(path.join(source, 'new-service-deleted-question-ids.json'), 'utf8'));
  check(deleted.length === 751 && deleted.every(id => !t.questions.some(q => q.question_id === id)), 'excluded IDs absent');
  let browser;
  let externalRequests = 0;
  let platformToolbarRequestsBlocked = 0;
  let browserErrors = 0;
  const platformToolbar = url => url.protocol === 'https:' && url.hostname === 'vercel.live' && url.pathname === '/_next-live/feedback/feedback.js';
  const checks = [];
  try {
    browser = await chromium.launch({ channel: 'msedge', headless: true });
    const unauth = await browser.newContext();
    const denied = await unauth.request.get(origin, { maxRedirects: 0 });
    check([401, 403, 302, 307].includes(denied.status()), 'Vercel unauthenticated access denied');
    check(!(await denied.text()).includes(learningHtml(selectedQuestion.body)), 'no source in unauthenticated response');
    await unauth.close();
    // Official automation header excludes Vercel's injected collaboration toolbar.
    // Application scripts and integrations remain subject to the origin checks.
    const context = await browser.newContext({ httpCredentials: { username: access.user, password: access.password }, extraHTTPHeaders: { 'x-vercel-skip-toolbar': '1' }, viewport: { width: 390, height: 844 } });
    await context.route('**/*', route => {
      const url = new URL(route.request().url());
      if (url.origin === origin) return route.continue();
      // Existing build artifacts can retain Vercel's injected toolbar despite
      // its suppression header/project setting. Block that known platform
      // request and report it separately; reject every other external request.
      if (platformToolbar(url)) { platformToolbarRequestsBlocked++; return route.abort(); }
      externalRequests++;
      return route.abort();
    });
    const page = await context.newPage();
    page.on('pageerror', () => browserErrors++);
    const first = await page.goto(access.shareUrl, { waitUntil: 'networkidle' });
    check(first?.status() === 200, 'authenticated home and temporary Vercel cookie');
    check(!await page.locator('.preview-notice').count(), 'actual source without sample notice');
    const authorization = 'Basic ' + Buffer.from(access.user + ':' + access.password).toString('base64');
    const post = async (route, input, auth = authorization) => {
      const response = await context.request.post(origin + route, { headers: { authorization: auth, 'content-type': 'application/json' }, data: input, maxRedirects: 0 });
      return { response, body: await response.json().catch(() => null) };
    };
    const wrong = await post('/question', { testId: examId }, 'Basic invalid');
    check(wrong.response.status() === 401, 'application wrong Basic denied');
    checks.push('Vercel and application authentication');
    const verifyQuestion = async q => {
      const v = t.versions.find(v => v.version_id === q.version_id);
      const expected = choicesByQuestion.get(q.question_id);
      const result = await post('/question', { testId: v.exam_id, verNbr: v.number, questId: q.question_id });
      check(result.response.status() === 200, 'exact question API');
      const body = result.body;
      check(String(body.questId) === q.question_id && body.questNbr === q.number && String(body.testId) === v.exam_id, 'original question identities');
      check(body.questTxt === learningHtml(q.body), 'sanitized source body');
      check(body.explanation === (q.explanation === null ? null : learningHtml(q.explanation)), 'nullable source explanation');
      check(body.reference === (q.reference === null ? null : learningHtml(q.reference)), 'nullable source reference');
      check(JSON.stringify(body.examples.filter(c => c.answer).map(c => String(c.exmpId)).sort()) === JSON.stringify(expected.filter(c => c.correct).map(c => c.choice_id).sort()), 'source correct choice set');
      check(body.examples.length === expected.length && body.examples.every(c => expected.some(e => e.choice_id === String(c.exmpId) && learningHtml(e.body) === c.exmpTxt)), 'source choice bodies');
      return { version: v, choices: expected };
    };
    const selected = await verifyQuestion(selectedQuestion);
    checks.push('direct source lookup beyond twenty, values, correct sets and nullable fields');
    for (const [languageCd, field] of [['kr', 'name_ko'], ['en', 'name_en']]) {
      const catalog = await post('/tests', { languageCd });
      check(catalog.response.status() === 200 && catalog.body.length === t.exams.filter(e => e[field] !== null).length, 'complete source catalog');
    }
    const versions = await post('/versions', { testId: examId });
    check(versions.response.status() === 200 && versions.body.length === t.versions.filter(v => v.exam_id === examId).length, 'complete version list');
    const counter = t.legacy_counters.find(c => c.question_id === selectedQuestion.question_id);
    const stats = await post('/questionStats', { questId: selectedQuestion.question_id });
    check(stats.response.status() === 200 && stats.body.correct === (counter?.correct ?? 0) && stats.body.inCorrect === (counter?.incorrect ?? 0), 'source counters');
    check((await post('/explanations', { questId: selectedQuestion.question_id })).response.status() === 503, 'native explanations remain pending');
    check((await post('/question', { testId: examId, questId: deleted[0] })).response.status() === 404, 'excluded question denied');
    check((await post('/question', { testId: t.exams.find(e => e.exam_id !== examId).exam_id, questId: selectedQuestion.question_id })).response.status() === 404, 'foreign exam denied');
    check((await post('/question', { testId: examId, questId: 'invalid' })).response.status() === 400, 'invalid identity denied');
    const random = await post('/question', { testId: examId, verNbr: version.number });
    check(random.response.status() === 200 && group.some(q => q.question_id === String(random.body.questId)), 'random question from requested population');
    checks.push('catalog, versions, counters, random and invalid/excluded identities');
    const practice = async (q, chosen, correct, locale, suffix) => {
      const v = t.versions.find(v => v.version_id === q.version_id);
      const base = routeFor(v.exam_id, locale)?.path;
      check(base, 'practice route');
      const response = await page.goto(origin + base + '?verNbr=' + v.number + '&questId=' + q.question_id);
      check(response.status() === 200, 'source SSR');
      check((response.headers()['x-robots-tag'] ?? '').includes('noindex'), 'preview noindex');
      check((response.headers()['cache-control'] ?? '').includes('no-store'), 'preview private cache');
      check(await page.locator('.question-card input').count() === choicesByQuestion.get(q.question_id).length, 'source browser choices');
      for (const c of chosen) await page.locator('input[value="' + c.choice_id + '"]').check();
      await page.getByRole('button', { name: messages[locale].grade, exact: true }).click();
      await page.getByText(correct ? messages[locale].correct : messages[locale].incorrect, { exact: true }).waitFor({ state: 'visible' });
      await page.reload();
      await page.getByText(correct ? messages[locale].correct : messages[locale].incorrect, { exact: true }).waitFor({ state: 'visible' });
      check(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth), 'mobile viewport width');
      await page.screenshot({ path: path.join(source, 'cloud-preview-' + suffix + '.png'), fullPage: true });
    };
    await practice(selectedQuestion, selected.choices.filter(c => c.correct), true, 'ko', 'korean');
    const multiple = t.questions.find(q => choicesByQuestion.get(q.question_id)?.filter(c => c.correct).length > 1 && routeFor(t.versions.find(v => v.version_id === q.version_id)?.exam_id, 'en'));
    check(multiple, 'real multiple-answer English question');
    const multipleChoices = choicesByQuestion.get(multiple.question_id).filter(c => c.correct);
    await verifyQuestion(multiple);
    await practice(multiple, multipleChoices.slice(0, 1), false, 'en', 'multiple-incomplete');
    await page.evaluate(() => localStorage.clear());
    await practice(multiple, multipleChoices, true, 'en', 'multiple-correct');
    checks.push('Korean/English mobile source grading, incomplete multiple answers and reload restoration');
    await page.goto(origin + '/kr' + examRoute + '?verNbr=' + version.number + '&questId=' + selectedQuestion.question_id);
    check(await page.locator('.question-card').count() === 1, 'legacy Korean alias');
    await page.goto(origin + '/test?testId=' + examId + '&questId=' + selectedQuestion.question_id);
    check(await page.locator('.question-card').count() === 1, 'legacy test deep link');
    const scripts = await page.locator('script[src]').evaluateAll(nodes => nodes.map(n => n.src));
    check(scripts.length > 0, 'client bundles present');
    for (const script of scripts) {
      if (platformToolbar(new URL(script))) continue;
      check(new URL(script).origin === origin, 'same origin bundle');
      const bundle = await (await context.request.get(script)).text();
      check(!bundle.includes(access.password) && !/sb_secret_[A-Za-z0-9_-]{20,}/.test(bundle), 'no server credentials in client bundle');
      check(!bundle.includes(selectedQuestion.body), 'source archive absent from static bundle');
    }
    check((await context.request.get(origin + '/api/admin/queue', { headers: { authorization } })).status() === 503, 'unprovisioned admin denied');
    check(externalRequests === 0 && browserErrors === 0, 'no external requests or browser errors');
    checks.push('legacy routes, static application bundle boundary, admin gate and zero external application requests');
    const evidence = { recordedAt: '2026-10-17', status: 'protected_actual_content_preview_pass', origin,
      projectId: 'prj_0SVBqfgurtvZErmpMJl01BJkUKOd', datasetSha256: '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f',
      checks, sourceQuestions: t.questions.length, excludedQuestions: deleted.length,
      externalRequests, browserErrors, secretValuesPrinted: false, sourceContentPrinted: false,
      screenshotsOwnerPrivate: true, platformToolbarRequestsBlocked, platformToolbarSuppressionHeaderSent: true, productionPublished: false };
    fs.writeFileSync(path.join(root, 'docs/modernization/cloud-preview-flow-evidence.json'), JSON.stringify(evidence, null, 2) + '\n');
    process.stdout.write('Protected actual-content API/browser flow passed; screenshots and credentials remain owner-private.\n');
  } finally {
    if (browser) await browser.close();
  }
}
try { await main(); }
catch (error) {
  process.stderr.write('Protected cloud preview failed (' + (error.verificationStep ?? error.constructor.name) + '); no source or credentials printed.\n');
  process.exitCode = 1;
}
