import { expect, test, type APIRequestContext } from "@playwright/test";
import pg from "pg";
test.skip(!process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL, "Isolated forum database is not configured");

async function mutate(request: APIRequestContext, body: Record<string, unknown>, extra: Record<string, string> = {}) {
  return request.post("http://127.0.0.1:3100/api/forum", {
    headers: { Origin: "http://127.0.0.1:3100", "Idempotency-Key": crypto.randomUUID(), ...extra }, data: body,
  });
}
async function fixtureAdmin(query: string, values: unknown[] = []) {
  if (process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== "postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture") throw new Error("Only the isolated fixture is allowed");
  const client = new pg.Client({ connectionString: "postgresql://quizeey_fixture@127.0.0.1:55432/quizeey_fixture" });
  await client.connect();
  try { return await client.query(query, values); } finally { await client.end(); }
}

test("two guest browsers: pending privacy, optional name, ownership, revisions, replies, reports and deletion", async ({ browser }) => {
  const a = await browser.newContext(); const b = await browser.newContext();
  try {
    const pageA = await a.newPage();
    await pageA.goto("http://127.0.0.1:3100/sqlp-developer");
    await expect(pageA.getByRole("heading", { name: "토론", exact: true })).toBeVisible();
    expect((await a.cookies()).some((c) => c.name === "__Host-quizeey-guest")).toBe(false);
    await pageA.locator('#forum-name').fill('   ');
    await pageA.locator('#forum-title').fill('Browser ownership fixture');
    await pageA.locator('#forum-body').fill('Original approved body');
    const pendingResponse = pageA.waitForResponse((r) => r.url().endsWith('/api/forum') && r.request().method()==='POST');
    await pageA.getByRole('button',{name:'등록',exact:true}).click();
    const created = await pendingResponse;
    expect(created.status()).toBe(202);
    const requestId = created.request().headers()['idempotency-key'];
    const payload = created.request().postDataJSON();
    await expect(pageA.locator('.own-posts')).toContainText('Original approved body');
    const initialOwn = (await (await a.request.get('http://127.0.0.1:3100/api/forum/mine')).json()).posts[0];
    const post = { postId: initialOwn.id, topicId: initialOwn.topic_id };
    const cookie = (await a.cookies()).find((c) => c.name === "__Host-quizeey-guest")!;
    expect(cookie).toMatchObject({ httpOnly: true, secure: true, sameSite: "Strict", path: "/" });
    expect((await mutate(a.request, payload, { "Idempotency-Key": requestId })).status()).toBe(202);
    expect((await mutate(b.request, payload, { "Idempotency-Key": requestId })).status()).toBe(409);
    const mine = await a.request.get("http://127.0.0.1:3100/api/forum/mine");
    expect(mine.headers()["cache-control"]).toContain("no-store");
    expect((await mine.json()).posts).toHaveLength(1);
    expect((await mine.json()).posts[0].display_name).toBeNull();
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum/mine")).json()).posts).toEqual([]);
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).posts).toEqual([]);
    expect((await mutate(b.request, { action: "edit", postId: post.postId, body: "Other browser", displayName: "same name" })).status()).toBe(403);

    await fixtureAdmin("select public.quizeey_forum_moderate('approve',$1)", [post.postId]);
    const visible = await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json();
    expect(visible.posts[0].body).toBe("Original approved body");
    expect((await mutate(a.request, { action: "edit", postId: post.postId, body: "<script>window.forumXss=1</script>Pending private revision" })).status()).toBe(202);
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).posts[0].body).toBe("Original approved body");
    await pageA.reload();
    await expect(pageA.locator(".own-posts")).toContainText("<script>window.forumXss=1</script>");
    expect(await pageA.evaluate(() => "forumXss" in window)).toBe(false);
    expect(await pageA.locator(".own-posts script").count()).toBe(0);

    expect((await mutate(b.request, { action: "report", postId: post.postId, reason: "Test report" })).status()).toBe(202);
    expect((await b.cookies()).some((c) => c.name === "__Host-quizeey-guest")).toBe(false);
    const replied = await mutate(b.request, { action: "reply", topicId: post.topicId, parentId: post.postId, body: "Reply fixture" });
    expect(replied.status()).toBe(202); const reply = await replied.json();
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum/mine")).json()).posts[0].parent_id).toBe(post.postId);
    expect((await mutate(b.request, { action: "delete", postId: reply.postId })).status()).toBe(200);
    expect((await mutate(a.request, { action: "delete", postId: post.postId })).status()).toBe(200);
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).topics).toEqual([]);
    await a.clearCookies();
    expect((await mutate(a.request, { action: "edit", postId: post.postId, body: "Lost cookie" })).status()).toBe(403);
  } finally { await a.close(); await b.close(); }
});

test("CSRF, bounds, expiry, context validation and concurrent shared limits", async ({ browser }) => {
  const guest = await browser.newContext();
  try {
    const payload = { action: "create", examId: "5", locale: "ko", title: "Security fixture", body: "Text" };
    expect((await guest.request.post("http://127.0.0.1:3100/api/forum", { headers: { "Idempotency-Key": crypto.randomUUID() }, data: payload })).status()).toBe(403);
    expect((await mutate(guest.request, payload, { Origin: "https://evil.test" })).status()).toBe(403);
    expect((await mutate(guest.request, { ...payload, body: "x".repeat(4001) })).status()).toBe(400);
    expect((await mutate(guest.request, { ...payload, examId: "999999" })).status()).toBe(404);
    const first = await mutate(guest.request, payload); expect(first.status()).toBe(202);
    const post = await first.json();
    await fixtureAdmin("update quizeey_private.guest_capabilities set expires_at=now()-interval '1 second' where capability_hash=(select capability_hash from quizeey_private.post_owners where post_id=$1)", [post.postId]);
    expect((await mutate(guest.request, { action: "edit", postId: post.postId, body: "Expired" })).status()).toBe(403);
    expect((await (await guest.request.get("http://127.0.0.1:3100/api/forum/mine")).json()).posts).toEqual([]);
    await guest.clearCookies();
    expect((await mutate(guest.request, payload)).status()).toBe(202);
    const results = await Promise.all(Array.from({ length: 20 }, () => mutate(guest.request, payload)));
    expect(results.filter((r) => r.status() === 202)).toHaveLength(9);
    expect(results.filter((r) => r.status() === 429)).toHaveLength(11);
  } finally { await guest.close(); }
});
