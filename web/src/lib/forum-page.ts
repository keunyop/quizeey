import { z } from "zod";

export const forumPageSize = 10;
export const forumCursor = z.object({ createdAt: z.iso.datetime({ offset: true }), id: z.uuid() }).strict();
export type ForumCursor = z.infer<typeof forumCursor>;

export function decodeForumCursor(value: string | null): ForumCursor | null {
  if (value === null) return null;
  if (!/^[A-Za-z0-9_-]{1,256}$/.test(value)) throw new Error("Invalid comment cursor");
  return forumCursor.parse(JSON.parse(Buffer.from(value, "base64url").toString("utf8")));
}

export function encodeForumCursor(value: ForumCursor | null): string | null {
  return value === null ? null : Buffer.from(JSON.stringify(forumCursor.parse(value))).toString("base64url");
}
