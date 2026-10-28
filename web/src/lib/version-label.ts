import type { Locale } from "./contracts";

/** Format a visible set label without changing its stored name or numeric identity. */
export function versionDisplayName(name: string | undefined, number: number, locale: Locale) {
  const label = name || String(number);
  if (!/^\d{4}-(0[1-9]|1[0-2])$/.test(label)) return label;
  return `${label} ${locale === "ko" ? "기출문제" : "practice questions"}`;
}
