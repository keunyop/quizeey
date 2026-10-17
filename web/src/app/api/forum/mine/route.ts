import { forumGet } from "@/server/forum-http";
export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const GET = (request: Request) => forumGet(request, true);
