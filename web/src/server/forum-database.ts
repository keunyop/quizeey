import pg from "pg";
import type { z } from "zod";
import type { forumRequest } from "./guest-policy";
import { environment } from "@/lib/environment";
import { forumConfiguration } from './forum-config';
import { createSupabaseTransport } from './supabase-transport';
import { encodeForumCursor, type ForumCursor } from '@/lib/forum-page';
import { includeForumAncestors } from './forum-ancestors';

let pool: pg.Pool | undefined;
export function forumConfigured() { return forumConfiguration() !== null; }
export function hostedForumTransport() {
  return forumConfiguration()?.kind === 'supabase' ? createSupabaseTransport() : null;
}
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
  const hosted = hostedForumTransport();
  if (hosted) return hosted.rpc('quizeey_forum_mutate', { p_capability_hash: capabilityHash, p_abuse_hash: abuseHash, p_request_id: requestId, p_action: action, p_payload: payload });
  const result = await forumConnection().query<{ result: { status: number; postId?: string; topicId?: string; revisionId?: string; visibility?: string } }>(
    "select public.quizeey_forum_mutate($1,$2,$3,$4,$5) as result", [capabilityHash, abuseHash, requestId, action, payload]);
  return result.rows[0].result;
}
export type PublicTopic = { id: string; title: string; locale: "ko" | "en"; created_at: string };
export type PublicPost = { id: string; topic_id: string; parent_id: string | null; display_name: string | null; body: string; created_at: string };
export type OwnedPost = PublicPost & { visibility: "pending" | "approved"; exam_id: string; question_id: string | null; locale: "ko" | "en"; title: string; pending_body: string | null };
export type ForumPage = { topics: PublicTopic[]; posts: PublicPost[]; nextCursor: string | null };
export async function publicForum(examId: string, locale: "ko" | "en", questionId: string | null, cursor: ForumCursor | null = null): Promise<ForumPage> {
  const hosted = hostedForumTransport();
  if (hosted) return hosted.publicForum(examId, locale, questionId, cursor);
  const result = await forumConnection().query<{ result: { topics: PublicTopic[]; posts: PublicPost[]; next: ForumCursor | null } }>(
    'select public.quizeey_forum_page($1,$2,$3,$4,$5) as result', [examId, locale, questionId, cursor?.createdAt ?? null, cursor?.id ?? null]);
  const page = result.rows[0].result;
  const posts = await includeForumAncestors(page.posts, async (ids, topicIds) => {
    // Match the anonymous hosted reader's RLS explicitly on the local transport.
    const parents = await forumConnection().query<PublicPost>(
      `select p.id,p.topic_id,p.parent_id,p.display_name,p.body,to_jsonb(p)->>'created_at' as created_at
       from public.quizeey_posts p join public.quizeey_topics t on t.id=p.topic_id
       where p.id=any($1::uuid[]) and p.topic_id=any($2::uuid[])
         and p.visibility='approved' and t.visibility='approved' and t.approved_post_count>0`, [ids, topicIds]);
    return parents.rows;
  });
  return { topics: page.topics, posts, nextCursor: encodeForumCursor(page.next) };
}
export async function ownForum(hash: string, postIds?: string[]): Promise<OwnedPost[]> {
  const hosted = hostedForumTransport();
  if (postIds) {
    if (!postIds.length) return [];
    if (hosted) return hosted.rpc('quizeey_forum_owned', { p_capability_hash: hash, p_post_ids: postIds });
    const result = await forumConnection().query<{ result: OwnedPost[] }>('select public.quizeey_forum_owned($1,$2) as result', [hash, postIds]);
    return result.rows[0].result;
  }
  if (hosted) return hosted.rpc('quizeey_forum_mine', { p_capability_hash: hash });
  const result = await forumConnection().query<{ result: OwnedPost[] }>("select public.quizeey_forum_mine($1) as result", [hash]);
  return result.rows[0].result;
}
