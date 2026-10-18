import contract from "../../fixtures/legacy-contract.json";

export type Locale = "ko" | "en";
export type LegacyRoute = Omit<(typeof contract.routes)[number],'testId'|'links'> & {testId:string|null;links:{href:string;label:string}[]};
// The source controller accidentally used the electrical-work identity for the
// refrigeration exam. The verified live catalog and imported DB agree on 141.
export const legacy = {...contract,routes:contract.routes.map((route):LegacyRoute=>route.path==='/industrial-engineer-air-conditioning-and-refrigerating-machinery'?{...route,testId:'141'}:route)};
export const legacyRedirects:Readonly<Record<string,string>>={
  '/microsoft-az-500':'/az-500',
  '/@ccna-300-115':'/ccnp-300-115',
  '/%40ccna-300-115':'/ccnp-300-115',
};

export function findRoute(path: string): LegacyRoute | undefined {
  return legacy.routes.find((route) => route.path === path);
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
  for (const key of ["testId", "questId", "verNbr", "page"]) {
    if (query.getAll(key).length > 1) throw new Error("Ambiguous legacy query");
  }
  const testId = identifier(query.has("testId") ? query.get("testId")! : undefined);
  const questId = identifier(query.has("questId") ? query.get("questId")! : undefined);
  const rawVersion = query.get("verNbr");
  if (rawVersion !== null && (!/^(0|[1-9]\d{0,8})$/.test(rawVersion))) throw new Error("Invalid version");
  if (requiredTest && !testId) throw new Error("testId required");
  const rawPage=query.get("page");
  if(rawPage!==null&&(!/^[1-9]\d{0,4}$/.test(rawPage)||Number(rawPage)>10000))throw new Error("Invalid practice page");
  return { testId, questId, verNbr: rawVersion === null ? 0 : Number(rawVersion), page:rawPage===null?1:Number(rawPage) };
}

export function routesForExam(testId: string, locale: Locale) {
  return legacy.routes.filter((route) => route.testId === testId && route.locale === locale && !route.path.startsWith("/kr/"));
}
