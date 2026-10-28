import { expect, test } from '@playwright/test';

test('country entry chooses English outside Korea while explicit practice and Korean visits remain accessible', async ({ browser }) => {
  for (const [country, expectedPath, expectedLanguage] of [['US', '/en', 'en'], ['CA', '/en', 'en'], ['KR', '/', 'ko']] as const) {
    const context = await browser.newContext({ baseURL: 'http://127.0.0.1:3100', extraHTTPHeaders: { 'x-vercel-ip-country': country }, locale: country === 'KR' ? 'en-US' : 'ko-KR' });
    const page = await context.newPage();
    await page.goto('/');
    await expect(page).toHaveURL('http://127.0.0.1:3100' + expectedPath);
    await expect(page.locator('html')).toHaveAttribute('lang', expectedLanguage);
    await page.goto('/sqlp-developer?verNbr=202610');
    await expect(page).toHaveURL('http://127.0.0.1:3100/sqlp-developer?verNbr=202610');
    await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
    await page.goto('/en');
    await expect(page.locator('html')).toHaveAttribute('lang', 'en');
    await context.close();
  }
});

test('language links remember manual choices across visits without a redirect loop', async ({ browser }) => {
  const context = await browser.newContext({ baseURL: 'http://127.0.0.1:3100', extraHTTPHeaders: { 'x-vercel-ip-country': 'US' } });
  const page = await context.newPage();
  await page.goto('/');
  await expect(page.locator('html')).toHaveAttribute('lang', 'en');
  await page.getByRole('link', { name: '한국어', exact: true }).click();
  await expect(page).toHaveURL('http://127.0.0.1:3100/');
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  expect((await context.cookies()).find(cookie => cookie.name === 'quizeey_locale')).toMatchObject({ value: 'ko', httpOnly: true, sameSite: 'Lax', path: '/' });
  await page.goto('/');
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await page.getByRole('link', { name: 'English', exact: true }).click();
  await expect(page).toHaveURL('http://127.0.0.1:3100/en');
  await page.goto('/');
  await expect(page).toHaveURL('http://127.0.0.1:3100/en');
  expect((await context.cookies()).find(cookie => cookie.name === 'quizeey_locale')?.value).toBe('en');
  await context.close();
});

test('search crawlers can read the Korean root from a non-Korean country', async ({ request }) => {
  const response = await request.get('/', { maxRedirects: 0, headers: { 'x-vercel-ip-country': 'US', 'user-agent': 'Googlebot/2.1' } });
  expect(response.status()).toBe(200);
  expect(response.headers().location).toBeUndefined();
  expect(await response.text()).toContain('<html lang="ko"');
});
