import { NextResponse, type NextRequest } from "next/server";
import { environment } from "./lib/environment";
import { legacyPageRedirect,legacyRedirects,parseQuery } from "./lib/contracts";
import { cronAuthorized } from './server/cron-auth';
import { homeLanguageRedirect, languagePreferenceCookie, languagePreferenceMaxAge } from './lib/home-language';

function privateLanguageResponse(response: NextResponse) {
  response.headers.set('Cache-Control', 'private, no-store');
  const vary = new Set((response.headers.get('Vary') ?? '').split(',').map(value => value.trim()).filter(Boolean));
  for (const name of ['X-Vercel-IP-Country', 'Cookie', 'User-Agent']) vary.add(name);
  response.headers.set('Vary', [...vary].join(', '));
  return response;
}

export function proxy(request: NextRequest) {
  const env = environment(process.env);
  const canonicalHost=new URL(env.origin).host;
  // Match RouteView's platform-routed Host. Next's internal URL may use the
  // loopback server hostname behind a reverse proxy. Never trust forwarded Host.
  const host=(request.headers.get('host')??request.nextUrl.host).toLowerCase();
  if(env.stage==='production'&&!env.productionReview&&host==='www.'+canonicalHost){
    const url=new URL(request.nextUrl.pathname+request.nextUrl.search,env.origin);
    return NextResponse.redirect(url,308);
  }
  const candidate=env.stage==='production'&&host!==canonicalHost;
  const cron = candidate && !env.productionReview && request.method === 'GET' && request.nextUrl.pathname === '/api/internal/cleanup' && cronAuthorized(request);
  if ((env.protectedReview||candidate) && !cron) {
    const expected = "Basic " + Buffer.from(`${env.previewUser}:${env.previewPassword}`,'utf8').toString('base64');
    if (request.headers.get("authorization") !== expected) {
      return new NextResponse("Protected Quizeey preview", { status: 401, headers: {
        "WWW-Authenticate": 'Basic realm="Quizeey preview", charset="UTF-8"', "Cache-Control": "private, no-store", "X-Robots-Tag": "noindex, nofollow",
      } });
    }
  }
  if(env.contentSource==='local-archive'&&!['127.0.0.1','localhost'].includes(request.nextUrl.hostname)){
    return new NextResponse('Local review only',{status:403,headers:{'Cache-Control':'private, no-store','X-Robots-Tag':'noindex, nofollow'}});
  }
  try { parseQuery(request.nextUrl.searchParams, /^(\/(en|kr))?\/test$/.test(request.nextUrl.pathname)); }
  catch { return new NextResponse("Invalid quiz URL. Check testId, questId and verNbr.", { status: 400, headers: { "Cache-Control": "no-store","X-Robots-Tag":"noindex, nofollow" } }); }
  const alias=legacyRedirects[request.nextUrl.pathname];
  const pageAlias = ['GET', 'HEAD'].includes(request.method)
    ? legacyPageRedirect(request.nextUrl.pathname, request.nextUrl.searchParams) : undefined;
  if (alias || pageAlias) {
    const url = new URL(pageAlias ?? alias + request.nextUrl.search,
      env.stage === 'production' && !candidate ? env.origin : request.nextUrl);
    const redirect = NextResponse.redirect(url, 308);
    if (env.protectedReview || candidate) redirect.headers.set('X-Robots-Tag', 'noindex, nofollow');
    return redirect;
  }
  if (['GET', 'HEAD'].includes(request.method)) {
    const language = homeLanguageRedirect({
      pathname: request.nextUrl.pathname, query: request.nextUrl.searchParams,
      country: request.headers.get('x-vercel-ip-country'),
      preference: request.cookies.get(languagePreferenceCookie)?.value,
      userAgent: request.headers.get('user-agent'),
    });
    if (language) {
      const base = env.stage === 'production' && !candidate ? env.origin : request.nextUrl;
      const redirect = privateLanguageResponse(NextResponse.redirect(new URL(language.destination, base), 307));
      if (language.preference) redirect.cookies.set(languagePreferenceCookie, language.preference, {
        httpOnly: true, sameSite: 'lax', path: '/', maxAge: languagePreferenceMaxAge,
        secure: env.stage === 'production' || request.nextUrl.protocol === 'https:',
      });
      if (env.protectedReview || candidate) redirect.headers.set('X-Robots-Tag', 'noindex, nofollow');
      return redirect;
    }
  }
  const response=NextResponse.next();
  // The root varies by country, saved choice and crawler navigation even when
  // no redirect is needed. Keep those responses out of shared caches too.
  if (['GET', 'HEAD'].includes(request.method) && request.nextUrl.pathname === '/') privateLanguageResponse(response);
  if(env.protectedReview||candidate){response.headers.set('Cache-Control','private, no-store');response.headers.set('X-Robots-Tag','noindex, nofollow, noarchive');}
  if(/^\/(?:en\/)?admin(?:\/|$)|^\/api\//.test(request.nextUrl.pathname)){
    response.headers.set('Cache-Control','private, no-store');response.headers.set('X-Robots-Tag','noindex, nofollow, noarchive');
  }
  return response;
}
export const config = { matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"] };
