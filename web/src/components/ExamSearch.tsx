"use client";
import { useState } from "react";
import type { LegacyRoute, Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";

function normalized(value: string) { return value.toLocaleLowerCase().replace(/[\s–-]/g, ""); }
function initials(value: string) {
  const cho = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
  return Array.from(value).map((c) => { const code = c.charCodeAt(0) - 44032; return code >= 0 && code < 11172 ? cho[Math.floor(code / 588)] : c; }).join("");
}
export function ExamSearch({ routes, locale }: { routes: LegacyRoute[]; locale: Locale }) {
  const [search, setSearch] = useState("");
  const term = normalized(search);
  const filtered = routes.filter((r) => normalized(r.title + r.headings.join(" ") + r.path + (r.testId === "5" ? " SQLD SQL개발자" : "")).includes(term) || normalized(initials(r.headings.join(" "))).includes(term));
  return <>
    <label className="search-label" htmlFor="exam-search">{messages[locale].search}</label>
    <input className="search" id="exam-search" name="exam-search" type="search" autoComplete="off" value={search} onChange={(e) => setSearch(e.target.value)} />
    <ul className="exam-list">{filtered.map((r) => <li key={r.path}><a href={r.path}>{r.headings[0] || r.title}</a></li>)}</ul>
    {!filtered.length && <p role="status">{locale === "ko" ? "검색 결과가 없습니다." : "No matching exams."}</p>}
  </>;
}
