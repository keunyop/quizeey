import type { LegacyRoute, Locale } from "./contracts";

export const categories = ["all", "it", "electrical", "safety", "engineering", "service", "other"] as const;
export type Category = typeof categories[number];
export const categoryNames: Record<Locale, Record<Category, string>> = {
  ko: { all: "전체", it: "IT·데이터", electrical: "전기·전자", safety: "안전·환경", engineering: "건설·기계", service: "생활·서비스", other: "기타" },
  en: { all: "All", it: "IT & data", electrical: "Electrical", safety: "Safety & environment", engineering: "Engineering", service: "Life & services", other: "Other" },
};
export function examName(route: LegacyRoute) {
  return (route.headings[0] || route.title || "Quizeey").replace(/\s*(기출문제|Practice Questions)\s*$/i, "").trim();
}
export function examCategory(route: LegacyRoute): Exclude<Category, "all"> {
  const name = route.path + " " + examName(route);
  if (/sql|aws|azure|microsoft|ms-\d|az-\d|정보처리|정보보안|정보기기|정보관리|컴퓨터|컴활|컴퓨터활용|워드프로세서|사무자동화|웹디자인|게임|멀티미디어|네트워크|리눅스|전자계산|빅데이터|데이터|network|linux|comptia/i.test(name)) return "it";
  if (/안전|환경|위험물|가스|소방|산업위생|소음|폐기물|safety|environment|pollution|hazard|fire-protection|gas/.test(name)) return "safety";
  if (/전기|전자|무선|전파|방송통신|정보통신|통신선로|electri|electronic|radio|telecommunication/.test(name)) return "electrical";
  if (/건축|건설|토목|측량|기계|용접|자동차|금속|재료|공조|냉동|에너지|승강기|지게차|굴삭기|철도|교통|도시|조경|콘크리트|설비|화공|화학|품질경영|machin|architect|weld|motor|surveying|fork-lift|construction|refrigera|energy|landscape|elevator|metal|transportation/.test(name)) return "engineering";
  if (/미용|조리|제빵|제과|식품|조주|직업상담|사회조사|간호|임상|영양|위생사|피부|네일|메이크업|서비스|유통|텔레마케팅|hair|cook|food|bread|baker|bartender|nail|esthetician|make-up|counsel|nurs|psycholog|survey-analyst|telemarketing|distribution/.test(name)) return "service";
  return "other";
}
function normalize(value: string) { return value.toLocaleLowerCase().replace(/[\s–—·()_-]/g, ""); }
function initials(value: string) {
  const cho = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
  return Array.from(value).map((c) => { const code = c.charCodeAt(0) - 44032; return code >= 0 && code < 11172 ? cho[Math.floor(code / 588)] : c; }).join("");
}
export function matchesExam(route: LegacyRoute, search: string) {
  const term = normalize(search);
  const name = route.title + examName(route) + route.path + (route.testId === "5" ? " SQLD SQL개발자" : "");
  const words = search.split(/[\s–—·()_-]+/).map(normalize).filter(Boolean);
  return words.every((word) => normalize(name).includes(word)) || normalize(initials(examName(route))).includes(term);
}
export function readFavorites(raw: string | null): string[] {
  if (!raw || raw.length > 10000) return [];
  try {
    const value = JSON.parse(raw);
    return value?.schema === 1 && Array.isArray(value.paths) && value.paths.length <= 250 && value.paths.every((path: unknown) => typeof path === "string" && /^\/(?:en\/)?[a-z0-9-]+$/.test(path)) ? [...new Set<string>(value.paths)] : [];
  } catch { return []; }
}
