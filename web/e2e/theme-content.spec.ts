import { expect, test } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import { authoredCatalog, authoredDefaultLocale, authoredQuestions } from "../src/lib/authored-practice";

test("theme follows the system, persists across pages and languages, and syncs between tabs", async ({ page, context }) => {
  const errors: string[] = []; page.on("pageerror", error => errors.push(error.message));
  await page.emulateMedia({ colorScheme: "dark" });
  await page.goto("/");
  await expect(page.locator("html")).toHaveAttribute("data-theme", "dark");
  await page.getByRole("button", { name: "라이트 모드로 전환" }).click();
  await expect(page.locator("html")).toHaveAttribute("data-theme", "light");
  await page.reload();
  await expect(page.locator("html")).toHaveAttribute("data-theme", "light");
  const second = await context.newPage();
  await second.goto("/en");
  await expect(second.locator("html")).toHaveAttribute("data-theme", "light");
  await second.getByRole("button", { name: "Switch to dark mode" }).click();
  await expect(page.locator("html")).toHaveAttribute("data-theme", "dark");
  await page.goto("/engineer-electricity?verNbr=202610");
  await expect(page.locator("html")).toHaveAttribute("data-theme", "dark");
  await page.getByRole("button", { name: "라이트 모드로 전환" }).click();
  await page.emulateMedia({ colorScheme: "light" });
  await page.emulateMedia({ colorScheme: "dark" });
  await expect(page.locator("html")).toHaveAttribute("data-theme", "light");
  await second.close(); expect(errors).toEqual([]);
});

test("theme still works when browser storage is unavailable", async ({ page }) => {
  await page.addInitScript(() => { Object.defineProperty(window, "localStorage", { get() { throw new Error("Storage blocked"); } }); });
  await page.emulateMedia({ colorScheme: "dark" });
  await page.goto("/");
  await expect(page.locator("html")).toHaveAttribute("data-theme", "dark");
  await page.getByRole("button", { name: "라이트 모드로 전환" }).click();
  await expect(page.locator("html")).toHaveAttribute("data-theme", "light");
  await page.emulateMedia({ colorScheme: "light" });
  await page.emulateMedia({ colorScheme: "dark" });
  await expect(page.locator("html")).toHaveAttribute("data-theme", "light");
});

test("both themes remain accessible at mobile and desktop sizes", async ({ page }) => {
  for (const width of [375, 1280]) {
    await page.setViewportSize({ width, height: 900 });
    for (const theme of ["light", "dark"]) {
      await page.emulateMedia({ colorScheme: theme as "light" | "dark" });
      await page.goto("/engineer-electricity?verNbr=202610");
      await expect(page.locator("html")).toHaveAttribute("data-theme", theme);
      await page.locator('input[type="radio"]').first().check();
      await page.getByRole("button", { name: "정답 확인", exact: true }).click();
      const result = await new AxeBuilder({ page }).analyze();
      expect(result.violations, `${width}px / ${theme}`).toEqual([]);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
      await page.screenshot({ path: test.info().outputPath(`${width}-${theme}.png`), fullPage: true });
      await page.evaluate(() => localStorage.clear());
    }
  }
});

test("all catalog exams offer the new set and native question identities through legacy APIs", async ({ request }) => {
  for (const exam of authoredCatalog) {
    const versions = await request.post("/versions", { data: { testId: exam.id } });
    expect(versions.status(), exam.slug).toBe(200);
    expect(await versions.json(), exam.slug).toEqual(expect.arrayContaining([expect.objectContaining({ verNm: "2026-10", verNbr: 202610 })]));
    const question = authoredQuestions(exam.id, authoredDefaultLocale(exam.id))[0];
    const response = await request.post("/question", { data: { testId: exam.id, questId: question.id, verNbr: 202610 } });
    expect(response.status(), exam.slug).toBe(200);
    const value = await response.json();
    expect(value).toMatchObject({ questId: Number(question.id), testId: Number(exam.id), verName: "2026-10" });
    expect(value.examples.filter((choice: { answer: boolean }) => choice.answer)).toHaveLength(1);
  }
});

test("an original practice set supports grading, explanations, refresh, completion and direct links", async ({ page }) => {
  const questions = authoredQuestions("27", "ko");
  await page.goto("/engineer-electricity?verNbr=202610");
  await expect(page.locator(".authored-badge")).toHaveCount(0);
  for (const question of questions) {
    await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.getByRole("button", { name: "정답 확인", exact: true }).click();
    await expect(page.getByText("정답입니다.", { exact: true })).toBeVisible();
    await expect(page.locator(".reference a")).toHaveAttribute("href", /^https:\/\//);
    await page.reload(); await page.getByRole("button", { name: "이어서 풀기", exact: true }).click();
    await expect(page.getByText("정답입니다.", { exact: true })).toBeVisible();
    await page.getByRole("button", { name: "다음", exact: true }).click();
  }
  await expect(page.getByRole("heading", { name: "학습 완료", exact: true })).toBeVisible();
  await page.goto(`/engineer-electricity?questId=${questions[1].id}&verNbr=202610`);
  await expect(page.locator(".question-prompt")).toHaveText("10 Ω과 15 Ω 저항을 직렬로 연결한 합성저항은?");
});
