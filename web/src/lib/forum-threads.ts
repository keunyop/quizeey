type ThreadPost = { id: string; topic_id: string; parent_id: string | null; created_at: string };

function oldestFirst(a: ThreadPost, b: ThreadPost) {
  return Date.parse(a.created_at) - Date.parse(b.created_at)
    || (a.created_at.match(/\.(\d+)/)?.[1] ?? '').padEnd(6, '0').localeCompare((b.created_at.match(/\.(\d+)/)?.[1] ?? '').padEnd(6, '0'))
    || a.id.localeCompare(b.id);
}

/** Keep newest root comments first, with each conversation in reading order. */
export function orderForumThreads<T extends ThreadPost>(posts: T[]): { post: T; isReply: boolean }[] {
  const byId = new Map(posts.map(post => [post.id, post]));
  const children = new Map<string, T[]>();
  const roots: T[] = [];
  for (const post of byId.values()) {
    const parent = post.parent_id ? byId.get(post.parent_id) : undefined;
    if (parent && parent.topic_id === post.topic_id && parent.id !== post.id) {
      const siblings = children.get(parent.id) ?? [];
      siblings.push(post);
      children.set(parent.id, siblings);
    } else roots.push(post);
  }
  for (const siblings of children.values()) siblings.sort(oldestFirst);
  const ordered: { post: T; isReply: boolean }[] = [];
  const seen = new Set<string>();
  function visit(root: T) {
    const stack = [{ post: root, isReply: false }];
    while (stack.length) {
      const item = stack.pop()!;
      if (seen.has(item.post.id)) continue;
      seen.add(item.post.id);
      ordered.push(item);
      for (const child of (children.get(item.post.id) ?? []).toReversed()) stack.push({ post: child, isReply: true });
    }
  }
  roots.sort((a, b) => oldestFirst(b, a)).forEach(visit);
  // Imported cycles or unavailable parents must never hide public comments.
  for (const post of byId.values()) if (!seen.has(post.id)) visit(post);
  return ordered;
}
