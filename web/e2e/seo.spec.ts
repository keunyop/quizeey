import { expect, test } from '@playwright/test';
import { legacy } from '../src/lib/contracts';

test('all exam links and localized introductions are available without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  for (const [path, locale] of [['/', 'ko'], ['/en', 'en']] as const) {
    await page.goto(path);
    await expect(page.locator('html')).toHaveAttribute('lang', locale);
    await expect(page.locator('.catalog-description')).toContainText(locale === 'ko' ? '한국 자격증' : 'United States and Canada');
    const expected = legacy.routes.filter(r => r.testId && r.locale === locale && !r.path.startsWith('/kr/')).map(r => r.path);
    expect(await page.locator('.exam-directory a').evaluateAll(links => links.map(a => a.getAttribute('href')))).toEqual(expected);
    await page.locator('.exam-directory summary').click();
    await expect(page.locator('.exam-directory a').last()).toBeVisible();
  }
  await context.close();
});

test('localized metadata and structured data reach the browser while fixture pages remain noindex', async ({ page }) => {
  for (const [path, locale] of [['/sqlp-developer', 'ko'], ['/en/aws-certified-developer-associate', 'en']] as const) {
    await page.goto(path);
    await expect(page.locator('html')).toHaveAttribute('lang', locale);
    await expect(page.locator('meta[property="og:locale"]')).toHaveAttribute('content', locale === 'ko' ? 'ko_KR' : 'en_US');
    if (locale === 'en') await expect(page.locator('meta[property="og:locale:alternate"]')).toHaveAttribute('content', 'en_CA');
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
    await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', locale === 'ko' ? /한국어 CBT/ : /free English practice questions/);
    await expect(page.locator('meta[name="twitter:card"]')).toHaveAttribute('content', 'summary');
    const data = JSON.parse(await page.locator('script[type="application/ld+json"]').innerText());
    expect(data['@graph'][1]).toMatchObject({ '@type': 'WebPage', url: 'https://quizeey.com' + path });
    expect(data['@graph'][2].itemListElement[0].item).toBe('https://quizeey.com' + (locale === 'ko' ? '/' : '/en'));
  }
});
