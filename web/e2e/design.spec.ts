import { expect, test } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import { createHash } from "node:crypto";
import { authoredQuestions } from "../src/lib/authored-practice";

test("catalog filters, initials, pagination, favorites, cross-tab sync and recovery", async ({ page, context }) => {
  const errors: string[] = []; page.on("pageerror", (error) => errors.push(error.message));
  await page.goto("/");
  await expect(page.locator(".exam-list > li")).toHaveCount(18);
  await expect(page.locator('.exam-list a').first()).toHaveAttribute('data-google-vignette', 'false');
  await page.getByRole("button", { name: /시험 더 보기/ }).click();
  await expect(page.locator(".exam-list > li")).toHaveCount(36);
  await page.getByRole("searchbox").fill("ㅈㅂㅊㄹㄱㅅ");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.getByRole("searchbox").fill("SQLD");
  const favorite = page.locator(".favorite-button");
  await favorite.click(); await expect(favorite).toHaveAttribute("aria-pressed", "true");
  const second = await context.newPage();
  await second.goto("/");
  await second.getByRole("button", { name: /^즐겨찾기/ }).first().click();
  await expect(second.locator(".exam-list a")).toHaveCount(1);
  await favorite.click();
  await expect(second.locator(".exam-list a")).toHaveCount(0);
  await favorite.click(); await page.reload();
  await page.getByRole("button", { name: /^즐겨찾기/ }).first().click();
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.getByRole("button", { name: "전기·전자", exact: true }).click();
  await expect(page.locator(".exam-list a")).toHaveCount(0);
  await page.getByRole("button", { name: "전체 시험 보기", exact: true }).click();
  await expect(page.locator(".exam-list > li")).toHaveCount(18);
  await page.evaluate(() => localStorage.setItem("quizeey:favorite-exams:v1", "broken"));
  await page.reload();
  await page.getByRole("button", { name: /^즐겨찾기/ }).first().click();
  await expect(page.getByRole("heading", { name: "자주 찾는 시험을 모아보세요" })).toBeVisible();
  expect(errors).toEqual([]); await second.close();
});

test("favorites stay independent across legacy exam routes", async ({ page }) => {
  await page.goto("/");
  await page.getByRole("searchbox").fill("조리기능사");
  await page.locator('.exam-card').filter({ has: page.locator('a[href="/craftsman-cook-korean-food"]') }).getByRole("button").click();
  await page.getByRole("button", { name: /^즐겨찾기/ }).first().click();
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await expect(page.locator(".exam-list a")).toHaveAttribute("href", "/craftsman-cook-korean-food");
});

test("question navigator, skipped counts and independent unanswered/bookmark/mistake review", async ({ page }) => {
  await page.goto("/sqlp-developer");
  await page.locator('input[value="910000001"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await page.getByRole("button", { name: "북마크", exact: true }).click();
  await page.locator('input[value="910000004"]').check();
  await page.locator('input[value="910000005"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByRole("progressbar")).toHaveAttribute("value", "2");
  await expect(page.locator(".question-version")).toHaveText("회차 · SQL 조건");
  await page.getByRole("button", { name: "건너뛰기", exact: true }).click();
  for (let i = 0; i < 3; i++) await page.getByRole("button", { name: "건너뛰기", exact: true }).click();
  await expect(page.locator(".result-stats strong")).toHaveText(["1", "1", "4"]);
  await page.getByRole("button", { name: /미응답 풀기/ }).click();
  await page.locator('input[value="910000008"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await page.reload(); await expect(page.getByText("정답입니다.", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  for (const question of authoredQuestions("5", "ko")) {
    await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.getByRole("button", { name: "정답 확인", exact: true }).click();
    await page.getByRole("button", { name: "다음", exact: true }).click();
  }
  await expect(page.locator(".result-stats strong")).toHaveText(["4", "0", "0"]);
  await page.getByRole("button", { name: /북마크 복습/ }).click();
  await expect(page.getByText("복수 선택", { exact: true })).toBeVisible();
  await expect(page.getByRole("button", { name: "정답 확인", exact: true })).toBeVisible();
  await page.reload();
  await expect(page.getByRole("button", { name: "정답 확인", exact: true })).toBeVisible();
  await page.getByRole("button", { name: "전체 문제", exact: true }).click();
  await page.locator(".question-map summary").click();
  await page.getByRole("button", { name: "문제 1, 오답", exact: true }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await page.locator(".question-map").getByRole("button", { name: /오답 복습/ }).click();
  await page.locator('input[value="910000002"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByRole("button", { name: /오답 복습/ })).toBeDisabled();
  await expect(page.locator(".result-stats strong")).toHaveText(["1", "0", "0"]);
});

test("branding assets and responsive layouts in both languages", async ({ page, request }) => {
  // Pin the preserved branding bytes without depending on the retired Java tree.
  for (const [path, sha256] of [
    ["/img/letter-q.svg", "cbaff1e68d3f261d7b0879dc2c4498a1f4815361c078741422d284b71ba86959"],
    ["/img/favicon.ico", "ffd7fcf1f85e07065b4e42be5b7a081b3fac5a973f99838dfdb583b9001769be"],
  ]) {
    const response = await request.get(path);
    expect(response.ok(), path).toBe(true);
    expect(createHash("sha256").update(await response.body()).digest("hex"), path).toBe(sha256);
  }
  for (const width of [320, 390, 768, 1440]) {
    await page.setViewportSize({ width, height: 900 });
    for (const path of ["/", "/en", "/sqlp-developer", "/en/aws-certified-developer-associate", "/privacy", "/about", "/engineer-electricity"]) {
      await page.goto(path);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth), `${path} at ${width}`).toBe(true);
      await expect(page.locator('link[rel="icon"]')).toHaveAttribute("href", "/img/favicon.ico");
      if ([390, 1440].includes(width) && ["/", "/sqlp-developer"].includes(path)) await page.screenshot({ path: test.info().outputPath(`${path === "/" ? "home" : "practice"}-${width}.png`), fullPage: path !== "/" });
    }
  }
});

test("keyboard and accessibility in both languages", async ({ page }) => {
  for (const path of ["/", "/en", "/sqlp-developer", "/en/aws-certified-developer-associate"]) {
    await page.goto(path);
    const result = await new AxeBuilder({ page }).analyze();
    expect(result.violations, path).toEqual([]);
  }
  await page.goto("/sqlp-developer");
  await page.getByRole("radio").first().focus();
  await page.keyboard.press("ArrowDown");
  await expect(page.getByRole("radio").nth(1)).toBeChecked();
  await page.keyboard.press("Tab");
  await expect(page.getByRole("button", { name: "정답 확인", exact: true })).toBeFocused();
  await page.keyboard.press("Enter");
  await expect(page.locator(".answer-feedback")).toBeVisible();
  expect((await new AxeBuilder({ page }).analyze()).violations).toEqual([]);
});

test("unavailable local storage keeps practice and favorites usable", async ({ page }) => {
  await page.addInitScript(() => { Object.defineProperty(window, "localStorage", { get() { throw new DOMException("Unavailable", "SecurityError"); } }); });
  await page.goto("/"); await page.getByRole("searchbox").fill("SQLD");
  await page.locator(".favorite-button").click();
  await expect(page.locator(".favorite-button")).toHaveAttribute("aria-pressed", "true");
  await expect(page.getByRole("status").filter({ hasText: "즐겨찾기를 저장할 수 없습니다" })).toBeVisible();
  await page.goto("/sqlp-developer");
  await page.locator('input[value="910000001"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByText("복수 선택", { exact: true })).toBeVisible();
});
