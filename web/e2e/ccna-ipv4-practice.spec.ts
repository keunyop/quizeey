import { expect, test } from '@playwright/test';
import { authoredQuestions } from '../src/lib/authored-practice';

const path = '/ccna-200-301';
const november = authoredQuestions('204', 'ko', 202611);

test('Korean CCNA IPv4 practice grades all five rotated questions and restores each set independently', async ({ page }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  const october = authoredQuestions('204', 'ko', 202610)[0];
  await page.goto(`${path}?verNbr=202610`);
  await expect(page.locator('#question-content')).toHaveAttribute('lang', 'en');
  await page.locator(`input[value="${october.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');

  await page.goto(`${path}?verNbr=202611`);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page).toHaveTitle(/2026-11/);
  await expect(page.locator('#version')).toHaveValue('202611');
  await expect(page.locator('.question-grid button')).toHaveCount(5);
  await expect(page.locator('.question-version')).toContainText('2026-11');
  await expect(page.locator('.answer-feedback')).toHaveCount(0);
  for (const [index, question] of november.entries()) {
    await page.locator('.question-grid button').nth(index).click();
    await expect(page.locator('#question-content')).toHaveAttribute('lang', 'ko');
    await expect(page.locator('.question-prompt')).toHaveText(question.text.replace(/<[^>]*>/g, ''));
    await expect(page.locator('.choice input')).toHaveCount(4);
    expect(await page.locator('.choice input').evaluateAll(inputs => inputs.map(input => (input as HTMLInputElement).value)))
      .toEqual(question.choices.map(choice => choice.id));
    await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.getByRole('button', { name: '정답 확인', exact: true }).click();
    await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
    await expect(page.locator('.explanation-region .learning-content').first()).toHaveText(question.explanation!.replace(/<[^>]*>/g, ''));
  }
  await expect(page.locator('.map-accuracy')).toContainText('100%');
  await page.reload();
  await page.getByRole('button', { name: '이어서 풀기', exact: true }).click();
  await expect(page.locator('.question-grid .map-correct')).toHaveCount(5);
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await expect(page.locator('.choice input:checked')).toHaveValue(november[4].choices.find(choice => choice.correct)!.id);
  await page.goto(`${path}?verNbr=202610`);
  await page.getByRole('button', { name: '이어서 풀기', exact: true }).click();
  await expect(page.locator('#question-content')).toHaveAttribute('lang', 'en');
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
  await expect(page.locator('.choice input:checked')).toHaveValue(october.choices.find(choice => choice.correct)!.id);
  expect(errors).toEqual([]);
});

test('November direct links and the local compatibility API resolve all five CCNA identities', async ({ page, request }) => {
  const versions = await request.post('/versions', { data: { testId: '204' } });
  expect(versions.status()).toBe(200);
  expect(await versions.json()).toEqual(expect.arrayContaining([{ verId: 8_400_000_204, verNm: '2026-11', verNbr: 202611 }]));
  for (const question of november) {
    const response = await request.post('/question', { data: { testId: '204', questId: question.id, verNbr: 202611 } });
    expect(response.status()).toBe(200);
    expect(await response.json()).toMatchObject({ questId: Number(question.id), testId: 204, verNbr: 202611, questTxt: question.text, explanation: question.explanation });
    await page.goto(`${path}?questId=${question.id}&verNbr=202611`);
    await expect(page.locator('.question-prompt')).toHaveText(question.text.replace(/<[^>]*>/g, ''));
    await expect(page.locator('#question-content')).toHaveAttribute('lang', 'ko');
    await expect(page.locator('.question-grid button')).toHaveCount(1);
  }
});
