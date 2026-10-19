import { expect, test } from "@playwright/test";
import { authoredQuestions } from "../src/lib/authored-practice";
import content from "../src/data/practice-2026-10.json" with { type: "json" };

const examId = "236";
const path = "/en/california-real-estate-salesperson";
const questions = authoredQuestions(examId, "en");
const originalQuestions = content.groups.find(group => group.examIds.includes(examId))!.questions;

test("California Salesperson is English-only and resolves all page boundaries and question IDs above 99", async ({ request }) => {
  const english = await request.post("/tests", { data: { languageCd: "en" } });
  expect(english.status()).toBe(200);
  expect(await english.json()).toEqual(expect.arrayContaining([expect.objectContaining({ testId: 236, url: "california-real-estate-salesperson" })]));
  const korean = await request.post("/tests", { data: { languageCd: "kr" } });
  expect(korean.status()).toBe(200);
  expect((await korean.json()).some((exam: { testId: number }) => exam.testId === 236)).toBe(false);
  const versions = await request.post("/versions", { data: { testId: examId } });
  expect(versions.status()).toBe(200);
  expect(await versions.json()).toEqual([{ verId: 8100000236, verNm: "2026-10", verNbr: 202610 }]);
  for (const index of [0, 19, 20, 39, 40, 59, 60, 79, 80, 98, 99, 100, 119, 120, 139, 140, 149]) {
    const question = questions[index];
    const response = await request.post("/question", { data: { testId: examId, questId: question.id, verNbr: 202610 } });
    expect(response.status()).toBe(200);
    expect(await response.json()).toMatchObject({ questId: Number(question.id), testId: 236, questNbr: index + 1, questTxt: question.text, explanation: question.explanation });
  }
  expect((await request.post("/questionStats", { data: { questId: questions[149].id } })).status()).toBe(200);
  expect((await request.post("/question", { data: { testId: 235, questId: questions[149].id, verNbr: 202610 } })).status()).toBe(404);
  for (const url of ["/california-real-estate-salesperson", `${path}?verNbr=202610&page=9`]) expect((await request.get(url)).status()).toBe(404);
  const home = await request.get("/en");
  expect(await home.text()).toContain(`href="${path}"`);
});

test("California Salesperson supports discovery, grading all 150 questions, saved progress, eight pages, and direct links", async ({ page }) => {
  // This complete study journey grades 150 questions and crosses eight server-rendered batches.
  test.setTimeout(120_000);
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  await page.goto("/en");
  await page.getByRole("searchbox").fill("California Real Estate Salesperson");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.locator(`.exam-list a[href="${path}"]`).click();
  await expect(page.getByRole("heading", { name: "California Real Estate Salesperson", exact: true })).toBeVisible();
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await page.getByLabel("Exam set", { exact: true }).selectOption("202610");
  await page.getByRole("button", { name: "Apply", exact: true }).click();
  await expect(page).toHaveURL(`${path}?verNbr=202610`);
  for (let batch = 0; batch < 8; batch++) {
    for (const question of questions.slice(batch * 20, (batch + 1) * 20)) {
      await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
      await page.getByRole("button", { name: "Check answer", exact: true }).click();
      await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(originalQuestions[question.questionNumber! - 1].explanation);
      if ((question.questionNumber! - 1) % 20 === 0) {
        await page.reload();
        await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      }
      await page.getByRole("button", { name: "Next", exact: true }).click();
    }
    await expect(page.getByRole("heading", { name: "Practice complete", exact: true })).toBeVisible();
    if (batch < 7) {
      await page.getByRole("link", { name: "Continue practice", exact: true }).click();
      await expect(page).toHaveURL(`${path}?verNbr=202610&page=${batch + 2}`);
    }
  }
  for (const index of [99, 149]) {
    await page.goto(`${path}?questId=${questions[index].id}&verNbr=202610`);
    await expect(page.locator(".question-prompt")).toHaveText(originalQuestions[index].prompt);
    await expect(page.locator(".question-counter")).toContainText("1 / 1");
  }
  expect(errors).toEqual([]);
});
