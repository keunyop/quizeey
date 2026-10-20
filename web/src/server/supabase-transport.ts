import 'server-only';
import { createClient } from '@supabase/supabase-js';
import { z } from 'zod';
import { environment } from '@/lib/environment';
import { forumRequest } from './guest-policy';
import { encodeForumCursor, forumCursor, forumPageSize, type ForumCursor } from '@/lib/forum-page';
import { inboxKind, inboxItem, overviewSchema, storedSubmission } from '@/lib/submissions';

const projectUrl = 'https://tfkhnrbshvyfmrzxqfmq.supabase.co';
const hash = z.string().regex(/^[a-f0-9]{64}$/);
const id = z.string().regex(/^[1-9]\d{0,18}$/).refine(value => BigInt(value) <= 9223372036854775807n);
const status = z.object({ status: z.number().int().min(100).max(599) });
const operations = {
  quizeey_submit_feedback: z.object({ p_request_id: z.uuid(), p_abuse_hash: hash, p_payload: storedSubmission }).strict(),
  quizeey_admin_credential: z.object({ p_username: z.string().min(1).max(80) }).strict(),
  quizeey_admin_overview: z.object({}).strict(),
  quizeey_admin_inbox: z.object({ p_kind: inboxKind, p_state: z.enum(['all', 'open', 'resolved']), p_cursor_time: z.iso.datetime({ offset: true }).nullable(), p_cursor_id: z.uuid().nullable() }).strict().refine(value => (value.p_cursor_time === null) === (value.p_cursor_id === null)),
  quizeey_admin_resolve_submission: z.object({ p_actor_id: z.uuid(), p_request_id: z.uuid(), p_id: z.uuid(), p_state: z.enum(['open', 'resolved']) }).strict(),
  quizeey_exam_click: z.object({ p_exam_id: id }).strict(),
  quizeey_exam_popularity: z.object({ p_exam_ids: z.array(id).min(1).max(500) }).strict(),
  quizeey_forum_mutate: z.object({ p_capability_hash: hash, p_abuse_hash: hash, p_request_id: z.uuid(), p_action: z.string(), p_payload: z.record(z.string(), z.unknown()) }).strict().superRefine((value, ctx) => {
    const payload = { ...value.p_payload };
    // HTTP validation normalizes an empty optional display name to null.
    if (payload.displayName === null) payload.displayName = '';
    if (!forumRequest.safeParse({ ...payload, action: value.p_action }).success) ctx.addIssue({ code: 'custom', message: 'Invalid forum payload' });
  }),
  quizeey_forum_mine: z.object({ p_capability_hash: hash }).strict(),
  quizeey_forum_owned: z.object({ p_capability_hash: hash, p_post_ids: z.array(z.uuid()).min(1).max(forumPageSize) }).strict(),
  quizeey_admin_login_limit: z.object({ p_abuse_hash: hash }).strict(),
  quizeey_admin_queue: z.object({ p_kind: z.enum(['posts', 'revisions', 'reports']), p_state: z.enum(['pending', 'approved', 'hidden']), p_cursor_time: z.iso.datetime({ offset: true }).nullable(), p_cursor_id: z.uuid().nullable() }).strict().refine(value => (value.p_cursor_time === null) === (value.p_cursor_id === null)),
  quizeey_admin_moderate: z.object({ p_actor_id: z.uuid(), p_request_id: z.uuid(), p_action: z.enum(['approve', 'hide', 'delete', 'lock', 'unlock', 'approve_revision', 'reject_revision', 'resolve_report']), p_id: z.uuid() }).strict(),
  quizeey_admin_session_create: z.object({ p_hash: hash, p_actor: z.uuid(), p_expires: z.iso.datetime({ offset: true }) }).strict(),
  quizeey_admin_session_actor: z.object({ p_hash: hash }).strict(),
  quizeey_admin_session_revoke: z.object({ p_hash: hash }).strict(),
  quizeey_forum_cleanup: z.object({}).strict(),
};
type Operation = keyof typeof operations;
const topic = z.object({ id: z.uuid(), title: z.string(), locale: z.enum(['ko', 'en']), created_at: z.string() });
const post = z.object({ id: z.uuid(), topic_id: z.uuid(), parent_id: z.uuid().nullable(), display_name: z.string().nullable(), body: z.string(), created_at: z.string() });
const ownedPost = post.extend({ visibility: z.enum(['pending', 'approved']), exam_id: id, question_id: id.nullable(), locale: z.enum(['ko', 'en']), title: z.string(), pending_body: z.string().nullable() });
const queueItem = z.object({ id: z.uuid(), created_at: z.iso.datetime({ offset: true }), body: z.string().optional(), published_body: z.string().optional(), reason: z.string().optional(), display_name: z.string().nullable().optional(), visibility: z.string().optional(), topic_id: z.uuid(), post_id: z.uuid().optional(), parent_id: z.uuid().nullable().optional(), title: z.string(), exam_id: id, question_id: id.nullable(), locale: z.enum(['ko', 'en']), locked: z.boolean().optional() });
const outputs = {
  quizeey_submit_feedback: status,
  quizeey_admin_credential: z.object({ actor_id: z.uuid(), salt: z.string().regex(/^[a-f0-9]{32}$/), password_hash: z.string().regex(/^[a-f0-9]{128}$/) }).nullable(),
  quizeey_admin_overview: overviewSchema,
  quizeey_admin_inbox: z.array(inboxItem).max(21),
  quizeey_admin_resolve_submission: status,
  quizeey_exam_click: z.null(),
  quizeey_exam_popularity: z.record(id, z.string().regex(/^(0|[1-9]\d{0,18})$/).refine(value => BigInt(value) <= 9223372036854775807n)),
  quizeey_forum_mutate: status.extend({ postId: z.uuid().optional(), topicId: z.uuid().optional(), revisionId: z.uuid().optional(), visibility: z.string().optional() }),
  quizeey_forum_mine: z.array(ownedPost).max(20),
  quizeey_forum_owned: z.array(ownedPost).max(forumPageSize),
  quizeey_admin_login_limit: z.boolean(),
  quizeey_admin_queue: status.extend({ items: z.array(queueItem).max(21) }),
  quizeey_admin_moderate: status,
  quizeey_admin_session_create: z.boolean(),
  quizeey_admin_session_actor: z.uuid().nullable(),
  quizeey_admin_session_revoke: z.null(),
  quizeey_forum_cleanup: z.null(),
};

