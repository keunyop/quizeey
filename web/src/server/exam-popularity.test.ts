import { afterEach, expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
vi.mock("./forum-database", () => ({ forumConfigured: vi.fn(), hostedForumTransport: vi.fn(), forumConnection: vi.fn() }));
vi.mock("./forum-config", () => ({ forumOriginAllowed: vi.fn() }));
import { forumConfigured, hostedForumTransport } from "./forum-database";
import { forumOriginAllowed } from "./forum-config";
import { examClick, examPopularity } from "./exam-popularity";
import { legacy } from "@/lib/contracts";

afterEach(() => vi.resetAllMocks());
function request(body: unknown) {
  return new Request("http://127.0.0.1:3100/api/exams/click", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(body) });
}
function backend() {
  vi.mocked(forumConfigured).mockReturnValue(true);
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  const rpc = vi.fn().mockResolvedValue(null);
  vi.mocked(hostedForumTransport).mockReturnValue({ rpc } as unknown as NonNullable<ReturnType<typeof hostedForumTransport>>);
  return rpc;
}

it("only records known exam paths from an allowed origin and never accepts client totals", async () => {
  const rpc = backend();
  vi.mocked(forumOriginAllowed).mockReturnValue(false);
  expect((await examClick(request({ path: "/sqlp-developer" }))).status).toBe(403);
  vi.mocked(forumOriginAllowed).mockReturnValue(true);
  for (const body of [{ path: "/" }, { path: "/unknown-exam" }]) expect((await examClick(request(body))).status).toBe(404);
  expect((await examClick(request({ path: "/sqlp-developer", count: 100 }))).status).toBe(400);
  expect(rpc).not.toHaveBeenCalled();
  const result = await examClick(request({ path: "/sqlp-developer" }));
  expect(result.status).toBe(204);
  expect(result.headers.get("cache-control")).toContain("no-store");
  expect(rpc).toHaveBeenCalledExactlyOnceWith("quizeey_exam_click", { p_exam_id: "5" });
});

it("loads one bounded set of shared exam totals, including aliases only once", async () => {
  const rpc = backend();
  rpc.mockResolvedValue({ "5": "19" });
  const routes = legacy.routes.filter(r => r.testId === "5");
  expect(await examPopularity(routes)).toEqual({ "5": "19" });
  expect(rpc).toHaveBeenCalledExactlyOnceWith("quizeey_exam_popularity", { p_exam_ids: ["5"] });
});

it("keeps the catalog usable without a backend and hides database failures", async () => {
  expect(await examPopularity(legacy.routes)).toEqual({});
  expect((await examClick(request({ path: "/sqlp-developer" }))).status).toBe(503);
  const rpc = backend();
  rpc.mockRejectedValue(new Error("private database detail"));
  const errorLog = vi.spyOn(console, "error").mockImplementation(() => {});
  try {
    expect(await examPopularity(legacy.routes)).toEqual({});
    expect(errorLog).toHaveBeenCalledWith("Exam popularity unavailable");
    const response = await examClick(request({ path: "/sqlp-developer" }));
    expect(response.status).toBe(503);
    expect(await response.text()).not.toContain("private database detail");
  } finally { errorLog.mockRestore(); }
});
