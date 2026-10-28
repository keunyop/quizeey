import {afterEach,expect,it,vi} from 'vitest';
import {NextRequest} from 'next/server';
import {proxy} from './proxy';
import robots from './app/robots';
import sitemap from './app/sitemap';
import { languagePreferenceCookie } from './lib/home-language';
const env={VERCEL_ENV:'production',QUIZEEY_RELEASE_READY:'true',QUIZEEY_CONTENT_SOURCE:'supabase',QUIZEEY_ADS_VERIFIED:'true',QUIZEEY_GA4_MEASUREMENT_ID:'G-TESTONLY123',QUIZEEY_CMP_SCRIPT_URL:'https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1',QUIZEEY_PREVIEW_USER:'review',QUIZEEY_PREVIEW_PASSWORD:'x'.repeat(24),QUIZEEY_SUPABASE_URL:'https://tfkhnrbshvyfmrzxqfmq.supabase.co',QUIZEEY_SUPABASE_SECRET_KEY:'sb_secret_mock',QUIZEEY_CONTENT_DATASET_SHA256:'88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'};
afterEach(()=>vi.unstubAllEnvs());
it('permanently redirects verified page aliases without losing content or tracking identity',()=>{
  for(const [key,value]of Object.entries(env))vi.stubEnv(key,value);
  const cases = [
    ['/kr', '/'], ['/app', '/'],
    ['/kr/sqlp-developer?verNbr=1&page=2&utm_source=gsc', '/sqlp-developer?verNbr=1&page=2&utm_source=gsc'],
    ['/test?testId=5&questId=9007199254740993&verNbr=1', '/sqlp-developer?questId=9007199254740993&verNbr=1'],
    ['/kr/test?testId=5&page=2', '/sqlp-developer?page=2'],
    ['/en/test?testId=1&verNbr=202610&page=2', '/en/aws-certified-developer-associate?verNbr=202610&page=2'],
  ];
  for (const [source, target] of cases) {
    for (const method of ['GET', 'HEAD']) {
      const response = proxy(new NextRequest('https://quizeey.com'+source, {method}));
      expect(response.status, source).toBe(308);
      expect(response.headers.get('location')).toBe('https://quizeey.com'+target);
      expect(response.headers.get('x-robots-tag')).toBeNull();
      expect(proxy(new NextRequest('https://quizeey.com'+target)).headers.get('location')).toBeNull();
    }
  }
  for (const path of ['/en/sqlp-developer', '/kr/missing-exam', '/test?testId=999999', '/en/test?testId=5', '/kr/sqlp-developer?testId=1']) {
    expect(proxy(new NextRequest('https://quizeey.com'+path)).headers.get('location'), path).toBeNull();
  }
  expect(proxy(new NextRequest('https://quizeey.com/test?testId=5', {method:'POST'})).headers.get('location')).toBeNull();
  for (const path of ['/test', '/test?testId=5&testId=1', '/kr/sqlp-developer?page=0']) {
    expect(proxy(new NextRequest('https://quizeey.com'+path)).status).toBe(400);
  }
  expect(proxy(new NextRequest('https://candidate.vercel.app/kr')).status).toBe(401);
});
it('uses the routed Host behind a loopback server and ignores untrusted forwarded hosts',()=>{
  for(const [key,value]of Object.entries(env))vi.stubEnv(key,value);
  const url='http://127.0.0.1:3114/sqlp-developer?verNbr=1&page=2';
  expect(proxy(new NextRequest(url,{headers:{host:'quizeey.com'}})).headers.get('x-robots-tag')).toBeNull();
  const redirect=proxy(new NextRequest(url,{headers:{host:'www.quizeey.com'}}));
  expect(redirect.status).toBe(308);expect(redirect.headers.get('location')).toBe('https://quizeey.com/sqlp-developer?verNbr=1&page=2');
  expect(proxy(new NextRequest(url,{headers:{host:'synthetic.vercel.app','x-forwarded-host':'quizeey.com'}})).status).toBe(401);
  const alias=proxy(new NextRequest('http://127.0.0.1:3114/microsoft-az-500?verNbr=1',{headers:{host:'quizeey.com'}}));
  expect(alias.headers.get('location')).toBe('https://quizeey.com/az-500?verNbr=1');
});
it('keeps staged production protected/noindex while allowing only the live canonical host',()=>{
  for(const [key,value]of Object.entries(env))vi.stubEnv(key,value);
  const candidate='https://quizeey-preview.vercel.app/sqlp-developer';
  expect(proxy(new NextRequest(candidate)).status).toBe(401);
  const review=proxy(new NextRequest(candidate,{headers:{authorization:'Basic '+Buffer.from('review:'+env.QUIZEEY_PREVIEW_PASSWORD).toString('base64')}}));
  expect(review.headers.get('x-robots-tag')).toContain('noindex');expect(review.headers.get('cache-control')).toBe('private, no-store');
  expect(proxy(new NextRequest('https://quizeey.com/sqlp-developer')).headers.get('x-robots-tag')).toBeNull();
  for(const path of ['/admin','/en/admin','/api/forum'])expect(proxy(new NextRequest('https://quizeey.com'+path)).headers.get('x-robots-tag')).toContain('noindex');
  const redirect=proxy(new NextRequest('https://www.quizeey.com/sqlp-developer?verNbr=1&page=2'));
  expect(redirect.status).toBe(308);expect(redirect.headers.get('location')).toBe('https://quizeey.com/sqlp-developer?verNbr=1&page=2');
  const alias=proxy(new NextRequest('https://quizeey.com/microsoft-az-500?questId=9007199254740993&verNbr=1'));
  expect(alias.status).toBe(308);expect(alias.headers.get('location')).toBe('https://quizeey.com/az-500?questId=9007199254740993&verNbr=1');
  expect(proxy(new NextRequest('https://quizeey.com/@ccna-300-115')).headers.get('location')).toBe('https://quizeey.com/ccnp-300-115');
});
it('allows only an authenticated cleanup GET through candidate Basic protection',()=>{
  for(const [key,value]of Object.entries(env))vi.stubEnv(key,value);
  vi.stubEnv('CRON_SECRET','c'.repeat(43));
  const headers={authorization:'Bearer '+'c'.repeat(43)};
  const url='https://quizeey-preview.vercel.app/api/internal/cleanup';
  expect(proxy(new NextRequest(url)).status).toBe(401);
  expect(proxy(new NextRequest(url,{headers:{authorization:'Bearer wrong'}})).status).toBe(401);
  const accepted=proxy(new NextRequest(url,{headers}));
  expect(accepted.status).toBe(200);expect(accepted.headers.get('x-robots-tag')).toContain('noindex');expect(accepted.headers.get('cache-control')).toContain('no-store');
  expect(proxy(new NextRequest(url,{method:'POST',headers})).status).toBe(401);
  expect(proxy(new NextRequest('https://quizeey-preview.vercel.app/api/admin/queue',{headers})).status).toBe(401);
  vi.stubEnv('VERCEL_ENV','preview');
  expect(proxy(new NextRequest(url,{headers})).status).toBe(401);
});
it('protects every host and removes public search discovery during production review',()=>{
  for(const [key,value]of Object.entries(env))vi.stubEnv(key,value);
  vi.stubEnv('QUIZEEY_PRODUCTION_REVIEW','true');vi.stubEnv('QUIZEEY_RELEASE_READY','false');vi.stubEnv('QUIZEEY_ADS_VERIFIED','false');vi.stubEnv('QUIZEEY_CMP_SCRIPT_URL',undefined);
  const authorization='Basic '+Buffer.from('review:'+env.QUIZEEY_PREVIEW_PASSWORD).toString('base64');
  for(const host of ['quizeey.com','www.quizeey.com','quizeey-review.vercel.app']){
    expect(proxy(new NextRequest('https://'+host+'/sqlp-developer')).status).toBe(401);
    const result=proxy(new NextRequest('https://'+host+'/sqlp-developer',{headers:{authorization}}));
    expect(result.status).toBe(200);expect(result.headers.get('x-robots-tag')).toContain('noindex');expect(result.headers.get('cache-control')).toContain('no-store');
  }
  vi.stubEnv('CRON_SECRET','c'.repeat(43));
  expect(proxy(new NextRequest('https://quizeey-review.vercel.app/api/internal/cleanup',{headers:{authorization:'Bearer '+'c'.repeat(43)}})).status).toBe(401);
  expect(robots()).toEqual({rules:{userAgent:'*',disallow:'/'}});expect(sitemap()).toEqual([]);
  vi.stubEnv('QUIZEEY_PRODUCTION_REVIEW','false');vi.stubEnv('QUIZEEY_RELEASE_READY','true');vi.stubEnv('QUIZEEY_ADS_VERIFIED','true');vi.stubEnv('QUIZEEY_CMP_SCRIPT_URL',env.QUIZEEY_CMP_SCRIPT_URL);
  expect(robots().sitemap).toBe('https://quizeey.com/sitemap.xml');expect(sitemap().length).toBeGreaterThan(180);
});

