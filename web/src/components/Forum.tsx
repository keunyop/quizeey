"use client";
import { Fragment, useEffect, useState } from "react";
import type { Locale } from "@/lib/contracts";
import { messages } from "@/lib/i18n";
import type { OwnedPost, PublicPost, PublicTopic } from "@/server/forum-database";

function TextBody({ value }: { value: string }) {
  return <p className="forum-body">{value.split(/(https?:\/\/[^\s<>]+)/g).map((part, i) => /^https?:\/\//.test(part)
    ? <a key={i} href={part} rel="ugc nofollow noopener noreferrer">{part}</a> : <Fragment key={i}>{part}</Fragment>)}</p>;
}

export function Forum({ examId, questionId, locale }: { examId: string; questionId?: string; locale: Locale }) {
  const en = locale === "en";
  const [data, setData] = useState<{ topics: PublicTopic[]; posts: PublicPost[]; own: OwnedPost[] }>({ topics: [], posts: [], own: [] });
  const [revision, refresh] = useState(0);
  const [name, setName] = useState(""); const [title, setTitle] = useState(""); const [body, setBody] = useState("");
  const [editing, setEditing] = useState<string | null>(null);
  const [reply, setReply] = useState<{ topicId: string; parentId?: string } | null>(null);
  const [busy, setBusy] = useState(false); const [notice, setNotice] = useState("");
  const [loadError, setLoadError] = useState(false);
  useEffect(() => {
    let active = true;
    const query = new URLSearchParams({ testId: examId, locale, ...(questionId ? { questId: questionId } : {}) });
    Promise.all([fetch("/api/forum?" + query, { cache: "no-store" }), fetch("/api/forum/mine", { cache: "no-store" })])
      .then(async ([publicResult, privateResult]) => {
        if (!publicResult.ok || !privateResult.ok) throw new Error("Unavailable");
        const [visible, owned] = await Promise.all([publicResult.json(), privateResult.json()]);
        if (active) { setData({ topics: visible.topics, posts: visible.posts, own: owned.posts.filter((p: OwnedPost) => p.exam_id === examId && p.locale === locale && p.question_id === (questionId ?? null)) }); setLoadError(false); }
      }).catch(() => { if (active) setLoadError(true); });
    return () => { active = false; };
  }, [examId, questionId, locale, revision]);

  async function send(value: Record<string, unknown>) {
    setBusy(true); setNotice("");
    try {
      const result = await fetch("/api/forum", { method: "POST", headers: { "Content-Type": "application/json", "Idempotency-Key": crypto.randomUUID() }, body: JSON.stringify(value) });
      await result.json();
      if (!result.ok) {
        setNotice(result.status === 429 ? en ? "Try again later." : "잠시 후 다시 시도해 주세요." : result.status === 403 ? en ? "This browser cannot change this post." : "이 브라우저에서는 글을 변경할 수 없습니다." : en ? "Unable to save. Check your input and try again." : "저장할 수 없습니다. 입력을 확인하고 다시 시도해 주세요.");
        return;
      }
      setNotice(result.status === 202 ? en ? "Submitted for review." : "검토 후 공개됩니다." : en ? "Saved." : "저장했습니다.");
      setBody(""); setTitle(""); setEditing(null); setReply(null); refresh((v) => v + 1);
    } catch { setNotice(en ? "Connection failed. Try again." : "연결에 실패했습니다. 다시 시도해 주세요."); }
    finally { setBusy(false); }
  }
  return <section className="forum" aria-labelledby="forum-heading">
    <h2 id="forum-heading">{messages[locale].discussion}</h2>
    {loadError && <p role="status">{en ? "Discussion is unavailable. Try again later." : "토론을 불러올 수 없습니다. 잠시 후 다시 시도해 주세요."}</p>}
    {data.topics.map((topic) => <article className="forum-topic" key={topic.id}>
      <h3>{topic.title}</h3>
      {data.posts.filter((p) => p.topic_id === topic.id).map((post) => <div className={post.parent_id ? "forum-post reply" : "forum-post"} key={post.id}>
        <span className="small muted">{post.display_name || messages[locale].anonymous}</span>
        <TextBody value={post.body} />
        <div className="actions"><button onClick={() => { setReply({ topicId: topic.id, parentId: post.id }); setEditing(null); setBody(""); document.getElementById("forum-body")?.focus(); }}>{en ? "Reply" : "답글"}</button>
          <button onClick={() => { const reason = window.prompt(en ? "Report reason" : "신고 사유"); if (reason?.trim()) void send({ action: "report", postId: post.id, reason: reason.trim() }); }}>{en ? "Report" : "신고"}</button></div>
      </div>)}
    </article>)}
    <form className="forum-form" onSubmit={(event) => {
      event.preventDefault();
      const base = { body, displayName: name };
      void send(editing ? { action: "edit", postId: editing, ...base } : reply ? { action: "reply", ...reply, ...base } : { action: "create", examId, ...(questionId ? { questionId } : {}), locale, title, ...base });
    }}>
      <label htmlFor="forum-name">{en ? "Name (optional)" : "이름 (선택)"}</label>
      <input id="forum-name" name="displayName" autoComplete="off" maxLength={80} value={name} onChange={(e) => setName(e.target.value)} placeholder={messages[locale].anonymous} />
      {!reply && !editing && <><label htmlFor="forum-title">{en ? "Title" : "제목"}</label><input id="forum-title" name="title" autoComplete="off" maxLength={120} required value={title} onChange={(e) => setTitle(e.target.value)} /></>}
      <label htmlFor="forum-body">{editing ? en ? "Edit post" : "글 수정" : reply ? en ? "Reply" : "답글" : en ? "Post" : "글"}</label>
      <textarea id="forum-body" name="body" rows={4} required maxLength={4000} value={body} onChange={(e) => setBody(e.target.value)} />
      <div className="actions"><button className="primary" type="submit" disabled={busy}>{busy ? en ? "Saving…" : "저장 중…" : en ? "Submit" : "등록"}</button>
        {(editing || reply) && <button type="button" onClick={() => { setEditing(null); setReply(null); setBody(""); }}>{en ? "Cancel" : "취소"}</button>}</div>
    </form>
    <p role="status">{notice}</p>
    {data.own.length > 0 && <div className="own-posts"><h3>{en ? "Your posts in this browser" : "이 브라우저에서 작성한 글"}</h3>
      <p className="small muted">{en ? "Edit or delete here. Clearing cookies removes access." : "여기서 수정·삭제할 수 있습니다. 쿠키를 지우면 접근 권한이 사라집니다."}</p>
      {data.own.map((post) => <article className="forum-post" key={post.id}>
        <p className="small muted">{post.visibility === "pending" || post.pending_body ? en ? "Pending review" : "검토 대기" : en ? "Published" : "공개"}</p>
        <TextBody value={post.pending_body ?? post.body} />
        <div className="actions"><button onClick={() => { setEditing(post.id); setReply(null); setName(post.display_name ?? ""); setBody(post.pending_body ?? post.body); document.getElementById("forum-body")?.focus(); }}>{en ? "Edit" : "수정"}</button>
          <button disabled={busy} onClick={() => { if (window.confirm(en ? "Delete this post?" : "이 글을 삭제할까요?")) void send({ action: "delete", postId: post.id }); }}>{en ? "Delete" : "삭제"}</button></div>
      </article>)}
    </div>}
  </section>;
}
