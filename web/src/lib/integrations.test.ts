import { expect, it, vi } from "vitest";
import { AdLifecycle, measure, type IntegrationPolicy } from "./integrations";
const allowed = { stage: "production", consent: true, verified: true } as const;
function port() { return { loadScript: vi.fn(async () => {}), reserve: vi.fn(), initialize: vi.fn() }; }
it("loads one script and initializes each physical slot once under concurrent calls", async () => {
  const mock = port(); const ads = new AdLifecycle(allowed, mock); const a = {}; const b = {};
  await Promise.all([ads.mount(a, "1033140566", 250), ads.mount(a, "1033140566", 250), ads.mount(b, "8990988805", 100)]);
  expect(mock.loadScript).toHaveBeenCalledTimes(1);
  expect(mock.loadScript).toHaveBeenCalledWith("ca-pub-8362228066874729");
  expect(mock.initialize).toHaveBeenCalledTimes(2);
  expect(mock.reserve).toHaveBeenCalledTimes(2);
});
it.each<IntegrationPolicy>([{ ...allowed, stage: "local" }, { ...allowed, stage: "preview" }, { ...allowed, consent: false }, { ...allowed, verified: false }])("does not reserve empty placeholders or load ads when disabled: %j", async (policy) => {
  const mock = port(); await new AdLifecycle(policy, mock).mount({}, "1033140566", 250);
  expect(mock.loadScript).not.toHaveBeenCalled(); expect(mock.reserve).not.toHaveBeenCalled();
});
it("handles ad blockers without retry loops", async () => {
  const mock = port(); mock.loadScript.mockRejectedValue(new Error("blocked"));
  const ads = new AdLifecycle(allowed, mock);
  expect(await ads.mount({}, "1033140566", 250)).toBe(false);
  expect(await ads.mount({}, "1033140566", 250)).toBe(false);
  expect(mock.loadScript).toHaveBeenCalledTimes(1); expect(mock.initialize).not.toHaveBeenCalled();
});
it('does not initialize an in-flight ad after consent is revoked',async()=>{
  let finish!:()=>void;
  const mock=port();mock.loadScript.mockImplementation(()=>new Promise<void>(resolve=>{finish=resolve;}));
  const ads=new AdLifecycle(allowed,mock);const pending=ads.mount({},'1033140566',250);
  ads.updatePolicy({...allowed,consent:false});finish();
  expect(await pending).toBe(false);expect(mock.initialize).not.toHaveBeenCalled();
});
it("only accepts real recorded slots and reserved dimensions", async () => {
  await expect(new AdLifecycle(allowed, port()).mount({}, "invented", 250)).rejects.toThrow();
  await expect(new AdLifecycle(allowed, port()).mount({}, "1033140566", 0)).rejects.toThrow();
});
it("records quiz events without pageviews or PII", () => {
  const send = vi.fn();
  expect(measure(allowed, send, "answer_submit", { test_id: "5", quest_id: "900000001", locale: "ko", correct: true })).toBe(true);
  expect(send).toHaveBeenCalledTimes(1);
  expect(measure({ ...allowed, stage: "preview" }, send, "question_start", { locale: "en" })).toBe(false);
  expect(() => measure(allowed, send, "forum_post_created", { locale: "ko", body: "private" } as never)).toThrow(/payload/);
  expect(() => measure(allowed, send, "page_view" as never, { locale: "ko" })).toThrow();
});
