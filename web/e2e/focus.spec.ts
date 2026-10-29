import { expect, test } from "@playwright/test";

test("mobile practice prioritizes the question and one main action without losing the selected answer", async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto("/sqlp-developer?verNbr=1");
  await page.evaluate(() => document.fonts.ready);
  const question = page.locator(".question-card");
  expect((await question.boundingBox())!.y).toBeLessThan(260);
  await expect(page.locator(".question-map")).toHaveAttribute("open");
  await expect(page.getByRole("button", { name: "시험정보", exact: true })).toHaveAttribute("aria-expanded", "false");
  await expect(page.locator(".exam-info-description")).toBeHidden();
  await expect(page.getByLabel("시험 회차", { exact: true })).toBeVisible();
  expect((await page.locator(".version-form").boundingBox())!.y).toBeLessThan((await question.boundingBox())!.y);
  await expect(page.locator(".question-version")).toHaveText("회차 · SQL 기본");
  await expect(page.getByRole("link", { name: "문제 링크", exact: true })).toBeVisible();
  await expect(page.locator('.question-link')).toHaveAttribute('data-google-vignette', 'false');
  expect(await page.locator(".question-prompt").evaluate((node) => getComputedStyle(node).fontSize)).toBe("16px");
  expect(await page.locator(".choice").first().evaluate((node) => getComputedStyle(node).fontSize)).toBe("16px");
  expect(await page.locator(".question-prompt pre").evaluate((node) => getComputedStyle(node).fontSize)).toBe("14px");
  await expect(page.locator(".practice-controls .primary")).toHaveCount(1);
  await expect(page.getByRole("button", { name: "정답 확인", exact: true })).toBeDisabled();

  await page.locator('input[value="910000002"]').check();
  await page.getByRole("button", { name: "북마크", exact: true }).click();
  await expect(page.locator('input[value="910000002"]')).toBeChecked();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.getByText("정답입니다.", { exact: true })).toBeVisible();
  await expect(page.getByRole("button", { name: "다음", exact: true })).toBeFocused();
  const nextButton = await page.getByRole("button", { name: "다음", exact: true }).boundingBox();
  const explanation = await page.locator('.explanation-region > details > summary').boundingBox();
  expect(nextButton!.y + nextButton!.height).toBeLessThan(explanation!.y);
  await expect(page.getByRole("button", { name: "건너뛰기", exact: true })).toHaveCount(0);
  await expect(page.locator(".practice-controls .primary")).toHaveCount(1);
  await page.reload(); await page.getByRole("button", { name: /^(이어서 풀기|Continue)$/ }).click();
  await expect(page.locator('input[value="910000002"]')).toBeChecked();
  await expect(page.getByRole("button", { name: "북마크 해제", exact: true })).toHaveAttribute("aria-pressed", "true");
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByText("복수 선택", { exact: true })).toBeVisible();
  await expect(page.locator("#question-content")).toBeFocused();
  await expect(page.getByRole("button", { name: "정답 확인", exact: true })).toBeDisabled();
  await page.screenshot({ path: test.info().outputPath("focused-mobile.png"), fullPage: true });
});

test("visible set selection works after a generic URL redirects to its named exam", async ({ page }) => {
  await page.goto("/test?testId=5&questId=900000001");
  await expect(page).toHaveURL(/\/sqlp-developer\?questId=900000001$/);
  await expect(page.locator('input[name="testId"]')).toHaveCount(0);
  await page.getByLabel("시험 회차", { exact: true }).selectOption("2");
  await expect(page).toHaveURL(/\/sqlp-developer\?verNbr=2$/);
  await expect(page.getByText("SQL에서 NULL을 검사하는 조건은 무엇인가요?", { exact: true })).toBeVisible();
  await expect(page.locator(".question-version")).toHaveText("회차 · SQL 조건");
  await expect(page.getByRole("link", { name: "문제 링크", exact: true })).toHaveAttribute("href", "?testId=5&questId=900000003&verNbr=2");
});

test("compact mobile controls remain usable at 320px and keep multiple-answer grading strict", async ({ page }) => {
  await page.setViewportSize({ width: 320, height: 740 });
  await page.goto("/kr/sqlp-developer?questId=900000002");
  await page.locator('input[value="910000004"]').check();
  await page.locator(".practice-controls").scrollIntoViewIfNeeded();
  const primary = await page.locator(".practice-primary").boundingBox();
  const secondary = await page.locator(".practice-secondary").boundingBox();
  expect(primary!.x).toBeGreaterThanOrEqual(secondary!.x + secondary!.width);
  expect(primary!.x + primary!.width).toBeLessThanOrEqual(320);
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await expect(page.locator(".answer-key")).toHaveText("정답 A, B");
  await expect(page.locator(".choice-correct")).toHaveCount(2);
  await expect(page.getByRole("button", { name: "다음", exact: true })).toBeEnabled();
  const nextButton = await page.getByRole("button", { name: "다음", exact: true }).boundingBox();
  const explanation = await page.locator('.explanation-region > details > summary').boundingBox();
  expect(nextButton!.y + nextButton!.height).toBeLessThan(explanation!.y);
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
});
