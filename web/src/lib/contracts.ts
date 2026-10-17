import contract from "../../fixtures/legacy-contract.json";

export type Locale = "ko" | "en";
export type LegacyRoute = (typeof contract.routes)[number];
export const legacy = contract;

export function findRoute(path: string): LegacyRoute | undefined {
  return contract.routes.find((route) => route.path === path);
}

// IDs remain decimal strings internally, including integers beyond JS's safe range.
export function identifier(input: string | undefined): string | undefined {
  if (input === undefined) return undefined;
  if (!/^[1-9]\d{0,18}$/.test(input) || BigInt(input) > 9223372036854775807n) {
    throw new Error("Invalid legacy identifier");
  }
  return input;
}

export function parseQuery(query: URLSearchParams, requiredTest = false) {
  for (const key of ["testId", "questId", "verNbr"]) {
    if (query.getAll(key).length > 1) throw new Error("Ambiguous legacy query");
  }
  const testId = identifier(query.has("testId") ? query.get("testId")! : undefined);
  const questId = identifier(query.has("questId") ? query.get("questId")! : undefined);
  const rawVersion = query.get("verNbr");
  if (rawVersion !== null && (!/^(0|[1-9]\d{0,8})$/.test(rawVersion))) throw new Error("Invalid version");
  if (requiredTest && !testId) throw new Error("testId required");
  return { testId, questId, verNbr: rawVersion === null ? 0 : Number(rawVersion) };
}

export function routesForExam(testId: string, locale: Locale) {
  return contract.routes.filter((route) => route.testId === testId && route.locale === locale && !route.path.startsWith("/kr/"));
}
