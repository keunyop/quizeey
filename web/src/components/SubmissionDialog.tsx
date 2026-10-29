"use client";
import { useId, useRef, useState, type FormEvent } from "react";
import type { Locale } from "@/lib/contracts";

export function SubmissionDialog({ locale, question }: { locale: Locale; question?: { examId: string; questionId: string } }) {
  const en = locale === "en", report = !!question;
  const title = report ? en ? "Report an error" : "오답 신고" : en ? "Feedback" : "피드백";
  const reasons = en ? ["Incorrect answer", "Question or choices issue", "Explanation issue", "Other"] : ["정답 오류", "문제·보기 오류", "해설 오류", "기타"];
  const [body, setBody] = useState("");
  const [reason, setReason] = useState(reasons[0]);
  const [busy, setBusy] = useState(false), [done, setDone] = useState(false), [error, setError] = useState("");
  const dialog = useRef<HTMLDialogElement>(null);
  const submission = useRef<{ body: string; id: string } | null>(null);
  const id = useId();
  function open() { setDone(false); setError(""); submission.current = null; dialog.current?.showModal(); }
  async function send(event: FormEvent) {
    event.preventDefault(); if (busy) return;
    setBusy(true); setError("");
    const payload = report ? { kind: "question_report", locale, ...question, body: reason + (body.trim() ? "\n" + body.trim() : "") }
      : { kind: "feedback", locale, path: window.location.pathname, body: body.trim() };
    const serialized = JSON.stringify(payload);
    if (submission.current?.body !== serialized) submission.current = { body: serialized, id: crypto.randomUUID() };
    try {
      const response = await fetch("/api/feedback", { method: "POST", headers: { "Content-Type": "application/json", "Idempotency-Key": submission.current.id }, body: serialized });
      if (!response.ok) {
        setError(response.status === 429 ? en ? "Please wait a few minutes before trying again." : "잠시 후 다시 보내주세요." : en ? "Unable to send. Your message is still here; please try again." : "전송하지 못했습니다. 입력한 내용을 확인하고 다시 보내주세요.");
        return;
      }
      setDone(true); setBody("");
    } catch { setError(en ? "Unable to send. Please try again." : "전송하지 못했습니다. 다시 시도해주세요."); }
    finally { setBusy(false); }
  }
  return <>
    {report ? <button type="button" className="text-button question-report-trigger" aria-haspopup="dialog" onClick={open}>{title}</button>
      : <a href="#feedback" aria-haspopup="dialog" onClick={event => { event.preventDefault(); open(); }}>{title}</a>}
    <dialog ref={dialog} className="submission-dialog" aria-labelledby={`${id}-title`} onClick={event => {
      const bounds = event.currentTarget.getBoundingClientRect();
      if (event.target === event.currentTarget && (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom)) event.currentTarget.close();
    }} onKeyDown={event => {
      if (event.key !== "Tab") return;
      const elements = Array.from(event.currentTarget.querySelectorAll<HTMLElement>('button:not(:disabled),input,textarea,select,a[href]')).filter(element => element.getClientRects().length);
      const first = elements[0], last = elements.at(-1);
      if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last?.focus(); }
      else if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first?.focus(); }
    }}>
      <div className="submission-heading"><h2 id={`${id}-title`}>{title}</h2><button type="button" className="text-button" aria-label={en ? "Close" : "닫기"} onClick={() => dialog.current?.close()}>×</button></div>
      {done ? <div role="status"><p>{en ? "Thank you. Your message has been received." : "접수했습니다. 의견을 남겨주셔서 감사합니다."}</p><button type="button" onClick={() => dialog.current?.close()}>{en ? "Close" : "닫기"}</button></div> : <form onSubmit={send}>
        {report && <><label htmlFor={`${id}-reason`}>{en ? "What needs correcting?" : "신고 유형"}</label><select id={`${id}-reason`} value={reason} onChange={event => setReason(event.target.value)}>{reasons.map(item => <option key={item}>{item}</option>)}</select><p className="small muted">{en ? "The exam and question are included automatically." : "시험과 문제 정보는 자동으로 전달됩니다."}</p></>}
        <label htmlFor={`${id}-body`}>{report ? en ? "Details (optional)" : "추가 설명 (선택)" : en ? "Your feedback" : "피드백 내용"}</label>
        <textarea id={`${id}-body`} rows={5} maxLength={report ? 3500 : 4000} required={!report} value={body} onChange={event => setBody(event.target.value)} />
        <p role="status" className="error">{error}</p>
        <button className="primary" disabled={busy || (!report && !body.trim())}>{busy ? en ? "Sending…" : "전송 중…" : en ? "Send" : "보내기"}</button>
      </form>}
    </dialog>
  </>;
}
