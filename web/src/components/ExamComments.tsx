"use client";

import { useCallback, useEffect, useId, useRef, useState, useSyncExternalStore } from "react";
import type { ReactNode } from "react";
import type { Locale } from "@/lib/contracts";
import { Forum } from "./Forum";
import { Icon } from "./Icon";

const desktopQuery = "(min-width: 1180px)";
function subscribe(listener: () => void) {
  const media = window.matchMedia(desktopQuery);
  media.addEventListener("change", listener);
  return () => media.removeEventListener("change", listener);
}
function snapshot() { return window.matchMedia(desktopQuery).matches; }

export function ExamComments({ examId, locale, title, children }: { examId: string; locale: Locale; title: string; children: ReactNode }) {
  const [open, setOpen] = useState(false);
  const [activated, setActivated] = useState(false);
  const subscribeAndClose = useCallback((listener: () => void) => subscribe(() => { setOpen(false); listener(); }), []);
  const desktop = useSyncExternalStore(subscribeAndClose, snapshot, () => false);
  const dialog = useRef<HTMLDialogElement>(null);
  const id = useId();
  const en = locale === "en";

  useEffect(() => {
    const element = dialog.current;
    if (!element || desktop || !open) return;
    element.showModal();
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      element.close();
      document.body.style.overflow = previousOverflow;
    };
  }, [desktop, open]);

  return <>
    <div className="study-main">
      <div className="page-heading study-heading study-heading-comments">
        <h1>{title}</h1>
        <button type="button" className="exam-comments-trigger" aria-haspopup="dialog" aria-expanded={open}
          aria-controls={`${id}-dialog`} onClick={() => { setActivated(true); setOpen(true); }}>
          {en ? "Comments" : "댓글"} <span aria-hidden="true">▶</span>
        </button>
      </div>
      {children}
    </div>
    {desktop ? <aside className="exam-comments-panel" aria-label={en ? "Exam discussion" : "시험 댓글 영역"}>
      <div className="exam-comments-card"><Forum examId={examId} locale={locale} /></div>
    </aside> : <dialog ref={dialog} id={`${id}-dialog`} className="exam-comments-dialog" aria-labelledby={`${id}-title`}
      onClose={() => setOpen(false)} onCancel={() => setOpen(false)} onKeyDown={event => {
        if (event.key !== 'Tab') return;
        const items = Array.from(event.currentTarget.querySelectorAll<HTMLElement>('button:not([disabled]),input:not([disabled]),textarea:not([disabled]),a[href],select:not([disabled]),[tabindex="0"]'))
          .filter(element => element.getClientRects().length > 0);
        const first = items[0];
        const last = items[items.length - 1];
        if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last?.focus(); }
        else if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first?.focus(); }
      }} onClick={event => {
        const bounds = event.currentTarget.getBoundingClientRect();
        if (event.target === event.currentTarget && event.clientX < bounds.left) setOpen(false);
      }}>
      <div className="exam-comments-sheet">
        <header className="exam-comments-sheet-heading"><h2 id={`${id}-title`}>{en ? "Exam comments" : "시험 댓글"}</h2>
          <button type="button" className="icon-button" autoFocus aria-label={en ? "Close comments" : "댓글 닫기"} onClick={() => setOpen(false)}><Icon name="close" /></button>
        </header>
        {activated && <Forum examId={examId} locale={locale} />}
      </div>
    </dialog>}
  </>;
}
