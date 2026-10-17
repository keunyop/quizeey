import { forumGet, forumPost } from "@/server/forum-http";
export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const GET = (request: Request) => forumGet(request);
export const POST = forumPost;
