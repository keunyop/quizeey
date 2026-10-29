import { expect, test } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";
import pg from "pg";
const origin = "http://127.0.0.1:3100";
const database = "postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture";
async function fixture(query: string, values: unknown[] = []) {
  if (process.env.VERCEL_ENV || process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== database) throw new Error("Isolated fixture required");
  const client = new pg.Client({ connectionString: "postgresql://quizeey_fixture@127.0.0.1:55432/quizeey_fixture" });
  await client.connect(); try { return await client.query(query, values); } finally { await client.end(); }
}

test("exam information starts collapsed beside the title and expands below it in both languages", async ({ page }) => {
  for (const [path, label] of [["/sqlp-developer", "시험정보"], ["/en/aws-certified-developer-associate", "Exam info"]]) {
    for (const width of [320, 1440]) {
      await page.setViewportSize({ width, height: 900 }); await page.goto(path);
      const button = page.getByRole("button", { name: label, exact: true });
      await expect(button).toHaveAttribute("aria-expanded", "false");
      const description = page.locator(".exam-info-description"); await expect(description).toBeHidden();
      await expect(page.locator(".exam-title-line")).toContainText(label);
      await button.click(); await expect(description).toBeVisible();
      expect((await description.boundingBox())!.y).toBeGreaterThan((await page.locator(".exam-title-line").boundingBox())!.y);
      expect((await description.textContent())!.trim().length).toBeGreaterThan(0);
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
      await button.click(); await expect(description).toBeHidden();
    }
  }
});

test("feedback modal supports escape, keyboard focus, failure recovery and accessible forms", async ({ page }) => {
  await page.goto("/");
  const trigger = page.getByRole("link", { name: /^(피드백|Feedback)$/, exact: true }); await trigger.click();
  const dialog = page.getByRole("dialog", { name: "피드백", exact: true });
  await expect(dialog).toBeVisible(); await page.keyboard.press("Escape"); await expect(dialog).not.toBeVisible(); await expect(trigger).toBeFocused();
  await trigger.click(); await dialog.getByLabel("피드백 내용").fill("Retained feedback draft");
  await page.route("**/api/feedback", route => route.fulfill({ status: 503, json: { error: "Unavailable" } }));
  await dialog.getByRole("button", { name: "보내기", exact: true }).click();
  await expect(dialog.getByRole("status")).toContainText("전송하지 못했습니다");
  await expect(dialog.getByLabel("피드백 내용")).toHaveValue("Retained feedback draft");
  expect((await new AxeBuilder({ page }).analyze()).violations).toEqual([]);
  await page.setViewportSize({ width: 320, height: 700 });
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
});

