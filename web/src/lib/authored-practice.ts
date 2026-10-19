import content from "@/data/practice-2026-10.json" with { type: "json" };
import catalog from "@/data/exam-catalog.json" with { type: "json" };
import type { Locale } from "./contracts";
import type { Question } from "./quiz";

export const authoredVersion = 202610;
export const authoredVersionName = "2026-10";
export const authoredCatalog = catalog;
const byExam = new Map(content.groups.flatMap(group => group.examIds.map(id => [id, group] as const)));
function escape(value: string) { return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;"); }
export function authoredQuestionId(examId: string, index: number) { return String(8_000_000_000 + Number(examId) * 100 + index + 1); }
export function authoredVersionId(examId: string) { return String(8_100_000_000 + Number(examId)); }

export function authoredQuestions(examId: string, locale: Locale): Question[] {
  const group = byExam.get(examId);
  if (!group) return [];
  return group.questions.map((item, index) => {
    const rotation = (Number(examId) + index) % 4;
    return {
      id: authoredQuestionId(examId, index), testId: examId, locale, version: authoredVersion,
      versionName: authoredVersionName, questionNumber: index + 1, authored: true,
      text: `<p>${escape(item.prompt)}</p>`, explanation: `<p>${escape(item.explanation)}</p>`,
      reference: `<p>${locale === "ko" ? "참고 학습자료" : "Learning reference"}: <a href="${escape(group.source)}" rel="noopener noreferrer">${escape(new URL(group.source).hostname)}</a></p>`,
      preserveOrder: true,
      choices: item.choices.map((_, position) => {
        const original = (position + rotation) % 4;
        return { id: String(9_000_000_000 + Number(examId) * 1000 + index * 10 + original), position: position + 1, text: escape(item.choices[original]), correct: original === 0 };
      }),
    };
  });
}

export function findAuthoredQuestion(questionId: string, locale: Locale = "ko") {
  // IDs are below Number.MAX_SAFE_INTEGER; reject other namespaces before conversion.
  if (!/^80000\d{5}$/.test(questionId)) return undefined;
  const value = Number(questionId) - 8_000_000_000;
  const examId = String(Math.floor(value / 100));
  return authoredQuestions(examId, locale).find(question => question.id === questionId);
}