it('uses the country only for the root entry and never guesses country from browser language', () => {
  for (const [key, value] of Object.entries(env)) vi.stubEnv(key, value);
  for (const country of ['US', 'CA', 'GB', 'JP', 'KR', '', 'XX', 'ZZ', 'unknown']) {
    const headers = { 'x-vercel-ip-country': country, 'accept-language': country === 'KR' ? 'en-US' : 'ko-KR' };
    const response = proxy(new NextRequest('https://quizeey.com/?utm_source=entry', { headers }));
    const english = ['US', 'CA', 'GB', 'JP'].includes(country);
    expect(response.status, country).toBe(english ? 307 : 200);
    expect(response.headers.get('location'), country).toBe(english ? 'https://quizeey.com/en?utm_source=entry' : null);
    expect(response.headers.get('cache-control')).toBe('private, no-store');
    expect(response.headers.get('vary')).toContain('X-Vercel-IP-Country');
    expect(response.headers.get('vary')).toContain('Cookie');
    expect(response.headers.get('set-cookie')).toBeNull();
  }
  const noCountry = proxy(new NextRequest('https://quizeey.com/', { headers: { 'accept-language': 'en-US' } }));
  expect(noCountry.headers.get('location')).toBeNull();
  for (const path of ['/en', '/sqlp-developer?verNbr=202610', '/en/az-900?questId=900000001', '/en/study-guides', '/admin', '/api/forum', '/sitemap.xml', '/robots.txt', '/img/letter-q.svg']) {
    const response = proxy(new NextRequest('https://quizeey.com' + path, { headers: { 'x-vercel-ip-country': 'US', cookie: languagePreferenceCookie + '=en' } }));
    expect(response.headers.get('location'), path).toBeNull();
  }
});

