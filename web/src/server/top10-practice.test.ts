import { createHash } from "node:crypto";
import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import manifest from "../../content/top10-2026-10.manifest.json" with { type: "json" };
import content from "@/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredQuestions, authoredSetSummary, findAuthoredQuestion } from "@/lib/authored-practice";
import { findRoute, type Locale } from "@/lib/contracts";
import { grade } from "@/lib/quiz";
import { publicSitemap } from "@/lib/seo";
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";

it("adds 400 distinct localized questions to the ranked twenty exams while preserving every prior question payload", () => {
  expect(manifest.exams).toHaveLength(20);
  for (const locale of ["ko", "en"]) expect(manifest.exams.filter(exam => exam.locale === locale).map(exam => exam.rank)).toEqual([1,2,3,4,5,6,7,8,9,10]);
  const originalPrompts = new Set(content.groups.filter(group => !group.topic.startsWith("top10-")).flatMap(group => group.questions.map(question => question.prompt)));
  const prompts = new Set<string>();
  const learning = new LearningStore(coreStudyStore({ schema: 1, tables: { exams: [], versions: [], questions: [], choices: [], legacy_counters: [] }, pendingExplanationCounts: {} }, "fixture"));
  const sitemap = new Set(publicSitemap("https://quizeey.com").map(entry => entry.url));
  for (const exam of manifest.exams) {
    const locale = exam.locale as Locale;
    const entry = authoredCatalog.find(item => item.id === exam.examId)!;
    const path = `${locale === "en" ? "/en" : ""}/${entry.slug}`;
    expect(findRoute(path)?.testId).toBe(exam.examId);
    const raw = content.groups.filter(group => group.examIds.includes(exam.examId)).flatMap(group => group.questions);
    expect(createHash("sha256").update(JSON.stringify(raw.slice(0, exam.previousQuestionCount))).digest("hex")).toBe(exam.previousQuestionsSha256);
    const questions = authoredQuestions(exam.examId, locale);
    // Later expansions may append questions; this release still owns exactly its original twenty.
    expect(questions.length).toBeGreaterThanOrEqual(exam.previousQuestionCount + 20);
    expect(authoredSetSummary(exam.examId, locale)?.count).toBe(questions.length);
    for (const item of raw.slice(exam.previousQuestionCount, exam.previousQuestionCount + 20)) {
      expect(originalPrompts.has(item.prompt)).toBe(false);
      expect(prompts.has(item.prompt)).toBe(false); prompts.add(item.prompt);
      expect(/[\uac00-\ud7a3]/.test(item.prompt)).toBe(locale === "ko");
      expect(item.explanation.length).toBeGreaterThan(25);
    }
    for (const question of questions.slice(exam.previousQuestionCount)) {
      expect(question).toMatchObject({ version: 202610, versionName: "2026-10", contentLocale: locale });
      expect(question.reference).toContain('href="https://');
      expect(grade(question, question.choices.filter(choice => choice.correct).map(choice => choice.id))).toBe(true);
      expect(grade(question, [question.choices.find(choice => !choice.correct)!.id])).toBe(false);
      expect(findAuthoredQuestion(question.id, locale)).toEqual(question);
    }
    const pages = Math.ceil(questions.length / 20);
    expect(Array.from({ length: pages }, (_, page) => learning.questions(exam.examId, locale, 202610, undefined, page + 1)).flat()).toEqual(questions);
    for (let page = 1; page <= pages; page++) expect(sitemap.has(`https://quizeey.com${path}?verNbr=202610${page > 1 ? `&page=${page}` : ""}`)).toBe(true);
  }
  expect(prompts.size).toBe(manifest.addedQuestions);
});
