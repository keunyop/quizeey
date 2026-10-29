import { expect, test } from "@playwright/test";
import { authoredQuestions } from "../src/lib/authored-practice";
import content from "../src/data/practice-2026-10.json" with { type: "json" };

const examId = "237";
const path = "/en/texas-life-and-health-insurance";
const questions = authoredQuestions(examId, "en");
const originalQuestions = content.groups.find(group => group.examIds.includes(examId))!.questions;

test("Texas insurance is English-only and resolves page boundaries and all extended question identities", async ({ request }) => {
  const english = await request.post("/tests", { data: { languageCd: "en" } });
  expect(english.status()).toBe(200);
  expect(await english.json()).toEqual(expect.arrayContaining([expect.objectContaining({ testId: 237, url: "texas-life-and-health-insurance" })]));
  const korean = await request.post("/tests", { data: { languageCd: "kr" } });
  expect(korean.status()).toBe(200);
  expect((await korean.json()).some((exam: { testId: number }) => exam.testId === 237)).toBe(false);
  const versions = await request.post("/versions", { data: { testId: examId } });
  expect(versions.status()).toBe(200);
  expect(await versions.json()).toEqual([{ verId: 8100000237, verNm: "2026-10", verNbr: 202610 }]);
  for (const index of [0, 19, 20, 39, 40, 59, 60, 79, 80, 98, 99, 100, 119, 120, 129]) {
    const question = questions[index];
    const response = await request.post("/question", { data: { testId: examId, questId: question.id, verNbr: 202610 } });
    expect(response.status()).toBe(200);
    expect(await response.json()).toMatchObject({ questId: Number(question.id), testId: 237, questNbr: index + 1, questTxt: question.text, explanation: question.explanation });
  }
  expect((await request.post("/questionStats", { data: { questId: questions[129].id } })).status()).toBe(200);
  expect((await request.post("/question", { data: { testId: 236, questId: questions[129].id, verNbr: 202610 } })).status()).toBe(404);
  for (const url of ["/texas-life-and-health-insurance", `${path}?verNbr=202610&page=8`]) expect((await request.get(url)).status()).toBe(404);
  const home = await request.get("/en");
  expect(await home.text()).toContain(`href="${path}"`);
});

test("Texas insurance supports discovery, grading all 130 questions, saved progress, seven pages, and direct links", async ({ page }) => {
  test.setTimeout(120_000);
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  await page.goto("/en");
  await page.getByRole("searchbox").fill("Texas Life and Health Insurance");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.locator(`.exam-list a[href="${path}"]`).click();
  await expect(page.getByRole("heading", { name: "Texas Life and Health Insurance", exact: true })).toBeVisible();
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await page.getByLabel("Exam set", { exact: true }).selectOption("202610");
  await expect(page).toHaveURL(`${path}?verNbr=202610`);
  for (let batch = 0; batch < 7; batch++) {
    for (const question of questions.slice(batch * 20, (batch + 1) * 20)) {
      await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
      await page.getByRole("button", { name: "Check answer", exact: true }).click();
      await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(originalQuestions[question.questionNumber! - 1].explanation);
      if ((question.questionNumber! - 1) % 20 === 0) {
        await page.reload(); await page.getByRole("button", { name: /^(이어서 풀기|Continue)$/ }).click();
        await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      }
      await page.getByRole("button", { name: "Next", exact: true }).click();
    }
    await expect(page.getByRole("heading", { name: "Practice complete", exact: true })).toBeVisible();
    if (batch < 6) {
      await page.getByRole("link", { name: "Continue practice", exact: true }).click();
      await expect(page).toHaveURL(`${path}?verNbr=202610&page=${batch + 2}`);
    }
  }
  for (const index of [99, 129]) {
    await page.goto(`${path}?questId=${questions[index].id}&verNbr=202610`);
    await expect(page.locator(".question-prompt")).toHaveText(originalQuestions[index].prompt);
    await expect(page.locator(".question-counter")).toContainText("1 / 1");
  }
  expect(errors).toEqual([]);
});
