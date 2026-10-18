import { createHash, randomBytes } from "node:crypto";
import { z } from "zod";

export const guestCookieName = "__Host-quizeey-guest";
export const guestCookieOptions = { httpOnly: true, secure: true, sameSite: "strict", path: "/", maxAge: 90 * 24 * 60 * 60 } as const;
export function capabilityHash(token: string): string {
  if (!/^[A-Za-z0-9_-]{43}$/.test(token)) throw new Error("Invalid guest capability");
  return createHash("sha256").update(token).digest("hex");
}
export function issueCapability() {
  const token = randomBytes(32).toString("base64url");
  return { token, verificationHash: capabilityHash(token) };
}
export function sameOrigin(request: Request, expectedOrigin: string): boolean {
  try {
    const expected = new URL(expectedOrigin);
    return expected.origin === expectedOrigin && request.headers.get("origin") === expectedOrigin &&
      [null, "same-origin"].includes(request.headers.get("sec-fetch-site"));
  } catch { return false; }
}
const id = z.string().regex(/^[1-9]\d{0,18}$/).refine((value) => /^[1-9]\d{0,18}$/.test(value) && BigInt(value) <= 9223372036854775807n);
const uuid = z.uuid();
const displayName = z.string().trim().max(80).default("").transform((value) => value || null);
const body = z.string().trim().min(1).max(4000).refine((value) => Buffer.byteLength(value, "utf8") <= 16000)
  .refine((value) => (value.match(/https?:\/\//gi)?.length ?? 0) <= 3, "Too many links");
export const forumRequest = z.discriminatedUnion("action", [
  z.object({ action: z.literal("create"), examId: id, questionId: id.optional(), locale: z.enum(["ko", "en"]), title: z.string().trim().min(1).max(120), body, displayName }).strict(),
  z.object({ action: z.literal("reply"), topicId: uuid, parentId: uuid.optional(), body, displayName }).strict(),
  z.object({ action: z.literal("edit"), postId: uuid, body, displayName }).strict(),
  z.object({ action: z.literal("delete"), postId: uuid }).strict(),
  z.object({ action: z.literal("report"), postId: uuid, reason: z.string().trim().min(1).max(500) }).strict(),
]);
export async function boundedJson(request: Request) {
  if (request.headers.get("content-type")?.split(";",1)[0].trim().toLowerCase() !== "application/json") throw new Error("JSON required");
  if (!request.body) throw new Error("Body required");
  const reader = request.body.getReader();
  const chunks: Uint8Array[] = []; let total = 0;
  try {
    for (;;) {
      const { value, done } = await reader.read();
      if (done) break;
      total += value.byteLength;
      if (total > 24000) { await reader.cancel(); throw new Error("Body limit exceeded"); }
      chunks.push(value);
    }
  } finally { reader.releaseLock(); }
  return JSON.parse(new TextDecoder("utf-8", { fatal: true }).decode(Buffer.concat(chunks))) as unknown;
}
export function verifiedAdminAllowed(verifiedUserId: string, configuredAdminIds: readonly string[]) {
  return z.uuid().safeParse(verifiedUserId).success && configuredAdminIds.includes(verifiedUserId);
}
