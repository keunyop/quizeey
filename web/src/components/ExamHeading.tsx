"use client";
import { useId, useState, type ReactNode } from "react";
import type { Locale } from "@/lib/contracts";

export function ExamHeading({ title, locale, description, children }: { title: string; locale: Locale; description: string[]; children?: ReactNode }) {
  const [open, setOpen] = useState(false);
  const id = useId();
  return <div className="page-heading study-heading">
    <div className="exam-title-line"><h1>{title}</h1>
      {description.some(Boolean) && <button type="button" className="exam-info-trigger" aria-label={locale === "ko" ? "시험 기본정보" : "About this exam"} aria-expanded={open} aria-controls={id} onClick={() => setOpen(value => !value)}>
        <span>{locale === "ko" ? <><span className="exam-info-extra">시험 </span>기본정보</> : <>About<span className="exam-info-extra"> this exam</span></>}</span><span aria-hidden="true">{open ? "⌃" : "⌄"}</span>
      </button>}{children}
    </div>
    <div id={id} hidden={!open} className="exam-info-description">{description.filter(Boolean).map((text, index) => <p className="exam-description" key={index}>{text}</p>)}</div>
  </div>;
}
