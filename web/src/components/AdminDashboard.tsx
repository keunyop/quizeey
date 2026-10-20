"use client";
import { useEffect, useState } from "react";
import { legacy, type Locale } from "@/lib/contracts";
import { examName, matchesExam, sortExams } from "@/lib/exam-catalog";
import type { AdminOverview, InboxItem, InboxKind } from "@/lib/submissions";

const routes = legacy.routes.filter(route => route.testId && !route.path.startsWith("/kr/"));
export function AdminDashboard({ locale, revision, onExpired }: { locale: Locale; revision: number; onExpired: () => void }) {
  const en = locale === "en";
  const [tab, setTab] = useState<"exams" | "activity" | InboxKind>("exams");
  const [state, setState] = useState<"all" | "open" | "resolved">("all");
  const [overview, setOverview] = useState<AdminOverview | null>(null);
  const [items, setItems] = useState<InboxItem[]>([]), [cursor, setCursor] = useState<string | null>(null);
  const [query, setQuery] = useState(""), [limit, setLimit] = useState(20);
  const [busy, setBusy] = useState(false), [error, setError] = useState("");
  const [change, refresh] = useState(0);
  const failure = en ? "Unable to load. Please try again." : "불러오지 못했습니다. 다시 시도해주세요.";
  const labels = { exams: en ? "Exam clicks" : "시험별 클릭 수", comments: en ? "Latest comments" : "최신 댓글", feedback: en ? "Feedback" : "피드백", question_report: en ? "Question reports" : "오답 신고", activity: en ? "Recent activity" : "최근 처리 이력" };
  useEffect(() => {
    let active = true;
    async function load() {
      try {
        const [summary, inbox] = await Promise.all([
          fetch("/api/admin/overview", { cache: "no-store" }),
          tab === "exams" || tab === "activity" ? Promise.resolve(null) : fetch("/api/admin/inbox?" + new URLSearchParams({ kind: tab, state }), { cache: "no-store" }),
        ]);
        if ([summary, inbox].some(response => response?.status === 401 || response?.status === 403)) { if (active) onExpired(); return; }
        if (!summary.ok || (inbox && !inbox.ok)) throw new Error();
        const [totals, page] = await Promise.all([summary.json(), inbox?.json()]);
        if (active) { setOverview(totals); setItems(page?.items ?? []); setCursor(page?.nextCursor ?? null); setError(""); }
      } catch { if (active) setError(failure); }
    }
    void load(); return () => { active = false; };
  }, [tab, state, revision, change, onExpired, failure]);

  async function more() {
    if (!cursor) return; setBusy(true);
    try {
      const response = await fetch("/api/admin/inbox?" + new URLSearchParams({ kind: tab, state, cursor }), { cache: "no-store" });
      if (response.status === 401 || response.status === 403) { onExpired(); return; }
      if (!response.ok) throw new Error(); const page = await response.json();
      setItems(old => [...new Map<string, InboxItem>([...old, ...page.items].map(item => [item.id, item])).values()]); setCursor(page.nextCursor);
    } catch { setError(failure); } finally { setBusy(false); }
  }
  async function resolve(item: InboxItem) {
    setBusy(true); setError("");
    try {
      const response = await fetch("/api/admin/inbox", { method: "PATCH", headers: { "Content-Type": "application/json", "Idempotency-Key": crypto.randomUUID() }, body: JSON.stringify({ id: item.id, state: item.state === "resolved" ? "open" : "resolved" }) });
      if (response.status === 401 || response.status === 403) { onExpired(); return; }
      if (!response.ok) throw new Error(); refresh(value => value + 1);
    } catch { setError(failure); } finally { setBusy(false); }
  }
  const localized = [...new Map(routes.map(route => [route.testId, routes.find(item => item.testId === route.testId && item.locale === locale) ?? route])).values()];
  const exams = sortExams(localized.filter(route => matchesExam(route, query)), locale, "popular", overview?.clicks ?? {});
  const total = Object.values(overview?.clicks ?? {}).reduce((sum, count) => sum + BigInt(count), 0n);
  function date(value: string) { return new Date(value).toLocaleString(en ? "en-US" : "ko-KR"); }
  function context(item: InboxItem) { return routes.find(route => route.testId === item.exam_id && route.locale === item.locale); }
  function link(item: InboxItem) { const path = context(item)?.path ?? item.path ?? (en ? "/en" : "/"); return item.question_id ? `${path}?questId=${item.question_id}` : path; }
  const activityNames: Record<string, string> = en ? { submission_resolved: "Submission resolved", submission_open: "Submission reopened", approve: "Comment approved", hide: "Comment hidden", delete: "Comment deleted", resolve_report: "Comment report resolved" }
    : { submission_resolved: "피드백·오답 신고 처리 완료", submission_open: "피드백·오답 신고 다시 열기", approve: "댓글 승인", hide: "댓글 숨김", delete: "댓글 삭제", resolve_report: "댓글 신고 처리" };
  const commentStates: Record<string, string> = en ? { pending: "Pending review", approved: "Published", hidden: "Hidden" } : { pending: "검토 대기", approved: "공개", hidden: "숨김" };
  return <section className="admin-dashboard" aria-label={en ? "Site management" : "사이트 관리"}>
    {overview && <dl className="admin-stats">
      {[ [en ? "Total exam clicks" : "전체 시험 클릭 수", total.toLocaleString(locale)], [en ? "Comments" : "전체 댓글", overview.comments], [en ? "Open feedback" : "미처리 피드백", overview.feedback_open], [en ? "Open question reports" : "미처리 오답 신고", overview.question_reports_open], [en ? "Open comment reports" : "미처리 댓글 신고", overview.comment_reports_open] ].map(([label, count]) => <div key={label}><dt>{label}</dt><dd>{count}</dd></div>)}
    </dl>}
    <div className="actions admin-tabs" role="group" aria-label={en ? "Management views" : "관리 항목"}>{(Object.keys(labels) as (keyof typeof labels)[]).map(key => <button key={key} aria-pressed={tab === key} disabled={busy} onClick={() => { setTab(key); setItems([]); setCursor(null); setState("all"); setError(""); }}>{labels[key]}</button>)}</div>
    <h2>{labels[tab]}</h2>
    {tab === "exams" && <>
      <label htmlFor="admin-exam-search">{en ? "Find an exam" : "시험 검색"}</label><input id="admin-exam-search" type="search" value={query} onChange={event => { setQuery(event.target.value); setLimit(20); }} />
      <div className="admin-table-scroll"><table><caption className="sr-only">{labels.exams}</caption><thead><tr><th>{en ? "Exam" : "시험"}</th><th>{en ? "Clicks" : "클릭 수"}</th></tr></thead><tbody>{exams.slice(0, limit).map(route => <tr key={route.testId}><td><a href={route.path}>{examName(route)}</a></td><td>{BigInt(overview?.clicks[route.testId!] ?? "0").toLocaleString(locale)}</td></tr>)}</tbody></table></div>
      {exams.length > limit && <button onClick={() => setLimit(value => value + 20)}>{en ? "More exams" : "시험 더 보기"}</button>}
    </>}
    {(tab === "feedback" || tab === "question_report") && <div className="actions">{(["all", "open", "resolved"] as const).map(value => <button key={value} disabled={busy} aria-pressed={state === value} onClick={() => { setState(value); setItems([]); setCursor(null); }}>{value === "all" ? en ? "All" : "전체" : value === "open" ? en ? "Open" : "미처리" : en ? "Resolved" : "처리 완료"}</button>)}</div>}
    {tab !== "exams" && tab !== "activity" && <>
      <p className="small muted">{en ? "Newest first" : "최신 등록 순"}</p>
      {!items.length && <p>{en ? "No entries." : "등록된 내역이 없습니다."}</p>}
      {items.map(item => <article className="panel admin-entry" key={item.id}>
        <div className="admin-entry-meta"><a href={link(item)}>{context(item) ? examName(context(item)!) : item.path || (en ? "Site feedback" : "사이트 피드백")}{item.question_id && ` · ${en ? "Question" : "문제"} ${item.question_id}`}</a><time dateTime={item.created_at}>{date(item.created_at)}</time></div>
        {tab === "comments" && <p className="small muted">{item.display_name || (en ? "Anonymous" : "익명")} · {commentStates[item.state] ?? item.state}</p>}
        <p className="forum-body">{item.body}</p>
        {tab !== "comments" && <div className="actions"><span>{item.state === "resolved" ? en ? "Resolved" : "처리 완료" : en ? "Open" : "미처리"}</span><button disabled={busy} onClick={() => resolve(item)}>{item.state === "resolved" ? en ? "Reopen" : "다시 열기" : en ? "Mark resolved" : "처리 완료로 변경"}</button></div>}
      </article>)}
      {cursor && <button disabled={busy} onClick={more}>{en ? "More entries" : "내역 더 보기"}</button>}
    </>}
    {tab === "activity" && <ul className="admin-activity">{overview?.activity.map((item, index) => <li key={index}><span>{activityNames[item.action] ?? item.action}</span> <time dateTime={item.created_at}>{date(item.created_at)}</time></li>)}</ul>}
    <p role="status" className="error">{error}</p>
  </section>;
}
