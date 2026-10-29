import { expect, test } from '@playwright/test';
import { legacy } from '../src/lib/contracts';
import { publicSitemap } from '../src/lib/seo';
import { sitemapXmlEntries } from '../src/lib/sitemap-xml';
import { resolveSitemap } from 'next/dist/build/webpack/loaders/metadata/resolve-route-data.js';

test('legacy page aliases redirect to working localized pages and retain invalid-context errors', async ({ request }) => {
  for (const [source, target] of [
    ['/kr', '/'], ['/app', '/'],
    ['/kr/sqlp-developer?verNbr=202610&page=2&utm_source=gsc', '/sqlp-developer?verNbr=202610&page=2&utm_source=gsc'],
    ['/test?testId=5&questId=900000002&verNbr=1', '/sqlp-developer?questId=900000002&verNbr=1'],
    ['/en/test?testId=1', '/en/aws-certified-developer-associate'],
  ]) {
    const response = await request.get(source, {maxRedirects:0});
    expect(response.status(), source).toBe(308);
    const location = new URL(response.headers().location, response.url());
    expect(location.pathname + location.search).toBe(target);
    const destination = await request.get(target, {maxRedirects:0});
    expect(destination.status(), target).toBe(200);
    expect(destination.headers()['x-robots-tag']).toContain('noindex');
  }
  for (const path of ['/kr/sqlp-developer?testId=1', '/en/test?testId=5', '/test?testId=999999', '/kr/missing-exam']) {
    const response = await request.get(path, {maxRedirects:0});
    expect(response.status(), path).toBe(404);
  }
  expect((await request.get('/test?testId=5&testId=1', {maxRedirects:0})).status()).toBe(400);
});

test('production sitemap XML parses and preserves query parameters and language alternates', async ({ page }) => {
  // Generate production XML from public fixture content; no hosted request or production environment.
  const entries = publicSitemap('https://quizeey.com');
  const xml = resolveSitemap(sitemapXmlEntries(entries));
  const parsed = await page.evaluate(xml => {
    const document = new DOMParser().parseFromString(xml, 'application/xml');
    return {
      error: document.querySelector('parsererror')?.textContent ?? null,
      locations: [...document.getElementsByTagNameNS('http://www.sitemaps.org/schemas/sitemap/0.9', 'loc')].map(node => node.textContent),
      alternates: [...document.getElementsByTagNameNS('http://www.w3.org/1999/xhtml', 'link')].map(node => node.getAttribute('href')),
    };
  }, xml);
  expect(parsed.error).toBeNull();
  expect(parsed.locations).toEqual(entries.map(entry => entry.url));
  expect(parsed.alternates).toEqual(entries.flatMap(entry => Object.values(entry.alternates?.languages ?? {})));
});

test('all exam links and localized introductions are available without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  for (const [path, locale] of [['/', 'ko'], ['/en', 'en']] as const) {
    await page.goto(path);
    await expect(page.locator('html')).toHaveAttribute('lang', locale);
    await expect(page.locator('.catalog-description')).toContainText(locale === 'ko' ? 'CBT 시험' : 'Canadian citizenship');
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
