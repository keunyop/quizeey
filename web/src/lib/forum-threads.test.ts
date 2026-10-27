import { expect, it } from 'vitest';
import { orderForumThreads } from './forum-threads';

const post = (id: string, parent_id: string | null, day: number, topic_id = 'topic') => ({ id, parent_id, topic_id, created_at: `2026-10-${day}T00:00:00Z` });

it('places newest-first API replies below their own parent in reading order in both comment contexts', () => {
  const posts = [post('nested', 'reply-a', 26), post('reply-b', 'older', 25), post('reply-a', 'older', 24),
    post('newer', null, 23), post('older', null, 22)];
  expect(orderForumThreads(posts).map(({ post, isReply }) => [post.id, isReply])).toEqual([
    ['newer', false], ['older', false], ['reply-a', true], ['nested', true], ['reply-b', true],
  ]);
  expect(posts[0].id).toBe('nested');
});

it('keeps timestamp ties deterministic including PostgreSQL microseconds', () => {
  const first = { ...post('z', null, 22), created_at: '2026-10-22T00:00:00.123455+00:00' };
  const second = { ...post('a', null, 22), created_at: '2026-10-22T00:00:00.123456Z' };
  expect(orderForumThreads([first, second]).map(item => item.post.id)).toEqual(['a', 'z']);
});

it('retains orphaned and cyclic comments without treating unrelated topics as parents', () => {
  const posts = [post('orphan', 'deleted', 26), post('other-topic', 'orphan', 25, 'other'),
    post('cycle-a', 'cycle-b', 24), post('cycle-b', 'cycle-a', 23)];
  const ordered = orderForumThreads(posts);
  expect(ordered.map(item => item.post.id)).toEqual(['orphan', 'other-topic', 'cycle-a', 'cycle-b']);
  expect(ordered.map(item => item.isReply)).toEqual([false, false, false, true]);
});
