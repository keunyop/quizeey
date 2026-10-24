import { expect, test } from "@playwright/test";
import pg from "pg";
import { legacy, type Locale } from "../src/lib/contracts";
import { examName } from "../src/lib/exam-catalog";

const origin = "http://127.0.0.1:3100";
const database = "postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture";
async function fixture(query: string, values: unknown[] = []) {
  if (process.env.VERCEL_ENV || process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== database) throw new Error("Isolated fixture required");
  const client = new pg.Client({ connectionString: "postgresql://quizeey_fixture@127.0.0.1:55432/quizeey_fixture" });
  await client.connect();
  try { return await client.query(query, values); } finally { await client.end(); }
}
async function count(id: string) {
  const result = await fixture("select click_count::text as count from quizeey_private.exam_clicks where exam_id=$1", [id]);
  return Number(result.rows[0]?.count ?? 0);
}

for (const locale of ["ko", "en"] as Locale[]) {
  test(`${locale} catalog supports name order throughout search, filters, favorites and pagination`, async ({ page }) => {
    await page.goto(locale === "ko" ? "/" : "/en");
    const sort = page.getByLabel(locale === "ko" ? "시험 정렬" : "Sort exams", { exact: true });
    await expect(sort).toHaveValue("popular");
    await sort.selectOption("name");
    const collator = new Intl.Collator(locale, { sensitivity: "base", numeric: true });
    const routes = legacy.routes.filter(r => r.testId && r.locale === locale && !r.path.startsWith("/kr/"));
    const names = routes.map(examName).sort(collator.compare);
    await expect(page.locator(".exam-card h3")).toHaveText(names.slice(0, 18));
    if (routes.length > 18) {
      await page.getByRole("button", { name: locale === "ko" ? /시험 더 보기/ : /Show more/ }).click();
      await expect(page.locator(".exam-card h3")).toHaveText(names.slice(0, 36));
    }
    await page.getByRole("searchbox").fill(locale === "ko" ? "기사" : "AWS");
    const filtered = await page.locator(".exam-card h3").allTextContents();
    expect(filtered).toEqual([...filtered].sort(collator.compare));
    await page.locator(".favorite-button").first().click();
    await page.getByRole("button", { name: locale === "ko" ? /^즐겨찾기/ : /^Favorites/ }).first().click();
    await expect(page.locator(".exam-card")).toHaveCount(1);
    await expect(sort).toHaveValue("name");
    await page.getByRole("button", { name: locale === "ko" ? "IT·데이터" : "IT & data", exact: true }).click();
    await expect(sort).toHaveValue("name");
    await page.getByRole("button", { name: locale === "ko" ? "필터 초기화" : "Reset filters", exact: true }).click();
    await expect(page.locator(".exam-card h3")).toHaveText(names.slice(0, 18));
    await sort.selectOption("popular");
    await expect(sort).toHaveValue("popular");
  });
}

test("recording failure does not block exam navigation", async ({ page }) => {
  await page.route("**/api/exams/click", route => route.abort());
  await page.goto("/");
  await page.getByRole("searchbox").fill("SQLD");
  await page.locator('.exam-card a[href="/sqlp-developer"]').click();
  await expect(page).toHaveURL(origin + "/sqlp-developer");
  await expect(page.locator(".study-heading h1")).toHaveText("SQLD - 국가공인 SQL개발자");
});

test.describe("shared database click counts", () => {
  test.skip(process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL !== database, "Isolated PostgreSQL fixture required");

  test("native, keyboard, middle and directory links count once; render, favorites and detail reload do not", async ({ page, context }) => {
    const initial = await count("5");
    await page.goto("/");
    await page.getByRole("searchbox").fill("SQLD");
    await page.locator(".favorite-button").click();
    expect(await count("5")).toBe(initial);
    await page.locator('.exam-card a[href="/sqlp-developer"]').click();
    await expect(page).toHaveURL(origin + "/sqlp-developer");
    // A keepalive request can outlive the old document's response event.
    // Verify the persisted navigation effect, as for the keyboard/middle clicks below.
    await expect.poll(() => count("5")).toBe(initial + 1);
    await page.reload();
    expect(await count("5")).toBe(initial + 1);
    await page.goto("/");
    await page.getByRole("searchbox").fill("SQLD");
    await page.locator('.exam-card a[href="/sqlp-developer"]').focus();
    await page.keyboard.press("Enter");
    await expect(page).toHaveURL(origin + "/sqlp-developer");
    await expect.poll(() => count("5")).toBe(initial + 2);
    await page.goto("/");
    await page.getByRole("searchbox").fill("SQLD");
    const popup = context.waitForEvent("page");
    await page.locator('.exam-card a[href="/sqlp-developer"]').click({ button: "middle" });
    const tab = await popup;
    await expect(tab).toHaveURL(origin + "/sqlp-developer");
    await expect.poll(() => count("5")).toBe(initial + 3);
    await tab.close();
    await page.locator(".exam-directory summary").click();
    await page.locator('.exam-directory a[href="/sqlp-developer"]').click();
    await expect(page).toHaveURL(origin + "/sqlp-developer");
    await expect.poll(() => count("5")).toBe(initial + 4);
    const otherBrowser = await context.browser()!.newContext();
    try {
      const otherPage = await otherBrowser.newPage();
      await otherPage.goto(origin);
      await expect(otherPage.locator(".exam-card a").first()).toHaveAttribute("href", "/sqlp-developer");
    } finally { await otherBrowser.close(); }
  });

  test("popularity is the default and name sorting can override higher counts", async ({ page }) => {
    const ko = legacy.routes.filter(r => r.testId && r.locale === "ko" && !r.path.startsWith("/kr/"));
    const collator = new Intl.Collator("ko", { sensitivity: "base", numeric: true });
    const sorted = [...ko].sort((a, b) => collator.compare(examName(a), examName(b)));
    const promoted = sorted.at(-1)!;
    const prior = await count(promoted.testId!);
    try {
      await fixture("insert into quizeey_private.exam_clicks(exam_id,click_count) values($1,10000) on conflict(exam_id) do update set click_count=10000", [promoted.testId]);
      await page.goto("/");
      await expect(page.getByLabel("시험 정렬", { exact: true })).toHaveValue("popular");
      await expect(page.locator(".exam-card a").first()).toHaveAttribute("href", promoted.path);
      await page.getByLabel("시험 정렬", { exact: true }).selectOption("name");
      await expect(page.locator(".exam-card a").first()).toHaveAttribute("href", sorted[0].path);
    } finally {
      await fixture("update quizeey_private.exam_clicks set click_count=$2 where exam_id=$1", [promoted.testId, prior]);
    }
  });
});
