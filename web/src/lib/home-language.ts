import type { Locale } from './contracts';

export const languagePreferenceCookie = 'quizeey_locale';
export const languagePreferenceMaxAge = 60 * 60 * 24 * 365;

// This affects navigation only, never access control or the content at a URL.
// Crawlers can discover both stable language URLs through links and hreflang.
const crawler = /bot|crawler|spider|slurp|yeti|Google-InspectionTool|GoogleOther|Mediapartners-Google|bingpreview|facebookexternalhit/i;

export function homeLanguageRedirect(input: {
  pathname: string;
  query: URLSearchParams;
  country: string | null;
  preference: string | undefined;
  userAgent: string | null;
}): { destination: string; preference?: Locale } | undefined {
  if (input.pathname !== '/' && input.pathname !== '/en') return undefined;
  const requested = input.query.get('lang');
  if (input.query.getAll('lang').length === 1 && (requested === 'ko' || requested === 'en')) {
    const query = new URLSearchParams(input.query);
    query.delete('lang');
    return {
      destination: (requested === 'en' ? '/en' : '/') + (query.size ? '?' + query : ''),
      preference: requested,
    };
  }
  // /en and all explicit subject URLs stay accessible from every country.
  if (input.pathname !== '/' || crawler.test(input.userAgent ?? '')) return undefined;
  const country = input.country?.trim().toUpperCase();
  const knownCountry = country && /^[A-Z]{2}$/.test(country) && !['XX', 'ZZ'].includes(country);
  // Missing geo information keeps the established Korean root, including local
  // development. Browser language is not a substitute for the visitor's country.
  const locale = input.preference === 'en' || input.preference === 'ko' ? input.preference
    : knownCountry ? country === 'KR' ? 'ko' : 'en' : 'ko';
  if (locale !== 'en') return undefined;
  return { destination: '/en' + (input.query.size ? '?' + input.query : '') };
}
