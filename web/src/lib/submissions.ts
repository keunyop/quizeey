import { z } from "zod";

const id = z.string().regex(/^[1-9]\d{0,18}$/).refine(value => BigInt(value) <= 9223372036854775807n);
export const submissionRequest = z.discriminatedUnion("kind", [
  z.object({ kind: z.literal("feedback"), locale: z.enum(["ko", "en"]), path: z.string().max(200), body: z.string().trim().min(1).max(4000) }).strict(),
  z.object({ kind: z.literal("question_report"), locale: z.enum(["ko", "en"]), examId: id, questionId: id, body: z.string().trim().min(1).max(4000) }).strict(),
]);
export const storedSubmission = z.object({
  kind: z.enum(["feedback", "question_report"]), locale: z.enum(["ko", "en"]),
  path: z.string().regex(/^\/[a-zA-Z0-9/_-]*$/).max(200), body: z.string().trim().min(1).max(4000),
  examId: id.nullable(), questionId: id.nullable(),
}).strict().refine(value => value.kind !== "question_report" || (value.examId !== null && value.questionId !== null));
export type StoredSubmission = z.infer<typeof storedSubmission>;
export const inboxKind = z.enum(["comments", "feedback", "question_report"]);
export type InboxKind = z.infer<typeof inboxKind>;
export const inboxItem = z.object({
  id: z.uuid(), body: z.string(), created_at: z.string(), locale: z.enum(["ko", "en"]),
  exam_id: id.nullable(), question_id: id.nullable(), path: z.string().nullable(),
  state: z.enum(["open", "resolved", "pending", "approved", "hidden"]), display_name: z.string().nullable(),
});
export type InboxItem = z.infer<typeof inboxItem>;
export const overviewSchema = z.object({
  feedback_open: z.number().int().nonnegative(), question_reports_open: z.number().int().nonnegative(),
  comments: z.number().int().nonnegative(), comment_reports_open: z.number().int().nonnegative(),
  clicks: z.record(id, z.string().regex(/^\d{1,19}$/)),
  activity: z.array(z.object({ action: z.string(), created_at: z.string() })).max(10),
});
export type AdminOverview = z.infer<typeof overviewSchema>;
