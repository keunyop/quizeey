import { NextResponse } from "next/server";
import { z } from "zod";
import { boundedJson, capabilityHash, forumRequest, guestCookieName, guestCookieOptions, issueCapability } from "./guest-policy";
import { findRoute, identifier, legacy } from "@/lib/contracts";
import { forumConfigured, mutateForum, ownForum, publicForum } from "./forum-database";
import { forumAbuseHash, forumConfiguration, forumOriginAllowed } from './forum-config';
import { loadLearningStore } from './learning-store';

const privateHeaders = { "Cache-Control": "private, no-store", "X-Robots-Tag": "noindex, nofollow" };
function response(value: unknown, status = 200) { return NextResponse.json(value, { status, headers: privateHeaders }); }
function readToken(request: Request) {
  const matches = (request.headers.get("cookie") ?? "").split(";").map((s) => s.trim()).filter((s) => s.startsWith(guestCookieName + "="));
  if (matches.length !== 1) return undefined;
  const token = matches[0].slice(guestCookieName.length + 1);
  return /^[A-Za-z0-9_-]{43}$/.test(token) ? token : undefined;
}
function available() { return forumConfigured(); }
async function validContext(testId: string, locale: "ko" | "en", questionId?: string) {
  if (forumConfiguration()?.kind === 'supabase') {
    const store = await loadLearningStore({ examId: testId, questionId });
    return store.hasExam(testId) && (!questionId || store.questions(testId, locale, 0, questionId).length === 1);
  }
  const path = legacy.routes.find((r) => r.testId === testId && r.locale === locale)?.path;
  if (!path || !findRoute(path)) return false;
  if (!questionId) return true;
  const store = await loadLearningStore({ examId: testId, questionId });
  return store.questions(testId, locale, 0, questionId).length === 1;
}
export async function forumGet(request: Request, mine = false) {
  if (!available()) return response({ error: "Forum unavailable" }, 503);
  if (mine) {
    const token = readToken(request);
    try { return response({ posts: token ? await ownForum(capabilityHash(token)) : [] }); }
    catch { return response({ error: "Forum unavailable" }, 503); }
  }
  let id: string | undefined;
  let questionId: string | undefined;
  let locale: 'ko' | 'en';
  try {
    const query = new URL(request.url).searchParams;
    if (["testId", "questId", "locale"].some((k) => query.getAll(k).length > 1)) return response({ error: "Invalid context" }, 400);
    id = identifier(query.get("testId") ?? undefined);
    questionId = identifier(query.has("questId") ? query.get("questId")! : undefined);
    locale = z.enum(["ko", "en"]).parse(query.get("locale"));
    if (!id) return response({ error: "Unknown context" }, 404);
  } catch { return response({ error: "Invalid context" }, 400); }
  try {
    if (!await validContext(id, locale, questionId)) return response({ error: 'Unknown context' }, 404);
    return response(await publicForum(id, locale, questionId ?? null));
  }
  catch { return response({ error: "Forum unavailable" }, 503); }
}
export async function forumPost(request: Request) {
  if (!available()) return response({ error: "Forum unavailable" }, 503);
  if (!forumOriginAllowed(request)) {
    return response({ error: "Origin rejected" }, 403);
  }
  let value: z.infer<typeof forumRequest>; let requestId: string;
  try {
    requestId = z.uuid().parse(request.headers.get("idempotency-key"));
    value = forumRequest.parse(await boundedJson(request));
  } catch { return response({ error: "Invalid forum request" }, 400); }
  try {
    if (value.action === 'create' && !await validContext(value.examId, value.locale, value.questionId)) return response({ error: 'Unknown context' }, 404);
  } catch { return response({ error: 'Forum unavailable' }, 503); }
  let token = readToken(request);
  if (!token && ["edit", "delete"].includes(value.action)) return response({ error: "Guest capability required" }, 403);
  const newlyIssued = !token && ["create", "reply"].includes(value.action);
  token ??= issueCapability().token;
  try {
    const abuse = forumAbuseHash(request, 'forum');
    const result = await mutateForum(capabilityHash(token), abuse, requestId, value);
    const output = response(result, result.status);
    if (newlyIssued && result.status === 202) output.cookies.set(guestCookieName, token, guestCookieOptions);
    return output;
  } catch { return response({ error: "Forum unavailable" }, 503); }
}
