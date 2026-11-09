import content from "@/data/practice-2026-10.json" with { type: "json" };
import november from "@/data/practice-2026-11.json" with { type: "json" };
import catalog from "@/data/exam-catalog.json" with { type: "json" };
import type { Locale } from "./contracts";
import type { Question } from "./quiz";
import { practiceDisplayCopy } from "./practice-display-copy";

export const authoredVersion = 202610;
export const authoredVersionName = "2026-10";
export const authoredVersions = [202610, 202611] as const;
export function isAuthoredVersion(version: number) { return authoredVersions.some(value => value === version); }
export function authoredVersionLabel(version: number) { return `${Math.floor(version / 100)}-${String(version % 100).padStart(2, '0')}`; }
export const authoredCatalog = catalog;
const catalogById = new Map(catalog.map(exam => [exam.id, exam]));
export function authoredDefaultLocale(examId: string): Locale {
  const locale = catalogById.get(examId)?.locale;
  return locale === "en" || locale === "all" ? "en" : "ko";
}
type AuthoredItem = (typeof content.groups)[number]["questions"][number] & { source: string };
const bySet = new Map<number, Map<string, AuthoredItem[]>>();
for (const [version, data] of [[202610, content], [202611, november]] as const) {
  const byExam = new Map<string, AuthoredItem[]>();
  bySet.set(version, byExam);
  for (const group of data.groups) {
    for (const id of group.examIds) {
      byExam.set(id, [...(byExam.get(id) ?? []), ...group.questions.map(item => ({ ...item, source: "source" in item ? item.source ?? group.source : group.source }))]);
    }
  }
}
function escape(value: string) { return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;"); }
// Larger sets opt into a separate namespace; existing IDs and saved progress stay stable.
function extendedIds(examId: string) { return catalogById.get(examId)?.idBlockSize === 1000; }
export function authoredQuestionId(examId: string, index: number, version = authoredVersion) {
  if (version === 202611) return String(8_300_000_000 + Number(examId) * 1000 + index + 1);
  return String((extendedIds(examId) ? 8_200_000_000 + Number(examId) * 1000 : 8_000_000_000 + Number(examId) * 100) + index + 1);
}
export function authoredVersionId(examId: string, version = authoredVersion) { return String((version === 202611 ? 8_400_000_000 : 8_100_000_000) + Number(examId)); }

export function authoredSetSummary(examId: string, locale: Locale, version = authoredVersion) {
  const exam = catalogById.get(examId);
  if (!exam || (exam.locale && exam.locale !== "all" && exam.locale !== locale)) return undefined;
  const items = bySet.get(version)?.get(examId) ?? [];
  if (!items.length) return undefined;
  return {
    count: items.length, version, name: authoredVersionLabel(version),
    scope: version === 202611 && !exam.firstVersion ? undefined : practiceDisplayCopy(exam.practiceScope),
    languages: [...new Set(items.map(item => /[\uac00-\ud7a3]/.test(item.prompt) ? "ko" as const : "en" as const))],
  };
}

export function authoredSetSummaries(examId: string, locale: Locale) {
  return [...authoredVersions].reverse().flatMap(version => {
    const summary = authoredSetSummary(examId, locale, version);
    return summary ? [summary] : [];
  });
}

export function allAuthoredQuestions(examId: string, locale: Locale): Question[] {
  return authoredVersions.flatMap(version => authoredQuestions(examId, locale, version));
}

export function authoredQuestions(examId: string, locale: Locale, version = authoredVersion): Question[] {
  const group = bySet.get(version)?.get(examId);
  const supportedLocale = catalogById.get(examId)?.locale;
  if (!group || (supportedLocale && supportedLocale !== "all" && supportedLocale !== locale)) return [];
  return group.map((item, index) => {
    const rotation = (Number(examId) + index) % 4;
    return {
      id: authoredQuestionId(examId, index, version), testId: examId, locale, version,
      versionName: authoredVersionLabel(version), questionNumber: index + 1, authored: true,
      contentLocale: /[\uac00-\ud7a3]/.test(item.prompt) ? "ko" : "en",
      text: `<p>${escape(item.prompt)}</p>`, explanation: `<p>${escape(item.explanation)}</p>`,
      reference: `<p>${locale === "ko" ? "참고 학습자료" : "Learning reference"}: <a href="${escape(item.source)}" rel="noopener noreferrer">${escape(new URL(item.source).hostname)}</a></p>`,
      preserveOrder: true,
      choices: item.choices.map((_, position) => {
        const original = (position + rotation) % 4;
        const choiceBase = version === 202611 ? 9_200_000_000 + Number(examId) * 10_000 : extendedIds(examId) ? 9_100_000_000 + Number(examId) * 10_000 : 9_000_000_000 + Number(examId) * 1000;
        return { id: String(choiceBase + index * 10 + original), position: position + 1, text: escape(item.choices[original]), correct: original === 0 };
      }),
    };
  });
}

export function findAuthoredQuestion(questionId: string, locale?: Locale) {
  if (/^8300\d{6}$/.test(questionId)) {
    const examId = String(Math.floor((Number(questionId) - 8_300_000_000) / 1000));
    return authoredQuestions(examId, locale ?? authoredDefaultLocale(examId), 202611).find(question => question.id === questionId);
  }
  // IDs are below Number.MAX_SAFE_INTEGER; reject other namespaces before conversion.
  const extended = /^8200\d{6}$/.test(questionId);
  if (!extended && !/^80000\d{5}$/.test(questionId)) return undefined;
  const value = Number(questionId) - (extended ? 8_200_000_000 : 8_000_000_000);
  const examId = String(Math.floor(value / (extended ? 1000 : 100)));
  return authoredQuestions(examId, locale ?? authoredDefaultLocale(examId)).find(question => question.id === questionId);
}