test.describe("visitor submissions and operator dashboard", () => {
  test.skip(process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== database, "Isolated PostgreSQL fixture required");
  async function cleanup() {
    for (const table of ["quizeey_private.post_owners", "quizeey_private.post_revisions", "quizeey_private.forum_reports"]) await fixture("delete from " + table + " where post_id in (select id from public.quizeey_posts where topic_id in (select id from public.quizeey_topics where title='Latest comments fixture'))");
    await fixture("delete from public.quizeey_posts where topic_id in (select id from public.quizeey_topics where title='Latest comments fixture')");
    await fixture("delete from public.quizeey_topics where title='Latest comments fixture'");
    await fixture("delete from quizeey_private.visitor_submissions where body=any($1::text[]) or body like 'Latest paging fixture %'", [["해설 오류\nExplanation needs review fixture", "Dashboard feedback fixture <script>alert(1)</script>", "Idempotent feedback fixture"]]);
  }
  test.beforeEach(async () => { await cleanup(); await fixture("delete from quizeey_private.rate_windows"); });
  test.afterEach(cleanup);
  test("anonymous feedback and question reports reach admin/admin, preserve context and resolution history", async ({ page, browser }) => {
    await page.goto("/sqlp-developer?verNbr=1");
    await page.getByRole("button", { name: "오답 신고", exact: true }).click();
    const report = page.getByRole("dialog", { name: "오답 신고", exact: true });
    await report.getByLabel("신고 유형", { exact: true }).selectOption({ label: "해설 오류" });
    await report.getByLabel("추가 설명 (선택)").fill("Explanation needs review fixture");
    const recorded = page.waitForResponse(response => response.url().endsWith("/api/feedback"));
    await report.getByRole("button", { name: "보내기", exact: true }).click();
    const response = await recorded; expect(response.status()).toBe(201);
    const payload = response.request().postDataJSON();
    expect(payload).toMatchObject({ examId: "5", questionId: "900000001" });
    await expect(report).toContainText("접수했습니다");
    await report.getByRole("button", { name: "닫기", exact: true }).last().click();
    await page.getByRole("link", { name: /^(피드백|Feedback)$/, exact: true }).click();
    const feedback = page.getByRole("dialog", { name: "피드백", exact: true });
    await feedback.getByLabel("피드백 내용").fill("Dashboard feedback fixture <script>alert(1)</script>");
    await feedback.getByRole("button", { name: "보내기", exact: true }).click(); await expect(feedback).toContainText("접수했습니다");
    await feedback.getByRole("button", { name: "닫기", exact: true }).last().click();
    const operator = await browser.newContext();
    try {
      expect((await operator.request.get(origin + "/api/admin/overview")).status()).toBe(401);
      expect((await operator.request.get(origin + "/api/admin/inbox?kind=feedback")).status()).toBe(401);
      const admin = await operator.newPage(); await admin.goto(origin + "/admin");
      await admin.getByLabel("아이디 또는 이메일", { exact: true }).fill("admin"); await admin.getByLabel("비밀번호", { exact: true }).fill("admin");
      await admin.getByRole("button", { name: "로그인", exact: true }).click();
      const dashboard = admin.getByRole("region", { name: "사이트 관리", exact: true });
      await expect(dashboard).toBeVisible(); await expect(dashboard.locator("tbody tr").first()).toBeVisible();
      await admin.screenshot({ path: test.info().outputPath("admin-dashboard.png") });
      await dashboard.getByRole("button", { name: "오답 신고", exact: true }).click();
      const entry = dashboard.locator(".admin-entry").filter({ hasText: "Explanation needs review fixture" });
      await expect(entry).toContainText("900000001"); await expect(entry.locator("a")).toHaveAttribute("href", "/sqlp-developer?questId=900000001");
      await entry.getByRole("button", { name: "처리 완료로 변경", exact: true }).click(); await expect(entry).toContainText("처리 완료");
      await dashboard.getByRole("button", { name: "미처리", exact: true }).click(); await expect(entry).toHaveCount(0);
      await dashboard.getByRole("button", { name: "처리 완료", exact: true }).click(); await expect(entry).toBeVisible();
      await entry.getByRole("button", { name: "다시 열기", exact: true }).click(); await expect(entry).toHaveCount(0);
      await dashboard.getByRole("button", { name: "피드백", exact: true }).click(); await expect(dashboard).toContainText("Dashboard feedback fixture <script>alert(1)</script>");
      await dashboard.getByRole("button", { name: "최근 처리 이력", exact: true }).click(); await expect(dashboard).toContainText("피드백·오답 신고 다시 열기");
      await admin.setViewportSize({ width: 320, height: 800 });
      expect(await admin.evaluate(() => document.documentElement.scrollWidth <= innerWidth)).toBe(true);
      expect((await new AxeBuilder({ page: admin }).analyze()).violations).toEqual([]);
      const token = (await operator.cookies()).find(cookie => cookie.name === "__Host-quizeey-admin")!;
      expect(token).toMatchObject({ httpOnly: true, secure: true, sameSite: "Strict" });
      await admin.getByRole("button", { name: "로그아웃", exact: true }).click();
      expect((await operator.request.get(origin + "/api/admin/overview", { headers: { cookie: token.name + "=" + token.value } })).status()).toBe(401);
    } finally { await operator.close(); }
  });

  test("inbox pages are latest-first and retry receipts do not duplicate feedback", async ({ browser, request }) => {
    const key = crypto.randomUUID(), data = { kind: "feedback", locale: "ko", path: "/", body: "Idempotent feedback fixture" };
    for (let n = 0; n < 2; n++) expect((await request.post("/api/feedback", { headers: { Origin: origin, "Idempotency-Key": key }, data })).status()).toBe(201);
    expect((await fixture("select count(*)::int as count from quizeey_private.visitor_submissions where id=$1", [key])).rows[0].count).toBe(1);
    for (const body of ["Older comment fixture", "Newest comment fixture"]) expect((await request.post("/api/forum", { headers: { Origin: origin, "Idempotency-Key": crypto.randomUUID() }, data: { action: "create", examId: "5", locale: "ko", title: "Latest comments fixture", body } })).status()).toBe(202);
    const paging = await fixture("with stamp as (select greatest(coalesce(max(created_at),now()),now()) + interval '1 day' as latest from quizeey_private.visitor_submissions) insert into quizeey_private.visitor_submissions(id,request_hash,kind,locale,path,body,created_at) select gen_random_uuid(),repeat('a',64),'feedback','ko','/','Latest paging fixture '||n,stamp.latest from generate_series(1,25) n cross join stamp returning created_at");
    const operator = await browser.newContext();
    try {
      expect((await operator.request.post(origin + "/api/admin/login", { headers: { Origin: origin }, data: { username: "admin", password: "admin" } })).status()).toBe(200);
      const first = await (await operator.request.get(origin + "/api/admin/inbox?kind=feedback")).json(); expect(first.items).toHaveLength(20); expect(first.nextCursor).toBeTruthy();
      const second = await (await operator.request.get(origin + "/api/admin/inbox?kind=feedback&cursor=" + first.nextCursor)).json();
      const ids = [...first.items, ...second.items].map(item => item.id); expect(new Set(ids).size).toBe(ids.length);
      expect(new Date(first.items[0].created_at).toISOString()).toBe(new Date(paging.rows[0].created_at).toISOString());
      const comments = await (await operator.request.get(origin + "/api/admin/inbox?kind=comments")).json();
      expect(comments.items.length).toBeGreaterThan(0);
      expect(comments.items[0].body).toBe("Newest comment fixture");
      const timestamps = comments.items.map((item: { created_at: string }) => Date.parse(item.created_at));
      expect(timestamps).toEqual([...timestamps].sort((a, b) => b - a));
    } finally { await operator.close(); }
  });
});
