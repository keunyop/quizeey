import { expect, test } from '@playwright/test';
import { authoredQuestions } from '../src/lib/authored-practice';
import manifest from '../content/practice-2026-11.manifest.json' with { type: 'json' };
import type { Locale } from '../src/lib/contracts';

test('all 320 November questions are available through the local question API', async ({ request }) => {
  test.setTimeout(180_000);
  for (const exam of manifest.exams) {
    for (const question of authoredQuestions(exam.examId, exam.locale as Locale, 202611)) {
      const response = await request.post('/question', {
        data: { testId: exam.examId, questId: question.id, verNbr: 202611 },
      });
      expect(response.status()).toBe(200);
      const body = await response.json();
      expect(body).toMatchObject({ questId: Number(question.id), testId: Number(exam.examId), verNbr: 202611 });
      expect(body.explanation).toBeTruthy();
      expect(body.examples.filter((choice: { answer: boolean }) => choice.answer)).toHaveLength(1);
    }
  }
});

for (const [path, id, locale] of [['/adsp', '260', 'ko'], ['/en/aws-ai-practitioner-aif-c01', '261', 'en']] as const) {
  test(`${locale} new exam supports discovery, grading and saved progress`, async ({ page }) => {
    await page.goto(locale === 'en' ? '/en' : '/');
    await expect(page.locator(`a[href="${path}"]`).first()).toBeAttached();
    await page.route('**/api/exams/click', route => route.fulfill({ status: 204 }));
    const recorded = page.waitForRequest(request => request.url().endsWith('/api/exams/click'));
    await page.getByRole('navigation', { name: locale === 'en' ? 'New November 2026 practice' : '2026-11 새 연습문제' }).locator(`a[href="${path}?verNbr=202611"]`).click();
    expect((await recorded).postDataJSON()).toEqual({ path });
    await expect(page.locator('#version')).toHaveValue('202611');
    await expect(page.locator('.question-version')).toContainText('2026-11');
    await expect(page.getByRole('navigation', { name: locale === 'en' ? 'Monthly practice sets' : '월별 연습문제' }).getByRole('link')).toHaveAttribute('href', `${path}?verNbr=202611`);
    const first = authoredQuestions(id, locale, 202611)[0];
    await page.locator(`input[value="${first.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.locator('#question-content').focus();
    await page.keyboard.press('Enter');
    await expect(page.locator('.answer-feedback')).toContainText(locale === 'en' ? 'Correct' : '정답');
    await page.reload();
    await page.getByRole('button', { name: locale === 'en' ? 'Continue' : '이어서 풀기', exact: true }).click();
    await expect(page.locator('.answer-feedback')).toBeVisible();
    await expect(page).toHaveTitle(/2026-11/);
  });
}

test('the old October set remains selectable alongside November', async ({ page }) => {
  await page.goto('/sqlp-developer?verNbr=202610');
  await expect(page.locator('.question-version')).toContainText('2026-10');
  await page.locator('#version').selectOption('202611');
  await expect(page.locator('.question-version')).toHaveText('회차 · 2026-11 연습문제');
  await expect(page.locator('.question-grid button')).toHaveCount(20);
  await expect(page.locator('.practice-outline a').first()).toHaveAttribute('href', /verNbr=202611/);
});
