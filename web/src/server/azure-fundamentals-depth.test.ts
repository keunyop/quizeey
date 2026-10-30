import { createHash } from "node:crypto";
import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import manifest from "../../content/azure-fundamentals-depth-2026-10.manifest.json" with { type: "json" };
import popularExpansion from "../../content/popular-2026-10-28.manifest.json" with { type: "json" };
import content from "@/data/practice-2026-10.json" with { type: "json" };
import { authoredCatalog, authoredDefaultLocale, authoredQuestions, findAuthoredQuestion } from "@/lib/authored-practice";
import { findRoute } from "@/lib/contracts";
import { grade } from "@/lib/quiz";
import { pageStructuredData, publicSitemap, searchMetadata } from "@/lib/seo";
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";

const questions = authoredQuestions(manifest.examId, "en");
const hash = (value: unknown) => createHash("sha256").update(JSON.stringify(value)).digest("hex");

it("preserves all prior content, Azure identities and other catalog entries while appending seventy English scenarios", () => {
  expect(hash(content.groups.slice(0, manifest.previousGroups.count))).toBe(manifest.previousGroups.sha256);
  const entry = authoredCatalog.find(exam => exam.id === manifest.examId)!;
  // Restore later catalog expansions when checking the historical Azure snapshot.
  const previousCatalog = authoredCatalog.slice(0, manifest.previousCatalog.count)
    .map(exam => popularExpansion.exams.find(item => item.examId === exam.id)?.previousCatalogEntry ?? exam)
    .map(exam => exam.id === manifest.examId ? manifest.previousCatalogEntry :
    exam.id === "14" ? { ...exam, questionCount: 23 } : exam);
  expect(previousCatalog).toHaveLength(manifest.previousCatalog.count);
  expect(hash(previousCatalog)).toBe(manifest.previousCatalog.sha256);
  const { practiceScope, ...sameEntry } = entry;
  expect({ ...sameEntry, questionCount: manifest.previousQuestionCount }).toEqual(manifest.previousCatalogEntry);
  expect(practiceScope).toContain("Original English AZ-900");
  expect(entry.questionCount).toBe(93);
  expect(questions).toHaveLength(93);

  const raw = content.groups.filter(group => group.examIds.includes(manifest.examId)).flatMap(group => group.questions);
  expect(hash(raw.slice(0, manifest.previousQuestionCount))).toBe(manifest.previousQuestionsSha256);
  for (const [index, question] of questions.entries()) {
    expect(question.id).toBe(String(8_000_017_001 + index));
    expect(question.choices.map(choice => choice.id).sort()).toEqual(
      Array.from({ length: 4 }, (_, choice) => String(9_000_170_000 + index * 10 + choice)).sort());
  }
  const groups = content.groups.slice(manifest.previousGroups.count, manifest.previousGroups.count + manifest.topics.length);
  expect(groups.map(group => group.topic)).toEqual(manifest.topics.map(topic => topic.key));
  expect(groups.map(group => group.questions.length)).toEqual([23, 22, 25]);
  const oldPrompts = new Set(content.groups.slice(0, manifest.previousGroups.count).flatMap(group => group.questions.map(item => item.prompt)));
  const newPrompts = new Set<string>();
  for (const group of groups) {
    expect(group.examIds).toEqual(["170"]);
    for (const item of group.questions) {
      expect(oldPrompts.has(item.prompt)).toBe(false);
      expect(newPrompts.has(item.prompt)).toBe(false);
      newPrompts.add(item.prompt);
      expect(item.prompt + item.explanation + item.choices.join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
      expect(item.explanation.length).toBeGreaterThan(120);
      expect(new Set(item.choices).size).toBe(4);
      expect("source" in item && item.source).toMatch(/^https:\/\/learn\.microsoft\.com\/en-us\//);
    }
  }
  expect(newPrompts.size).toBe(manifest.addedQuestionCount);
  const allIds = authoredCatalog.flatMap(exam => authoredQuestions(exam.id, authoredDefaultLocale(exam.id)).map(question => question.id));
  expect(new Set(allIds).size).toBe(allIds.length);
});

it("serves every expanded page and direct question through the hosted overlay with correct exam boundaries and search identity", () => {
  const learning = new LearningStore(coreStudyStore({ schema: 1, tables: {
    exams: [], versions: [], questions: [], choices: [], legacy_counters: [],
  }, pendingExplanationCounts: {} }, "synthetic-hosted-metadata", "supabase"));
  expect(learning.pagination("170", "en", 202610)).toEqual({ page: 1, total: 93, pages: 5 });
  expect([1, 2, 3, 4, 5].flatMap(page => learning.questions("170", "en", 202610, undefined, page))).toEqual(questions);
  expect(learning.questions("170", "en", 202610, undefined, 6)).toEqual([]);
  for (const question of questions.slice(manifest.previousQuestionCount)) {
    expect(question).toMatchObject({ contentLocale: "en", version: 202610, authored: true });
    expect(learning.questions("170", "en", 202610, question.id)).toEqual([question]);
    expect(learning.questions("169", "en", 202610, question.id)).toEqual([]);
    expect(learning.questions("170", "en", 1, question.id)).toEqual([]);
    expect(findAuthoredQuestion(question.id, "en")).toEqual(question);
    expect(question.choices.filter(choice => choice.correct)).toHaveLength(1);
    expect(grade(question, [question.choices.find(choice => choice.correct)!.id])).toBe(true);
    expect(grade(question, [question.choices.find(choice => !choice.correct)!.id])).toBe(false);
  }
  const origin = "https://example.test", path = "/en/az-900", route = findRoute(path)!;
  const urls = new Set(publicSitemap(origin).map(entry => entry.url));
  for (const page of [1, 2, 3, 4, 5]) {
    const query = new URLSearchParams(`verNbr=202610${page > 1 ? `&page=${page}` : ""}`);
    expect(urls.has(`${origin}${path}?${query}`)).toBe(true);
    const metadata = searchMetadata(path, query, route, origin, true);
    expect(metadata.description).toContain("93 practice questions");
    expect(metadata.robots).toEqual({ index: true, follow: true });
    expect(searchMetadata(path, query, route, origin, false).robots).toEqual({ index: false, follow: false });
    expect(pageStructuredData(path, query, route, origin)["@graph"][1]).toMatchObject({
      mainEntity: { inLanguage: ["en"], isAccessibleForFree: true },
    });
  }
  expect(urls.has(`${origin}${path}?verNbr=202610&page=6`)).toBe(false);
  expect(searchMetadata(path, new URLSearchParams(`questId=${questions.at(-1)!.id}&verNbr=202610`), route, origin, true).robots)
    .toEqual({ index: false, follow: true });
});
