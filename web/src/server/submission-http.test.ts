import { afterEach, expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
vi.mock("./admin-auth", () => ({ requireAdmin: vi.fn(), AdminAuthError: class extends Error { constructor(public status: number) { super(); } } }));
vi.mock("./admin-http", () => ({ adminHeaders: { "Cache-Control": "private, no-store" } }));
vi.mock("./forum-database", () => ({ forumConfigured: () => true }));
vi.mock("./forum-config", () => ({ forumOriginAllowed: vi.fn(), forumAbuseHash: () => "a".repeat(64) }));
vi.mock("./submission-database", () => ({ submitFeedback: vi.fn(), adminInbox: vi.fn(), adminOverview: vi.fn(), resolveSubmission: vi.fn() }));
import { submissionPost, inboxGet, inboxPatch, overviewGet } from "./submission-http";
import { forumOriginAllowed } from "./forum-config";
import { requireAdmin, AdminAuthError } from "./admin-auth";
import { submitFeedback, adminInbox, resolveSubmission } from "./submission-database";
const uuid = "50000000-0000-4000-8000-000000000001";
function request(body?: unknown, url = "/api/feedback", headers = {}) {
  return new Request("http://127.0.0.1:3100" + url, { method: body === undefined ? "GET" : "POST", headers: { "Content-Type": "application/json", "Idempotency-Key": uuid, ...headers }, body: body === undefined ? undefined : JSON.stringify(body) });
}
afterEach(() => vi.resetAllMocks());
it("checks origin, known pages and request keys before saving anonymous feedback", async () => {
  vi.mocked(forumOriginAllowed).mockReturnValue(false);
  expect((await submissionPost(request({ kind: "feedback", locale: "ko", path: "/", body: "Opinion" }))).status).toBe(403);
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  expect((await submissionPost(request({ kind: "feedback", locale: "ko", path: "https://evil.invalid", body: "Opinion" }))).status).toBe(404);
  expect((await submissionPost(request({ kind: "feedback", locale: "ko", path: "/", body: " " }))).status).toBe(400);
  expect((await submissionPost(request({ kind: "feedback", locale: "ko", path: "/", body: "Opinion" }, undefined, { "Idempotency-Key": "bad" }))).status).toBe(400);
  expect(submitFeedback).not.toHaveBeenCalled();
  vi.mocked(submitFeedback).mockResolvedValue({ status: 201 });
  expect((await submissionPost(request({ kind: "feedback", locale: "ko", path: "/", body: " Opinion " }))).status).toBe(201);
  expect(submitFeedback).toHaveBeenCalledWith(uuid, "a".repeat(64), { kind: "feedback", locale: "ko", path: "/", body: "Opinion", examId: null, questionId: null });
});
it("rejects mismatched question identities and records the actual question context", async () => {
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  const body = { kind: "question_report", locale: "ko", examId: "5", questionId: "900000001", body: "Incorrect answer" };
  expect((await submissionPost(request({ ...body, examId: "999999" }))).status).toBe(404);
  expect((await submissionPost(request({ ...body, questionId: "999999" }))).status).toBe(404);
  expect(submitFeedback).not.toHaveBeenCalled();
  vi.mocked(submitFeedback).mockResolvedValue({ status: 201 });
  expect((await submissionPost(request(body))).status).toBe(201);
  expect(submitFeedback).toHaveBeenCalledWith(uuid, "a".repeat(64), { ...body, path: "/sqlp-developer" });
});
it('accepts feedback on published English guides and rejects unknown or mismatched guide paths', async () => {
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  const body = { kind: 'feedback', locale: 'en', path: '/en/study-guides/servsafe-foodsafe-practice', body: 'Please expand the food safety guide.' };
  for (const value of [
    { ...body, locale: 'ko' },
    { ...body, path: '/en/study-guides/missing' },
    { ...body, path: body.path + '/extra' },
    { ...body, path: '/en/study-guides?untrusted=true' },
  ]) expect((await submissionPost(request(value))).status).toBe(404);
  expect(submitFeedback).not.toHaveBeenCalled();
  vi.mocked(submitFeedback).mockResolvedValue({ status: 201 });
  for (const path of ['/en/study-guides', body.path]) {
    expect((await submissionPost(request({ ...body, path }))).status).toBe(201);
    expect(submitFeedback).toHaveBeenLastCalledWith(uuid, 'a'.repeat(64), { ...body, path, examId: null, questionId: null });
  }
});
it("requires an admin on every inbox read and resolution and derives the actor on the server", async () => {
  vi.mocked(requireAdmin).mockRejectedValue(new AdminAuthError(401));
  expect((await overviewGet(request())).status).toBe(401);
  expect((await inboxGet(request(undefined, "/api/admin/inbox?kind=feedback"))).status).toBe(401);
  vi.mocked(forumOriginAllowed).mockReturnValue(false);
  expect((await inboxPatch(request({ id: uuid, state: "resolved" }))).status).toBe(403);
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  expect((await inboxPatch(request({ id: uuid, state: "resolved" }))).status).toBe(401);
  vi.mocked(requireAdmin).mockResolvedValue({ id: uuid });
  expect((await inboxPatch(request({ id: uuid, state: "resolved", actor: uuid }))).status).toBe(400);
  vi.mocked(resolveSubmission).mockResolvedValue({ status: 200 });
  expect((await inboxPatch(request({ id: uuid, state: "resolved" }))).status).toBe(200);
  expect(resolveSubmission).toHaveBeenCalledExactlyOnceWith(uuid, uuid, uuid, "resolved");
  vi.mocked(adminInbox).mockResolvedValue({ items: [], nextCursor: null });
  expect((await inboxGet(request(undefined, "/api/admin/inbox?kind=feedback&cursor=bad"))).status).toBe(400);
});
