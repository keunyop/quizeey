import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { authoredQuestions } from '../src/lib/authored-practice';
import { baristaMilkSteamingPost as post } from '../src/lib/blog';

const practiceLink = '바리스타 2급 11월 연습 20문항 풀기';

test('milk steaming guide is discoverable and readable without JavaScript', async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false });
  try {
    const page = await context.newPage();
    await page.goto('http://127.0.0.1:3100/blog');
    await page.getByRole('link', { name: post.title, exact: true }).click();
    await expect(page).toHaveURL(new RegExp(post.path + '$'));
    await expect(page.getByRole('heading', { name: post.title, level: 1 })).toBeVisible();
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
    await expect(page.getByRole('table').locator('tbody tr')).toHaveCount(3);
    for (const [index, answer] of [2, 1, 3].entries()) {
      const question = page.locator('details').filter({ hasText: `${index + 1}번 정답과 오답 이유` });
      await question.locator('summary').click();
      await expect(question.locator('strong')).toHaveText(`정답은 ${answer}번입니다.`);
      await expect(question.locator('strong')).toBeVisible();
    }
    await expect(page.getByRole('link', { name: practiceLink })).toHaveAttribute('href', post.practicePath);
  } finally {
    await context.close();
  }
});

test('milk steaming guide passes mobile accessibility and reaches the actual explanation', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(post.path);
  for (const summary of await page.locator('main details summary').all()) await summary.click();
  for (const theme of ['light', 'dark']) {
    await page.evaluate(value => { document.documentElement.dataset.theme = value; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
  }
  await page.getByRole('link', { name: practiceLink }).click();
  await expect(page.getByRole('heading', { level: 1 })).toContainText(/바리스타 ?2급/);
  await expect(page.getByRole('link', { name: '2026-11 연습문제 20개', exact: true })).toBeVisible();
  const question = authoredQuestions('125', 'ko', 202611)[9];
  if (!question?.explanation) throw new Error('Expected a fixture explanation for Barista question 10');
  await expect(page.locator('.question-card input').first()).toBeEnabled();
  await page.getByRole('button', { name: /^문제 10,/ }).click();
  await expect(page.locator('.question-prompt')).toContainText('기포');
  await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await expect(page.locator('.explanation-region')).toContainText(question.explanation.replace(/<[^>]*>/g, ''));
});
