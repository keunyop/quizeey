"use client";

import { useEffect,useMemo,useRef, useState, useSyncExternalStore } from "react";
import { messages } from "@/lib/i18n";
import type { Locale } from "@/lib/contracts";
import { emptyProgress, practiceStats, readProgress, reviewProgress, type Progress } from "@/lib/progress";
import { grade, shuffleChoices, type Question } from "@/lib/quiz";
import { Icon } from "./Icon";
import { Forum } from "./Forum";
import { useAnalytics } from './Monetization';

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
        try { localStorage.setItem(key, fallback); useFallback = false; onError(false); }
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

function QuestionCard({ question, locale, attempt, onGrade, onPrevious, onNext, canPrevious, commentsEnabled }: {
  question: Question; locale: Locale; attempt: Progress["attempts"][string] | undefined;
  onGrade: (selected: string[]) => void;
  onPrevious: () => void; onNext: () => void; canPrevious: boolean; commentsEnabled: boolean;
}) {
  const m = messages[locale];
  const [draft, setDraft] = useState<string[]>([]);
  const selected = attempt?.selected ?? draft;
  const multiple = question.choices.filter((choice) => choice.correct).length > 1;
  const answerLetters = question.choices.flatMap((choice, index) => choice.correct ? [String.fromCharCode(65 + index)] : []);
  const analytics=useAnalytics();
  return <section className="question-card" aria-label={locale === "ko" ? "문제" : "Question"}>
    <p className="question-version">{locale === "ko" ? "회차" : "Set"} · {question.versionName || question.version}</p>
    <div id="question-content" tabIndex={-1} className="learning-content question-prompt" dangerouslySetInnerHTML={{ __html: question.text }} />
    <fieldset disabled={!!attempt}>
      <legend>{multiple ? m.multiple : m.single}</legend>
      {question.choices.map((choice, index) => <label className={`choice ${attempt ? choice.correct ? "choice-correct" : attempt.selected.includes(choice.id) ? "choice-incorrect" : "" : ""}`} key={choice.id}>
        <input type={multiple ? "checkbox" : "radio"} name={`answer-${question.id}`} value={choice.id}
          checked={selected.includes(choice.id)} onChange={(event) => {
            setDraft(multiple ? event.target.checked ? [...selected, choice.id] : selected.filter((id) => id !== choice.id) : [choice.id]);
          }} />
        <span aria-hidden="true" className="choice-letter">{String.fromCharCode(65 + index)}</span>
        <span className="learning-content" dangerouslySetInnerHTML={{ __html: choice.text }} />
        {attempt && (choice.correct || attempt.selected.includes(choice.id)) && <span className="choice-result"><Icon name={choice.correct ? "check" : "close"} /><span className="sr-only">{choice.correct ? locale === "ko" ? "정답" : "Correct answer" : locale === "ko" ? "선택한 오답" : "Your incorrect answer"}</span></span>}
      </label>)}
    </fieldset>
    <div className="answer-region" aria-live="polite">
      {attempt && <>
        <p className={`answer-feedback ${attempt.correct ? "correct" : "error"}`}><Icon name={attempt.correct ? "check" : "close"} />{attempt.correct ? m.correct : m.incorrect}</p>
        <p className="answer-key">{locale === "ko" ? "정답" : "Answer"} <strong>{answerLetters.join(", ")}</strong></p>
        <details open onToggle={event=>{if(event.currentTarget.open)analytics.track('explanation_open',{test_id:question.testId,quest_id:question.id,locale});}}><summary>{m.explanation}</summary>
          {question.explanation && <div className="learning-content" dangerouslySetInnerHTML={{ __html: question.explanation }} />}
          {question.reference&&<div className="learning-content reference" dangerouslySetInnerHTML={{__html:question.reference}}/>}
          {commentsEnabled && <Forum key={`${question.id}:${locale}`} examId={question.testId} questionId={question.id} locale={locale} />}
        </details>
      </>}
    </div>
    <div className="practice-controls">
      <button className="primary practice-primary" disabled={!attempt && !selected.length} onClick={() => attempt ? onNext() : onGrade(selected)}>
        {attempt ? m.next : m.grade}{attempt && <Icon name="arrow" />}
      </button>
      <div className="practice-secondary">
        <button className="text-button previous-button" disabled={!canPrevious} onClick={onPrevious}><Icon name="back" /><span>{m.previous}</span></button>
        {!attempt && <button className="text-button skip-button" onClick={onNext}>{m.skip}</button>}
      </div>
    </div>
  </section>;
}