it('saves explicit language choices and prevents country redirects from overriding them', () => {
  for (const [key, value] of Object.entries(env)) vi.stubEnv(key, value);
  const headers = { 'x-vercel-ip-country': 'US', cookie: languagePreferenceCookie + '=en' };
  const korean = proxy(new NextRequest('https://quizeey.com/?lang=ko&utm_source=choice', { headers }));
  expect(korean.status).toBe(307);
  expect(korean.headers.get('location')).toBe('https://quizeey.com/?utm_source=choice');
  expect(korean.cookies.get(languagePreferenceCookie)?.value).toBe('ko');
  for (const attribute of ['HttpOnly', 'Secure', 'SameSite=lax', 'Path=/', 'Max-Age=31536000']) expect(korean.headers.get('set-cookie')).toContain(attribute);
  const savedKorean = proxy(new NextRequest('https://quizeey.com/', { headers: { ...headers, cookie: languagePreferenceCookie + '=ko' } }));
  expect(savedKorean.headers.get('location')).toBeNull();
  const english = proxy(new NextRequest('https://quizeey.com/en?lang=en', { headers: { 'x-vercel-ip-country': 'KR' } }));
  expect(english.status).toBe(307);
  expect(english.headers.get('location')).toBe('https://quizeey.com/en');
  expect(english.cookies.get(languagePreferenceCookie)?.value).toBe('en');
  expect(proxy(new NextRequest('https://quizeey.com/', { headers: { 'x-vercel-ip-country': 'KR', cookie: languagePreferenceCookie + '=en' } })).headers.get('location')).toBe('https://quizeey.com/en');
  expect(proxy(new NextRequest('https://quizeey.com/en', { headers: { cookie: languagePreferenceCookie + '=ko' } })).headers.get('location')).toBeNull();
  for (const path of ['/?lang=fr', '/?lang=ko&lang=en', '/en/az-900?lang=ko']) expect(proxy(new NextRequest('https://quizeey.com' + path)).headers.get('set-cookie')).toBeNull();
  expect(proxy(new NextRequest('https://quizeey.com/?lang=en', { method: 'POST' })).headers.get('location')).toBeNull();
});

it('keeps stable language entry URLs available to search crawlers and preserves protection before language routing', () => {
  for (const [key, value] of Object.entries(env)) vi.stubEnv(key, value);
  for (const userAgent of ['Googlebot/2.1', 'bingbot/2.0', 'Yeti/1.1', 'Google-InspectionTool/1.0']) {
    const response = proxy(new NextRequest('https://quizeey.com/', { headers: { 'x-vercel-ip-country': 'US', 'user-agent': userAgent, cookie: languagePreferenceCookie + '=en' } }));
    expect(response.status).toBe(200);
    expect(response.headers.get('location')).toBeNull();
    expect(response.headers.get('vary')).toContain('User-Agent');
  }
  const candidate = 'https://candidate.vercel.app/?lang=en';
  expect(proxy(new NextRequest(candidate, { headers: { 'x-vercel-ip-country': 'US' } })).status).toBe(401);
  const authorization = 'Basic ' + Buffer.from('review:' + env.QUIZEEY_PREVIEW_PASSWORD).toString('base64');
  const protectedChoice = proxy(new NextRequest(candidate, { headers: { authorization, 'x-vercel-ip-country': 'US' } }));
  expect(protectedChoice.status).toBe(307);
  expect(protectedChoice.headers.get('location')).toBe('https://candidate.vercel.app/en');
  expect(protectedChoice.headers.get('x-robots-tag')).toContain('noindex');
  const loopback = proxy(new NextRequest('http://127.0.0.1:3114/', { headers: { host: 'quizeey.com', 'x-vercel-ip-country': 'CA', 'x-forwarded-host': 'evil.invalid' } }));
  expect(loopback.headers.get('location')).toBe('https://quizeey.com/en');
});
