import { expect, test } from "@playwright/test";
import manifest from "../content/top10-2026-10.manifest.json" with { type: "json" };
import { authoredCatalog, authoredQuestions } from "../src/lib/authored-practice";
import type { Locale } from "../src/lib/contracts";

test("all 400 supplemental questions resolve with answers and explanations in the registered October set", async ({ request }) => {
  test.setTimeout(120_000);
  for (const exam of manifest.exams) {
    const versions = await request.post("/versions", { data: { testId: exam.examId } });
    expect(await versions.json()).toContainEqual({ verId: 8_100_000_000 + Number(exam.examId), verNm: "2026-10", verNbr: 202610 });
    for (const question of authoredQuestions(exam.examId, exam.locale as Locale).slice(exam.previousQuestionCount, exam.previousQuestionCount + 20)) {
      const response = await request.post("/question", { data: { testId: exam.examId, questId: question.id, verNbr: 202610 } });
      expect(response.status()).toBe(200);
      const data = await response.json();
      expect(data).toMatchObject({ questId: Number(question.id), testId: Number(exam.examId), verNbr: 202610, questTxt: question.text, explanation: question.explanation });
      expect(data.examples.filter((choice: { answer: boolean }) => choice.answer)).toHaveLength(1);
    }
  }
});

test("set discovery and the full page of prompts work without JavaScript in both languages", async ({ browser, request }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: "http://127.0.0.1:3100" });
  const page = await context.newPage();
  for (const [id, locale] of [["14", "ko"], ["168", "en"]] as const) {
    const exam = authoredCatalog.find(exam => exam.id === id)!;
    const path = `${locale === "en" ? "/en" : ""}/${exam.slug}`;
    await page.goto(path);
    await expect(page.locator(".practice-set-summary a")).toHaveAttribute("href", `${path}?verNbr=202610`);
    await page.locator(".practice-set-summary a").click();
    await expect(page).toHaveURL(`${path}?verNbr=202610`);
    await expect(page).toHaveTitle(/2026-10/);
    await page.locator(".practice-outline summary").click();
    await expect(page.locator(".practice-outline li")).toHaveCount(20);
    await expect(page.locator(".practice-outline li").last()).toBeVisible();
    await expect(page.locator(".explanation-region")).toHaveCount(0);
    await page.locator(".practice-pages a[rel=next]").click();
    await expect(page).toHaveURL(`${path}?verNbr=202610&page=2`);
    await expect(page.locator(".practice-outline li")).toHaveCount(id === "14" ? 3 : 20);
    expect((await request.get(`${path}?verNbr=999999`)).status()).toBe(404);
  }
  await context.close();
});

test("new Korean and English questions grade, explain and resume with the correct content language", async ({ page }) => {
  for (const id of ["14", "54", "177", "168"]) {
    const selected = manifest.exams.find(exam => exam.examId === id)!;
    const locale = selected.locale as Locale;
    const exam = authoredCatalog.find(exam => exam.id === id)!;
    const question = authoredQuestions(id, locale).at(-1)!;
    const path = `${locale === "en" ? "/en" : ""}/${exam.slug}`;
    await page.goto(`${path}?questId=${question.id}&verNbr=202610`);
    await expect(page.locator(".question-prompt")).toHaveAttribute("lang", locale);
    await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
    await page.getByRole("button", { name: locale === "ko" ? "정답 확인" : "Check answer", exact: true }).click();
    await expect(page.locator(".answer-feedback")).toHaveText(locale === "ko" ? "정답입니다." : "Correct.");
    await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(question.explanation!.replace(/<[^>]*>/g, ""));
    await page.reload();
    await expect(page.locator(".answer-feedback")).toHaveText(locale === "ko" ? "정답입니다." : "Correct.");
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
  }
});

test("expanding the October set retains progress stored under its previous three-question key", async ({ page }) => {
  const questions = authoredQuestions("5", "ko");
  await page.goto("/sqlp-developer?verNbr=202610");
  await page.locator(`input[value="${questions[0].choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.locator(".answer-feedback")).toHaveText("정답입니다.");
  await page.evaluate(() => {
    const key = Object.keys(localStorage).find(key => key.startsWith("quizeey:progress:v1:ko:5:") && key.endsWith(":all"))!;
    const saved = JSON.parse(localStorage.getItem(key)!);
    saved.ids = saved.ids.slice(0, 3);
    saved.bookmarks = [saved.ids[0]];
    const beforeVersions = Array(3).fill(202610).join(",");
    const beforeKey = key.replace(/:(?:202610,)*202610:all$/, `:${beforeVersions}:all`);
    localStorage.setItem(beforeKey, JSON.stringify(saved));
    localStorage.removeItem(key);
  });
  await page.reload();
  await expect(page.locator(".answer-feedback")).toHaveText("정답입니다.");
  await expect(page.getByRole("button", { name: "북마크 해제", exact: true })).toHaveAttribute("aria-pressed", "true");
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await page.locator(`input[value="${questions[1].choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await page.reload();
  await expect(page.locator(".answer-feedback")).toHaveText("정답입니다.");
  await expect(page.getByRole("progressbar")).toHaveAttribute("value", "2");
});
