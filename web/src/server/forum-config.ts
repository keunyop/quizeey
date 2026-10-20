import 'server-only';
import { createHmac } from 'node:crypto';
import { isIP } from 'node:net';
import { environment } from '@/lib/environment';
import { sameOrigin } from './guest-policy';

const localDatabase = 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture';
const localOrigins = ['http://127.0.0.1:3000', 'http://127.0.0.1:3100', 'http://localhost:3000', 'http://localhost:3100'];

/** Fail closed until the verified hosted backend is explicitly configured. */
export function forumConfiguration(input: Record<string, string | undefined> = process.env) {
  try {
    const env = environment(input);
    if (env.stage === 'local' && !input.VERCEL && input.VERCEL_ENV === undefined &&
        input.QUIZEEY_LOCAL_FORUM_DATABASE_URL === localDatabase) {
      const origin = input.QUIZEEY_LOCAL_FORUM_ORIGIN ?? localOrigins[0];
      return localOrigins.includes(origin) ? { kind: 'local' as const, origins: [origin] } : null;
    }
    if (input.QUIZEEY_FORUM_BACKEND !== 'supabase' || input.VERCEL !== '1' ||
        !['preview', 'production'].includes(env.stage) || input.VERCEL_ENV !== env.stage ||
        env.contentSource !== 'supabase' || input.QUIZEEY_TRUSTED_PROXY !== 'vercel-direct' ||
        !/^[A-Za-z0-9_-]{43,128}$/.test(input.QUIZEEY_ABUSE_HMAC_KEY ?? '') ||
        !/^[A-Za-z0-9_-]{43,128}$/.test(input.CRON_SECRET ?? '') || input.CRON_SECRET === input.QUIZEEY_ABUSE_HMAC_KEY ||
        !/^sb_publishable_[A-Za-z0-9_-]+$/.test(input.QUIZEEY_SUPABASE_PUBLISHABLE_KEY ?? '')) return null;
    const deploymentOrigins = [input.VERCEL_URL, ...(env.stage === 'preview' ? [input.VERCEL_BRANCH_URL] : [])]
      .filter((host): host is string => !!host && /^[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.vercel\.app$/.test(host))
      .map(host => 'https://' + host);
    const origins = env.stage === 'production' ? [env.origin, ...deploymentOrigins] : deploymentOrigins;
    if (!origins.length) return null;
    return { kind: 'supabase' as const, origins, hmacKey: input.QUIZEEY_ABUSE_HMAC_KEY! };
  } catch { return null; }
}

export function forumOriginAllowed(request: Request, input: Record<string, string | undefined> = process.env) {
  const config = forumConfiguration(input);
  return !!config && config.origins.some(origin => sameOrigin(request, origin));
}

export function forumAbuseHash(request: Request, purpose: 'forum' | 'admin' | 'submission', input: Record<string, string | undefined> = process.env) {
  const config = forumConfiguration(input);
  if (!config) throw new Error('Forum unavailable');
  // Vercel overwrites this header. External CF/XFF values are never trusted.
  // Hosted activation requires a direct, DNS-only Vercel origin, reviewed at cutover.
  const peer = config.kind === 'local' ? '127.0.0.1' : request.headers.get('x-vercel-forwarded-for');
  if (!peer || !isIP(peer)) throw new Error('Verified request peer unavailable');
  const normalized = isIP(peer) === 6 ? new URL('http://[' + peer + ']').hostname : peer;
  return createHmac('sha256', config.kind === 'local' ? `local-${purpose}-fixture-peer-only` : config.hmacKey)
    .update(`${purpose}:${new Date().toISOString().slice(0, 10)}:${normalized}`).digest('hex');
}
