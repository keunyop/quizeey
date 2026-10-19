"use client";

import { Fragment, useEffect, useId, useRef, useState } from "react";
import type { Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";
import type { OwnedPost, PublicPost, PublicTopic } from "@/server/forum-database";

function TextBody({ value }: { value: string }) {
  return <p className="forum-body">{value.split(/(https?:\/\/[^\s<>]+)/g).map((part, i) => /^https?:\/\//.test(part)
    ? <a key={i} href={part} rel="ugc nofollow noopener noreferrer">{part}</a> : <Fragment key={i}>{part}</Fragment>)}</p>;
}

export function Forum({ examId, questionId, locale }: { examId: string; questionId?: string; locale: Locale }) {
  const en = locale === "en";
  const id = useId();
  const textarea = useRef<HTMLTextAreaElement>(null);
  const composer = useRef<HTMLDetailsElement>(null);
  const sending = useRef(false);
  const retry = useRef<{ signature: string; key: string } | null>(null);
  const [data, setData] = useState<{ topics: PublicTopic[]; posts: PublicPost[]; own: OwnedPost[] }>({ topics: [], posts: [], own: [] });
  const [cursors, setCursors] = useState<(string | null)[]>([null]);
  const [nextCursor, setNextCursor] = useState<string | null>(null);
  const cursor = cursors[cursors.length - 1];
  const [revision, refresh] = useState(0);
  const [name, setName] = useState("");
  const [body, setBody] = useState("");
  const [editing, setEditing] = useState<string | null>(null);
  const [reply, setReply] = useState<{ topicId: string; parentId?: string } | null>(null);
  const [busy, setBusy] = useState(false);
  const [notice, setNotice] = useState("");
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState(false);
  const [ownError, setOwnError] = useState(false);

  useEffect(() => {
    const controller = new AbortController();
    const query = new URLSearchParams({ testId: examId, locale, ...(questionId ? { questId: questionId } : {}) });
    if (cursor) query.set('cursor', cursor);
    const options = { cache: "no-store" as const, signal: AbortSignal.any([controller.signal, AbortSignal.timeout(10000)]) };
    let redirected = false;
    // Resolve ownership only for the bounded public page; failure cannot hide it.
    void fetch("/api/forum?" + query, options).then(async result => {
      if (!result.ok) throw new Error();
      const visible = await result.json();
      if (!controller.signal.aborted) {
        if (!visible.posts.length && cursor) {
          redirected = true;
          setCursors(current => current.slice(0, -1));
          return;
        }
        setData({ topics: visible.topics, posts: visible.posts, own: [] });
        setNextCursor(visible.nextCursor);
        setLoadError(false);
        setLoading(false);
        if (!visible.posts.length) { setOwnError(false); return; }
        try {
          const ownQuery = new URLSearchParams({ posts: visible.posts.map((post: PublicPost) => post.id).join(',') });
          const ownedResult = await fetch('/api/forum/mine?' + ownQuery, options);
          if (!ownedResult.ok) throw new Error();
          const owned = await ownedResult.json();
          if (!controller.signal.aborted) { setData(current => ({ ...current, own: owned.posts })); setOwnError(false); }
        } catch { if (!controller.signal.aborted) setOwnError(true); }
      }
    }).catch(() => { if (!controller.signal.aborted) setLoadError(true); })
      .finally(() => { if (!controller.signal.aborted && !redirected) setLoading(false); });
    return () => controller.abort();
  }, [examId, questionId, locale, revision, cursor]);

  async function send(value: Record<string, unknown>) {
    if (sending.current) return;
    sending.current = true;
    setBusy(true); setNotice("");
    try {
      const signature = JSON.stringify(value);
      if (retry.current?.signature !== signature) retry.current = { signature, key: crypto.randomUUID() };
      const result = await fetch("/api/forum", {
        method: "POST", headers: { "Content-Type": "application/json", "Idempotency-Key": retry.current.key },
        body: signature, signal: AbortSignal.timeout(15000),
      });
      if (!result.ok) {
        if (result.status < 500) retry.current = null;
        setNotice(result.status === 429 ? en ? "Try again in a few minutes." : "잠시 후 다시 시도해 주세요." : result.status === 403 ? en ? "This browser cannot change this comment." : "이 브라우저에서는 댓글을 변경할 수 없습니다." : en ? "Unable to save. Please try again." : "저장하지 못했습니다. 다시 시도해 주세요.");
        return;
      }
      retry.current = null;
      setNotice(value.action === "report" ? en ? "Report received." : "신고가 접수되었습니다." : value.action === "delete" ? en ? "Comment deleted." : "댓글을 삭제했습니다." : "");
      if (["create", "reply", "edit"].includes(String(value.action))) { setBody(""); setEditing(null); setReply(null); }
      if (["create", "reply"].includes(String(value.action))) setCursors([null]);
      setLoading(true);
      refresh(v => v + 1);
    } catch { setNotice(en ? "Connection failed. Your draft is kept; try again." : "연결에 실패했습니다. 작성한 내용은 유지됩니다. 다시 시도해 주세요."); }
    finally { sending.current = false; setBusy(false); }
  }

  function edit(post: OwnedPost) {
    setEditing(post.id); setReply(null); setName(post.display_name ?? ""); setBody(post.pending_body ?? post.body); focusComposer();
  }
  function focusComposer() {
    if (composer.current) composer.current.open = true;
    requestAnimationFrame(() => textarea.current?.focus());
  }
  function remove(postId: string) {
    if (window.confirm(en ? "Delete this comment?" : "이 댓글을 삭제할까요?")) void send({ action: "delete", postId });
  }
  const ownById = new Map(data.own.map(post => [post.id, post]));
  const heading = questionId ? en ? "Question comments" : "문제 댓글" : en ? "Exam comments" : "시험 댓글";
  return <section className={`forum${questionId ? " question-forum" : ""}`} aria-labelledby={`${id}-heading`}>
    <div className="forum-heading"><h2 id={`${id}-heading`}>{heading}</h2></div>
    <p className="forum-intro">{questionId ? en ? "Share a question or explanation about this problem." : "이 문제에 대한 질문이나 풀이를 나눠보세요." : en ? "Share study tips and questions about this exam." : "이 시험의 공부 방법과 궁금한 점을 나눠보세요."}</p>
    <details className="comment-composer" ref={composer} open={(!loading && !loadError && data.posts.length === 0) || undefined}>
      <summary>{en ? "Write a comment" : "댓글 남기기"}</summary>
      <form className="forum-form" aria-label={heading} onSubmit={event => {
      event.preventDefault();
      if (!body.trim()) { textarea.current?.focus(); return; }
      const base = { body: body.trim(), displayName: name };
      void send(editing ? { action: "edit", postId: editing, ...base } : reply ? { action: "reply", ...reply, ...base } : { action: "create", examId, ...(questionId ? { questionId } : {}), locale, title: body.trim().replace(/\s+/g, " ").slice(0, 100), ...base });
    }}>
      {(editing || reply) && <p className="forum-context">{editing ? en ? "Editing your comment" : "내 댓글 수정 중" : en ? "Writing a reply" : "답글 작성 중"}</p>}
      <label htmlFor={`${id}-name`}>{en ? "Name (optional)" : "작성자명 (선택)"}</label>
      <input id={`${id}-name`} name="displayName" autoComplete="nickname" maxLength={80} value={name} disabled={busy} onChange={e => setName(e.target.value)} placeholder={en ? "Leave blank for Anonymous" : "비워두면 익명으로 등록됩니다"} />
      <label htmlFor={`${id}-body`}>{editing ? en ? "Edit comment" : "댓글 수정" : reply ? en ? "Reply" : "답글" : en ? "Comment" : "댓글"}</label>
      <textarea id={`${id}-body`} ref={textarea} name="body" rows={3} required maxLength={4000} value={body} disabled={busy} onChange={e => setBody(e.target.value)} placeholder={en ? "Write a comment." : "댓글을 입력해 주세요."} />
      <div className="actions"><button className="primary" type="submit" disabled={busy || !body.trim()}>{busy ? en ? "Saving…" : "등록 중…" : en ? "Post comment" : "댓글 등록"}</button>
        {(editing || reply) && <button type="button" disabled={busy} onClick={() => { setEditing(null); setReply(null); setBody(""); }}>{en ? "Cancel" : "취소"}</button>}</div>
      <p className="forum-notice" role="status" aria-live="polite">{notice}</p>
      </form>
    </details>
    {loading && <p className="forum-loading" role="status">{en ? "Loading comments…" : "댓글을 불러오는 중…"}</p>}
    {(loadError || ownError) && <p className="forum-notice" role="status">{loadError ? en ? "Unable to load comments." : "댓글을 불러오지 못했습니다." : en ? "Unable to load your comments." : "내 댓글을 불러오지 못했습니다."}{" "}<button type="button" className="text-button" onClick={() => { setLoading(true); refresh(v => v + 1); }}>{en ? "Retry" : "다시 시도"}</button></p>}
    {!loading && !loadError && !data.posts.length && <p className="forum-empty">{en ? "No comments yet. Start the conversation." : "아직 댓글이 없습니다. 첫 댓글을 남겨보세요."}</p>}
    {!loading && !loadError && <div className="forum-comments" aria-busy={loading}>
      {data.posts.map(post => {
        const own = ownById.get(post.id);
        return <article className={post.parent_id ? "forum-post reply" : "forum-post"} key={post.id}>
          <div className="forum-post-meta"><strong>{post.display_name || messages[locale].anonymous}</strong><time dateTime={post.created_at}>{new Intl.DateTimeFormat(en ? "en-CA" : "ko-KR", { dateStyle: "medium", timeZone: "UTC" }).format(new Date(post.created_at))}</time></div>
          <TextBody value={post.body} />
          <div className="actions"><button type="button" disabled={busy} onClick={() => { setReply({ topicId: post.topic_id, parentId: post.id }); setEditing(null); setBody(""); focusComposer(); }}>{en ? "Reply" : "답글"}</button>
            {own && <><button type="button" disabled={busy} onClick={() => edit(own)}>{en ? "Edit" : "수정"}</button><button type="button" disabled={busy} onClick={() => remove(post.id)}>{en ? "Delete" : "삭제"}</button></>}
            <button type="button" disabled={busy} onClick={() => { const reason = window.prompt(en ? "Report reason" : "신고 사유"); if (reason?.trim()) void send({ action: "report", postId: post.id, reason: reason.trim() }); }}>{en ? "Report" : "신고"}</button></div>
        </article>;
      })}
    </div>}
    {(cursors.length > 1 || nextCursor) && <nav className="forum-pagination" aria-label={en ? "Comment pages" : "댓글 페이지"}>
      <button type="button" aria-label={en ? "Previous comments" : "이전 댓글"} disabled={busy || loading || cursors.length === 1} onClick={() => { setLoading(true); setCursors(current => current.slice(0, -1)); }}>{en ? "Previous" : "이전"}</button>
      <span role="status">{en ? `Page ${cursors.length}` : `${cursors.length} 페이지`}</span>
      <button type="button" aria-label={en ? "Next comments" : "다음 댓글"} disabled={busy || loading || !nextCursor} onClick={() => { if (nextCursor) { setLoading(true); setCursors(current => [...current, nextCursor]); } }}>{en ? "Next" : "다음"}</button>
    </nav>}
  </section>;
}
