import { describe, expect, it } from "vitest";
import { findRoute, identifier, legacy, parseQuery } from "./contracts";
import { questions } from "./fixtures";
import { grade, shuffleChoices } from "./quiz";
import { emptyProgress, readProgress } from "./progress";
import { environment } from "./environment";
import { learningHtml } from "./content";

describe("legacy route and query preservation", () => {
  it("matches the reviewed source and every declared route", () => {
    expect(legacy.sourceCommit).toBe("33e8fb73294d1ab66d87cb424d500b63a7320736");
    expect(legacy.sitemapEntries).toBe(238);
    expect(legacy.routes.length).toBeGreaterThan(180);
    expect(legacy.missingTemplates).toEqual([]);
    expect(new Set(legacy.routes.map((r) => r.path)).size).toBe(legacy.routes.length);
    expect(legacy.routes.every((r) => findRoute(r.path)?.testId === r.testId)).toBe(true);
  });
  it("keeps supported aliases and does not invent aliases", () => {
    expect(findRoute("/sqlp-developer")?.testId).toBe("5");
    expect(findRoute("/kr/sqlp-developer")?.testId).toBe("5");
    expect(findRoute("/en/sqlp-developer")).toBeUndefined();
    expect(findRoute("/app")).toBeDefined();
  });
  it("preserves long decimal IDs without numeric rounding", () => {
    expect(identifier("9223372036854775807")).toBe("9223372036854775807");
    expect(() => identifier("9223372036854775808")).toThrow();
  });
  it('binds refrigeration and electrical work to their verified separate exam identities',()=>{
    expect(findRoute('/industrial-engineer-air-conditioning-and-refrigerating-machinery')?.testId).toBe('141');
    expect(findRoute('/industrial-engineer-electric-work')?.testId).toBe('140');
  });
  it.each(["", "0", "-1", "1.5", "1e2", " 5", "05", "NaN", "abc"])("rejects malformed identity %s", (id) => {
    expect(() => parseQuery(new URLSearchParams({ questId: id }))).toThrow();
  });
  it("rejects duplicate IDs and a missing generic test ID", () => {
    expect(() => parseQuery(new URLSearchParams("questId=1&questId=2"))).toThrow();
    expect(() => parseQuery(new URLSearchParams(), true)).toThrow();
  });
  it("keeps unrelated query values and supports the legacy all-version value", () => {
    const query = new URLSearchParams("testId=5&verNbr=0&utm_source=test");
    expect(parseQuery(query, true)).toEqual({ testId: "5", questId: undefined, verNbr: 0, page:1 });
    expect(query.get("utm_source")).toBe("test");
  });
  it('validates bounded practice pages without changing legacy identities',()=>{
    expect(parseQuery(new URLSearchParams('testId=5&page=2'),true)).toMatchObject({testId:'5',page:2});
    for(const query of ['page=0','page=-1','page=01','page=1.5','page=10001','page=2&page=3'])expect(()=>parseQuery(new URLSearchParams(query))).toThrow();
  });
});

describe("grading survives shuffled display letters", () => {
  it("compares single answer identity", () => {
    expect(grade(questions[0], ["910000002"])).toBe(true);
    expect(grade(questions[0], ["910000001"])).toBe(false);
  });
  it("requires exactly the correct set for multiple answers", () => {
    expect(grade(questions[1], ["910000005", "910000004"])).toBe(true);
    expect(grade(questions[1], ["910000004"])).toBe(false);
    expect(grade(questions[1], ["910000004", "910000005", "910000006"])).toBe(false);
    expect(grade(questions[1], ["910000004", "910000004"])).toBe(false);
    expect(grade(questions[1], [])).toBe(false);
  });
  it("does not mutate data and preserves sensitive ordering", () => {
    const original = questions[0].choices.map((c) => c.id);
    const shuffled = shuffleChoices(questions[0], () => 0);
    expect(questions[0].choices.map((c) => c.id)).toEqual(original);
    expect(grade(shuffled, ["910000002"])).toBe(true);
    expect(shuffleChoices(questions[1], () => 0).choices).toEqual(questions[1].choices);
  });
});

