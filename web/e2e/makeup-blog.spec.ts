import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { makeupHygienePost } from '../src/lib/blog';

test('makeup guide opens its explanations and the verified practice set without JavaScript', async ({ browser, request }) => {
  const response = await request.get(makeupHygienePost.path);
  expect(response.status()).toBe(200);
  expect(await response.text()).toContain('BlogPosting');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: makeupHygienePost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(makeupHygienePost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', makeupHygienePost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await page.getByText('사례 1 정답과 선택지별 이유', { exact: true }).click();
  await expect(page.getByText('정답은 3번입니다.', { exact: true })).toBeVisible();
  await page.getByText('사례 2 정답과 선택지별 이유', { exact: true }).click();
  await expect(page.getByText('정답은 2번입니다.', { exact: true })).toBeVisible();
  await page.getByRole('link', { name: '메이크업 기초 위생 3문제 풀기 →', exact: true }).click();
  await expect(page).toHaveURL(/make-up-artist\?verNbr=202610/);
  await expect(page.locator('h1')).toHaveText('미용사(메이크업)');
  await expect(page.locator('.question-prompt')).toHaveText('여러 고객에게 사용하는 도구를 관리하는 적절한 방법은?');
  await context.close();
});

test('makeup guide stays accessible on mobile in both themes and leads to answer feedback', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(makeupHygienePost.path);
  for (const theme of ['light', 'dark']) {
    await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
  }
  await page.getByRole('link', { name: '메이크업 기초 위생 3문제 풀기 →', exact: true }).click();
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
});
