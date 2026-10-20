import "server-only";
import { forumConnection, hostedForumTransport } from "./forum-database";
import type { AdminOverview, InboxItem, InboxKind, StoredSubmission } from "@/lib/submissions";

export async function submitFeedback(requestId: string, abuseHash: string, payload: StoredSubmission) {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc("quizeey_submit_feedback", { p_request_id: requestId, p_abuse_hash: abuseHash, p_payload: payload });
  return (await forumConnection().query<{ result: { status: number } }>("select public.quizeey_submit_feedback($1,$2,$3) as result", [requestId, abuseHash, payload])).rows[0].result;
}
export async function adminCredential(username: string) {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc("quizeey_admin_credential", { p_username: username });
  return (await forumConnection().query<{ result: { actor_id: string; salt: string; password_hash: string } | null }>("select public.quizeey_admin_credential($1) as result", [username])).rows[0].result;
}
export async function adminOverview(): Promise<AdminOverview> {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc("quizeey_admin_overview", {});
  return (await forumConnection().query<{ result: AdminOverview }>("select public.quizeey_admin_overview() as result")).rows[0].result;
}
export async function adminInbox(kind: InboxKind, state: "all" | "open" | "resolved", cursor?: { time: string; id: string }) {
  const hosted = hostedForumTransport();
  const items = hosted ? await hosted.rpc("quizeey_admin_inbox", { p_kind: kind, p_state: state, p_cursor_time: cursor?.time ?? null, p_cursor_id: cursor?.id ?? null })
    : (await forumConnection().query<{ result: InboxItem[] }>("select public.quizeey_admin_inbox($1,$2,$3,$4) as result", [kind, state, cursor?.time ?? null, cursor?.id ?? null])).rows[0].result;
  const page = items.slice(0, 20), last = page.at(-1);
  return { items: page, nextCursor: items.length > 20 && last ? Buffer.from(JSON.stringify({ time: last.created_at, id: last.id })).toString("base64url") : null };
}
export async function resolveSubmission(actorId: string, requestId: string, id: string, state: "open" | "resolved") {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc("quizeey_admin_resolve_submission", { p_actor_id: actorId, p_request_id: requestId, p_id: id, p_state: state });
  return (await forumConnection().query<{ result: { status: number } }>("select public.quizeey_admin_resolve_submission($1,$2,$3,$4) as result", [actorId, requestId, id, state])).rows[0].result;
}
