import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { blogPost, blogPostPath, subnetPost } from '../src/lib/blog';

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
  for (const path of ['/blog', blogPostPath, '/en/blog', subnetPost.path]) {
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
  expect((await request.get('/en/blog/not-a-post')).status()).toBe(404);
  expect((await request.get('/blog/ipv4-subnetting-practice')).status()).toBe(404);
  expect((await request.get('/en/blog/sqld-cbt-study-guide')).status()).toBe(404);
});

test('English article is readable without JavaScript and links to existing practice', async ({ browser, request }) => {
  const html = await (await request.get(subnetPost.path)).text();
  expect(html).toContain('172.16.32.0/20');
  expect(html).toContain('BlogPosting');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/en/blog');
  await page.getByRole('link', { name: subnetPost.title, exact: true }).click();
  await expect(page.locator('html')).toHaveAttribute('lang', 'en');
  await page.getByText('Show answer 3', { exact: true }).click();
  await expect(page.getByText('Network: 172.16.32.0/20.', { exact: false })).toBeVisible();
  await expect(page.locator('link[hreflang]')).toHaveCount(0);
  await page.getByRole('link', { name: 'Practise Network+ questions →', exact: true }).click();
  await expect(page.locator('.question-prompt')).toBeVisible();
  await context.close();
});

test('article discovery leads to an answered Network+ question', async ({ page }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  await page.goto('/en/comptia-n10-009');
  await page.getByRole('link', { name: subnetPost.title, exact: true }).click();
  for (const width of [390, 1280]) {
    await page.setViewportSize({ width, height: 900 });
    await page.screenshot({ path: `../docs/seo/previews/subnetting-${width}.png`, fullPage: true });
  }
  await page.getByRole('link', { name: 'Practise Network+ questions →', exact: true }).click();
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: 'Check answer', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
  expect(errors).toEqual([]);
});
