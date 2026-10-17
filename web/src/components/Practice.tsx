"use client";

import { useMemo, useState, useSyncExternalStore } from "react";
import { messages } from "@/lib/i18n";
import type { Locale } from "@/lib/contracts";
import { emptyProgress, readProgress, type Progress } from "@/lib/progress";
import { grade, shuffleChoices, type Question } from "@/lib/quiz";

function createProgressStore(key: string, onError: (error: boolean) => void) {
    let fallback: string | null = null;
    let useFallback = false;
    return {
      getSnapshot: () => {
        if (useFallback) return fallback;
        try { return localStorage.getItem(key); } catch { return fallback; }
      },
      subscribe: (listener: () => void) => {
        const onStorage = (event: StorageEvent) => { if (event.key === key || event.key === null) listener(); };
        window.addEventListener("storage", onStorage);
        return () => window.removeEventListener("storage", onStorage);
      },
      write: (value: Progress) => {
        fallback = JSON.stringify(value);
        try { localStorage.setItem(key, fallback); onError(false); }
        catch { useFallback = true; onError(true); }
        window.dispatchEvent(new StorageEvent("storage", { key, newValue: fallback }));
      },
    };
}
function useProgress(key: string, ids: string[], contentVersion: string) {
  const [storageError, setStorageError] = useState(false);
  const store = useMemo(() => createProgressStore(key, setStorageError), [key]);
  const raw = useSyncExternalStore(store.subscribe, store.getSnapshot, () => null);
  const progress = useMemo(() => readProgress(raw, ids, contentVersion) ?? emptyProgress(ids, contentVersion), [raw, ids, contentVersion]);
  return { progress, save: store.write, storageError };
}

function QuestionCard({ question, locale, attempt, onGrade }: {
  question: Question; locale: Locale; attempt: Progress["attempts"][string] | undefined;
  onGrade: (selected: string[]) => void;
}) {
  const m = messages[locale];
  const [selected, setSelected] = useState<string[]>(attempt?.selected ?? []);
  const [error, setError] = useState(false);
  const multiple = question.choices.filter((choice) => choice.correct).length > 1;
  return <section className="question-card" aria-label={locale === "ko" ? "문제" : "Question"}>
    <div className="learning-content" dangerouslySetInnerHTML={{ __html: question.text }} />
    <fieldset disabled={!!attempt}>
      <legend>{multiple ? m.multiple : m.single}</legend>
      {question.choices.map((choice, index) => <label className="choice" key={choice.id}>
        <input type={multiple ? "checkbox" : "radio"} name={`answer-${question.id}`} value={choice.id}
          checked={selected.includes(choice.id)} onChange={(event) => {
            setError(false);
            setSelected(multiple ? event.target.checked ? [...selected, choice.id] : selected.filter((id) => id !== choice.id) : [choice.id]);
          }} />
        <span aria-hidden="true" className="choice-letter">{String.fromCharCode(65 + index)}</span>
        <span className="learning-content" dangerouslySetInnerHTML={{ __html: choice.text }} />
      </label>)}
    </fieldset>
    {!attempt && <button className="primary" onClick={() => {
      if (!selected.length) { setError(true); return; }
      onGrade(selected);
    }}>{m.grade}</button>}
    <div aria-live="polite">
      {error && <p className="error">{m.select}</p>}
      {attempt && <>
        <p className={attempt.correct ? "correct" : "error"}>{attempt.correct ? m.correct : m.incorrect}</p>
        <details open><summary>{m.explanation}</summary>
          <ul>{question.choices.filter((c) => c.correct).map((c) => <li key={c.id} dangerouslySetInnerHTML={{ __html: c.text }} />)}</ul>
          <div className="learning-content" dangerouslySetInnerHTML={{ __html: question.explanation??'' }} />
          {question.reference&&<div className="learning-content reference" dangerouslySetInnerHTML={{__html:question.reference}}/>}
        </details>
      </>}
    </div>
  </section>;
}

export function Practice({ questions, locale, testId, contentVersion, directId }: {
  questions: Question[]; locale: Locale; testId: string; contentVersion: string; directId?: string;
}) {
  const m = messages[locale];
  const ids = useMemo(() => questions.map((q) => q.id), [questions]);
  const key = `quizeey:progress:v1:${locale}:${testId}:${contentVersion}:${questions.map((q) => q.version).join(",")}:${directId ?? "all"}`;
  const { progress, save, storageError } = useProgress(key, ids, contentVersion);
  const activeQuestions = progress.reviewIds ? questions.filter((q) => progress.reviewIds!.includes(q.id)) : questions;
  const question = activeQuestions[progress.index];
  const attempt = question ? progress.attempts[question.id] : undefined;

  function navigate(index: number) {
    const target = activeQuestions[index];
    const choiceOrders = { ...progress.choiceOrders };
    if (target && !choiceOrders[target.id]) choiceOrders[target.id] = shuffleChoices(target).choices.map((c) => c.id);
    save({ ...progress, index, choiceOrders });
  }

  if (!question) return <section className="panel">
    <h2>{m.complete}</h2>
    <p>{Object.values(progress.attempts).filter((a) => a.correct).length} / {questions.length}</p>
    <div className="actions">
      <button onClick={() => save({ ...emptyProgress(ids, contentVersion), bookmarks: progress.bookmarks })}>{m.restart}</button>
      <button onClick={() => {
        const mistakes = Object.entries(progress.attempts).filter(([, a]) => !a.correct).map(([id]) => id);
        save({ ...progress, reviewIds: mistakes, index: 0, attempts: Object.fromEntries(Object.entries(progress.attempts).filter(([, a]) => a.correct)) });
      }}>{m.mistakes}</button>
    </div>
    {progress.reviewIds?.length === 0 && <p>{m.noMistakes}</p>}
  </section>;

  const order = progress.choiceOrders[question.id];
  const displayed = order && order.length === question.choices.length && new Set(order).size === order.length && order.every((id) => question.choices.some((c) => c.id === id))
    ? { ...question, choices: order.map((id) => question.choices.find((c) => c.id === id)!) } : question;
  return <div className="practice">
    <div className="practice-toolbar">
      <span>{progress.index + 1} / {activeQuestions.length}</span>
      <a href={`?testId=${testId}&questId=${question.id}&verNbr=${question.version}`}>{locale === "ko" ? "문제 링크" : "Question link"}</a>
      <button aria-pressed={progress.bookmarks.includes(question.id)} onClick={() => save({ ...progress,
        bookmarks: progress.bookmarks.includes(question.id) ? progress.bookmarks.filter((id) => id !== question.id) : [...progress.bookmarks, question.id],
      })}>{progress.bookmarks.includes(question.id) ? m.bookmarked : m.bookmark}</button>
    </div>
    <progress value={progress.index} max={activeQuestions.length} aria-label={locale === "ko" ? "학습 진행률" : "Practice progress"} />
    <QuestionCard key={`${question.id}:${attempt ? "graded" : "open"}`} question={displayed} locale={locale} attempt={attempt} onGrade={(selected) => save({ ...progress,
      attempts: { ...progress.attempts, [question.id]: { selected, correct: grade(question, selected) } },
    })} />
    <div className="actions navigation">
      <button disabled={progress.index === 0} onClick={() => navigate(progress.index - 1)}>{m.previous}</button>
      <button className={attempt ? "primary" : ""} onClick={() => navigate(progress.index + 1)}>{attempt ? m.next : m.skip}</button>
    </div>
    {storageError && <p role="status" className="error">{m.storageError}</p>}
    <p className="small muted">{m.localNote}</p>
  </div>;
}