function QuestionNavigator({ questions, question, locale, testId, progress, onNavigate, onReview }: {
  questions: Question[]; question: Question; locale: Locale; testId: string; progress: Progress;
  onNavigate: (index: number) => void; onReview: (mode: "mistakes" | "bookmarks") => void;
}) {
  const en = locale === "en";
  const stats = practiceStats(progress, progress.ids);
  return <details className="question-map">
    <summary><span><Icon name="grid" />{en ? "Questions & review" : "문제 목록·복습"}</span></summary>
    <div className="map-content">
      <div className="map-legend"><span><i className="dot-correct" />{en ? "Correct" : "정답"}</span><span><i className="dot-incorrect" />{en ? "Incorrect" : "오답"}</span><span><i />{en ? "Unanswered" : "미응답"}</span></div>
      <div className="question-grid">{questions.map((q, index) => {
        const answered = progress.attempts[q.id];
        const saved = progress.bookmarks.includes(q.id);
        const status = answered ? answered.correct ? en ? "Correct" : "정답" : en ? "Incorrect" : "오답" : en ? "Unanswered" : "미응답";
        return <button key={q.id} className={answered ? answered.correct ? "map-correct" : "map-incorrect" : ""}
          aria-current={index === progress.index ? "step" : undefined}
          aria-label={`${en ? "Question" : "문제"} ${index + 1}, ${status}${saved ? en ? ", Bookmarked" : ", 북마크" : ""}`}
          onClick={() => onNavigate(index)}>{index + 1}{saved && <Icon name="bookmark" />}</button>;
      })}</div>
      <div className="map-review">
        <button disabled={!stats.incorrect} onClick={() => onReview("mistakes")}>{messages[locale].mistakes}<span>{stats.incorrect}</span></button>
        <button disabled={!progress.bookmarks.length} onClick={() => onReview("bookmarks")}>{en ? "Review bookmarks" : "북마크 복습"}<span>{progress.bookmarks.length}</span></button>
      </div>
      <div className="question-meta"><a className="question-link" data-google-vignette="false" href={`?testId=${testId}&questId=${question.id}&verNbr=${question.version}`}><Icon name="link" />{en ? "Question link" : "문제 링크"}</a></div>
    </div>
  </details>;
}

