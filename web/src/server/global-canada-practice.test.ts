import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import content from "@/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredQuestions, authoredDefaultLocale, findAuthoredQuestion } from "@/lib/authored-practice";
import { findRoute, legacy } from "@/lib/contracts";
import { examCategory, matchesExam } from "@/lib/exam-catalog";
import { publicSitemap } from "@/lib/seo";
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";

const ids = ["181", "238", "239", "168", "240", "241", "242"];
function store() {
  return new LearningStore(coreStudyStore({ schema: 1, tables: {
    exams: [
      { exam_id: "181", name_ko: "Existing Core 1", name_en: "Existing Core 1", legacy_slug: "comptia-220-1001", priority: 1 },
      { exam_id: "168", name_ko: "Existing Security+", name_en: "Existing Security+", legacy_slug: "comptia-sy0-501", priority: 2 },
    ], versions: [], questions: [], choices: [], legacy_counters: [],
  }, pendingExplanationCounts: {} }, "synthetic-hosted-metadata", "supabase"));
}

it("adds exactly 210 distinct English questions and preserves the six existing CompTIA items and identities", () => {
  const oldSets = content.groups.filter(group => ["pc", "security"].includes(group.topic));
  for (const id of ["181", "168"]) {
    const original = oldSets.find(group => group.examIds.includes(id))!;
    const questions = authoredQuestions(id, "en");
    expect(questions).toHaveLength(id === "168" ? 53 : 33);
    for (const [index, item] of original.questions.entries()) {
      expect(questions[index].text).toContain(item.prompt);
      expect(questions[index].id).toBe(String(8_000_000_000 + Number(id) * 100 + index + 1));
      expect(questions[index].reference).toContain(original.source);
    }
  }
  const newItems = ids.flatMap(id => authoredQuestions(id, "en").slice(["181", "168"].includes(id) ? 3 : 0, ["181", "168"].includes(id) ? 33 : 30));
  expect(newItems).toHaveLength(210);
  expect(new Set(newItems.map(item => item.text)).size).toBe(210);
  for (const item of newItems) {
    expect(item.text + item.explanation + item.choices.map(choice => choice.text).join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
    expect(item.choices.filter(choice => choice.correct)).toHaveLength(1);
    expect(item.explanation!.length).toBeGreaterThan(60);
  }
});

it("shares global exams across both catalogs without duplicate routes and keeps Canadian exams English-only", () => {
  const learning = store();
  const sitemap = new Set(publicSitemap("https://example.test").map(entry => entry.url));
  for (const id of ids) {
    const exam = authoredCatalog.find(exam => exam.id === id)!;
    const english = findRoute(`/en/${exam.slug}`)!;
    expect(english).toMatchObject({ testId: id, locale: "en" });
    expect(matchesExam(english, exam.name)).toBe(true);
    expect(examCategory(english)).toBe(["240", "241", "242"].includes(id) ? "service" : "it");
    expect(sitemap.has(`https://example.test/en/${exam.slug}`)).toBe(true);
    expect(authoredDefaultLocale(id)).toBe("en");
    expect(learning.defaultLocale(id)).toBe("en");
    expect(learning.exams.filter(exam => exam.id === id)).toHaveLength(1);
    expect(learning.exams.find(exam => exam.id === id)?.nameEn).toBeTruthy();
    if (exam.locale === "all") {
      expect(findRoute(`/${exam.slug}`)).toMatchObject({ testId: id, locale: "ko" });
      expect(sitemap.has(`https://example.test/${exam.slug}`)).toBe(true);
      expect(learning.exams.find(exam => exam.id === id)?.nameKo).toBeTruthy();
      expect(authoredQuestions(id, "ko").map(item => item.id)).toEqual(authoredQuestions(id, "en").map(item => item.id));
    } else {
      expect(findRoute(`/${exam.slug}`)).toBeUndefined();
      expect(learning.exams.find(exam => exam.id === id)?.nameKo).toBeNull();
      expect(learning.versions(id, "ko")).toEqual([]);
      expect(learning.questions(id, "ko", 202610)).toEqual([]);
    }
  }
  expect(new Set(legacy.routes.map(route => route.path)).size).toBe(legacy.routes.length);
});

it("serves every 2026-10 question across all pages, direct links, and correct exam boundaries", () => {
  const learning = store();
  for (const id of ids) {
    const questions = authoredQuestions(id, "en");
    expect(learning.versions(id, "en")).toEqual([{ id: String(8_100_000_000 + Number(id)), number: 202610, name: "2026-10" }]);
    const pages = Math.ceil(questions.length / 20);
    expect(learning.pagination(id, "en", 202610)).toEqual({ page: 1, total: questions.length, pages });
    expect(Array.from({ length: pages }, (_, index) => learning.questions(id, "en", 202610, undefined, index + 1)).flat()).toEqual(questions);
    expect(learning.questions(id, "en", 202610, undefined, pages + 1)).toEqual([]);
    const last = questions.at(-1)!;
    expect(learning.questions(id, "en", 202610, last.id)).toEqual([last]);
    expect(findAuthoredQuestion(last.id)).toMatchObject({ testId: id, locale: "en" });
    expect(learning.questions(id, "en", 1, last.id)).toEqual([]);
    expect(learning.questions(id === "242" ? "241" : "242", "en", 202610, last.id)).toEqual([]);
  }
});
