import { expect, test, type APIRequestContext } from "@playwright/test";
import pg from "pg";
import AxeBuilder from "@axe-core/playwright";
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

test.beforeEach(async () => { await fixtureAdmin("delete from quizeey_private.rate_windows"); });

test("two guest browsers: immediate publication, optional name, ownership, edits, replies, reports and deletion", async ({ browser }) => {
  const a = await browser.newContext(); const b = await browser.newContext();
  try {
    const pageA = await a.newPage();
    await pageA.goto("http://127.0.0.1:3100/sqlp-developer");
    await expect(pageA.getByRole("heading", { name: "시험 댓글", exact: true })).toBeVisible();
    expect((await a.cookies()).some((c) => c.name === "__Host-quizeey-guest")).toBe(false);
    await pageA.getByLabel('작성자명 (선택)').fill('   ');
    await pageA.getByLabel('댓글', { exact: true }).fill('Original approved body');
    const pendingResponse = pageA.waitForResponse((r) => r.url().endsWith('/api/forum') && r.request().method()==='POST');
    await pageA.getByRole('button',{name:'댓글 등록',exact:true}).click();
    const created = await pendingResponse;
    expect(created.status()).toBe(202);
    const requestId = created.request().headers()['idempotency-key'];
    const payload = created.request().postDataJSON();
    await expect(pageA.locator('.forum-comments')).toContainText('Original approved body');
    await expect(pageA.getByText('댓글을 등록했습니다.', { exact: true })).toHaveCount(0);
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
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).posts[0].body).toBe("Original approved body");
    expect((await mutate(b.request, { action: "edit", postId: post.postId, body: "Other browser", displayName: "same name" })).status()).toBe(403);

    const visible = await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json();
    expect(visible.posts[0].body).toBe("Original approved body");
    expect((await mutate(a.request, { action: "edit", postId: post.postId, body: "<script>window.forumXss=1</script>Immediate edit" })).status()).toBe(200);
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).posts[0].body).toContain("Immediate edit");
    await pageA.reload();
    await expect(pageA.locator(".forum-comments")).toContainText("<script>window.forumXss=1</script>");
    expect(await pageA.evaluate(() => "forumXss" in window)).toBe(false);
    expect(await pageA.locator(".forum-comments script").count()).toBe(0);

    expect((await mutate(b.request, { action: "report", postId: post.postId, reason: "Test report" })).status()).toBe(202);
    expect((await b.cookies()).some((c) => c.name === "__Host-quizeey-guest")).toBe(false);
    const replied = await mutate(b.request, { action: "reply", topicId: post.topicId, parentId: post.postId, body: "Reply fixture" });
    expect(replied.status()).toBe(202); const reply = await replied.json();
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum/mine")).json()).posts[0].parent_id).toBe(post.postId);
    expect((await mutate(b.request, { action: "delete", postId: reply.postId })).status()).toBe(200);
    expect((await mutate(a.request, { action: "delete", postId: post.postId })).status()).toBe(200);
    expect((await (await b.request.get("http://127.0.0.1:3100/api/forum?testId=5&locale=ko")).json()).posts.some((value: { id: string }) => [post.postId, reply.postId].includes(value.id))).toBe(false);
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


