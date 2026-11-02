import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { blogPost, blogPostPath } from '../src/lib/blog';

test('read the Korean blog and reach SQLD practice without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/');
  await page.getByRole('link', { name: blogPost.title, exact: true }).click();
  await expect(page).toHaveURL(new RegExp(blogPostPath));
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.getByRole('heading', { level: 1 })).toHaveText(blogPost.title);
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', blogPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await page.getByText('정답과 해설 보기', { exact: true }).click();
  await expect(page.getByText('정답: 1, 0.', { exact: true })).toBeVisible();
  await page.getByRole('link', { name: 'SQLD 문제 풀기 →', exact: true }).click();
  await expect(page.locator('.question-prompt')).toBeVisible();
  await expect(page.getByRole('link', { name: blogPost.title, exact: true })).toHaveAttribute('href', blogPostPath);
  await page.goto('/blog');
  await expect(page.getByRole('link', { name: blogPost.title, exact: true })).toHaveAttribute('href', blogPostPath);
  await context.close();
});

test('blog remains accessible on mobile in light and dark themes', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  for (const path of ['/blog', blogPostPath]) {
    await page.goto(path);
    for (const theme of ['light', 'dark']) {
      await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
      const results = await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze();
      expect(results.violations).toEqual([]);
    }
  }
});

test('unknown blog articles return 404', async ({ request }) => {
  expect((await request.get('/blog/not-a-post')).status()).toBe(404);
});
