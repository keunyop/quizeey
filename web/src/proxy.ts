import { NextResponse, type NextRequest } from "next/server";
import { environment } from "./lib/environment";
import { parseQuery } from "./lib/contracts";

export function proxy(request: NextRequest) {
  const env = environment(process.env);
  if (env.protectedReview) {
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
  catch { return new NextResponse("Invalid quiz URL. Check testId, questId and verNbr.", { status: 400, headers: { "Cache-Control": "no-store" } }); }
  const response=NextResponse.next();
  if(env.protectedReview)response.headers.set('Cache-Control','private, no-store');
  return response;
}
export const config = { matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"] };
