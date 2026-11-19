import { expect, test } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { ccnaTroubleshootingPost } from '../src/lib/blog';
import { authoredQuestions } from '../src/lib/authored-practice';

const firstQuestion = authoredQuestions('204', 'ko', 202611)[0];
const summary = 'B의 마스크만 /26으로 바꾸면 해결될까요?';
const cta = 'CCNA IPv4 한국어 5문제 풀기 →';

test('CCNA mask troubleshooting is discoverable with metadata and native explanations without JavaScript', async ({ browser, request }) => {
  const response = await request.get(ccnaTroubleshootingPost.path);
  expect(response.status()).toBe(200);
  const html = await response.text();
  expect(html).toContain('BlogPosting');
  expect(html).toContain('"datePublished":"2026-11-19"');
  expect(html).toContain('"dateModified":"2026-11-19"');
  expect(html).toContain('"inLanguage":"ko-KR"');
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: 'http://127.0.0.1:3100' });
  const page = await context.newPage();
  await page.goto('/blog');
  await page.getByRole('link', { name: ccnaTroubleshootingPost.title, exact: true }).click();
  await expect(page.locator('h1')).toHaveText(ccnaTroubleshootingPost.title);
  await expect(page.locator('html')).toHaveAttribute('lang', 'ko');
  await expect(page.locator('meta[name="description"]')).toHaveAttribute('content', ccnaTroubleshootingPost.description);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /noindex/);
  await expect(page.getByRole('table', { name: '각 장비가 자기 마스크로 계산한 결과' })).toBeVisible();
  await expect(page.getByRole('rowheader')).toHaveText(['A: 198.51.100.70/26', 'B: 198.51.100.130/24']);
  await expect(page.locator('#mask-ping')).toHaveText('이 결과만으로 ping 성공을 알 수 없는 이유');
  await page.getByText(summary, { exact: true }).click();
  await expect(page.getByText('두 마스크를 같게 만드는 것만으로 같은 서브넷이 되지는 않습니다.', { exact: true })).toBeVisible();
  await expect(page.getByRole('link', { name: cta, exact: true })).toHaveAttribute('href', ccnaTroubleshootingPost.practicePath);
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page).toHaveURL(/ccna-200-301\?verNbr=202611/);
  await expect(page.locator('h1')).toHaveText('Cisco 공인 네트워크 어소시에이트(CCNA 200-301)');
  await expect(page.locator('.question-prompt')).toHaveText(firstQuestion.text.replace(/<[^>]*>/g, ''));
  await expect(page.locator('#question-content')).toHaveAttribute('lang', 'ko');
  await context.close();
});

test('CCNA mask article has no mobile overflow or accessibility violations in either theme and reaches feedback', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(ccnaTroubleshootingPost.path);
  await page.getByText(summary, { exact: true }).click();
  for (const theme of ['light', 'dark']) {
    await page.evaluate(theme => { document.documentElement.dataset.theme = theme; }, theme);
    expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
    expect((await new AxeBuilder({ page }).withTags(['wcag2a', 'wcag2aa', 'wcag21aa']).analyze()).violations).toEqual([]);
  }
  await page.getByRole('link', { name: cta, exact: true }).click();
  await expect(page.locator('.question-prompt')).toHaveText(firstQuestion.text.replace(/<[^>]*>/g, ''));
  await page.locator(`input[value="${firstQuestion.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(page.locator('.answer-feedback')).toHaveText('정답입니다.');
});