test("exam comments and answer-area question comments have independent forms, authors and contexts", async ({ page, context }) => {
  await page.goto('/sqlp-developer?verNbr=1');
  const exam = page.getByRole('region', { name: '시험 댓글', exact: true });
  await expect(exam).toBeVisible();
  await expect(page.getByRole('heading', { name: '문제 댓글', exact: true })).toHaveCount(0);
  await exam.getByLabel('댓글', { exact: true }).fill('Only an exam comment');
  await exam.getByRole('button', { name: '댓글 등록', exact: true }).click();
  await expect(exam.locator('.forum-comments')).toContainText('Only an exam comment');
  await expect(exam.locator('.forum-comments')).toContainText('익명');
  await expect(exam.getByText('댓글을 등록했습니다.', { exact: true })).toHaveCount(0);
  const examComposer = await exam.locator('.comment-composer').boundingBox();
  const examComments = await exam.locator('.forum-comments').boundingBox();
  expect(examComposer!.y).toBeLessThan(examComments!.y);
  await page.locator('input[value="910000002"]').check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  const problem = page.getByRole('region', { name: '문제 댓글', exact: true });
  await expect(problem).toBeVisible();
  await expect(problem).not.toContainText('Only an exam comment');
  await problem.getByText('댓글 남기기', { exact: true }).click();
  await problem.getByLabel('작성자명 (선택)').fill('Study partner');
  await problem.getByLabel('댓글', { exact: true }).fill('Only the first question');
  await problem.getByRole('button', { name: '댓글 등록', exact: true }).click();
  await expect(problem.locator('.forum-comments')).toContainText('Only the first question');
  await expect(problem.locator('.forum-comments')).toContainText('Study partner');
  await expect(problem.getByText('댓글을 등록했습니다.', { exact: true })).toHaveCount(0);
  const problemComposer = await problem.locator('.comment-composer').boundingBox();
  const problemComments = await problem.locator('.forum-comments').boundingBox();
  expect(problemComposer!.y).toBeLessThan(problemComments!.y);
  await expect(exam).not.toContainText('Only the first question');
  const ids = await page.locator('[id]').evaluateAll(nodes => nodes.map(node => node.id));
  expect(new Set(ids).size).toBe(ids.length);
  await page.getByRole('button', { name: '다음', exact: true }).click();
  await page.locator('input[value="910000004"]').check();
  await page.locator('input[value="910000005"]').check();
  await page.getByRole('button', { name: '정답 확인', exact: true }).click();
  await expect(problem).not.toContainText('Only the first question');
  await page.getByRole('button', { name: '이전', exact: true }).click();
  await expect(problem.locator('.forum-comments')).toContainText('Only the first question');
  await page.reload();
  await expect(problem.locator('.forum-comments')).toContainText('Only the first question');
  await expect(exam.locator('.forum-comments')).toContainText('Only an exam comment');
  const tab = await context.newPage();
  await tab.goto('/engineer-electricity?verNbr=202610');
  const otherExam = tab.getByRole('region', { name: '시험 댓글', exact: true });
  await expect(otherExam).not.toContainText('Only an exam comment');
  await tab.close();
});

test('comment pages include large threads and retain ownership past the newest twenty comments', async ({ page, context }) => {
  const created = await mutate(context.request, { action: 'create', examId: '5', locale: 'ko', title: 'Paging ownership fixture', body: 'Owner seed' });
  expect(created.status()).toBe(202);
  const { postId, topicId } = await created.json();
  try {
    await fixtureAdmin("insert into public.quizeey_posts(topic_id,body,visibility,created_at) select $1,'Paged comment '||n,'approved','2099-01-01T03:04:05.123456Z'::timestamptz from generate_series(1,25) n", [topicId]);
    await fixtureAdmin('insert into quizeey_private.post_owners select id,(select capability_hash from quizeey_private.post_owners where post_id=$2) from public.quizeey_posts where topic_id=$1 and id<>$2', [topicId, postId]);
    await fixtureAdmin('update public.quizeey_topics set approved_post_count=26 where id=$1', [topicId]);
    await page.goto('/sqlp-developer');
    const forum = page.getByRole('region', { name: '시험 댓글', exact: true });
    const pages = forum.getByRole('navigation', { name: '댓글 페이지' });
    await expect(forum.locator('.forum-post')).toHaveCount(10);
    const card = page.locator('.exam-comments-card');
    const expanded = await card.boundingBox();
    expect(expanded!.height).toBeGreaterThan(page.viewportSize()!.height);
    expect(await card.evaluate(element => element.scrollHeight - element.clientHeight)).toBeLessThanOrEqual(1);
    const footer = await page.locator('.site-footer').boundingBox();
    expect(footer!.y).toBeGreaterThanOrEqual(expanded!.y + expanded!.height);
    await page.evaluate(() => window.scrollTo(0, 400));
    const scrolled = await card.boundingBox();
    expect(scrolled!.y).toBeLessThan(expanded!.y - 300);
    await page.evaluate(() => window.scrollTo(0, 0));
    const composer = await forum.locator('.comment-composer').boundingBox();
    const firstComment = await forum.locator('.forum-post').first().boundingBox();
    expect(composer!.y).toBeLessThan(firstComment!.y);
    const first = await forum.locator('.forum-body').allTextContents();
    await pages.getByRole('button', { name: '다음 댓글', exact: true }).click();
    await expect(pages).toContainText('2 페이지');
    await expect(forum.locator('.forum-post')).toHaveCount(10);
    const second = await forum.locator('.forum-body').allTextContents();
    expect(second.some(value => first.includes(value))).toBe(false);
    await pages.getByRole('button', { name: '다음 댓글', exact: true }).click();
    await expect(pages).toContainText('3 페이지');
    const oldComment = forum.locator('.forum-post').filter({ hasText: 'Paged comment' }).first();
    await oldComment.getByRole('button', { name: '수정', exact: true }).click();
    await forum.getByLabel('댓글 수정', { exact: true }).fill('Older-page edit is immediately public');
    await forum.getByRole('button', { name: '댓글 등록', exact: true }).click();
    await expect(forum.locator('.forum-comments')).toContainText('Older-page edit is immediately public');
    await pages.getByRole('button', { name: '이전 댓글', exact: true }).click();
    await expect(pages).toContainText('2 페이지');
    await expect(forum.locator('.forum-body')).toHaveText(second);
    expect((await context.request.get('/api/forum?testId=5&locale=ko&cursor=invalid')).status()).toBe(400);
  } finally {
    await fixtureAdmin('delete from quizeey_private.post_owners where post_id in (select id from public.quizeey_posts where topic_id=$1)', [topicId]);
    await fixtureAdmin('delete from public.quizeey_posts where topic_id=$1', [topicId]);
    await fixtureAdmin('delete from public.quizeey_topics where id=$1', [topicId]);
  }
});

