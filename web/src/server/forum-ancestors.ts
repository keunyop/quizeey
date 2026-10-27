import type { PublicPost } from './forum-database';

export const forumAncestorDepth = 20;

/** Add public parent context without changing the ten-post pagination cursor. */
export async function includeForumAncestors(posts: PublicPost[], load: (ids: string[], topicIds: string[]) => Promise<PublicPost[]>): Promise<PublicPost[]> {
  const combined = new Map(posts.map(post => [post.id, post]));
  const attempted = new Set(combined.keys());
  let frontier = posts;
  // Each round requests at most ten parents. Bound deep or malformed imports.
  for (let depth = 0; depth < forumAncestorDepth; depth++) {
    const missing = new Map<string, string>();
    for (const post of frontier) if (post.parent_id && !attempted.has(post.parent_id)) missing.set(post.parent_id, post.topic_id);
    if (!missing.size) break;
    for (const id of missing.keys()) attempted.add(id);
    const parents = await load([...missing.keys()], [...new Set(missing.values())]);
    frontier = parents.filter(post => missing.get(post.id) === post.topic_id && !combined.has(post.id));
    for (const post of frontier) combined.set(post.id, post);
  }
  return [...combined.values()];
}
