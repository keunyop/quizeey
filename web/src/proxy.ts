import { NextResponse, type NextRequest } from "next/server";
import { environment } from "./lib/environment";
import { legacyRedirects,parseQuery } from "./lib/contracts";
import { cronAuthorized } from './server/cron-auth';

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
  if(alias){const url=env.stage==='production'&&!candidate?new URL(request.nextUrl.pathname+request.nextUrl.search,env.origin):request.nextUrl.clone();url.pathname=alias;const redirect=NextResponse.redirect(url,308);if(env.protectedReview||candidate)redirect.headers.set('X-Robots-Tag','noindex, nofollow');return redirect;}
  const response=NextResponse.next();
  if(env.protectedReview||candidate){response.headers.set('Cache-Control','private, no-store');response.headers.set('X-Robots-Tag','noindex, nofollow, noarchive');}
  if(/^\/(?:en\/)?admin(?:\/|$)|^\/api\//.test(request.nextUrl.pathname)){
    response.headers.set('Cache-Control','private, no-store');response.headers.set('X-Robots-Tag','noindex, nofollow, noarchive');
  }
  return response;
}
export const config = { matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"] };
