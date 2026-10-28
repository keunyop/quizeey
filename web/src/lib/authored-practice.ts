import content from "@/data/practice-2026-10.json" with { type: "json" };
import catalog from "@/data/exam-catalog.json" with { type: "json" };
import type { Locale } from "./contracts";
import type { Question } from "./quiz";
import { practiceDisplayCopy } from "./practice-display-copy";

export const authoredVersion = 202610;
export const authoredVersionName = "2026-10";
export const authoredCatalog = catalog;
const catalogById = new Map(catalog.map(exam => [exam.id, exam]));
export function authoredDefaultLocale(examId: string): Locale {
  const locale = catalogById.get(examId)?.locale;
  return locale === "en" || locale === "all" ? "en" : "ko";
}
type AuthoredItem = (typeof content.groups)[number]["questions"][number] & { source: string };
const byExam = new Map<string, AuthoredItem[]>();
for (const group of content.groups) {
  for (const id of group.examIds) {
    byExam.set(id, [...(byExam.get(id) ?? []), ...group.questions.map(item => ({ ...item, source: "source" in item ? item.source ?? group.source : group.source }))]);
  }
}
function escape(value: string) { return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;"); }
// Larger sets opt into a separate namespace; existing IDs and saved progress stay stable.
function extendedIds(examId: string) { return catalogById.get(examId)?.idBlockSize === 1000; }
export function authoredQuestionId(examId: string, index: number) {
  return String((extendedIds(examId) ? 8_200_000_000 + Number(examId) * 1000 : 8_000_000_000 + Number(examId) * 100) + index + 1);
}
export function authoredVersionId(examId: string) { return String(8_100_000_000 + Number(examId)); }

export function authoredSetSummary(examId: string, locale: Locale) {
  const exam = catalogById.get(examId);
  if (!exam || (exam.locale && exam.locale !== "all" && exam.locale !== locale)) return undefined;
  const items = byExam.get(examId) ?? [];
  if (!items.length) return undefined;
  return {
    count: items.length, version: authoredVersion, name: authoredVersionName,
    scope: practiceDisplayCopy(exam.practiceScope),
    languages: [...new Set(items.map(item => /[\uac00-\ud7a3]/.test(item.prompt) ? "ko" as const : "en" as const))],
  };
}

export function authoredQuestions(examId: string, locale: Locale): Question[] {
  const group = byExam.get(examId);
  const supportedLocale = catalogById.get(examId)?.locale;
  if (!group || (supportedLocale && supportedLocale !== "all" && supportedLocale !== locale)) return [];
  return group.map((item, index) => {
    const rotation = (Number(examId) + index) % 4;
    return {
      id: authoredQuestionId(examId, index), testId: examId, locale, version: authoredVersion,
      versionName: authoredVersionName, questionNumber: index + 1, authored: true,
      contentLocale: /[\uac00-\ud7a3]/.test(item.prompt) ? "ko" : "en",
      text: `<p>${escape(item.prompt)}</p>`, explanation: `<p>${escape(item.explanation)}</p>`,
      reference: `<p>${locale === "ko" ? "참고 학습자료" : "Learning reference"}: <a href="${escape(item.source)}" rel="noopener noreferrer">${escape(new URL(item.source).hostname)}</a></p>`,
      preserveOrder: true,
      choices: item.choices.map((_, position) => {
        const original = (position + rotation) % 4;
        const choiceBase = extendedIds(examId) ? 9_100_000_000 + Number(examId) * 10_000 : 9_000_000_000 + Number(examId) * 1000;
        return { id: String(choiceBase + index * 10 + original), position: position + 1, text: escape(item.choices[original]), correct: original === 0 };
      }),
    };
  });
}

export function findAuthoredQuestion(questionId: string, locale?: Locale) {
  // IDs are below Number.MAX_SAFE_INTEGER; reject other namespaces before conversion.
  const extended = /^8200\d{6}$/.test(questionId);
  if (!extended && !/^80000\d{5}$/.test(questionId)) return undefined;
  const value = Number(questionId) - (extended ? 8_200_000_000 : 8_000_000_000);
  const examId = String(Math.floor(value / (extended ? 1000 : 100)));
  return authoredQuestions(examId, locale ?? authoredDefaultLocale(examId)).find(question => question.id === questionId);
}
