import "server-only";
import { NextResponse } from "next/server";
import { z } from "zod";
import { findRoute, type LegacyRoute } from "@/lib/contracts";
import type { ExamPopularity } from "@/lib/exam-catalog";
import { forumConfigured, forumConnection, hostedForumTransport } from "./forum-database";
import { forumOriginAllowed } from "./forum-config";
import { boundedJson } from "./guest-policy";

const responseHeaders = { "Cache-Control": "private, no-store", "X-Robots-Tag": "noindex, nofollow" };

export async function examPopularity(routes: LegacyRoute[]): Promise<ExamPopularity> {
  const ids = [...new Set(routes.flatMap(route => route.testId ? [route.testId] : []))];
  if (!ids.length || !forumConfigured()) return {};
  try {
    const hosted = hostedForumTransport();
    if (hosted) return await hosted.rpc("quizeey_exam_popularity", { p_exam_ids: ids });
    const result = await forumConnection().query<{ result: ExamPopularity }>(
      "select public.quizeey_exam_popularity($1::text[]) as result", [ids]);
    return result.rows[0].result;
  } catch {
    console.error("Exam popularity unavailable");
    return {};
  }
}

export async function examClick(request: Request) {
  const response = (error: string, status: number) => NextResponse.json({ error }, { status, headers: responseHeaders });
  if (!forumConfigured()) return response("Exam popularity unavailable", 503);
  if (!forumOriginAllowed(request)) return response("Origin rejected", 403);
  let path: string;
  try {
    ({ path } = z.object({ path: z.string().min(1).max(200) }).strict().parse(await boundedJson(request)));
  } catch { return response("Invalid exam click", 400); }
  const route = findRoute(path);
  if (!route?.testId) return response("Unknown exam", 404);
  try {
    const hosted = hostedForumTransport();
    if (hosted) await hosted.rpc("quizeey_exam_click", { p_exam_id: route.testId });
    else await forumConnection().query("select public.quizeey_exam_click($1)", [route.testId]);
    return new NextResponse(null, { status: 204, headers: responseHeaders });
  } catch { return response("Exam popularity unavailable", 503); }
}