test('mobile title opens a right-hand modal with focus containment, draft retention and desktop sidebar', async ({ page }) => {
  const errors: string[] = [];
  page.on('pageerror', error => errors.push(error.message));
  await page.setViewportSize({ width: 375, height: 812 });
  await page.goto('/sqlp-developer');
  const trigger = page.getByRole('button', { name: '댓글', exact: true });
  await expect(trigger).toBeVisible();
  await expect(page.locator('.exam-comments-panel')).toHaveCount(0);
  await trigger.click();
  const dialog = page.getByRole('dialog', { name: '시험 댓글' });
  await expect(dialog).toBeVisible();
  await expect(dialog.getByRole('button', { name: '댓글 닫기' })).toBeFocused();
  expect(await page.evaluate(() => document.body.style.overflow)).toBe('hidden');
  await dialog.getByLabel('댓글', { exact: true }).fill('Preserved mobile draft');
  await expect(dialog).not.toContainText('쿠키를 유지');
  await expect(dialog).not.toContainText('검토 대기');
  for (let index = 0; index < 6; index++) {
    await page.keyboard.press('Tab');
    expect(await dialog.evaluate(element => element.contains(document.activeElement))).toBe(true);
  }
  expect((await new AxeBuilder({ page }).analyze()).violations).toEqual([]);
  await page.screenshot({ path: test.info().outputPath('mobile-comments.png') });
  await page.keyboard.press('Escape');
  await expect(dialog).not.toBeVisible();
  await expect(trigger).toBeFocused();
  expect(await page.evaluate(() => document.body.style.overflow)).not.toBe('hidden');
  await trigger.click();
  await expect(dialog.getByLabel('댓글', { exact: true })).toHaveValue('Preserved mobile draft');
  await page.setViewportSize({ width: 1280, height: 900 });
  await expect(page.locator('.exam-comments-panel')).toBeVisible();
  const question = await page.locator('.question-card').boundingBox();
  const sidebar = await page.locator('.exam-comments-panel').boundingBox();
  expect(sidebar!.x).toBeGreaterThan(question!.x + question!.width);
  const card = await page.locator('.exam-comments-card').boundingBox();
  const footer = await page.locator('.site-footer').boundingBox();
  expect(footer!.y).toBeGreaterThanOrEqual(card!.y + card!.height);
  expect(await page.locator('.exam-comments-card').evaluate(element => element.scrollHeight - element.clientHeight)).toBeLessThanOrEqual(1);
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
  await page.screenshot({ path: test.info().outputPath('desktop-comments.png'), fullPage: true });
  await page.setViewportSize({ width: 375, height: 812 });
  await expect(page.getByRole('dialog')).not.toBeVisible();
  expect(errors).toEqual([]);
});
