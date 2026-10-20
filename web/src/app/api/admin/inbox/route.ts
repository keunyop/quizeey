import { inboxGet, inboxPatch } from "@/server/submission-http";
export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const GET = inboxGet;
export const PATCH = inboxPatch;
