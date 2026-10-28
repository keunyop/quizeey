import { expect, test } from "@playwright/test";
import manifest from "../content/azure-fundamentals-depth-2026-10.manifest.json" with { type: "json" };
import content from "../src/data/practice-2026-10.json" with { type: "json" };
import { authoredQuestions } from "../src/lib/authored-practice";

const path = "/en/az-900", set = `${path}?verNbr=202610`;
const questions = authoredQuestions("170", "en");
const raw = content.groups.filter(group => group.examIds.includes("170")).flatMap(group => group.questions);

test("every new Azure scenario is available through the question API with an answer, explanation and official reference", async ({ request }) => {
  const versions = await request.post("/versions", { data: { testId: "170" } });
  expect(await versions.json()).toContainEqual({ verId: 8_100_000_170, verNm: "2026-10", verNbr: 202610 });
  for (const question of questions.slice(manifest.previousQuestionCount)) {
    const response = await request.post("/question", { data: { testId: "170", questId: question.id, verNbr: 202610 } });
    expect(response.status()).toBe(200);
    const data = await response.json();
    expect(data).toMatchObject({ questId: Number(question.id), testId: 170, questNbr: question.questionNumber, questTxt: question.text, explanation: question.explanation });
    expect(data.reference).toContain("https://learn.microsoft.com/en-us/");
    expect(data.examples.filter((choice: { answer: boolean }) => choice.answer)).toHaveLength(1);
  }
  expect((await request.post("/question", { data: { testId: "169", questId: questions.at(-1)!.id, verNbr: 202610 } })).status()).toBe(404);
  expect((await request.get(`${set}&page=6`)).status()).toBe(404);
});

test("the English directory and all five Azure prompt pages are usable without JavaScript", async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: "http://127.0.0.1:3100" });
  const page = await context.newPage();
  try {
    await page.goto("/en");
    await expect(page.locator(`.exam-directory a[href="${path}"]`)).toHaveCount(1);
    for (const number of [1, 2, 3, 4, 5]) {
      await page.goto(`${set}${number > 1 ? `&page=${number}` : ""}`);
      await expect(page.locator(".practice-set-summary")).toContainText("93 practice questions with explanations");
      await expect(page.locator(".practice-set-summary")).toContainText("English AZ-900");
      await expect(page.locator('meta[name="description"]')).toHaveAttribute("content", /93 practice questions/);
      await page.locator(".practice-outline summary").click();
      const outline = page.locator(".practice-outline li a");
      await expect(outline).toHaveCount(number === 5 ? 13 : 20);
      await expect(outline.last()).toHaveText(raw[Math.min(number * 20, 93) - 1].prompt);
    }
  } finally { await context.close(); }
});

test("a returning learner retains the old three-question second page and can grade, bookmark and review a new scenario", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  await page.goto(`${set}&page=2`);
  const original = questions[20];
  await page.locator(`input[value="${original.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "Check answer", exact: true }).click();
  await expect(page.locator(".answer-feedback")).toHaveText("Correct.");
  await page.evaluate(() => {
    const key = Object.keys(localStorage).find(key => key.startsWith("quizeey:progress:v1:en:170:") && key.endsWith(":all:page2"))!;
    const saved = JSON.parse(localStorage.getItem(key)!);
    saved.ids = saved.ids.slice(0, 3);
    saved.bookmarks = [saved.ids[0]];
    const beforeKey = key.replace(/:(?:202610,)*202610:all:page2$/, `:${Array(3).fill(202610).join(",")}:all:page2`);
    localStorage.setItem(beforeKey, JSON.stringify(saved));
    localStorage.removeItem(key);
  });
  await page.reload();
  await expect(page.locator(".answer-feedback")).toHaveText("Correct.");
  await expect(page.locator(".bookmark-button")).toHaveAttribute("aria-pressed", "true");

  await page.locator(".question-map summary").click();
  await page.locator(".question-grid button").nth(3).click();
  const added = questions[23];
  await expect(page.locator(".question-prompt")).toHaveText(raw[23].prompt);
  await expect(page.locator(".question-prompt")).toHaveAttribute("lang", "en");
  await page.locator(".bookmark-button").click();
  await page.locator(`input[value="${added.choices.find(choice => !choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "Check answer", exact: true }).click();
  await expect(page.locator(".answer-feedback")).toContainText("Incorrect");
  await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(raw[23].explanation);
  await expect(page.locator(".explanation-region a").first()).toHaveAttribute("href", /https:\/\/learn\.microsoft\.com/);
  await page.reload();
  await expect(page.locator(".answer-feedback")).toContainText("Incorrect");
  await expect(page.locator(".bookmark-button")).toHaveAttribute("aria-pressed", "true");
  await page.locator(".question-map summary").click();
  await page.getByRole("button", { name: /^Review mistakes/ }).click();
  await expect(page.locator(".question-prompt")).toHaveText(raw[23].prompt);
  await expect(page.locator(".answer-feedback")).toHaveCount(0);
  await page.locator(`input[value="${added.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "Check answer", exact: true }).click();
  await expect(page.locator(".answer-feedback")).toHaveText("Correct.");

  await page.goto(`${path}?questId=${questions.at(-1)!.id}&verNbr=202610`);
  await expect(page.locator(".question-prompt")).toHaveText(raw.at(-1)!.prompt);
  expect(errors).toEqual([]);
});
