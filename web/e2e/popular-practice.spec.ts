import { expect, test } from "@playwright/test";
import manifest from "../content/popular-2026-10-28.manifest.json" with { type: "json" };
import { authoredQuestions } from "../src/lib/authored-practice";
import type { Locale } from "../src/lib/contracts";
import { learningHtml } from "../src/lib/content";

test("all 160 popularity-selected additions resolve through the local question API with correct identities and explanations", async ({ request }) => {
  test.setTimeout(90_000);
  let checked = 0;
  for (const exam of manifest.exams) {
    for (const question of authoredQuestions(exam.examId, exam.locale as Locale).slice(exam.previousQuestionCount)) {
      const response = await request.post("/question", { data: { testId: exam.examId, questId: question.id, verNbr: 202610 } });
      expect(response.status()).toBe(200);
      const data = await response.json();
      expect(data).toMatchObject({ questId: Number(question.id), testId: Number(exam.examId), verNbr: 202610, questTxt: learningHtml(question.text), explanation: learningHtml(question.explanation!) });
      expect(data.examples.filter((choice: { answer: boolean }) => choice.answer)).toHaveLength(1);
      checked++;
    }
  }
  expect(checked).toBe(manifest.addedQuestionCount);
});
