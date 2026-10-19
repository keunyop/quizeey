import type { Locale } from "@/lib/contracts";
import { legacy } from "@/lib/contracts";
import { authoredCatalog, authoredQuestions, authoredVersion, authoredVersionId, authoredVersionName, findAuthoredQuestion } from "@/lib/authored-practice";
import type { StudyStore } from "./study-store";
import { loadStudyStore, type StudyContext } from "./study-loader";

/** Append the public original set without modifying archived IDs, content or counters.
 * Hosted archive pages stay bounded to the same 20-item RPC. Original questions
 * fill the last page's remaining slots, then continue on a new page if needed.
 */
export class LearningStore {
  readonly source;
  readonly version;
  readonly exams;
  constructor(private base: StudyStore) {
    this.source = base.source;
    this.version = base.version;
    const existing = new Set(base.exams.map(exam => exam.id));
    this.exams = [...base.exams, ...authoredCatalog.filter(exam => !existing.has(exam.id)).map(exam => ({
      id: exam.id, nameKo: exam.name, nameEn: legacy.routes.find(route => route.testId === exam.id && route.locale === "en")?.headings[0] ?? null,
      slug: exam.slug, priority: 1000,
    }))];
  }
  hasExam(id: string) { return this.base.hasExam(id) || authoredCatalog.some(exam => exam.id === id); }
  hasQuestion(id: string) { return this.base.hasQuestion(id) || !!findAuthoredQuestion(id); }
  defaultLocale(id: string): Locale { return this.base.defaultLocale(id); }
  versions(id: string, locale: Locale) {
    const extra = authoredQuestions(id, locale).length ? [{ id: authoredVersionId(id), number: authoredVersion, name: authoredVersionName }] : [];
    return [...extra, ...this.base.versions(id, locale)];
  }
  pagination(id: string, locale: Locale, version = 0, page = 1) {
    const additional = !version || version === authoredVersion ? authoredQuestions(id, locale).length : 0;
    const total = (version === authoredVersion ? 0 : this.base.pagination(id, locale, version, page).total) + additional;
    return { page, total, pages: Math.max(1, Math.ceil(total / 20)) };
  }
  questions(id: string, locale: Locale, version = 0, directId?: string, page = 1) {
    const extra = authoredQuestions(id, locale);
    if (directId) {
      const found = extra.find(question => question.id === directId && (!version || version === authoredVersion));
      return found ? [found] : this.base.questions(id, locale, version, directId, page);
    }
    if (version === authoredVersion) return extra.slice((page - 1) * 20, page * 20);
    const batch = this.base.questions(id, locale, version, undefined, page);
    if (version) return batch;
    const legacyTotal = this.base.pagination(id, locale, 0, page).total;
    const start = Math.max(0, (page - 1) * 20 - legacyTotal);
    return [...batch, ...extra.slice(start, start + 20 - batch.length)];
  }
  random(id: string, locale: Locale, version = 0) {
    if (version !== authoredVersion) {
      const original = this.base.random(id, locale, version);
      if (original || version) return original;
    }
    const extra = authoredQuestions(id, locale);
    return extra[Math.floor(Math.random() * extra.length)];
  }
  counter(id: string) { return this.base.counter(id); }
  pendingExplanations(id: string) { return this.base.pendingExplanations(id); }
}

export async function loadLearningStore(context: StudyContext = {}, input: Record<string, string | undefined> = process.env) {
  const authored = context.questionId ? findAuthoredQuestion(context.questionId) : undefined;
  // An authored identity is resolved locally; it must never be sent as an archive ID.
  const baseContext = authored ? {} : context.version === authoredVersion ? {} : context;
  return new LearningStore(await loadStudyStore(baseContext, input));
}
