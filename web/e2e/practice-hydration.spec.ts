import { expect, test } from '@playwright/test';
import { authoredQuestions } from '../src/lib/authored-practice';

for (const [path, id, locale] of [
  ['/craftsman-cook-korean-food?verNbr=202611', '14', 'ko'],
  ['/en/aws-ai-practitioner-aif-c01?verNbr=202611', '261', 'en'],
] as const) {
  test(`${locale} answer controls wait for delayed JavaScript and preserve the first graded answer`, async ({ page }) => {
    let releaseScripts!: () => void;
    const scripts = new Promise<void>(resolve => { releaseScripts = resolve; });
    let blocked = 0;
    await page.route(/\/_next\/static\/.*\.js(?:\?|$)/, async route => {
      blocked++;
      await scripts;
      await route.continue();
    });
    try {
      await page.goto(path, { waitUntil: 'commit' });
      await expect(page.locator('.question-prompt')).toBeVisible();
      await expect.poll(() => blocked).toBeGreaterThan(0);
      await expect(page.locator('.question-card fieldset input').first()).toBeDisabled();
      await expect(page.locator('.practice-primary')).toBeDisabled();
      // Once the client owns the controls, the first user selection must reach React state.
      releaseScripts();
      await expect(page.locator('.question-card fieldset input').first()).toBeEnabled();
      const first = authoredQuestions(id, locale, 202611)[0];
      const correct = page.locator(`input[value="${first.choices.find(choice => choice.correct)!.id}"]`);
      await correct.check();
      await expect(correct).toBeChecked();
      await expect(page.locator('.practice-primary')).toBeEnabled();
      await page.locator('.practice-primary').click();
      await expect(page.locator('.answer-feedback')).toHaveText(locale === 'en' ? 'Correct.' : '정답입니다.');
      await page.reload();
      await page.getByRole('button', { name: locale === 'en' ? 'Continue' : '이어서 풀기', exact: true }).click();
      await expect(correct).toBeChecked();
      await expect(page.locator('.answer-feedback')).toHaveText(locale === 'en' ? 'Correct.' : '정답입니다.');
    } finally {
      releaseScripts();
    }
  });
}
