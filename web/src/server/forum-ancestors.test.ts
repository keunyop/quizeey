import { expect, it, vi } from 'vitest';
import type { PublicPost } from './forum-database';
import { forumAncestorDepth, includeForumAncestors } from './forum-ancestors';

const post = (id: string, parent_id: string | null, topic_id = 'topic'): PublicPost => ({
  id, parent_id, topic_id, display_name: null, body: id, created_at: '2026-10-26T00:00:00Z',
});

it('loads missing ancestors across comment pages once and keeps cursor posts first', async () => {
  const load = vi.fn().mockResolvedValueOnce([post('parent', 'root')]).mockResolvedValueOnce([post('root', null)]);
  const page = [post('reply', 'parent'), post('sibling', 'parent')];
  expect((await includeForumAncestors(page, load)).map(item => item.id)).toEqual(['reply', 'sibling', 'parent', 'root']);
  expect(load.mock.calls).toEqual([[['parent'], ['topic']], [['root'], ['topic']]]);
});

it('skips in-page parents and stops at missing, cross-topic or cyclic ancestors', async () => {
  const load = vi.fn().mockResolvedValueOnce([post('wrong', null, 'other-topic'), post('parent', 'reply')]);
  const page = [post('reply', 'parent'), post('orphan', 'hidden'), post('bad-link', 'wrong')];
  expect((await includeForumAncestors(page, load)).map(item => item.id)).toEqual(['reply', 'orphan', 'bad-link', 'parent']);
  expect(load).toHaveBeenCalledTimes(1);
  load.mockClear();
  await includeForumAncestors([post('reply', 'parent'), post('parent', null)], load);
  expect(load).not.toHaveBeenCalled();
});

it('bounds parent lookups for pathological legacy chains', async () => {
  let index = 1;
  const load = vi.fn(async () => [post(String(index), String(++index))]);
  const result = await includeForumAncestors([post('0', '1')], load);
  expect(load).toHaveBeenCalledTimes(forumAncestorDepth);
  expect(result).toHaveLength(forumAncestorDepth + 1);
});
