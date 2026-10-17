import pg from "pg";
import type { z } from "zod";
import type { forumRequest } from "./guest-policy";
import { environment } from "@/lib/environment";

let pool: pg.Pool | undefined;
export function forumConfigured() { return !!process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL; }
export function forumConnection() {
  const env = environment(process.env);
  const raw = process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL;
  if (env.stage !== "local" || !raw) throw new Error("Local forum is unavailable");
  const url = new URL(raw);
  if (url.protocol !== "postgresql:" || url.hostname !== "127.0.0.1" || url.port !== "55432" ||
      url.username !== "quizeey_server" || url.password || url.pathname !== "/quizeey_fixture" || url.search || url.hash) {
    throw new Error("Refusing a database outside the isolated local fixture");
  }
  // This shared resource is a connection pool, never a request/user/capability cache.
  pool ??= new pg.Pool({ connectionString: url.href, max: 4, idleTimeoutMillis: 10000, connectionTimeoutMillis: 3000,
    statement_timeout: 3000, application_name: "quizeey-local-forum-fixture" });
  return pool;
}
export async function mutateForum(capabilityHash: string, abuseHash: string, requestId: string, value: z.infer<typeof forumRequest>) {
  const { action, ...payload } = value;
  const result = await forumConnection().query<{ result: { status: number; postId?: string; topicId?: string; revisionId?: string; visibility?: string } }>(
    "select public.quizeey_forum_mutate($1,$2,$3,$4,$5) as result", [capabilityHash, abuseHash, requestId, action, payload]);
  return result.rows[0].result;
}
export type PublicTopic = { id: string; title: string; locale: "ko" | "en"; created_at: string };
export type PublicPost = { id: string; topic_id: string; parent_id: string | null; display_name: string | null; body: string; created_at: string };
export type OwnedPost = PublicPost & { visibility: "pending" | "approved"; exam_id: string; question_id: string | null; locale: "ko" | "en"; title: string; pending_body: string | null };
export async function publicForum(examId: string, locale: "ko" | "en", questionId: string | null) {
  const db = forumConnection();
  // quizeey_server inherits anon SELECT permissions/RLS. It has no table write grant.
  // Old MySQL explanations were keyed only by question ID, shared across locales.
  // This reserved import namespace keeps that behavior without sharing new topics.
  const topics = await db.query<PublicTopic>("select id,title,locale,created_at from public.quizeey_topics where exam_id=$1 and question_id is not distinct from $3 and (locale=$2 or ($3::text is not null and source_thread_id='mysql:question:'||$3)) order by created_at desc,id limit 20", [examId, locale, questionId]);
  const ids = topics.rows.map((t) => t.id);
  const posts = ids.length ? await db.query<PublicPost>("select id,topic_id,parent_id,display_name,body,created_at from public.quizeey_posts where topic_id=any($1::uuid[]) order by created_at,id limit 50", [ids]) : { rows: [] };
  return { topics: topics.rows, posts: posts.rows };
}
export async function ownForum(hash: string): Promise<OwnedPost[]> {
  const result = await forumConnection().query<{ result: OwnedPost[] }>("select public.quizeey_forum_mine($1) as result", [hash]);
  return result.rows[0].result;
}
