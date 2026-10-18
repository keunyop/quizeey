import { timingSafeEqual } from 'node:crypto';

export function cronAuthorized(request: Request, input: Record<string, string | undefined> = process.env) {
  const secret = input.CRON_SECRET;
  if (!secret || !/^[A-Za-z0-9_-]{43,128}$/.test(secret)) return false;
  const actual = Buffer.from(request.headers.get('authorization') ?? '');
  const expected = Buffer.from('Bearer ' + secret);
  return actual.length === expected.length && timingSafeEqual(actual, expected);
}
