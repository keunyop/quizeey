import type { Locale } from './contracts';

export const maxPracticeCount = 100;
export type SessionSettings = { seed: string; count: number };
export function sessionCookie(locale: Locale, examId: string, version: number) {
  return `quizeey_session_${locale}_${examId}_${version}`;
}
export function lastSetCookie(locale: Locale, examId: string) {
  return `quizeey_last_set_${locale}_${examId}`;
}
export function readLastSet(raw?: string) {
  return raw && /^(0|[1-9]\d{0,8})$/.test(raw) ? Number(raw) : 0;
}
export function readSessionSettings(raw?: string): SessionSettings | undefined {
  if (!raw) return;
  const [seed, count] = raw.split('.');
  if (seed === 'legacy' && count === '20') return { seed, count: 20 };
  if (/^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$/.test(seed) && /^[1-9]\d{0,2}$/.test(count) && Number(count) <= maxPracticeCount) return { seed, count: Number(count) };
}
export function saveSessionSettings(name: string, settings: SessionSettings) {
  try {
    const attributes = `; Path=/; Max-Age=7776000; SameSite=Lax${location.protocol === 'https:' ? '; Secure' : ''}`;
    document.cookie = `${name}=${settings.seed}.${settings.count}${attributes}`;
    const match = /^quizeey_session_(ko|en)_(\d+)_(\d+)$/.exec(name);
    if (match) document.cookie = `${lastSetCookie(match[1] as Locale, match[2])}=${match[3]}${attributes}`;
  } catch { /* Practice remains usable without browser persistence. */ }
}
