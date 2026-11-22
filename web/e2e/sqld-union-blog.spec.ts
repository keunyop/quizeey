import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { sqldUnionPost } from '../src/lib/blog';
import { authoredQuestions } from '../src/lib/authored-practice';

const firstQuestion = authoredQuestions('5', 'ko', 202611)[0];
const cta = 'SQLD 11월 연습문제 풀기 →';

test('UNION guide explains the input and reaches the exact SQLD November set without JavaScript', async ({ browser, request }) => {
  const response = await request.get(sqldUnionPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('BlogPosting');
  expect(html).toContain('"datePublished":"2026-11-21"');
  expect(html).toContain('"inLanguage":"ko-KR"');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: sqldUnionPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(sqldUnionPost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', sqldUnionPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.getByRole('table', { name: '두 조회가 반환하는 입력 여섯 행' }).locator('tbody tr')).toHaveCount(6);
  await expect(page.getByRole('table', { name: 'UNION 결과: 순서를 지정하지 않은 세 행의 예시 나열' }).locator('tbody tr')).toHaveCount(3);
  for (const [index, answer] of [[1, 2], [2, 1], [3, 3]]) {
    const detail = page.locator('details').filter({ has: page.getByText(`${index}번 정답과 오답 이유`, { exact: true }) });
    await detail.locator('summary').click();
    await expect(detail).toContainText(`정답은 ${answer}번입니다.`);
  }
  await expect(page.getByRole('link', { name: cta, exact: true })).toHaveAttribute('href', sqldUnionPost.practicePath);
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page).toHaveURL(/sqlp-developer\?verNbr=202611/);
  await expect(page.locator('h1')).toHaveText('SQLD - 국가공인 SQL개발자');
  await expect(page.locator('.question-prompt')).toHaveText(firstQuestion.text.replace(/<[^>]*>/g, ''));
  await expect(page.getByRole('link', { name: '2026-11 연습문제 20개', exact: true })).toBeVisible();
  await context.close();
});

test('UNION guide supports mobile themes, accessibility and actual answer feedback', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(sqldUnionPost.path);
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