export function Practice({ questions, locale, testId, contentVersion, directId, pageNumber=1, nextPage, commentsEnabled=false }: {
  questions: Question[]; locale: Locale; testId: string; contentVersion: string; directId?: string;pageNumber?:number;nextPage?:string;commentsEnabled?:boolean;
}) {
  const m = messages[locale];
  const ids = useMemo(() => questions.map((q) => q.id), [questions]);
  const retained = questions.filter(question => !question.authored);
  const key = `quizeey:progress:v1:${locale}:${testId}:${contentVersion}:${(retained.length ? retained : questions).map((q) => q.version).join(",")}:${directId ?? "all"}${pageNumber>1?`:page${pageNumber}`:''}`;
  const { progress, save, storageError } = useProgress(key, ids, contentVersion);
  const activeQuestions = progress.reviewIds ? questions.filter((q) => progress.reviewIds!.includes(q.id)) : questions;
  const question = activeQuestions[progress.index];
  const attempt = question ? progress.attempts[question.id] : undefined;
  const activeIds = activeQuestions.map((q) => q.id);
  const stats = practiceStats(progress, activeIds);
  const allStats = practiceStats(progress, ids);
  const en = locale === "en";
  const analytics=useAnalytics();const viewed=useRef<string|null>(null);
  useEffect(()=>{
    const identity=question?.id??'complete';
    if(!analytics.analytics||viewed.current===identity)return;
    if(analytics.track(question?'question_start':'practice_complete',{test_id:testId,...(question?{quest_id:question.id}:{}),locale}))viewed.current=identity;
  },[question,locale,testId,analytics]);
  const reviewLabel = progress.reviewMode === "bookmarks" ? en ? "Bookmarked questions" : "북마크 복습" : progress.reviewMode === "unanswered" ? en ? "Unanswered questions" : "미응답 풀기" : m.mistakes;

  function focusQuestion(hasQuestion = true) {
    requestAnimationFrame(() => {
      const element = document.getElementById(hasQuestion ? "question-content" : "practice-result");
      element?.focus({ preventScroll: true });
      if (window.matchMedia("(max-width: 760px)").matches) element?.scrollIntoView({ block: "start" });
    });
  }
  function review(mode: NonNullable<Progress["reviewMode"]>) {
    const next = reviewProgress(progress, mode);
    if (next === progress) return;
    save(next); focusQuestion();
  }
  function exitReview() {
    const index = question ? ids.indexOf(question.id) : 0;
    save({ ...progress, reviewIds: null, reviewMode: undefined, index: Math.max(0, index) }); focusQuestion();
  }

  function navigate(index: number) {
    const target = activeQuestions[index];
    const choiceOrders = { ...progress.choiceOrders };
    if (target && !choiceOrders[target.id]) choiceOrders[target.id] = shuffleChoices(target).choices.map((c) => c.id);
    save({ ...progress, index, choiceOrders });
    focusQuestion(!!target);
  }

  if (!question) return <section className="panel result-panel" id="practice-result" tabIndex={-1}>
    <div className="result-icon"><Icon name={stats.unanswered ? "book" : "check"} /></div>
    {progress.reviewIds && <p className="eyebrow">{reviewLabel}</p>}
    <h2>{stats.unanswered ? en ? "Your practice results" : "학습 결과" : m.complete}</h2>
    <p className="result-score"><strong>{stats.correct}</strong><span> / {activeIds.length}</span></p>
    <p className="muted">{en ? "Correct answers" : "정답 문항"}</p>
    <div className="result-stats"><div><strong>{stats.correct}</strong><span>{en ? "Correct" : "정답"}</span></div><div><strong>{stats.incorrect}</strong><span>{en ? "Incorrect" : "오답"}</span></div><div><strong>{stats.unanswered}</strong><span>{en ? "Unanswered" : "미응답"}</span></div></div>
    <div className="actions">
      {nextPage&&!progress.reviewIds&&<a className="button-link primary" data-google-vignette="false" href={nextPage}>{en?'Continue practice':'이어서 풀기'}<Icon name="arrow" /></a>}
      <button className="primary" disabled={!allStats.incorrect} onClick={() => review("mistakes")}><Icon name="refresh" />{m.mistakes}<span>{allStats.incorrect}</span></button>
      {allStats.unanswered > 0 && <button onClick={() => review("unanswered")}>{en ? "Answer remaining" : "미응답 풀기"}<span>{allStats.unanswered}</span></button>}
      <button disabled={!progress.bookmarks.length} onClick={() => review("bookmarks")}><Icon name="bookmark" />{en ? "Review bookmarks" : "북마크 복습"}<span>{progress.bookmarks.length}</span></button>
      <button onClick={() => { save({ ...emptyProgress(ids, contentVersion), bookmarks: progress.bookmarks }); focusQuestion(); }}><Icon name="refresh" />{m.restart}</button>
    </div>
    {progress.reviewIds && <button className="text-button" onClick={exitReview}>{en ? "Back to all questions" : "전체 문제로 돌아가기"}<Icon name="arrow" /></button>}
    {storageError && <p role="status" className="error">{m.storageError}</p>}
  </section>;

  const order = progress.choiceOrders[question.id];
  const displayed = order && order.length === question.choices.length && new Set(order).size === order.length && order.every((id) => question.choices.some((c) => c.id === id))
    ? { ...question, choices: order.map((id) => question.choices.find((c) => c.id === id)!) } : question;
  return <div className="practice">
    {progress.reviewIds && <div className="review-banner"><span><Icon name="refresh" />{reviewLabel}</span><button className="text-button" onClick={exitReview}>{en ? "All questions" : "전체 문제"}<Icon name="close" /></button></div>}
    <div className="practice-toolbar">
      <span className="question-counter"><span>{en ? "Question" : "문제"}</span><strong>{progress.index + 1}</strong><span> / {activeQuestions.length}</span></span>
      <button className="icon-button bookmark-button" aria-label={progress.bookmarks.includes(question.id) ? m.bookmarked : m.bookmark}
        title={progress.bookmarks.includes(question.id) ? m.bookmarked : m.bookmark}
        aria-pressed={progress.bookmarks.includes(question.id)} onClick={() => {if(!progress.bookmarks.includes(question.id))analytics.track('bookmark_add',{test_id:testId,quest_id:question.id,locale});save({ ...progress,
        bookmarks: progress.bookmarks.includes(question.id) ? progress.bookmarks.filter((id) => id !== question.id) : [...progress.bookmarks, question.id],
      });}}><Icon name="bookmark" /></button>
    </div>
    <progress value={stats.answered} max={activeQuestions.length} aria-label={en ? "Practice progress" : "학습 진행률"}
      aria-valuetext={en ? `${stats.answered} of ${activeQuestions.length} answered` : `${activeQuestions.length}문제 중 ${stats.answered}문제 완료`} />
    <QuestionCard commentsEnabled={commentsEnabled} key={`${question.id}:${progress.reviewMode ?? "all"}`} question={displayed} locale={locale} attempt={attempt}
      canPrevious={progress.index > 0} onPrevious={() => navigate(progress.index - 1)} onNext={() => navigate(progress.index + 1)}
      onGrade={(selected) => {const correct=grade(question,selected);analytics.track('answer_submit',{test_id:testId,quest_id:question.id,locale,correct});save({ ...progress,
      attempts: { ...progress.attempts, [question.id]: { selected, correct } },
    });}} />
    <QuestionNavigator questions={activeQuestions} question={question} locale={locale} testId={testId} progress={progress} onNavigate={navigate} onReview={review} />
    {storageError && <p role="status" className="error">{m.storageError}</p>}
  </div>;
}
