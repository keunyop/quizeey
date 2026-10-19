import { expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import { LearningStore } from "./learning-store";
import { coreStudyStore } from "./study-store";
import { authoredCatalog, authoredQuestions, authoredQuestionId, findAuthoredQuestion } from "@/lib/authored-practice";
import { grade } from "@/lib/quiz";
import { emptyProgress, readProgress } from "@/lib/progress";
import { findRoute } from "@/lib/contracts";

function archive(count: number) {
  const questions = Array.from({ length: count }, (_, i) => ({ question_id: String(1000 + i), version_id: "10", number: i + 1, body: "Existing question", explanation: null, reference: null, multiple_answers: false }));
  return coreStudyStore({ schema: 1, tables: {
    exams: [{ exam_id: "5", name_ko: "SQLD", name_en: null, legacy_slug: "sqlp-developer", priority: 1 }],
    versions: [{ version_id: "10", exam_id: "5", number: 1, name: "Archive" }], questions,
    choices: questions.map((q, i) => ({ choice_id: String(2000 + i), question_id: q.question_id, number: 1, body: "Existing answer", correct: true })), legacy_counters: [],
  }, pendingExplanationCounts: {} }, "unchanged-archive");
}

it("covers all 181 catalog exams with 543 distinct, answerable, attributed original questions", () => {
  expect(authoredCatalog).toHaveLength(181);
  const ids = new Set<string>(); const choiceIds = new Set<string>();
  for (const exam of authoredCatalog) {
    expect(findRoute("/" + exam.slug)?.testId).toBe(exam.id);
    const questions = authoredQuestions(exam.id, "ko");
    expect(questions).toHaveLength(3);
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
  expect(ids.size).toBe(543); expect(choiceIds.size).toBe(2172);
  expect(findAuthoredQuestion("8000099999")).toBeUndefined();
});

it.each([0, 1, 17, 18, 19, 20, 21, 37, 38, 39, 40, 41])("appends originals to %i archived questions without gaps or pagination overlap", count => {
  const store = new LearningStore(archive(count));
  const { total, pages } = store.pagination("5", "ko");
  expect(total).toBe(count + 3);
  const ids: string[] = [];
  for (let page = 1; page <= pages; page++) {
    const batch = store.questions("5", "ko", 0, undefined, page);
    expect(batch.length).toBeLessThanOrEqual(20); ids.push(...batch.map(q => q.id));
  }
  expect(ids).toEqual([...Array.from({ length: count }, (_, i) => String(1000 + i)), ...authoredQuestions("5", "ko").map(q => q.id)]);
  expect(new Set(ids).size).toBe(total);
  expect(store.questions("5", "ko", 1).every(q => !q.authored)).toBe(true);
  expect(store.questions("5", "ko", 202610)).toHaveLength(3);
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
