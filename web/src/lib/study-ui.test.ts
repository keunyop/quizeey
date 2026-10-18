import { describe, expect, it } from "vitest";
import { findRoute, legacy } from "./contracts";
import { examCategory, examName, matchesExam, readFavorites } from "./exam-catalog";
import { emptyProgress, practiceStats, readProgress, reviewProgress } from "./progress";

describe("exam discovery", () => {
  it("finds Korean initials, aliases, spacing and English names", () => {
    expect(matchesExam(findRoute("/sqlp-developer")!, "sqld")).toBe(true);
    expect(matchesExam(findRoute("/engineer-information-processing")!, "ㅈㅂㅊㄹ")).toBe(true);
    expect(matchesExam(findRoute("/diat")!, "ㅈㅂㅊㄹㄱㅅ")).toBe(false);
    expect(matchesExam(findRoute("/computer-specialist-in-spreadsheet-and-database-level-2")!, "컴활2급")).toBe(true);
    expect(matchesExam(findRoute("/en/aws-certified-developer-associate")!, "AWS developer")).toBe(true);
    expect(matchesExam(findRoute("/en/aws-certified-developer-associate")!, "aws-certified")).toBe(true);
  });
  it("keeps every exam discoverable and classifies representative subjects", () => {
    expect(legacy.routes.filter((route) => route.testId).every((route) => examName(route) && matchesExam(route, ""))).toBe(true);
    for (const [path, category] of [["/sqlp-developer", "it"], ["/engineer-electricity", "electrical"], ["/engineer-industrial-safety", "safety"], ["/engineer-architecture", "engineering"], ["/nail-technician", "service"]]) expect(examCategory(findRoute(path)!)).toBe(category);
  });
  it("recovers from broken or untrusted favorite storage", () => {
    for (const raw of [null, "broken", "null", '{"schema":1,"paths":[{}]}', '{"schema":2,"paths":["/sqlp-developer"]}', '{"schema":1,"paths":["//evil.test"]}', '{"schema":1,"paths":["javascript:alert(1)"]}']) expect(readFavorites(raw)).toEqual([]);
    expect(readFavorites('{"schema":1,"paths":["/sqlp-developer","/sqlp-developer","/craftsman-cook-korean-food"]}')).toEqual(["/sqlp-developer", "/craftsman-cook-korean-food"]);
  });
});

describe("review sessions and honest results", () => {
  function fixture() {
    return { ...emptyProgress(["1", "2", "3"], "v1"), index: 3, bookmarks: ["2"], attempts: { "1": { selected: ["11"], correct: false }, "2": { selected: ["22"], correct: true } } };
  }
  it("counts skipped questions separately from answered questions", () => {
    expect(practiceStats(fixture(), ["1", "2", "3"])).toEqual({ correct: 1, incorrect: 1, unanswered: 1, answered: 2 });
  });
  it.each(["mistakes", "bookmarks", "unanswered"] as const)("starts %s review, preserves unrelated answers and restores after refresh", (mode) => {
    const original = fixture(); const next = reviewProgress(original, mode);
    const id = mode === "mistakes" ? "1" : mode === "bookmarks" ? "2" : "3";
    expect(next.reviewIds).toEqual([id]);
    expect(next.index).toBe(0);
    expect(next.attempts[id]).toBeUndefined();
    expect(next.bookmarks).toEqual(["2"]);
    expect(Object.keys(next.attempts)).toHaveLength(mode === "unanswered" ? 2 : 1);
    expect(readProgress(JSON.stringify(next), original.ids, "v1")).toEqual(next);
    expect(original.index).toBe(3);
    expect(Object.keys(original.attempts)).toHaveLength(2);
  });
  it("does not open an empty review and uses the current review denominator", () => {
    const original = fixture(); original.bookmarks = [];
    expect(reviewProgress(original, "bookmarks")).toBe(original);
    const review = reviewProgress(original, "mistakes");
    review.attempts["1"] = { selected: ["12"], correct: true };
    expect(practiceStats(review, review.reviewIds!)).toEqual({ correct: 1, incorrect: 0, unanswered: 0, answered: 1 });
  });
  it("rejects malformed review modes, duplicate review IDs and invalid review indexes", () => {
    const original = fixture();
    for (const patch of [{ reviewMode: "unknown" }, { reviewIds: ["1", "1"], index: 0 }, { reviewIds: ["1"], index: 2 }, { choiceOrders: [] }]) expect(readProgress(JSON.stringify({ ...original, ...patch }), original.ids, "v1")).toBeNull();
    expect(readProgress(JSON.stringify(original), original.ids, "v1")).toEqual(original);
  });
});
