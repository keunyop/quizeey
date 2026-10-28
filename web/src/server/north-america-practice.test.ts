import { createHash } from "node:crypto";
import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import manifest from "../../content/north-america-2026-10.manifest.json" with { type: "json" };
import azureExpansion from "../../content/azure-fundamentals-depth-2026-10.manifest.json" with { type: "json" };
import popularExpansion from "../../content/popular-2026-10-28.manifest.json" with { type: "json" };
import content from "@/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredDefaultLocale, authoredQuestions, findAuthoredQuestion } from "@/lib/authored-practice";
import { findRoute, legacy } from "@/lib/contracts";
import { examCategory, matchesExam } from "@/lib/exam-catalog";
import { grade } from "@/lib/quiz";
import { publicSitemap, searchMetadata, pageStructuredData } from "@/lib/seo";
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";

const exams = authoredCatalog.filter(exam => manifest.examIds.includes(exam.id));
const learning = new LearningStore(coreStudyStore({ schema: 1, tables: {
  exams: [], versions: [], questions: [], choices: [], legacy_counters: [],
}, pendingExplanationCounts: {} }, "synthetic-hosted-metadata", "supabase"));

it("appends 300 explained English questions without changing earlier content or catalog entries", () => {
  expect(exams).toHaveLength(10);
  const hash = (value: unknown) => createHash("sha256").update(JSON.stringify(value)).digest("hex");
  expect(hash(content.groups.slice(0, manifest.previousGroups.count))).toBe(manifest.previousGroups.sha256);
  // Restore later expansions when checking this earlier release's catalog baseline.
  const previousCatalog = authoredCatalog.slice(0, manifest.previousCatalog.count)
    .map(exam => popularExpansion.exams.find(item => item.examId === exam.id)?.previousCatalogEntry ?? exam)
    .map(exam => exam.id === azureExpansion.examId ? azureExpansion.previousCatalogEntry :
      exam.id === "14" ? { ...exam, questionCount: 23 } : exam);
  expect(hash(previousCatalog)).toBe(manifest.previousCatalog.sha256);
  const oldPrompts = new Set(content.groups.slice(0, manifest.previousGroups.count).flatMap(group => group.questions.map(item => item.prompt)));
  const newGroups = content.groups.slice(manifest.previousGroups.count, manifest.previousGroups.count + manifest.examIds.length);
  expect(newGroups).toHaveLength(10);
  const items = newGroups.flatMap(group => group.questions);
  expect(items).toHaveLength(300);
  expect(new Set(items.map(item => item.prompt)).size).toBe(300);
  for (const item of items) {
    expect(oldPrompts.has(item.prompt)).toBe(false);
    expect(item.prompt + item.explanation + item.choices.join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
    expect(item.explanation.length).toBeGreaterThan(60);
    expect(new Set(item.choices).size).toBe(4);
  }
  const oldIds = new Set(authoredCatalog.filter(exam => !manifest.examIds.includes(exam.id))
    .flatMap(exam => authoredQuestions(exam.id, authoredDefaultLocale(exam.id))).map(item => item.id));
  const questions = exams.flatMap(exam => authoredQuestions(exam.id, "en"));
  expect(new Set(questions.map(question => question.id)).size).toBe(300);
  expect(new Set(questions.flatMap(question => question.choices.map(choice => choice.id))).size).toBe(1200);
  for (const question of questions) {
    expect(oldIds.has(question.id)).toBe(false);
    expect(question).toMatchObject({ authored: true, locale: "en", contentLocale: "en", version: 202610, versionName: "2026-10" });
    expect(question.choices.filter(choice => choice.correct)).toHaveLength(1);
    expect(grade(question, [question.choices.find(choice => choice.correct)!.id])).toBe(true);
    expect(grade(question, [question.choices.find(choice => !choice.correct)!.id])).toBe(false);
    expect(question.reference).toContain('href="https://');
    expect(findAuthoredQuestion(question.id)).toEqual(question);
  }
});

it("serves both pages and direct IDs from the hosted-content overlay and keeps English-only identities", () => {
  for (const exam of exams) {
    const path = `/en/${exam.slug}`;
    const route = findRoute(path)!;
    expect(route).toMatchObject({ testId: exam.id, locale: "en", template: "authored-practice" });
    expect(findRoute(`/${exam.slug}`)).toBeUndefined();
    expect(learning.exams.filter(item => item.id === exam.id)).toHaveLength(1);
    expect(learning.exams.find(item => item.id === exam.id)?.nameKo).toBeNull();
    expect(learning.defaultLocale(exam.id)).toBe("en");
    expect(learning.versions(exam.id, "en")).toEqual([{ id: String(8_100_000_000 + Number(exam.id)), number: 202610, name: "2026-10" }]);
    expect(learning.versions(exam.id, "ko")).toEqual([]);
    expect(learning.questions(exam.id, "ko", 202610)).toEqual([]);
    const questions = authoredQuestions(exam.id, "en");
    expect(questions).toHaveLength(30);
    expect(learning.pagination(exam.id, "en", 202610)).toEqual({ page: 1, total: 30, pages: 2 });
    expect([1, 2].flatMap(page => learning.questions(exam.id, "en", 202610, undefined, page))).toEqual(questions);
    expect(learning.questions(exam.id, "en", 202610, undefined, 3)).toEqual([]);
    for (const question of questions) {
      expect(learning.questions(exam.id, "en", 202610, question.id)).toEqual([question]);
      expect(learning.questions(exam.id, "en", 1, question.id)).toEqual([]);
      expect(learning.questions(exam.id === "243" ? "244" : "243", "en", 202610, question.id)).toEqual([]);
    }
    expect(matchesExam(route, exam.name)).toBe(true);
    for (const alias of exam.searchTerms ?? []) expect(matchesExam(route, alias)).toBe(true);
    expect(examCategory(route)).toBe(Number(exam.id) <= 248 ? "academic" : exam.id === "252" ? "citizenship" : "driving");
  }
  expect(new Set(legacy.routes.map(route => route.path)).size).toBe(legacy.routes.length);
});

it("provides unique targeted search copy, canonical set pages, sitemap entries and learning-resource data", () => {
  const origin = "https://example.test";
  const sitemap = publicSitemap(origin);
  const urls = new Set(sitemap.map(entry => entry.url));
  const titles = new Set<string>();
  const descriptions = new Set<string>();
  for (const exam of exams) {
    const path = `/en/${exam.slug}`, route = findRoute(path)!;
    for (const suffix of ["", "?verNbr=202610", "?verNbr=202610&page=2"]) {
      const query = new URLSearchParams(suffix.replace(/^\?/, ""));
      query.set("utm_source", "test");
      const metadata = searchMetadata(path, query, route, origin, true);
      expect(metadata.robots).toEqual({ index: true, follow: true });
      expect(metadata.alternates).toMatchObject({ canonical: origin + path + suffix, languages: { en: origin + path + suffix, "en-US": origin + path + suffix, "en-CA": origin + path + suffix } });
      expect(urls.has(origin + path + suffix)).toBe(true);
      const title = (metadata.title as { absolute: string }).absolute;
      expect(title).toContain(exam.seoTitle);
      expect(titles.has(title)).toBe(false); titles.add(title);
      expect(metadata.description).toContain("30");
      expect(metadata.description).toContain("2026-10");
      expect(metadata.description).toContain("explanations");
      expect(descriptions.has(metadata.description!)).toBe(false); descriptions.add(metadata.description!);
      if (suffix) expect(pageStructuredData(path, query, route, origin)["@graph"][1]).toMatchObject({
        mainEntity: { "@type": ["CreativeWork", "LearningResource"], inLanguage: ["en"], isAccessibleForFree: true },
      });
      expect(searchMetadata(path, query, route, origin, false).robots).toEqual({ index: false, follow: false });
    }
    expect(urls.has(origin + path + "?verNbr=202610&page=3")).toBe(false);
  }
  expect(titles.size).toBe(30);
  expect(urls.size).toBe(sitemap.length);
});

it("uses the dated BC learner update instead of the superseded handbook age and distinguishes regional signals", () => {
  const bc = authoredQuestions("251", "en");
  const supervisor = bc.find(item => item.text.includes("minimum age"))!;
  expect(supervisor.text).toContain("October 19, 2026");
  expect(supervisor.choices.find(choice => choice.correct)?.text).toBe("22 years old");
  expect(supervisor.reference).toContain("you-have-a-class-7l-licence");
  expect(bc[0].choices.find(choice => choice.correct)?.text).toContain("pedestrian-controlled");
  expect(authoredQuestions("250", "en")[7].choices.find(choice => choice.correct)?.text).toContain("opposing traffic faces red");
});
