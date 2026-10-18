import {expect,it} from 'vitest';
import {canonicalPath,seoAlternates,publicSitemap} from './seo';
it('preserves content identity and pages while consolidating aliases and tracking parameters',()=>{
  expect(canonicalPath('/kr/sqlp-developer',new URLSearchParams('utm_source=test&verNbr=2&page=2'))).toBe('/sqlp-developer?verNbr=2&page=2');
  expect(canonicalPath('/test',new URLSearchParams('testId=5&questId=9007199254740993'))).toBe('/sqlp-developer?questId=9007199254740993');
  expect(canonicalPath('/app',new URLSearchParams())).toBe('/');
  expect(canonicalPath('/en/aws-certified-developer-associate',new URLSearchParams('verNbr=0&page=1'))).toBe('/en/aws-certified-developer-associate');
});
it('publishes only verified equivalents and unique static sitemap URLs',()=>{
  const origin='https://quizeey.com';
  expect(seoAlternates('/',new URLSearchParams(),origin)?.languages).toEqual({ko:origin+'/',en:origin+'/en','x-default':origin+'/'});
  expect(seoAlternates('/sqlp-developer',new URLSearchParams(),origin)?.languages).toBeUndefined();
  const map=publicSitemap(origin);
  expect(map.length).toBeGreaterThan(180);
  expect(new Set(map.map(r=>r.url)).size).toBe(map.length);
  expect(map.every(r=>!r.url.includes('/kr')&&!r.url.endsWith('/test')&&!r.url.endsWith('/app')&&!r.lastModified)).toBe(true);
});
