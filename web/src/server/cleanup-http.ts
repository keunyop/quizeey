import 'server-only';
import { NextResponse } from 'next/server';
import { cronAuthorized } from './cron-auth';
import { hostedForumTransport } from './forum-database';

export async function cleanupGet(request: Request) {
  const headers = { 'Cache-Control': 'private, no-store', 'X-Robots-Tag': 'noindex, nofollow' };
  if (!cronAuthorized(request)) return NextResponse.json({ error: 'Unauthorized' }, { status: 401, headers });
  try {
    const transport = hostedForumTransport();
    if (!transport) throw new Error();
    // Existing SQL removes expired rate windows, receipts, reports, audit and sessions.
    // Repeated cleanup is safe; it does not change active posts or content.
    await transport.rpc('quizeey_forum_cleanup', {});
    return NextResponse.json({ ok: true }, { headers });
  } catch { return NextResponse.json({ error: 'Cleanup unavailable' }, { status: 503, headers }); }
}
