import { expect, test } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test("Korean SSR, grading, refresh, multiple answers, back, bookmark and completion", async ({ page, request }) => {
  const response = await request.get("/sqlp-developer?verNbr=1");
  const html = await response.text();
  expect(html).toContain("SELECT COUNT(*) FROM sample;");
  expect(response.headers()["x-robots-tag"]).toContain("noindex");
  await page.goto("/sqlp-developer?verNbr=1");
  await expect(page).toHaveTitle("SQLD - 국가공인 SQL개발자 기출문제 · 1 회차 - Quizeey");
  await page.locator('input[value="910000001"]').check();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await page.reload(); await page.getByRole("button", { name: /^(이어서 풀기|Continue)$/ }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await page.locator('input[value="910000004"]').check();
  await page.locator('input[value="910000005"]').check();
  await page.getByRole("button", { name: "북마크", exact: true }).click();
  await page.getByRole("button", { name: "정답 확인", exact: true }).click();
  await expect(page.getByText("정답입니다.", { exact: true })).toBeVisible();
  await expect(page.getByRole("img")).toBeVisible();
  await page.getByRole("button", { name: "이전", exact: true }).click();
  await expect(page.getByText("오답입니다.", { exact: true })).toBeVisible();
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByRole("button", { name: "북마크 해제", exact: true })).toHaveAttribute("aria-pressed", "true");
  await page.getByRole("button", { name: "다음", exact: true }).click();
  await expect(page.getByRole("heading", { name: "학습 완료", exact: true })).toBeVisible();
});

test("deep links, aliases, version filters and invalid identity", async ({ page, request }) => {
  await page.goto("/kr/sqlp-developer?questId=900000002");
  await expect(page.getByText("복수 선택", { exact: true })).toBeVisible();
  await page.goto("/test?testId=5&questId=900000001");
  await expect(page.getByText("SELECT COUNT(*) FROM sample;", { exact: true })).toBeVisible();
  await page.goto("/sqlp-developer?verNbr=2");
  await expect(page.getByText("SQL에서 NULL을 검사하는 조건은 무엇인가요?", { exact: true })).toBeVisible();
  for (const path of ["/sqlp-developer?questId=garbage", "/test", "/test?testId=5&testId=1"]) expect((await request.get(path)).status()).toBe(400);
  for (const path of ["/sqlp-developer?questId=900000004", "/sqlp-developer?questId=999999", "/unknown-exam", "/en/sqlp-developer"]) expect((await request.get(path)).status()).toBe(404);
});

test("English language, mobile, keyboard and zero ad/Disqus/analytics requests", async ({ page }) => {
  const integrations: string[] = [];
  page.on("request", (request) => { if (/googlesyndication|doubleclick|disqus|google-analytics|googletagmanager/.test(request.url())) integrations.push(request.url()); });
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto("/en/aws-certified-developer-associate?verNbr=1");
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await expect(page.getByText("Which practice protects an application secret?", { exact: true })).toBeVisible();
  await page.keyboard.press("Tab");
  await expect(page.locator(":focus")).toBeVisible();
  const results = await new AxeBuilder({ page }).analyze();
  expect(results.violations).toEqual([]);
  expect(await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth)).toBe(true);
  expect(integrations).toEqual([]);
  await expect(page.locator(".adsbygoogle")).toHaveCount(0);
  await expect(page.locator('link[rel="alternate"][hreflang]')).toHaveCount(0);
});

test("skip, corrupt storage recovery and client-side exam search", async ({ page }) => {
  await page.goto("/sqlp-developer?verNbr=1");
  await page.getByRole("button", { name: "건너뛰기", exact: true }).click();
  await expect(page.getByText("복수 선택", { exact: true })).toBeVisible();
  await page.evaluate(() => { for (const key of Object.keys(localStorage)) localStorage.setItem(key, "invalid json"); });
  await page.reload();
  await expect(page.getByText("SELECT COUNT(*) FROM sample;", { exact: true })).toBeVisible();
  await page.goto("/");
  await page.getByRole("searchbox").fill("SQLD");
  await expect(page.locator(".exam-list a")).toHaveCount(1);
  await page.getByRole("link", { name: "English", exact: true }).click();
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
});
