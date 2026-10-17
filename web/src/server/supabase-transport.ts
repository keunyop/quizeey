import 'server-only';
import { createClient } from '@supabase/supabase-js';
import { z } from 'zod';
import { environment } from '@/lib/environment';
import { forumRequest } from './guest-policy';

const projectUrl = 'https://tfkhnrbshvyfmrzxqfmq.supabase.co';
const hash = z.string().regex(/^[a-f0-9]{64}$/);
const id = z.string().regex(/^[1-9]\d{0,18}$/).refine(value => BigInt(value) <= 9223372036854775807n);
const status = z.object({ status: z.number().int().min(100).max(599) }).passthrough();
const operations = {
  quizeey_forum_mutate: z.object({ p_capability_hash: hash, p_abuse_hash: hash, p_request_id: z.uuid(), p_action: z.string(), p_payload: z.record(z.string(), z.unknown()) }).strict().superRefine((value, ctx) => {
    if (!forumRequest.safeParse({ ...value.p_payload, action: value.p_action }).success) ctx.addIssue({ code: 'custom', message: 'Invalid forum payload' });
  }),
  quizeey_forum_mine: z.object({ p_capability_hash: hash }).strict(),
  quizeey_admin_login_limit: z.object({ p_abuse_hash: hash }).strict(),
  quizeey_admin_queue: z.object({ p_kind: z.enum(['posts', 'revisions', 'reports']), p_state: z.enum(['pending', 'approved', 'hidden']), p_cursor_time: z.iso.datetime({ offset: true }).nullable(), p_cursor_id: z.uuid().nullable() }).strict().refine(value => (value.p_cursor_time === null) === (value.p_cursor_id === null)),
  quizeey_admin_moderate: z.object({ p_actor_id: z.uuid(), p_request_id: z.uuid(), p_action: z.enum(['approve', 'hide', 'delete', 'lock', 'unlock', 'approve_revision', 'reject_revision', 'resolve_report']), p_id: z.uuid() }).strict(),
  quizeey_admin_session_create: z.object({ p_hash: hash, p_actor: z.uuid(), p_expires: z.iso.datetime({ offset: true }) }).strict(),
  quizeey_admin_session_actor: z.object({ p_hash: hash }).strict(),
  quizeey_admin_session_revoke: z.object({ p_hash: hash }).strict(),
};
type Operation = keyof typeof operations;
const topic = z.object({ id: z.uuid(), title: z.string(), locale: z.enum(['ko', 'en']), created_at: z.string() });
const post = z.object({ id: z.uuid(), topic_id: z.uuid(), parent_id: z.uuid().nullable(), display_name: z.string().nullable(), body: z.string(), created_at: z.string() });

export class SupabaseTransportError extends Error {
  constructor() { super('Supabase transport unavailable'); }
}

/** Prepared preview adapter. HTTP routes stay disabled until the hosted rehearsal passes.
 * No client, Auth session, credential or provider error escapes this closure.
 */
export function createSupabaseTransport(input: Record<string, string | undefined> = process.env) {
  try {
    if (environment(input).stage !== 'preview' || input.QUIZEEY_SUPABASE_URL !== projectUrl ||
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
    async rpc<N extends Operation>(name: N, args: z.input<(typeof operations)[N]>): Promise<unknown> {
      try {
        // Runtime allowlist matters even if a JS caller circumvents the TypeScript union.
        if (!Object.hasOwn(operations, name)) throw new Error();
        const payload = operations[name].parse(args);
        const { data, error } = await serverClient.rpc(name, payload);
        if (error) throw new Error();
        if (name === 'quizeey_forum_mutate' || name === 'quizeey_admin_moderate') return status.parse(data);
        if (name === 'quizeey_admin_queue') return status.extend({ items: z.array(z.record(z.string(), z.unknown())).max(21) }).parse(data);
        if (name === 'quizeey_forum_mine') return z.array(z.record(z.string(), z.unknown())).max(20).parse(data);
        if (name === 'quizeey_admin_session_actor') return z.uuid().nullable().parse(data);
        if (name === 'quizeey_admin_session_revoke') return z.null().parse(data);
        return z.boolean().parse(data);
      } catch { throw new SupabaseTransportError(); }
    },
    async publicForum(examId: string, locale: 'ko' | 'en', questionId: string | null) {
      try {
        id.parse(examId); z.enum(['ko', 'en']).parse(locale); id.nullable().parse(questionId);
        let query = publicClient.from('quizeey_topics').select('id,title,locale,created_at')
          .eq('exam_id', examId).eq('visibility', 'approved');
        query = questionId === null ? query.is('question_id', null).eq('locale', locale)
          : query.eq('question_id', questionId).or(`locale.eq.${locale},source_thread_id.eq.mysql:question:${questionId}`);
        const topicsResult = await query.order('created_at', { ascending: false }).order('id').limit(20);
        if (topicsResult.error) throw new Error();
        const topics = z.array(topic).max(20).parse(topicsResult.data);
        if (!topics.length) return { topics, posts: [] };
        const postsResult = await publicClient.from('quizeey_posts')
          .select('id,topic_id,parent_id,display_name,body,created_at').in('topic_id', topics.map(value => value.id))
          .eq('visibility', 'approved').order('created_at').order('id').limit(50);
        if (postsResult.error) throw new Error();
        const posts = z.array(post).max(50).parse(postsResult.data);
        if (posts.some(value => !topics.some(item => item.id === value.topic_id))) throw new Error();
        return { topics, posts };
      } catch { throw new SupabaseTransportError(); }
    },
  };
}
