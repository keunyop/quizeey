import { expect, test } from '@playwright/test';
import { authoredSetSummary } from '../src/lib/authored-practice';
import { findRoute } from '../src/lib/contracts';
import { studyGuidePath, studyGuides } from '../src/lib/study-guides';

test('English home, guides and practice sets form a usable path without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/en');
  for (const guide of studyGuides) {
    const link = page.locator('.study-guide-discovery').getByRole('link', { name: guide.title, exact: true });
    await expect(link).toHaveAttribute('href', studyGuidePath(guide.slug));
  }
  await page.getByRole('link', { name: 'All English study guides', exact: true }).click();
  await expect(page.getByRole('heading', { level: 1 })).toHaveText('Free Exam Practice and Study Guides in English');
  for (const guide of studyGuides) {
    await page.goto(studyGuidePath(guide.slug));
    await expect(page.locator('html')).toHaveAttribute('lang', 'en');
    await expect(page.getByRole('heading', { level: 1 })).toHaveText(guide.title);
    await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', guide.description);
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
    await expect(page.getByRole('heading', { name: 'Official learning resources', exact: true })).toBeVisible();
    for (const resource of guide.resources) await expect(page.getByRole('link', { name: resource.title, exact: true })).toHaveAttribute('href', resource.url);
    const item = guide.exams[0];
    const exam = findRoute(item.path)!;
    const set = authoredSetSummary(exam.testId!, 'en')!;
    const practiceLink = page.locator('.guide-practice-links li').first().getByRole('link', { name: `${set.count} questions with answers and explanations`, exact: true });
    await expect(practiceLink).toHaveAttribute('href', `${item.path}?verNbr=${set.version}`);
    await practiceLink.click();
    await expect(page.locator('.question-prompt')).toBeVisible();
    await expect(page.locator('.related-study-guide a')).toHaveAttribute('href', studyGuidePath(guide.slug));
  }
  await context.close();
});

test('unknown study guide returns 404', async ({ request }) => {
  expect((await request.get('/en/study-guides/not-a-guide')).status()).toBe(404);
});
