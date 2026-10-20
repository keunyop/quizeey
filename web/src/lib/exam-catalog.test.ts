import { expect, it } from "vitest";
import { legacy, type LegacyRoute } from "./contracts";
import { sortExams } from "./exam-catalog";

function exam(name: string, id: string): LegacyRoute {
  return { ...legacy.routes[0], path: `/exam-${id}`, testId: id, headings: [name] };
}

it("sorts Korean names in 가나다 order and English names alphabetically", () => {
  const ko = [exam("전기기사", "3"), exam("나무의사", "2"), exam("가스기사", "1")];
  const en = [exam("Cisco", "3"), exam("azure", "2"), exam("AWS", "1")];
  expect(sortExams(ko, "ko", "name", { "3": "999" }).map(r => r.testId)).toEqual(["1", "2", "3"]);
  expect(sortExams(en, "en", "name", {}).map(r => r.testId)).toEqual(["1", "2", "3"]);
  expect(ko.map(r => r.testId)).toEqual(["3", "2", "1"]);
});

it("ranks by shared exam clicks, resolves ties by name, and treats missing totals as zero", () => {
  const routes = [exam("다", "3"), exam("나", "2"), exam("가", "1"), exam("라", "4")];
  expect(sortExams(routes, "ko", "popular", { "2": "8", "1": "8", "4": "20" }).map(r => r.testId)).toEqual(["4", "1", "2", "3"]);
  expect(sortExams(routes, "ko", "popular", {}).map(r => r.testId)).toEqual(["1", "2", "3", "4"]);
  expect(sortExams(routes, "ko", "popular", { "1": "9007199254740992", "2": "9007199254740993" })[0].testId).toBe("2");
});
