"use client";
import { useId, useState, type ReactNode } from "react";
import type { Locale } from "@/lib/contracts";

export function ExamHeading({ title, locale, description, children }: { title: string; locale: Locale; description: string[]; children?: ReactNode }) {
  const [open, setOpen] = useState(false);
  const id = useId();
  return <div className="page-heading study-heading">
    <div className="exam-title-line"><h1>{title}</h1>
      {description.some(Boolean) && <button type="button" className="text-button exam-info-trigger" aria-expanded={open} aria-controls={id} onClick={() => setOpen(value => !value)}>
        {locale === "ko" ? '시험정보' : 'Exam info'}
      </button>}{children}
    </div>
    <div id={id} hidden={!open} className="exam-info-description">{description.filter(Boolean).map((text, index) => <p className="exam-description" key={index}>{text}</p>)}</div>
  </div>;
}
