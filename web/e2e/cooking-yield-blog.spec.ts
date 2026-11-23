import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { cookingYieldPost } from '../src/lib/blog';
import { authoredQuestions } from '../src/lib/authored-practice';

const firstQuestion = authoredQuestions('14', 'ko', 202611)[0];
const cta = '한식조리 11월 연습문제 풀기 →';

test('Cooking yield guide explains purchase arithmetic and reaches the actual November practice without JavaScript', async ({ browser, request }) => {
  const response = await request.get(cookingYieldPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('BlogPosting');
  expect(html).toContain('"datePublished":"2026-11-23"');
  expect(html).toContain('"inLanguage":"ko-KR"');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: cookingYieldPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(cookingYieldPost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', cookingYieldPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.getByRole('table', { name: '같은 손질 작업의 중량과 비율' }).locator('tbody tr')).toHaveCount(4);
  await expect(page.locator('main')).toContainText('1.8 kg ÷ 0.75 = 2.4 kg');
  for (const [index, answer] of [[1, 3], [2, 1], [3, 2]]) {
    const detail = page.locator('details').filter({ has: page.getByText(`${index}번 정답과 오답 이유`, { exact: true }) });
    await detail.locator('summary').click();
    await expect(detail).toContainText(`정답은 ${answer}번입니다.`);
  }
  await expect(page.getByRole('link', { name: cta, exact: true })).toHaveAttribute('href', cookingYieldPost.practicePath);
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page).toHaveURL(/craftsman-cook-korean-food\?verNbr=202611/);
  await expect(page.locator('h1')).toHaveText('한식조리기능사');
  await expect(page.locator('.question-prompt')).toHaveText(firstQuestion.text.replace(/<[^>]*>/g, ''));
  await expect(page.getByRole('link', { name: '2026-11 연습문제 80개', exact: true })).toBeVisible();
  await context.close();
});

test('Cooking yield guide supports mobile themes, accessible reading and actual answer feedback', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(cookingYieldPost.path);
  for (const summary of await page.locator('details summary').all()) await summary.click();
  for (const theme of ['light', 'dark']) {
    await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
  }
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page.locator('.question-prompt')).toHaveText(firstQuestion.text.replace(/<[^>]*>/g, ''));
  await page.locator(`input[value="${firstQuestion.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await expect(page.locator('.explanation-region')).toBeVisible();
});
