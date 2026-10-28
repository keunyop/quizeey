import { createHash } from "node:crypto";
import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import manifest from "../../content/popular-2026-10-28.manifest.json" with { type: "json" };
import content from "@/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredDefaultLocale, authoredQuestions, findAuthoredQuestion } from "@/lib/authored-practice";
import type { Locale } from "@/lib/contracts";
import { grade } from "@/lib/quiz";
import { publicSitemap } from "@/lib/seo";
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";

const hash = (value: unknown) => createHash("sha256").update(JSON.stringify(value)).digest("hex");

it("preserves every old group and identity while adding exactly 100 Korean and 60 English explained questions", () => {
  expect(hash(content.groups.slice(0, manifest.previousGroups.count))).toBe(manifest.previousGroups.sha256);
  const restored = authoredCatalog.map(exam => manifest.exams.find(item => item.examId === exam.id)?.previousCatalogEntry ?? exam);
  expect(hash(restored)).toBe(manifest.previousCatalog.sha256);
  expect(authoredCatalog).toHaveLength(manifest.previousCatalog.count);
  const oldPrompts = new Set(content.groups.slice(0, manifest.previousGroups.count).flatMap(group => group.questions.map(question => question.prompt)));
  const newGroups = content.groups.slice(manifest.previousGroups.count);
  expect(newGroups).toHaveLength(8);
  const newPrompts = newGroups.flatMap(group => group.questions.map(question => question.prompt));
  expect(newPrompts).toHaveLength(manifest.addedQuestionCount);
  expect(new Set(newPrompts).size).toBe(manifest.addedQuestionCount);
  for (const prompt of newPrompts) expect(oldPrompts.has(prompt)).toBe(false);
  const addedByLocale = { ko: 0, en: 0 };
  for (const entry of manifest.exams) {
    const locale = entry.locale as Locale;
    const raw = content.groups.filter(group => group.examIds.includes(entry.examId)).flatMap(group => group.questions);
    expect(hash(raw.slice(0, entry.previousQuestionCount))).toBe(entry.previousQuestionsSha256);
    expect(raw).toHaveLength(entry.questionCount);
    const questions = authoredQuestions(entry.examId, locale);
    expect(questions).toHaveLength(entry.questionCount);
    for (const question of questions.slice(entry.previousQuestionCount)) {
      addedByLocale[locale]++;
      expect(question).toMatchObject({ version: 202610, versionName: "2026-10", contentLocale: locale });
      expect(question.reference).toContain('href="https://');
      expect(question.explanation!.replace(/<[^>]*>/g, "").length).toBeGreaterThan(35);
      expect(question.choices.filter(choice => choice.correct)).toHaveLength(1);
      expect(grade(question, [question.choices.find(choice => choice.correct)!.id])).toBe(true);
      expect(grade(question, [question.choices.find(choice => !choice.correct)!.id])).toBe(false);
      expect(findAuthoredQuestion(question.id, locale)).toEqual(question);
    }
  }
  expect(addedByLocale).toEqual({ ko: manifest.koreanQuestions, en: manifest.englishQuestions });
  const allQuestions = authoredCatalog.flatMap(exam => authoredQuestions(exam.id, authoredDefaultLocale(exam.id)));
  expect(new Set(allQuestions.map(question => question.id)).size).toBe(manifest.previousQuestionCount + manifest.addedQuestionCount);
  expect(new Set(allQuestions.flatMap(question => question.choices.map(choice => choice.id))).size).toBe(allQuestions.length * 4);
});

it("serves expanded pagination and direct questions through the hosted overlay without crossing exam boundaries", () => {
  const store = new LearningStore(coreStudyStore({ schema: 1, tables: {
    exams: [], versions: [], questions: [], choices: [], legacy_counters: [],
  }, pendingExplanationCounts: {} }, "synthetic-hosted-metadata", "supabase"));
  const sitemap = new Set(publicSitemap("https://example.test").map(entry => entry.url));
  for (const entry of manifest.exams) {
    const locale = entry.locale as Locale;
    const exam = authoredCatalog.find(exam => exam.id === entry.examId)!;
    const questions = authoredQuestions(exam.id, locale);
    const pages = Math.ceil(entry.questionCount / 20);
    expect(store.pagination(exam.id, locale, 202610)).toEqual({ page: 1, total: entry.questionCount, pages });
    expect(Array.from({ length: pages }, (_, index) => store.questions(exam.id, locale, 202610, undefined, index + 1)).flat()).toEqual(questions);
    expect(store.questions(exam.id, locale, 202610, undefined, pages + 1)).toEqual([]);
    for (const question of questions.slice(entry.previousQuestionCount)) {
      expect(store.questions(exam.id, locale, 202610, question.id)).toEqual([question]);
      expect(store.questions(exam.id === "14" ? "5" : "14", locale, 202610, question.id)).toEqual([]);
      expect(store.questions(exam.id, locale, 1, question.id)).toEqual([]);
    }
    for (let page = 1; page <= pages; page++) {
      expect(sitemap.has(`https://example.test${locale === "en" ? "/en" : ""}/${exam.slug}?verNbr=202610${page > 1 ? `&page=${page}` : ""}`)).toBe(true);
    }
  }
});
