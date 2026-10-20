import { expect, test } from "@playwright/test";
import { authoredCatalog, authoredQuestions } from "../src/lib/authored-practice";

const ids = ["181", "238", "239", "168", "240", "241", "242"];

test("global and Canadian exams have the requested catalog visibility and resolve new page-boundary IDs", async ({ request }) => {
  for (const languageCd of ["kr", "en"]) {
    const response = await request.post("/tests", { data: { languageCd } });
    expect(response.status()).toBe(200);
    const exams: { testId: number; url: string }[] = await response.json();
    for (const id of ids) {
      const exam = authoredCatalog.find(exam => exam.id === id)!;
      const visible = languageCd === "en" || exam.locale === "all";
      expect(exams.filter(entry => entry.testId === Number(id))).toHaveLength(visible ? 1 : 0);
    }
  }
  for (const id of ids) {
    const versions = await request.post("/versions", { data: { testId: id } });
    expect(await versions.json()).toEqual([{ verId: 8_100_000_000 + Number(id), verNm: "2026-10", verNbr: 202610 }]);
    const questions = authoredQuestions(id, "en");
    for (const index of [3, 19, 20, questions.length - 1]) {
      const question = questions[index];
      const response = await request.post("/question", { data: { testId: id, questId: question.id, verNbr: 202610 } });
      expect(response.status()).toBe(200);
      expect(await response.json()).toMatchObject({ testId: Number(id), questNbr: index + 1, questTxt: question.text, explanation: question.explanation });
    }
  }
  for (const slug of ["foodsafe-level-1", "llqp"]) expect((await request.get(`/${slug}`)).status()).toBe(404);
});

test("new exams are searchable in the correct home catalogs", async ({ page }) => {
  for (const locale of ["ko", "en"]) {
    await page.goto(locale === "en" ? "/en" : "/");
    for (const id of ids) {
      const exam = authoredCatalog.find(exam => exam.id === id)!;
      await page.getByRole("searchbox").fill(exam.name);
      const visible = locale === "en" || exam.locale === "all";
      await expect(page.locator(`.exam-list a[href="${locale === "en" ? "/en" : ""}/${exam.slug}"]`)).toHaveCount(visible ? 1 : 0);
    }
  }
});

test("English questions support grading and resume in both interfaces and on the second page", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  for (const id of ids) {
    const exam = authoredCatalog.find(exam => exam.id === id)!;
    for (const locale of exam.locale === "all" ? ["ko", "en"] : ["en"]) {
      const path = `${locale === "en" ? "/en" : ""}/${exam.slug}`;
      const question = authoredQuestions(id, locale as "ko" | "en")[20];
      await page.goto(`${path}?verNbr=202610&page=2`);
      await expect(page.locator("html")).toHaveAttribute("lang", locale);
      await expect(page.locator(".question-prompt")).toHaveText(question.text.replace(/<[^>]*>/g, ""));
      await page.locator(`input[value="${question.choices.find(choice => choice.correct)!.id}"]`).check();
      await page.getByRole("button", { name: locale === "ko" ? "정답 확인" : "Check answer", exact: true }).click();
      await expect(page.getByText(locale === "ko" ? "정답입니다." : "Correct.", { exact: true })).toBeVisible();
      await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(question.explanation!.replace(/<[^>]*>/g, ""));
      await page.reload();
      await expect(page.getByText(locale === "ko" ? "정답입니다." : "Correct.", { exact: true })).toBeVisible();
      const last = authoredQuestions(id, locale as "ko" | "en").at(-1)!;
      await page.goto(`${path}?questId=${last.id}&verNbr=202610`);
      await expect(page.locator(".question-prompt")).toHaveText(last.text.replace(/<[^>]*>/g, ""));
    }
  }
  expect(errors).toEqual([]);
});
