import { expect, test } from '@playwright/test';
import { authoredQuestions } from '../src/lib/authored-practice';
import { certifications } from '../src/lib/certifications';
import { routesForExam } from '../src/lib/contracts';

test('English discovery separates archives, keeps favorites and exposes the expanded categories', async ({ page }) => {
  await page.goto('/en');
  await expect(page).not.toHaveTitle(/dumps/i);
  for (const name of ['Cloud', 'Cybersecurity', 'Networking', 'Data & databases', 'IT support', 'Project & service management']) {
    await expect(page.getByRole('button', { name, exact: true })).toBeVisible();
  }
  await page.getByRole('button', { name: 'Cybersecurity', exact: true }).click();
  await expect(page.locator('.exam-card a[href="/en/comptia-sy0-701"]')).toBeVisible();
  await expect(page.locator('.exam-card a[href="/en/comptia-sy0-501"]')).toHaveCount(0);
  await page.getByRole('searchbox', { name: 'Search exams' }).fill('SY0-501');
  await expect(page.locator('.archive-hint')).toBeVisible();
  await page.getByLabel('Include retired exam archives').check();
  await expect(page.locator('.exam-card .exam-status')).toHaveText('Retired exam · Archive');
  await page.locator('.exam-card .favorite-button').click();
  await page.getByLabel('Include retired exam archives').uncheck();
  await page.getByRole('button', { name: /^Favorites/ }).click();
  await expect(page.locator('.exam-card a[href="/en/comptia-sy0-501"]')).toBeVisible();
});

test('archive notices and replacement paths work without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  try {
    const page = await context.newPage();
    await page.goto('/en');
    await expect(page.locator('.retired-directory a[href="/en/comptia-sy0-501"]')).toHaveCount(1);
    await expect(page.locator('.exam-directory:not(.retired-directory) a[href="/en/comptia-sy0-501"]')).toHaveCount(0);
    for (const [old, next, code] of [['comptia-sy0-501', 'comptia-sy0-701', 'SY0-501'], ['az-103', 'az-104', 'AZ-103']]) {
      await page.goto(`/en/${old}?verNbr=202610`);
      await expect(page.getByRole('heading', { name: `Retired exam: ${code}`, exact: true })).toBeVisible();
      await expect(page).toHaveTitle(/Retired Exam Archive/);
      const link = page.locator(`.certification-notice a[href="/en/${next}?verNbr=202610"]`);
      await link.click();
      await expect(page.locator('.certification-notice')).toContainText('Exam version:');
      await expect(page.locator('.question-prompt')).toBeVisible();
      await page.locator('.practice-outline summary').click();
      await expect(page.locator('.practice-outline li')).toHaveCount(12);
    }
  } finally { await context.close(); }
});

test('new certification questions can be fetched, graded and followed through related question links', async ({ page, request }) => {
  for (const [id, info] of Object.entries(certifications).filter(([, info]) => info.status === 'current')) {
    const route = routesForExam(id, 'en')[0];
    const questions = authoredQuestions(id, 'en');
    for (const question of questions) {
      const response = await request.post('/question', { data: { testId: id, questId: question.id, verNbr: 202610 } });
      expect(response.status()).toBe(200);
      expect(await response.json()).toMatchObject({ questId: Number(question.id), explanation: question.explanation, reference: question.reference });
    }
    await page.goto(`${route.path}?verNbr=202610`);
    await expect(page.locator('.certification-notice')).toContainText(info.code);
    const first = questions[0];
    await page.locator(`input[value="${first.choices.find(c => c.correct)!.id}"]`).check();
    await page.getByRole('button', { name: 'Check answer', exact: true }).click();
    await expect(page.locator('.answer-feedback')).toHaveText('Correct.');
    await expect(page.locator('.explanation-region .learning-content').first()).toContainText(first.explanation!.replace(/<[^>]*>/g, ''));
    await page.locator('.certification-practice-links a[href*="questId="]').first().click();
    await expect(page.locator('.question-prompt')).toBeVisible();
    await expect(page.locator('.certification-practice-links a')).not.toHaveCount(0);
  }
});
