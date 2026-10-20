import { NextResponse } from "next/server";
import { z } from "zod";
import { findRoute, routesForExam } from "@/lib/contracts";
import { inboxKind, submissionRequest } from "@/lib/submissions";
import { boundedJson } from "./guest-policy";
import { forumConfigured } from "./forum-database";
import { forumAbuseHash, forumOriginAllowed } from "./forum-config";
import { loadLearningStore } from "./learning-store";
import { AdminAuthError, requireAdmin } from "./admin-auth";
import { adminHeaders } from "./admin-http";
import { adminInbox, adminOverview, resolveSubmission, submitFeedback } from "./submission-database";

function response(value: unknown, status = 200) { return NextResponse.json(value, { status, headers: adminHeaders }); }
function failure(error: unknown) { return response({ error: "Request unavailable or denied" }, error instanceof AdminAuthError ? error.status : 503); }

export async function submissionPost(request: Request) {
  if (!forumConfigured()) return response({ error: "Feedback unavailable" }, 503);
  if (!forumOriginAllowed(request)) return response({ error: "Origin rejected" }, 403);
  let value: z.infer<typeof submissionRequest>, requestId: string;
  try {
    requestId = z.uuid().parse(request.headers.get("idempotency-key"));
    value = submissionRequest.parse(await boundedJson(request));
  } catch { return response({ error: "Invalid feedback" }, 400); }
  try {
    let path: string, examId: string | null = null, questionId: string | null = null;
    if (value.kind === "feedback") {
      const route = findRoute(value.path);
      if (!route || route.locale !== value.locale) return response({ error: "Unknown page" }, 404);
      path = value.path; examId = route.testId;
    } else {
      const route = routesForExam(value.examId, value.locale)[0];
      if (!route) return response({ error: "Unknown exam" }, 404);
      const store = await loadLearningStore({ examId: value.examId, questionId: value.questionId });
      if (store.questions(value.examId, value.locale, 0, value.questionId).length !== 1) return response({ error: "Unknown question" }, 404);
      path = route.path; examId = value.examId; questionId = value.questionId;
    }
    const result = await submitFeedback(requestId, forumAbuseHash(request, "submission"), {
      kind: value.kind, locale: value.locale, path, body: value.body, examId, questionId,
    });
    return response(result, result.status);
  } catch (error) { return failure(error); }
}
export async function overviewGet(request: Request) {
  try { await requireAdmin(request); return response(await adminOverview()); }
  catch (error) { return failure(error); }
}
export async function inboxGet(request: Request) {
  try {
    await requireAdmin(request);
    let kind: z.infer<typeof inboxKind>, state: "all" | "open" | "resolved", cursor: { time: string; id: string } | undefined;
    try {
      const query = new URL(request.url).searchParams;
      if (["kind", "state", "cursor"].some(key => query.getAll(key).length > 1)) throw new Error();
      kind = inboxKind.parse(query.get("kind")); state = z.enum(["all", "open", "resolved"]).parse(query.get("state") ?? "all");
      const raw = query.get("cursor");
      if (raw) {
        if (raw.length > 300 || !/^[A-Za-z0-9_-]+$/.test(raw)) throw new Error();
        cursor = z.object({ time: z.iso.datetime({ offset: true }), id: z.uuid() }).strict().parse(JSON.parse(Buffer.from(raw, "base64url").toString("utf8")));
      }
    } catch { return response({ error: "Invalid inbox query" }, 400); }
    return response(await adminInbox(kind, state, cursor));
  } catch (error) { return failure(error); }
}
export async function inboxPatch(request: Request) {
  if (!forumOriginAllowed(request)) return response({ error: "Origin rejected" }, 403);
  try {
    const actor = await requireAdmin(request);
    let input: { id: string; state: "open" | "resolved" }, requestId: string;
    try {
      requestId = z.uuid().parse(request.headers.get("idempotency-key"));
      input = z.object({ id: z.uuid(), state: z.enum(["open", "resolved"]) }).strict().parse(await boundedJson(request));
    } catch { return response({ error: "Invalid resolution" }, 400); }
    const result = await resolveSubmission(actor.id, requestId, input.id, input.state);
    return response(result, result.status);
  } catch (error) { return failure(error); }
}
