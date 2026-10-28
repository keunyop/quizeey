import { expect, test } from "@playwright/test";
import manifest from "../content/north-america-2026-10.manifest.json" with { type: "json" };
import content from "../src/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredQuestions } from "../src/lib/authored-practice";
import { practiceDisplayCopy } from "../src/lib/practice-display-copy";

const exams = authoredCatalog.filter(exam => manifest.examIds.includes(exam.id));

test("North American exams appear in the English API catalog and every new question resolves with an explanation", async ({ request }) => {
  for (const languageCd of ["en", "kr"]) {
    const response = await request.post("/tests", { data: { languageCd } });
    expect(response.status()).toBe(200);
    const catalog: { testId: number }[] = await response.json();
    for (const exam of exams) expect(catalog.filter(item => item.testId === Number(exam.id))).toHaveLength(languageCd === "en" ? 1 : 0);
  }
  for (const exam of exams) {
    const versions = await request.post("/versions", { data: { testId: exam.id } });
    expect(versions.status()).toBe(200);
    expect(await versions.json()).toEqual([{ verId: 8_100_000_000 + Number(exam.id), verNm: "2026-10", verNbr: 202610 }]);
    for (const question of authoredQuestions(exam.id, "en")) {
      const response = await request.post("/question", { data: { testId: exam.id, questId: question.id, verNbr: 202610 } });
      expect(response.status()).toBe(200);
      expect(await response.json()).toMatchObject({ testId: Number(exam.id), questNbr: question.questionNumber, questTxt: question.text, explanation: question.explanation });
    }
    expect((await request.get(`/${exam.slug}`)).status()).toBe(404);
    expect((await request.get(`/en/${exam.slug}?verNbr=202610&page=3`)).status()).toBe(404);
    expect((await request.get(`/en/${exam.slug}?verNbr=202611`)).status()).toBe(404);
  }
});

test("search aliases and the new academic, driving and citizenship filters find the right exams", async ({ page }) => {
  await page.goto("/en");
  for (const [category, count] of [["School & equivalency", 6], ["Driving", 3], ["Citizenship", 1]] as const) {
    await page.getByRole("button", { name: category, exact: true }).click();
    await expect(page.locator(".exam-list a")).toHaveCount(count);
  }
  await page.getByRole("button", { name: "All", exact: true }).click();
  for (const exam of exams) {
    await page.getByRole("searchbox").fill(exam.searchTerms![0]);
    await expect(page.locator(`.exam-list a[href="/en/${exam.slug}"]`)).toHaveCount(1);
  }
});

test("new exam links, set summaries, all prompts and targeted metadata are server-rendered", async ({ browser }) => {
  const context = await browser.newContext({ javaScriptEnabled: false, baseURL: "http://127.0.0.1:3100" });
  const page = await context.newPage();
  await page.goto("/en");
  for (const exam of exams) await expect(page.locator(`.exam-directory a[href="/en/${exam.slug}"]`)).toHaveCount(1);
  for (const exam of exams) {
    const questions = authoredQuestions(exam.id, "en");
    for (const pageNumber of [1, 2]) {
      await page.goto(`/en/${exam.slug}?verNbr=202610${pageNumber === 2 ? "&page=2" : ""}`);
      await expect(page.locator("html")).toHaveAttribute("lang", "en");
      await expect(page).toHaveTitle(new RegExp(exam.seoTitle!.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")));
      await expect(page.locator('meta[name="description"]')).toHaveAttribute("content", new RegExp(exam.description!.slice(0, 20)));
      await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
      await expect(page.locator(".practice-set-summary")).toContainText("30 practice questions with explanations");
      await expect(page.locator(".practice-set-summary")).toContainText(practiceDisplayCopy(exam.practiceScope)!);
      await page.locator(".practice-outline summary").click();
      const outline = page.locator(".practice-outline li a");
      await expect(outline).toHaveCount(pageNumber === 1 ? 20 : 10);
      await expect(outline.last()).toHaveAttribute("href", `/en/${exam.slug}?questId=${questions[pageNumber === 1 ? 19 : 29].id}&verNbr=202610`);
      const data = JSON.parse(await page.locator('script[type="application/ld+json"]').innerText());
      expect(data["@graph"][1].mainEntity).toMatchObject({ "@type": ["CreativeWork", "LearningResource"], inLanguage: ["en"], isAccessibleForFree: true });
    }
  }
  await context.close();
});

for (const exam of exams) test(`${exam.name}: grading, explanation, bookmark, resume and direct question work`, async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", error => errors.push(error.message));
  const questions = authoredQuestions(exam.id, "en"), question = questions[20];
  const original = content.groups.filter(group => group.examIds.includes(exam.id)).flatMap(group => group.questions);
  const path = `/en/${exam.slug}`;
  await page.goto(`${path}?verNbr=202610&page=2`);
  await expect(page.locator(".question-prompt")).toHaveText(original[20].prompt);
  await page.locator(".bookmark-button").click();
  await page.locator(`input[value="${question.choices.find(choice => !choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "Check answer", exact: true }).click();
  await expect(page.locator(".answer-feedback")).toContainText("Incorrect");
  await expect(page.locator(".explanation-region .learning-content").first()).toHaveText(original[20].explanation);
  await expect(page.locator(".explanation-region a").first()).toHaveAttribute("href", /https:\/\//);
  await page.reload();
  await expect(page.locator(".answer-feedback")).toContainText("Incorrect");
  await expect(page.locator(".bookmark-button")).toHaveAttribute("aria-pressed", "true");
  await page.getByRole("button", { name: "Next", exact: true }).click();
  const next = questions[21];
  await expect(page.locator(".question-prompt")).toHaveText(original[21].prompt);
  await page.locator(`input[value="${next.choices.find(choice => choice.correct)!.id}"]`).check();
  await page.getByRole("button", { name: "Check answer", exact: true }).click();
  await expect(page.getByText("Correct.", { exact: true })).toBeVisible();
  const last = questions.at(-1)!;
  await page.goto(`${path}?questId=${last.id}&verNbr=202610`);
  await expect(page.locator(".question-prompt")).toHaveText(original.at(-1)!.prompt);
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
  expect(errors).toEqual([]);
});
