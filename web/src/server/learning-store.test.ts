import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";
import { authoredCatalog, authoredDefaultLocale, authoredQuestions, authoredQuestionId, findAuthoredQuestion } from "@/lib/authored-practice";
import { grade } from "@/lib/quiz";
import { emptyProgress, readProgress } from "@/lib/progress";
import { findRoute } from "@/lib/contracts";
import { examCategory, matchesExam } from "@/lib/exam-catalog";
import { publicSitemap, seoAlternates } from "@/lib/seo";

function archive(count: number) {
  const questions = Array.from({ length: count }, (_, i) => ({ question_id: String(1000 + i), version_id: "10", number: i + 1, body: "Existing question", explanation: null, reference: null, multiple_answers: false }));
  return coreStudyStore({ schema: 1, tables: {
    exams: [{ exam_id: "5", name_ko: "SQLD", name_en: null, legacy_slug: "sqlp-developer", priority: 1 }],
    versions: [{ version_id: "10", exam_id: "5", number: 1, name: "Archive" }], questions,
    choices: questions.map((q, i) => ({ choice_id: String(2000 + i), question_id: q.question_id, number: 1, body: "Existing answer", correct: true })), legacy_counters: [],
  }, pendingExplanationCounts: {} }, "unchanged-archive");
}

it("covers all 190 catalog exams with 1563 distinct, answerable, attributed original questions", () => {
  expect(authoredCatalog).toHaveLength(190);
  const ids = new Set<string>(); const choiceIds = new Set<string>();
  for (const exam of authoredCatalog) {
    const locale = authoredDefaultLocale(exam.id);
    expect(findRoute((locale === "en" ? "/en/" : "/") + exam.slug)?.testId).toBe(exam.id);
    const questions = authoredQuestions(exam.id, locale);
    expect(questions).toHaveLength(exam.questionCount ?? 3);
    for (const q of questions) {
      expect(q).toMatchObject({ version: 202610, versionName: "2026-10", authored: true });
      expect(q.text.length).toBeLessThan(2000); expect(q.explanation).toBeTruthy(); expect(q.reference).toContain('href="https://');
      expect(q.choices).toHaveLength(4); expect(new Set(q.choices.map(c => c.text)).size).toBe(4);
      expect(q.choices.filter(c => c.correct)).toHaveLength(1);
      expect(grade(q, q.choices.filter(c => c.correct).map(c => c.id))).toBe(true);
      expect(grade(q, q.choices.filter(c => !c.correct).map(c => c.id))).toBe(false);
      expect(findAuthoredQuestion(q.id)?.testId).toBe(exam.id);
      expect(ids.has(q.id)).toBe(false); ids.add(q.id);
      for (const choice of q.choices) { expect(choiceIds.has(choice.id)).toBe(false); choiceIds.add(choice.id); }
    }
  }
  expect(ids.size).toBe(1563); expect(choiceIds.size).toBe(6252);
  expect(findAuthoredQuestion("8000099999")).toBeUndefined();
});

it("keeps existing authored question and choice identities stable while larger sets use a separate namespace", () => {
  for (const exam of authoredCatalog.filter(exam => exam.idBlockSize !== 1000)) {
    for (const [index, q] of authoredQuestions(exam.id, authoredDefaultLocale(exam.id)).entries()) {
      expect(q.id).toBe(String(8_000_000_000 + Number(exam.id) * 100 + index + 1));
      expect(q.choices.find(choice => choice.correct)?.id).toBe(String(9_000_000_000 + Number(exam.id) * 1000 + index * 10));
    }
  }
  for (const [index, id] of [[0, "8200236001"], [98, "8200236099"], [99, "8200236100"], [100, "8200236101"], [149, "8200236150"]] as const) {
    expect(authoredQuestionId("236", index)).toBe(id);
    expect(findAuthoredQuestion(id)).toMatchObject({ id, testId: "236", questionNumber: index + 1, locale: "en" });
  }
  for (const id of ["8200236000", "8200236151", "8200237000", "8200237131", "8200238001", "8000023601", "8200234001"]) expect(findAuthoredQuestion(id)).toBeUndefined();
});

