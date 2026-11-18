import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { cookingInfectionPost } from '../src/lib/blog';

test('cooking infection article exposes its metadata and native explanations without JavaScript', async ({ browser, request }) => {
  const response = await request.get(cookingInfectionPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('BlogPosting');
  expect(html).toContain('"datePublished":"2026-11-18"');
  expect(html).toContain('"inLanguage":"ko-KR"');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: cookingInfectionPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(cookingInfectionPost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', cookingInfectionPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.getByRole('table')).toHaveCount(1);
  await expect(page.getByRole('rowheader')).toHaveText(['장티푸스', '세균성이질', '폴리오', '유행성이하선염']);
  for (const [index, answer] of [[1, '정답은 4번, 유행성이하선염입니다.'], [2, '정답은 2번입니다.'], [3, '정답은 3번입니다.']] as const) {
    await page.getByText(`사례 ${index} 정답과 선택지별 이유`, { exact: true }).click();
    await expect(page.getByText(answer, { exact: true })).toBeVisible();
  }
  await page.getByRole('link', { name: '한식조리기능사 10월 연습문제 풀기 →', exact: true }).click();
  await expect(page).toHaveURL(/craftsman-cook-korean-food\?verNbr=202610/);
  await expect(page.locator('h1')).toHaveText('한식조리기능사');
  await expect(page.locator('.question-prompt')).toHaveText('생고기와 바로 먹는 채소를 손질할 때 적절한 방법은?');
  await context.close();
});

test('cooking infection article is accessible on mobile in both themes and reaches practice feedback', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(cookingInfectionPost.path);
  for (const theme of ['light', 'dark']) {
    await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.getByText('사례 1 정답과 선택지별 이유', { exact: true }).click();
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
    await page.getByText('사례 1 정답과 선택지별 이유', { exact: true }).click();
  }
  await page.getByRole('link', { name: '한식조리기능사 10월 연습문제 풀기 →', exact: true }).click();
  await expect(page.locator('.question-prompt')).toHaveText('생고기와 바로 먹는 채소를 손질할 때 적절한 방법은?');
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
});
