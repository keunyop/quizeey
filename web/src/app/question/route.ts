import { legacyRead } from "@/server/legacy-read";
export const POST = (request: Request) => legacyRead(request, "question");
