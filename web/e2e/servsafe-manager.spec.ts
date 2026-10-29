import { expect, test } from "@playwright/test";
import { authoredQuestions } from "../src/lib/authored-practice";

const examId = "235";
const path = "/en/servsafe-food-protection-manager";
const questions = authoredQuestions(examId, "en");

test("Manager is a separate English exam and every page boundary resolves through the APIs", async ({ request }) => {
  const english = await request.post("/tests", { data: { languageCd: "en" } });
  expect(english.status()).toBe(200);
  expect(await english.json()).toEqual(expect.arrayContaining([
    expect.objectContaining({ testId: 234, url: "servsafe-food-handler" }),
    expect.objectContaining({ testId: 235, url: "servsafe-food-protection-manager" }),
  ]));
  const korean = await request.post("/tests", { data: { languageCd: "kr" } });
  expect(korean.status()).toBe(200);
  expect((await korean.json()).some((exam: { testId: number }) => exam.testId === 235)).toBe(false);
  const versions = await request.post("/versions", { data: { testId: examId } });
  expect(versions.status()).toBe(200);
  expect(await versions.json()).toEqual([{ verId: 8100000235, verNm: "2026-10", verNbr: 202610 }]);
  for (const index of [0, 19, 20, 39, 40, 59, 60, 79, 80, 89]) {
    const question = questions[index];
    const response = await request.post("/question", { data: { testId: examId, questId: question.id, verNbr: 202610 } });
    expect(response.status()).toBe(200);
    expect(await response.json()).toMatchObject({ questId: Number(question.id), testId: 235, questNbr: index + 1, questTxt: question.text, explanation: question.explanation });
  }
  expect((await request.post("/questionStats", { data: { questId: questions[89].id } })).status()).toBe(200);
  expect((await request.post("/question", { data: { testId: 234, questId: questions[89].id, verNbr: 202610 } })).status()).toBe(404);
  for (const url of ["/servsafe-food-protection-manager", `${path}?verNbr=202610&page=6`]) expect((await request.get(url)).status()).toBe(404);
});

test("Manager supports discovery, English grading, saved progress, all 90 questions, and a direct link to question 90", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  await page.goto("/en");
  await page.getByRole("searchbox").fill("ServSafe Food Protection Manager");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.locator(`.exam-list a[href="${path}"]`).click();
  await expect(page.getByRole("heading", { name: "ServSafe Food Protection Manager", exact: true })).toBeVisible();
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await page.getByLabel("Exam set", { exact: true }).selectOption("202610");
  await expect(page).toHaveURL(`${path}?verNbr=202610`);
  for (let batch = 0; batch < 5; batch++) {
    for (const question of questions.slice(batch * 20, (batch + 1) * 20)) {
      await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
      await page.getByRole("button", { name: "Check answer", exact: true }).click();
      await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(question.explanation!.replace(/<[^>]*>/g, ""));
      if ((question.questionNumber! - 1) % 20 === 0) {
        await page.reload(); await page.getByRole("button", { name: /^(이어서 풀기|Continue)$/ }).click();
        await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
      }
      await page.getByRole("button", { name: "Next", exact: true }).click();
    }
    await expect(page.getByRole("heading", { name: "Practice complete", exact: true })).toBeVisible();
    if (batch < 4) {
      await page.getByRole("link", { name: "Continue practice", exact: true }).click();
      await expect(page).toHaveURL(`${path}?verNbr=202610&page=${batch + 2}`);
    }
  }
  await page.goto(`${path}?questId=${questions[89].id}&verNbr=202610`);
  await expect(page.locator(".question-prompt")).toHaveText(questions[89].text.replace(/<[^>]*>/g, ""));
  await expect(page.locator(".question-counter")).toContainText("1 / 1");
  expect(errors).toEqual([]);
});
