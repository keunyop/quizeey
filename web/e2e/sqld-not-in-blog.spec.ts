import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { sqldNotInPost } from '../src/lib/blog';
import { authoredQuestions } from '../src/lib/authored-practice';

const cta = 'SQLD 11월 연습 20문항 풀기';
const questions = authoredQuestions('5', 'ko', 202611);
test('NOT IN guide explains row truth values and reaches the actual SQLD set without JavaScript', async ({ browser, request }) => {
  const response = await request.get(sqldNotInPost.path);
  expect(response.status()).toBe(200);
  expect(await response.text()).toContain('"datePublished":"2026-11-24"');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: sqldNotInPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(sqldNotInPost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', sqldNotInPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  const rows = page.getByRole('table', { name: '같은 제외 목록에 대한 코드별 판정' }).locator('tbody tr');
  await expect(rows).toHaveCount(3);
  await expect(rows.nth(0)).toContainText('FALSE');
  for (const [index, answer] of [[1, 2], [2, 1], [3, 3]]) {
    const detail = page.locator('details').filter({ has: page.getByText(`${index}번 정답과 오답 이유`, { exact: true }) });
    await detail.locator('summary').click();
    await expect(detail).toContainText(`정답은 ${answer}번입니다.`);
  }
  await expect(page.getByRole('link', { name: cta, exact: true })).toHaveAttribute('href', sqldNotInPost.practicePath);
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page).toHaveURL(/sqlp-developer\?verNbr=202611/);
  await expect(page.locator('h1')).toHaveText('SQLD - 국가공인 SQL개발자');
  await expect(page.locator('.question-prompt')).toHaveText(questions[0].text.replace(/<[^>]*>/g, ''));
  await expect(page.getByRole('link', { name: '2026-11 연습문제 20개', exact: true })).toBeVisible();
  expect(questions.some(question => question.text.includes('NOT IN'))).toBe(true);
  await context.close();
});

test('NOT IN guide reads on mobile in both themes and grades the linked practice', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(sqldNotInPost.path);
  for (const summary of await page.locator('details summary').all()) await summary.click();
  for (const theme of ['light', 'dark']) {
    await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
  }
  await page.getByRole('link', { name: cta, exact: true }).click();
  await page.locator(`input[value="${questions[0].choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await expect(page.locator('.explanation-region')).toBeVisible();
});