describe("versioned local progress", () => {
  const ids = ["900000001", "900000002"];
  it("restores known content only", () => {
    const progress = emptyProgress(ids, "v1");
    progress.index = 1;
    expect(readProgress(JSON.stringify(progress), ids, "v1")?.index).toBe(1);
    expect(readProgress(JSON.stringify(progress), ids, "v2")).toBeNull();
    expect(readProgress(JSON.stringify(progress), ["other"], "v1")).toBeNull();
  });
  it("ignores corrupted and out-of-range storage", () => {
    expect(readProgress("{broken", ids, "v1")).toBeNull();
    expect(readProgress(JSON.stringify({ ...emptyProgress(ids, "v1"), index: 100 }), ids, "v1")).toBeNull();
    expect(readProgress(JSON.stringify({ ...emptyProgress(ids, "v1"), attempts: { x: { selected: [], correct: true } } }), ids, "v1")).toBeNull();
  });
});

describe("safe environment gates", () => {
  it("defaults local and disables live integrations", () => {
    expect(environment({})).toMatchObject({ stage: "local", adsEnabled: false, analyticsEnabled: false });
  });
  it("blocks unprotected preview and fixture production", () => {
    expect(() => environment({ VERCEL_ENV: "preview" })).toThrow(/preview/);
    expect(() => environment({ VERCEL_ENV: "production", QUIZEEY_ENV: "local" })).toThrow(/Production release blocked/);
  });
  it("accepts a protected preview", () => {
    expect(environment({ VERCEL_ENV: "preview", QUIZEEY_PREVIEW_USER: "review", QUIZEEY_PREVIEW_PASSWORD: "test-password-with-24-characters" }).stage).toBe("preview");
  });
  it("rejects origin credentials and non-HTTPS", () => {
    expect(() => environment({ QUIZEEY_CANONICAL_ORIGIN: "https://user:secret@example.com" })).toThrow();
    expect(() => environment({ QUIZEEY_CANONICAL_ORIGIN: "http://quizeey.com" })).toThrow();
  });
});

describe("legacy learning HTML safety", () => {
  it("preserves technical placeholders with their original case as inert text", () => {
    const html=learningHtml('<p>Press <CTRL> + <Page\u00a0Up>; use <AMI-ID> and List<T extends Number>.</p><pre><code><T></T></code></pre>');
    expect(html).toContain('&lt;CTRL&gt;');
    expect(html).toContain('&lt;Page\u00a0Up&gt;');
    expect(html).toContain('&lt;AMI-ID&gt;');
    expect(html).toContain('&lt;T extends Number&gt;');
    expect(html).toContain('<code>&lt;T&gt;&lt;/T&gt;</code>');
    expect(learningHtml(html)).toBe(html);
  });
  it("still removes executable and malformed markup around technical placeholders", () => {
    const html=learningHtml('<CTRL><script>bad()</script><iframe src="https://evil.test"></iframe><T onclick="bad()">value</T><img src="data:image/svg+xml,bad" onerror="bad()"><svg><foreignObject><img src=x onerror=bad()></foreignObject></svg>');
    expect(html).toContain('&lt;CTRL&gt;');
    expect(html).not.toMatch(/<script|<iframe|onclick|onerror|evil\.test|data:image|bad\(\)/);
    expect(html).not.toMatch(/<svg|<foreignObject/i);
  });
  it("removes scripts, event handlers and executable URLs", () => {
    const html = learningHtml('<script>alert(1)</script><p onclick="x()">safe</p><a href="javascript:x()">link</a><img src="//evil.test/a" onerror="x()">');
    expect(html).not.toMatch(/script|onclick|onerror|javascript|evil\.test/);
    expect(html).toContain("safe");
  });
  it("preserves tables, code, subscripts and authorized local images", () => {
    const html = learningHtml('<table><tr><td colspan="2">A<sub>1</sub></td></tr></table><pre><code>SELECT 1;</code></pre><img src="/fixtures/relation.svg" alt="Table" width="400" height="160">');
    expect(html).toContain('<td colspan="2">');
    expect(html).toContain("<code>SELECT 1;</code>");
    expect(html).toContain('alt="Table"');
  });
});