export class SupabaseTransportError extends Error {
  constructor() { super('Supabase transport unavailable'); }
}

/** Server-only adapter. Hosted HTTP activation has a separate explicit configuration gate.
 * No client, Auth session, credential or provider error escapes this closure.
 */
export function createSupabaseTransport(input: Record<string, string | undefined> = process.env) {
  try {
    if (!['preview', 'production'].includes(environment(input).stage) || input.QUIZEEY_SUPABASE_URL !== projectUrl ||
        !/^sb_publishable_[A-Za-z0-9_-]+$/.test(input.QUIZEEY_SUPABASE_PUBLISHABLE_KEY ?? '') ||
        !/^sb_secret_[A-Za-z0-9_-]+$/.test(input.QUIZEEY_SUPABASE_SECRET_KEY ?? '')) throw new Error();
  } catch { throw new SupabaseTransportError(); }
  const options = {
    auth: { persistSession: false, autoRefreshToken: false, detectSessionInUrl: false },
    db: { schema: 'public', retry: false },
    global: { fetch: (url: RequestInfo | URL, init?: RequestInit) => fetch(url, {
      ...init, cache: 'no-store', redirect: 'error', signal: AbortSignal.timeout(5000),
    }) },
  };
  // The public client remains subject to anon RLS; privileged RPCs use a separate client.
  const publicClient = createClient(projectUrl, input.QUIZEEY_SUPABASE_PUBLISHABLE_KEY!, options);
  const serverClient = createClient(projectUrl, input.QUIZEEY_SUPABASE_SECRET_KEY!, options);
  return {
    async rpc<N extends Operation>(name: N, args: z.input<(typeof operations)[N]>): Promise<z.output<(typeof outputs)[N]>> {
      try {
        // Runtime allowlist matters even if a JS caller circumvents the TypeScript union.
        if (!Object.hasOwn(operations, name)) throw new Error();
        const payload = operations[name].parse(args);
        const { data, error } = await serverClient.rpc(name, payload);
        if (error) throw new Error();
        return outputs[name].parse(data) as z.output<(typeof outputs)[N]>;
      } catch { throw new SupabaseTransportError(); }
    },
    async publicForum(examId: string, locale: 'ko' | 'en', questionId: string | null, cursor: ForumCursor | null = null) {
      try {
        id.parse(examId); z.enum(['ko', 'en']).parse(locale); id.nullable().parse(questionId);
        if (cursor) forumCursor.parse(cursor);
        const { data, error } = await publicClient.rpc('quizeey_forum_page', { p_exam_id: examId, p_locale: locale, p_question_id: questionId,
          p_cursor_time: cursor?.createdAt ?? null, p_cursor_id: cursor?.id ?? null });
        if (error) throw new Error();
        const { topics, posts, next } = z.object({ topics: z.array(topic).max(forumPageSize), posts: z.array(post).max(forumPageSize), next: forumCursor.nullable() }).parse(data);
        if (posts.some(value => !topics.some(item => item.id === value.topic_id))) throw new Error();
        return { topics, posts, nextCursor: encodeForumCursor(next) };
      } catch { throw new SupabaseTransportError(); }
    },
  };
}
