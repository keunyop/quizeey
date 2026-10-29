import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { fixtureVersion, questions as fixtureQuestions } from '../src/lib/fixtures';
import { authoredQuestions } from '../src/lib/authored-practice';
import { emptyProgress } from '../src/lib/progress';

test('the previous sequential All session is offered before switching to random practice', async ({ page, context }) => {
  const archived = fixtureQuestions.filter(question => question.testId === '5');
  const ids = [...archived, ...authoredQuestions('5', 'ko')].slice(0, 20).map(question => question.id);
  const saved = { ...emptyProgress(ids, fixtureVersion), attempts: { [ids[0]]: { selected: ['910000002'], correct: true } } };
  const key = `quizeey:progress:v1:ko:5:${fixtureVersion}:${archived.map(question => question.version).join(',')}:all`;
  await page.goto('/about');
  await page.evaluate(({ key, saved }) => localStorage.setItem(key, JSON.stringify(saved)), { key, saved });
  await page.goto('/sqlp-developer');
  await expect(page.getByRole('dialog', { name: '이어서 풀까요?' })).toBeVisible();
  await page.getByRole('button', { name: '이어서 풀기', exact: true }).click();
  await expect(page.locator('input[value="910000002"]')).toBeChecked();
  await page.reload();
  await page.getByRole('button', { name: '새로 시작', exact: true }).click();
  await expect(page.getByRole('progressbar')).toHaveAttribute('value', '0');
  expect((await context.cookies()).find(cookie => cookie.name === 'quizeey_session_ko_5_0')?.value).not.toContain('legacy');
});

test('changing set or question count applies immediately; the map opens with live accuracy', async ({ page }) => {
  await page.goto('/sqlp-developer');
  await expect(page.getByRole('button', { name: '적용', exact: true })).toHaveCount(0);
  await expect(page.locator('.question-map')).toHaveAttribute('open');
  await expect(page.locator('.map-accuracy')).toContainText('—');
  await page.getByLabel('풀 문제 수', { exact: true }).selectOption('5');
  await expect(page.locator('.question-grid button')).toHaveCount(5);
  await expect(page.getByRole('dialog')).toHaveCount(0);
  await page.getByLabel('시험 회차', { exact: true }).selectOption('2');
  await expect(page.locator('.question-version')).toHaveText('회차 · SQL 조건');
  await expect(page.locator('.question-grid button')).toHaveCount(1);
  await page.keyboard.press('1');
  await page.keyboard.press('Enter');
  await expect(page.locator('.answer-feedback')).toBeVisible();
  await expect(page.locator('.map-accuracy')).toContainText(/0%|100%/);
  await expect(page.locator('.map-review,.practice-pages,.practice-set-summary')).toHaveCount(0);
});

test('all sets includes every source; resume keeps order and start fresh clears answers', async ({ page, context }) => {
  const errors: string[] = []; page.on('pageerror', error => errors.push(error.message));
  await page.goto('/sqlp-developer?count=100');
  const seen = new Set<string>();
  const count = await page.locator('.question-grid button').count();
  expect(count).toBeGreaterThan(20);
  for (let index = 0; index < count; index++) {
    await page.locator('.question-grid button').nth(index).click();
    seen.add(await page.locator('.question-version').innerText());
  }
  expect([...seen]).toEqual(expect.arrayContaining(['회차 · SQL 기본', '회차 · SQL 조건', '회차 · 2026-10 기출문제']));
  await page.locator('.question-grid button').nth(3).click();
  const question = await page.locator('.question-prompt').innerText();
  await page.locator('#question-content').focus();
  await page.keyboard.press('1'); await page.keyboard.press('Enter');
  const selected = await page.locator('.choice input:checked').getAttribute('value');
  await page.goto('/'); await page.goto('/sqlp-developer');
  const dialog = page.getByRole('dialog', { name: '이어서 풀까요?' });
  await expect(dialog).toBeVisible();
  expect((await new AxeBuilder({ page }).analyze()).violations).toEqual([]);
  await page.keyboard.press('2'); await page.keyboard.press('Enter');
  // Enter on the focused Continue button resumes; it must not grade or advance.
  await expect(dialog).toHaveCount(0);
  await expect(page.locator('.question-prompt')).toHaveText(question);
  await expect(page.locator(`input[value="${selected}"]`)).toBeChecked();
  const before = (await context.cookies()).find(cookie => cookie.name === 'quizeey_session_ko_5_0')!.value;
  await page.reload();
  await page.getByRole('button', { name: '새로 시작', exact: true }).click();
  await expect(page.getByRole('progressbar')).toHaveAttribute('value', '0');
  await expect(page.locator('.answer-feedback')).toHaveCount(0);
  await expect(page.locator('.choice input:checked')).toHaveCount(0);
  const after = (await context.cookies()).find(cookie => cookie.name === 'quizeey_session_ko_5_0')!.value;
  expect(after).not.toBe(before);
  expect(errors).toEqual([]);
});

test('number keys handle single and multiple answers; Enter checks once and advances once', async ({ page }) => {
  await page.goto('/sqlp-developer?verNbr=1');
  await page.keyboard.press('Enter');
  await expect(page.locator('.answer-feedback')).toHaveCount(0);
  await page.keyboard.press('1');
  await expect(page.locator('.choice input').nth(0)).toBeChecked();
  await page.keyboard.press('2');
  await expect(page.locator('.choice input').nth(1)).toBeChecked();
  await expect(page.locator('.choice input:checked')).toHaveCount(1);
  await page.keyboard.press('Enter');
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await page.keyboard.press('Enter');
  await expect(page.locator('.question-counter')).toContainText('2 / 2');
  await page.keyboard.press('1'); await page.keyboard.press('2');
  await expect(page.locator('.choice input:checked')).toHaveCount(2);
  await page.keyboard.press('2');
  await expect(page.locator('.choice input:checked')).toHaveCount(1);
  await page.keyboard.press('2'); await page.keyboard.press('Enter');
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await page.keyboard.press('Enter');
  await expect(page.getByRole('heading', { name: '학습 완료' })).toBeVisible();
});

test('shortcuts never consume report text or submit its dialog', async ({ page }) => {
  await page.goto('/sqlp-developer?verNbr=1');
  await page.getByRole('button', { name: '오답 신고', exact: true }).click();
  await page.getByLabel('추가 설명 (선택)', { exact: true }).fill('1234');
  await page.keyboard.press('Enter');
  await expect(page.getByRole('dialog')).toBeVisible();
  await page.getByRole('button', { name: '닫기', exact: true }).click();
  await expect(page.locator('.choice input:checked')).toHaveCount(0);
  await expect(page.locator('.answer-feedback')).toHaveCount(0);
});

test('returning from the home page restores the selected set; invalid preferences recover', async ({ page, context }) => {
  await page.goto('/sqlp-developer?verNbr=2');
  await page.keyboard.press('1'); await page.keyboard.press('Enter');
  await page.goto('/');
  await page.goto('/sqlp-developer');
  await page.getByRole('button', { name: '이어서 풀기', exact: true }).click();
  await expect(page.getByLabel('시험 회차', { exact: true })).toHaveValue('2');
  await expect(page.locator('.answer-feedback')).toBeVisible();
  await context.addCookies([{ name: 'quizeey_last_set_ko_5', value: '999999', url: 'http://127.0.0.1:3100' }]);
  await page.goto('/sqlp-developer');
  await expect(page.getByLabel('시험 회차', { exact: true })).toHaveValue('0');
  await expect(page.locator('.question-card')).toBeVisible();
});