it("offers 130 English Texas insurance questions across seven pages with stable IDs and SEO discovery", () => {
  const store = new LearningStore(archive(0));
  const path = "/en/texas-life-and-health-insurance";
  const route = findRoute(path)!;
  expect(route).toMatchObject({ testId: "237", locale: "en" });
  expect(route.description).toContain("130 original English practice questions");
  expect(findRoute("/texas-life-and-health-insurance")).toBeUndefined();
  expect(examCategory(route)).toBe("service");
  expect(matchesExam(route, "Texas life health insurance")).toBe(true);
  expect(store.exams.find(exam => exam.id === "237")).toMatchObject({ nameKo: null, nameEn: "Texas Life and Health Insurance Practice Questions" });
  expect(store.defaultLocale("237")).toBe("en");
  expect(store.versions("237", "en")).toEqual([{ id: "8100000237", number: 202610, name: "2026-10" }]);
  expect(store.versions("237", "ko")).toEqual([]);
  expect(store.questions("237", "ko", 202610)).toEqual([]);
  expect(store.pagination("237", "en", 202610)).toEqual({ page: 1, total: 130, pages: 7 });
  const batches = Array.from({ length: 7 }, (_, i) => store.questions("237", "en", 202610, undefined, i + 1));
  expect(batches.map(batch => batch.length)).toEqual([20, 20, 20, 20, 20, 20, 10]);
  const questions = batches.flat();
  expect(questions.map(q => q.questionNumber)).toEqual(Array.from({ length: 130 }, (_, i) => i + 1));
  expect(new Set(questions.map(q => q.id)).size).toBe(130);
  expect(new Set(questions.map(q => q.text)).size).toBe(130);
  for (const index of [0, 98, 99, 100, 129]) {
    expect(questions[index].id).toBe(String(8_200_237_001 + index));
    expect(findAuthoredQuestion(questions[index].id)).toMatchObject({ testId: "237", questionNumber: index + 1, locale: "en" });
    expect(findAuthoredQuestion(questions[index].id, "ko")).toBeUndefined();
  }
  expect(store.questions("237", "en", 0, undefined, 7)).toEqual(batches[6]);
  expect(store.questions("237", "en", 202610, undefined, 8)).toEqual([]);
  expect(store.questions("237", "en", 202610, questions[129].id)).toEqual([questions[129]]);
  expect(store.hasQuestion(questions[129].id)).toBe(true);
  expect(store.questions("236", "en", 202610, questions[129].id)).toEqual([]);
  expect(store.questions("237", "en", 1, questions[129].id)).toEqual([]);
  for (const q of questions) expect(q.text + q.explanation + q.reference + q.choices.map(c => c.text).join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
  const origin = "https://example.test";
  expect(publicSitemap(origin).some(entry => entry.url === origin + path)).toBe(true);
  expect(seoAlternates(path, new URLSearchParams("verNbr=202610&page=7"), origin)).toMatchObject({
    canonical: origin + path + "?verNbr=202610&page=7",
    languages: { en: origin + path + "?verNbr=202610&page=7" },
  });
});

it("offers all 150 English California questions across eight pages with discovery and SEO metadata", () => {
  const store = new LearningStore(archive(0));
  const path = "/en/california-real-estate-salesperson";
  const route = findRoute(path)!;
  expect(route).toMatchObject({ testId: "236", locale: "en" });
  expect(findRoute("/california-real-estate-salesperson")).toBeUndefined();
  expect(examCategory(route)).toBe("service");
  expect(matchesExam(route, "California real estate salesperson")).toBe(true);
  expect(store.exams.find(exam => exam.id === "236")).toMatchObject({ nameKo: null, nameEn: "California Real Estate Salesperson Practice Questions" });
  expect(store.defaultLocale("236")).toBe("en");
  expect(store.versions("236", "en")).toEqual([{ id: "8100000236", number: 202610, name: "2026-10" }]);
  expect(store.versions("236", "ko")).toEqual([]);
  expect(store.questions("236", "ko", 202610)).toEqual([]);
  expect(store.pagination("236", "en", 202610)).toEqual({ page: 1, total: 150, pages: 8 });
  const batches = Array.from({ length: 8 }, (_, i) => store.questions("236", "en", 202610, undefined, i + 1));
  expect(batches.map(batch => batch.length)).toEqual([20, 20, 20, 20, 20, 20, 20, 10]);
  const questions = batches.flat();
  expect(questions.map(q => q.questionNumber)).toEqual(Array.from({ length: 150 }, (_, i) => i + 1));
  expect(new Set(questions.map(q => q.id)).size).toBe(150);
  expect(new Set(questions.map(q => q.text)).size).toBe(150);
  expect(store.questions("236", "en", 0, undefined, 8)).toEqual(batches[7]);
  expect(store.questions("236", "en", 202610, undefined, 9)).toEqual([]);
  expect(store.questions("236", "en", 202610, questions[149].id)).toEqual([questions[149]]);
  expect(store.hasQuestion(questions[149].id)).toBe(true);
  expect(findAuthoredQuestion(questions[149].id, "ko")).toBeUndefined();
  expect(store.questions("235", "en", 202610, questions[149].id)).toEqual([]);
  expect(store.questions("236", "en", 1, questions[149].id)).toEqual([]);
  for (const q of questions) expect(q.text + q.explanation + q.reference + q.choices.map(c => c.text).join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
  const origin = "https://example.test";
  expect(publicSitemap(origin).some(entry => entry.url === origin + path)).toBe(true);
  expect(seoAlternates(path, new URLSearchParams("verNbr=202610&page=8"), origin)).toMatchObject({
    canonical: origin + path + "?verNbr=202610&page=8",
    languages: { en: origin + path + "?verNbr=202610&page=8" },
  });
});

it("offers the English-only Food Handler set through discovery, both pages, and direct identities", () => {
  const store = new LearningStore(archive(0));
  expect(findRoute("/en/servsafe-food-handler")).toMatchObject({ testId: "234", locale: "en" });
  expect(findRoute("/servsafe-food-handler")).toBeUndefined();
  expect(store.exams.find(exam => exam.id === "234")).toMatchObject({ nameKo: null, nameEn: "ServSafe Food Handler Practice Questions" });
  expect(store.defaultLocale("234")).toBe("en");
  expect(store.versions("234", "en")).toEqual([{ id: "8100000234", number: 202610, name: "2026-10" }]);
  expect(store.versions("234", "ko")).toEqual([]);
  expect(store.questions("234", "ko", 202610)).toEqual([]);
  expect(store.pagination("234", "en", 202610)).toEqual({ page: 1, total: 40, pages: 2 });
  const first = store.questions("234", "en", 202610);
  const second = store.questions("234", "en", 202610, undefined, 2);
  expect(first).toHaveLength(20); expect(second).toHaveLength(20);
  expect([...first, ...second].map(q => q.questionNumber)).toEqual(Array.from({ length: 40 }, (_, i) => i + 1));
  expect(new Set([...first, ...second].map(q => q.id)).size).toBe(40);
  expect(store.questions("234", "en", 0, undefined, 2)).toEqual(second);
  expect(store.questions("234", "en", 202610, undefined, 3)).toEqual([]);
  expect(store.questions("234", "en", 202610, second[19].id)).toEqual([second[19]]);
  expect(store.hasQuestion(second[19].id)).toBe(true);
  expect(findAuthoredQuestion(second[19].id)?.locale).toBe("en");
  expect(findAuthoredQuestion(second[19].id, "ko")).toBeUndefined();
  expect(store.questions("234", "en", 1, second[19].id)).toEqual([]);
  for (const q of [...first, ...second]) expect(q.text + q.explanation + q.reference + q.choices.map(c => c.text).join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
});

it("keeps all 90 English Manager questions distinct from Food Handler and reachable across five pages", () => {
  const store = new LearningStore(archive(0));
  expect(findRoute("/en/servsafe-food-protection-manager")).toMatchObject({ testId: "235", locale: "en" });
  expect(findRoute("/servsafe-food-protection-manager")).toBeUndefined();
  expect(store.exams.find(exam => exam.id === "235")).toMatchObject({ nameKo: null, nameEn: "ServSafe Food Protection Manager Practice Questions" });
  expect(store.defaultLocale("235")).toBe("en");
  expect(store.versions("235", "en")).toEqual([{ id: "8100000235", number: 202610, name: "2026-10" }]);
  expect(store.versions("235", "ko")).toEqual([]);
  expect(store.questions("235", "ko", 202610)).toEqual([]);
  expect(store.pagination("235", "en", 202610)).toEqual({ page: 1, total: 90, pages: 5 });
  const batches = Array.from({ length: 5 }, (_, i) => store.questions("235", "en", 202610, undefined, i + 1));
  expect(batches.map(batch => batch.length)).toEqual([20, 20, 20, 20, 10]);
  const questions = batches.flat();
  expect(questions.map(q => q.questionNumber)).toEqual(Array.from({ length: 90 }, (_, i) => i + 1));
  expect(new Set(questions.map(q => q.id)).size).toBe(90);
  expect(new Set(questions.map(q => q.text)).size).toBe(90);
  expect(store.questions("235", "en", 0, undefined, 5)).toEqual(batches[4]);
  expect(store.questions("235", "en", 202610, undefined, 6)).toEqual([]);
  expect(store.questions("235", "en", 202610, questions[89].id)).toEqual([questions[89]]);
  expect(store.hasQuestion(questions[89].id)).toBe(true);
  expect(findAuthoredQuestion(questions[89].id)?.locale).toBe("en");
  expect(findAuthoredQuestion(questions[89].id, "ko")).toBeUndefined();
  expect(store.questions("234", "en", 202610, questions[89].id)).toEqual([]);
  expect(store.questions("235", "en", 1, questions[89].id)).toEqual([]);
  const handlerPrompts = new Set(authoredQuestions("234", "en").map(q => q.text));
  for (const q of questions) {
    expect(handlerPrompts.has(q.text)).toBe(false);
    expect(q.text + q.explanation + q.reference + q.choices.map(c => c.text).join(" ")).not.toMatch(/[\u3131-\u318e\uac00-\ud7a3]/);
  }
});

it.each([0, 1, 17, 18, 19, 20, 21, 37, 38, 39, 40, 41])("appends originals to %i archived questions without gaps or pagination overlap", count => {
  const store = new LearningStore(archive(count));
  const { total, pages } = store.pagination("5", "ko");
  expect(total).toBe(count + authoredQuestions("5", "ko").length);
  const ids: string[] = [];
  for (let page = 1; page <= pages; page++) {
    const batch = store.questions("5", "ko", 0, undefined, page);
    expect(batch.length).toBeLessThanOrEqual(20); ids.push(...batch.map(q => q.id));
  }
  expect(ids).toEqual([...Array.from({ length: count }, (_, i) => String(1000 + i)), ...authoredQuestions("5", "ko").map(q => q.id)]);
  expect(new Set(ids).size).toBe(total);
  expect(store.questions("5", "ko", 1).every(q => !q.authored)).toBe(true);
  expect(store.questions("5", "ko", 202610)).toHaveLength(20);
  expect(store.questions("1", "ko", 0, authoredQuestionId("5", 0))).toEqual([]);
  expect(store.questions("5", "ko", 1, authoredQuestionId("5", 0))).toEqual([]);
  expect(store.questions("5", "ko", 202610, authoredQuestionId("5", 0))).toHaveLength(1);
});

it("preserves attempts, shuffled choice order and bookmarks when new questions are appended", () => {
  const progress = emptyProgress(["1000", "1001"], "archive-v1");
  progress.attempts["1000"] = { selected: ["2000"], correct: true };
  progress.bookmarks = ["1001"]; progress.choiceOrders["1000"] = ["2000"]; progress.index = 1;
  const next = readProgress(JSON.stringify(progress), ["1000", "1001", "8000000501"], "archive-v1");
  expect(next).toMatchObject({ ...progress, ids: ["1000", "1001", "8000000501"] });
  expect(readProgress(JSON.stringify(progress), ["1001", "1000", "new"], "archive-v1")).toBeNull();
  expect(readProgress(JSON.stringify(progress), ["1000", "1001"], "different-archive")).toBeNull();
});
