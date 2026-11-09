import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { blogPost, blogPostPath, subnetPost, cloudPost, printingPost, roadSignsPost } from '../src/lib/blog';

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
  for (const path of ['/blog', blogPostPath, printingPost.path, '/en/blog', subnetPost.path, cloudPost.path, roadSignsPost.path]) {
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
  expect((await request.get('/en/blog/' + printingPost.slug)).status()).toBe(404);
  expect((await request.get('/blog/' + roadSignsPost.slug)).status()).toBe(404);
});

test('Ontario signs article is readable without JS and leads to a submitted G1 answer', async ({ page, browser, request }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  const response = await request.get(roadSignsPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('shape → colour');
  expect(html).toContain('BlogPosting');
  expect(html).toContain('2026-11-08');
  await page.goto(roadSignsPost.practicePath);
  await page.getByRole('link', { name: roadSignsPost.title, exact: true }).click();
  await expect(page).toHaveTitle(`${roadSignsPost.title} | Quizeey`);
  await expect(page.locator('h1')).toHaveText(roadSignsPost.title);
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', roadSignsPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.locator('link[rel="canonical"], link[hreflang]')).toHaveCount(0);
  for (const width of [390, 1280]) {
    await page.setViewportSize({ width, height: 900 });
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.screenshot({ path: `../docs/seo/previews/ontario-signs-${width}.png`, fullPage: true });
  }
  await page.getByRole('link', { name: 'Practise Ontario G1 questions →', exact: true }).click();
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: 'Check answer', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
  expect(errors).toEqual([]);
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const staticPage = await context.newPage();
  await staticPage.goto('/en/blog');
  await staticPage.getByRole('link', { name: roadSignsPost.title, exact: true }).click();
  await staticPage.getByText('Show sign answer 2', { exact: true }).click();
  await expect(staticPage.getByText('Stop and give way.', { exact: true })).toBeVisible();
  await staticPage.getByRole('link', { name: 'Practise Ontario G1 questions →', exact: true }).click();
  await expect(staticPage.locator('.question-prompt')).toBeVisible();
  await context.close();
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

test('cloud article leads from the guide to an answered Azure question', async ({ page, browser, request }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  const html = await (await request.get(cloudPost.path)).text();
  expect(html).toContain('The migrated booking server');
  expect(html).toContain('BlogPosting');
  expect(html).toContain('2026-11-04');
  await page.goto('/en/study-guides/aws-azure-certification-practice');
  await page.getByRole('link', { name: cloudPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(cloudPost.title);
  await expect(page.locator('link[hreflang]')).toHaveCount(0);
  for (const width of [390, 1280]) {
    await page.setViewportSize({ width, height: 900 });
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.screenshot({ path: `../docs/seo/previews/cloud-responsibility-${width}.png`, fullPage: true });
  }
  await page.getByRole('link', { name: 'Practise AZ-900 questions →', exact: true }).click();
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: 'Check answer', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
  await expect(page.getByRole('link', { name: cloudPost.title, exact: true })).toHaveAttribute('href', cloudPost.path);
  expect(errors).toEqual([]);
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const staticPage = await context.newPage();
  await staticPage.goto('/en/blog');
  await staticPage.getByRole('link', { name: cloudPost.title, exact: true }).click();
  await staticPage.getByText('Show cloud answer 1', { exact: true }).click();
  await expect(staticPage.getByText('The company.', { exact: true })).toBeVisible();
  await staticPage.getByRole('link', { name: 'Practise AZ-900 questions →', exact: true }).click();
  await expect(staticPage.locator('.question-prompt')).toBeVisible();
  await context.close();
  expect((await request.get('/blog/' + cloudPost.slug)).status()).toBe(404);
});

test('3D printer article leads from the exam page to answered Korean practice', async ({ page, browser, request }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  const response = await request.get(printingPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('24 ÷ 0.20');
  expect(html).toContain('BlogPosting');
  expect(html).toContain('2026-11-05');
  await page.goto(printingPost.practicePath);
  await page.getByRole('link', { name: printingPost.title, exact: true }).click();
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page).toHaveTitle(`${printingPost.title} | Quizeey`);
  await expect(page.locator('h1')).toHaveText(printingPost.title);
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', printingPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.locator('link[rel="canonical"]')).toHaveCount(0);
  await expect(page.locator('link[hreflang]')).toHaveCount(0);
  expect(await page.locator('script[type="application/ld+json"]').textContent()).toContain(printingPost.title);
  await expect(page.getByRole('link', { name: 'SQLD CBT 공부법과 COUNT 예제', exact: true })).toHaveAttribute('href', blogPost.path);
  for (const width of [390, 1280]) {
    await page.setViewportSize({ width, height: 900 });
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.screenshot({ path: `../docs/seo/previews/3d-printer-${width}.png`, fullPage: true });
  }
  await page.getByText('1번 정답과 해설', { exact: true }).click();
  await expect(page.getByText('120층.', { exact: true })).toBeVisible();
  await page.getByRole('link', { name: '3D프린터운용기능사 문제 풀기 →', exact: true }).click();
  await page.locator('input[type="radio"]').first().check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toBeVisible();
  await expect(page.getByRole('link', { name: printingPost.title, exact: true })).toHaveAttribute('href', printingPost.path);
  expect(errors).toEqual([]);
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const staticPage = await context.newPage();
  await staticPage.goto('/blog');
  await staticPage.getByRole('link', { name: printingPost.title, exact: true }).click();
  await staticPage.getByText('4번 정답과 해설', { exact: true }).click();
  await expect(staticPage.getByText('재료 사용량과 출력 시간이 늘어납니다.', { exact: true })).toBeVisible();
  await staticPage.getByRole('link', { name: '3D프린터운용기능사 문제 풀기 →', exact: true }).click();
  await expect(staticPage.locator('.question-prompt')).toBeVisible();
  await context.close();
});
