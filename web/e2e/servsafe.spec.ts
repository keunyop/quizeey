import { expect, test } from "@playwright/test";
import { authoredQuestions } from "../src/lib/authored-practice";

const examId = "234";
const path = "/en/servsafe-food-handler";
const questions = authoredQuestions(examId, "en");

test("Food Handler is English-only and all page-boundary question identities resolve through the APIs", async ({ request }) => {
  const english = await request.post("/tests", { data: { languageCd: "en" } });
  expect(english.status()).toBe(200);
  expect(await english.json()).toEqual(expect.arrayContaining([expect.objectContaining({ testId: 234, url: "servsafe-food-handler" })]));
  const korean = await request.post("/tests", { data: { languageCd: "kr" } });
  expect(korean.status()).toBe(200);
  expect((await korean.json()).some((exam: { testId: number }) => exam.testId === 234)).toBe(false);
  const versions = await request.post("/versions", { data: { testId: examId } });
  expect(await versions.json()).toEqual([{ verId: 8100000234, verNm: "2026-10", verNbr: 202610 }]);
  for (const index of [0, 19, 20, 39]) {
    const question = questions[index];
    const response = await request.post("/question", { data: { testId: examId, questId: question.id, verNbr: 202610 } });
    expect(response.status()).toBe(200);
    expect(await response.json()).toMatchObject({ questId: Number(question.id), testId: 234, questNbr: index + 1, questTxt: question.text, explanation: question.explanation });
  }
  const stats = await request.post("/questionStats", { data: { questId: questions[39].id } });
  expect(stats.status()).toBe(200);
  for (const url of ["/servsafe-food-handler", `${path}?verNbr=202610&page=3`]) expect((await request.get(url)).status()).toBe(404);
});

test("Food Handler can be found, graded, resumed, completed across 40 questions, and opened by a direct link", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  await page.goto("/en");
  await page.getByRole("searchbox").fill("ServSafe Food Handler");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.locator(`.exam-list a[href="${path}"]`).click();
  await expect(page.getByRole("heading", { name: "ServSafe Food Handler", exact: true })).toBeVisible();
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await page.getByLabel("Exam set", { exact: true }).selectOption("202610");
  await page.getByRole("button", { name: "Apply", exact: true }).click();
  await expect(page).toHaveURL(`${path}?verNbr=202610`);
  for (let batch = 0; batch < 2; batch++) {
    for (const question of questions.slice(batch * 20, (batch + 1) * 20)) {
      await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
      await page.getByRole("button", { name: "Check answer", exact: true }).click();
      await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(question.explanation!.replace(/<[^>]*>/g, ""));
      if (question.questionNumber === 1 || question.questionNumber === 21) {
        await page.reload();
        await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      }
      await page.getByRole("button", { name: "Next", exact: true }).click();
    }
    await expect(page.getByRole("heading", { name: "Practice complete", exact: true })).toBeVisible();
    if (batch === 0) {
      await page.getByRole("link", { name: "Continue practice", exact: true }).click();
      await expect(page).toHaveURL(`${path}?verNbr=202610&page=2`);
    }
  }
  await page.goto(`${path}?questId=${questions[39].id}&verNbr=202610`);
  await expect(page.locator(".question-prompt")).toHaveText(questions[39].text.replace(/<[^>]*>/g, ""));
  expect(errors).toEqual([]);
});
