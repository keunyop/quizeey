import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { authoredQuestions, authoredSetSummaries } from '../src/lib/authored-practice';
import { koreanCookingPath, unavailableCookingExams } from '../src/lib/cooking-availability';

const restoredExams = [
  { path: '/craftsman-cook-western-food', name: '양식조리기능사', id: '262' },
  { path: '/craftsman-cook-japanese-food', name: '일식조리기능사', id: '263' },
];

test('both restored cooking exams can be found, answered and saved independently', async ({ page }) => {
  for (const exam of restoredExams) {
    await page.goto('/');
    await page.getByRole('searchbox').fill(exam.name);
    const result = page.locator(`.exam-list a[href="${exam.path}"]`);
    await expect(result).toContainText(exam.name);
    await result.click();
    await expect(page).toHaveURL(new RegExp(`${exam.path}$`));
    await expect(page.getByRole('heading', { level: 1 })).toHaveText(exam.name);
    await page.getByRole('button', { name: '시험정보' }).click();
    await expect(page.locator('.exam-description')).toContainText('자체 제작 연습문제 20개');
    await page.getByRole('link', { name: '2026-11 연습문제 20개' }).click();
    const questions = authoredQuestions(exam.id, 'ko', 202611);
    expect(questions).toHaveLength(20);
    await expect(page.locator('.practice-outline a')).toHaveCount(20);
    const first = questions[0];
    await expect(page.locator(`.practice-outline a[href="${exam.path}?questId=${first.id}&verNbr=202611"]`)).toHaveCount(1);
    await expect(page.locator('#question-content')).toHaveText(first.text.replace(/^<p>|<\/p>$/g, ''));
    await page.locator(`input[value="${first.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.getByRole('button', { name: '정답 확인', exact: true }).click();
    await expect(page.locator('.answer-feedback')).toHaveClass(/\bcorrect\b/);
    await expect(page.locator('.explanation-region .reference a')).toHaveAttribute('href', /^https:\/\//);
    await page.getByRole('button', { name: '북마크', exact: true }).click();
  }
  const keys = await page.evaluate(() => Object.keys(localStorage).filter(key => key.startsWith('quizeey:progress:')));
  expect(keys.map(key => key.split(':')[4]).sort()).toEqual(['262', '263']);
});

test('restored cooking paths and read APIs reject old Korean and cross-exam question IDs', async ({ request }) => {
  const korean = authoredQuestions('14', 'ko', 202611)[0];
  for (const [index, exam] of restoredExams.entries()) {
    const other = authoredQuestions(restoredExams[1 - index].id, 'ko', 202611)[0];
    const own = authoredQuestions(exam.id, 'ko', 202611)[0];
    const direct = await request.get(`${exam.path}?questId=${own.id}&verNbr=202611`);
    expect(direct.status()).toBe(200);
    expect(await direct.text()).toContain(`name="answer-${own.id}"`);
    expect((await request.get(`${exam.path}?testId=14`)).status()).toBe(404);
    for (const questId of [korean.id, other.id]) {
      expect((await request.get(`${exam.path}?questId=${questId}&verNbr=202611`)).status()).toBe(404);
      expect((await request.post('/question', { data: { testId: exam.id, questId, verNbr: 202611 } })).status()).toBe(404);
    }
    const question = await request.post('/question', { data: { testId: exam.id, questId: own.id, verNbr: 202611 } });
    expect(question.status()).toBe(200);
    expect(await question.json()).toMatchObject({ testId: Number(exam.id), questId: Number(own.id), verNbr: 202611 });
  }
});

for (const [path, name] of Object.entries(unavailableCookingExams)) {
  test(`${name} base, monthly pages and old direct links show an accurate notice`, async ({ request }) => {
    const question = authoredQuestions('14', 'ko', 202611)[0];
    const suffixes = ['', `?questId=${question.id}&verNbr=202611`, '?testId=14&count=40'];
    for (const set of authoredSetSummaries('14', 'ko')) {
      for (let page = 1; page <= Math.ceil(set.count / 20); page++) {
        suffixes.push(`?verNbr=${set.version}${page > 1 ? `&page=${page}` : ''}`);
      }
    }
    for (const suffix of suffixes) {
      const response = await request.get(path + suffix);
      expect(response.status()).toBe(200);
      const html = await response.text();
      expect(html).toContain(`${name} 문제 제공 안내`);
      expect(html).toContain('현재 제공하지 않습니다');
      expect(html).toContain(`href="${koreanCookingPath}"`);
      expect(html).toMatch(/<meta name="robots" content="[^"]*noindex/);
      expect(html).not.toContain('class="question-card"');
      expect(html).not.toContain('id="version"');
      expect(html).not.toContain('LearningResource');
    }
    expect((await request.get(path + '/practice/202611')).status()).toBe(404);
    const direct = await request.get(`${path}?testId=14&questId=${question.id}&verNbr=202611&count=40`);
    expect(await direct.text()).toContain(`href="${koreanCookingPath}?questId=${question.id}&amp;verNbr=202611&amp;count=40"`);
  });
}

test('unavailable cooking exams are absent from home discovery and search', async ({ page }) => {
  await page.goto('/');
  for (const path of Object.keys(unavailableCookingExams)) {
    await expect(page.locator(`a[href^="${path}"]`)).toHaveCount(0);
  }
  for (const name of Object.values(unavailableCookingExams)) {
    await page.getByRole('searchbox').fill(name);
    await expect(page.locator('.exam-list a')).toHaveCount(0);
  }
  await page.getByRole('searchbox').fill('한식조리기능사');
  await expect(page.locator(`.exam-list a[href="${koreanCookingPath}"]`)).toBeVisible();
});

test('cooking notices preserve saved Korean answers, bookmarks, score and session', async ({ page, context }) => {
  await page.goto(`${koreanCookingPath}?verNbr=202611`);
  const question = await page.locator('#question-content').innerText();
  await page.locator('.question-card input').first().check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await page.getByRole('button', { name: '북마크', exact: true }).click();
  const feedback = await page.locator('.answer-feedback').innerText();
  const score = await page.locator('.map-accuracy').innerText();
  const saved = await page.evaluate(() => Object.fromEntries(Object.entries(localStorage).filter(([key]) => key.startsWith('quizeey:progress:'))));
  expect(Object.keys(saved)).toHaveLength(1);
  expect(Object.keys(saved)[0]).toContain(':ko:14:');
  const cookies = (await context.cookies()).filter(cookie => /^quizeey_(session|last_set)_ko_14/.test(cookie.name)).map(({ name, value }) => ({ name, value }));
  expect(cookies).toHaveLength(2);
  for (const path of Object.keys(unavailableCookingExams)) {
    await page.goto(`${path}?verNbr=202611&page=2`);
    await expect(page.locator('.question-card')).toHaveCount(0);
    expect(await page.evaluate(() => Object.fromEntries(Object.entries(localStorage).filter(([key]) => key.startsWith('quizeey:progress:'))))).toEqual(saved);
    expect((await context.cookies()).filter(cookie => /^quizeey_(session|last_set)_ko_14/.test(cookie.name)).map(({ name, value }) => ({ name, value }))).toEqual(cookies);
  }
  await page.getByRole('link', { name: '한식조리기능사 문제풀기로 이동' }).click();
  await page.getByRole('button', { name: '이어서 풀기', exact: true }).click();
  await expect(page.locator('#version')).toHaveValue('202611');
  await expect(page.locator('#question-content')).toHaveText(question);
  await expect(page.locator('.answer-feedback')).toHaveText(feedback);
  await expect(page.locator('.map-accuracy')).toHaveText(score);
  await expect(page.getByRole('button', { name: '북마크 해제', exact: true })).toHaveAttribute('aria-pressed', 'true');
});

for (const theme of ['light', 'dark']) {
  test(`cooking notice is accessible on mobile in ${theme} theme`, async ({ page }) => {
    await page.setViewportSize({ width: 390, height: 844 });
    await page.addInitScript(value => localStorage.setItem('quizeey:theme', value), theme);
    await page.goto('/craftsman-cook-chinese-food');
    await expect(page.getByRole('heading', { level: 1 })).toHaveText('중식조리기능사 문제 제공 안내');
    await expect(page.locator('html')).toHaveAttribute('data-theme', theme);
    expect((await new AxeBuilder({ page }).analyze()).violations).toEqual([]);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    await page.getByRole('link', { name: '한식조리기능사 문제풀기로 이동' }).focus();
    await expect(page.locator(':focus')).toHaveAttribute('href', koreanCookingPath);
  });
}
