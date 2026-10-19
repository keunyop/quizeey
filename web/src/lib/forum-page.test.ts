import { expect, it } from 'vitest';
import { decodeForumCursor, encodeForumCursor } from './forum-page';

it('preserves microseconds and the UUID tie breaker across comment pages', () => {
  const cursor = { createdAt: '2026-10-19T05:01:02.123456+00:00', id: '00000000-0000-4000-8000-000000000101' };
  expect(decodeForumCursor(encodeForumCursor(cursor))).toEqual(cursor);
  expect(decodeForumCursor(null)).toBeNull();
});

it('rejects oversized, malformed, incomplete and non-date cursors', () => {
  for (const value of ['', 'x'.repeat(257), 'not-json', Buffer.from(JSON.stringify({ id: '00000000-0000-4000-8000-000000000101' })).toString('base64url'),
    Buffer.from(JSON.stringify({ createdAt: 'infinity', id: '00000000-0000-4000-8000-000000000101' })).toString('base64url')]) {
    expect(() => decodeForumCursor(value)).toThrow();
  }
});
