import { z } from "zod";

const schema = z.object({
  QUIZEEY_ENV: z.enum(["local", "preview", "production"]).optional(),
  VERCEL_ENV: z.enum(["development", "preview", "production"]).optional(),
  QUIZEEY_CONTENT_SOURCE: z.enum(["fixture", "local-archive", "supabase"]).default("fixture"),
  QUIZEEY_LOCAL_CONTENT_FILE: z.string().optional(),
  QUIZEEY_CANONICAL_ORIGIN: z.url().default("https://quizeey.com"),
  QUIZEEY_PREVIEW_USER: z.string().optional(),
  QUIZEEY_PREVIEW_PASSWORD: z.string().optional(),
  QUIZEEY_CONTENT_DATASET_SHA256: z.string().optional(),
});

export function environment(input: Record<string, string | undefined>) {
  const result = schema.safeParse(input);
  if (!result.success) throw new Error("Invalid Quizeey environment configuration (values redacted).");
  const value = result.data;
  // A hosted stage cannot be downgraded by a user-defined env variable.
  const stage = value.VERCEL_ENV === "production" ? "production"
    : value.VERCEL_ENV === "preview" ? "preview" : value.QUIZEEY_ENV ?? "local";
  const origin = new URL(value.QUIZEEY_CANONICAL_ORIGIN);
  if (origin.protocol !== "https:" || origin.pathname !== "/" || origin.search || origin.hash || origin.username || origin.password) {
    throw new Error("Canonical origin must be an HTTPS origin without credentials, path or query.");
  }
  const protectedReview=stage==='preview'||value.QUIZEEY_CONTENT_SOURCE==='local-archive';
  if (protectedReview && (!value.QUIZEEY_PREVIEW_USER || value.QUIZEEY_PREVIEW_USER.includes(':') || (value.QUIZEEY_PREVIEW_PASSWORD?.length ?? 0) < 24)) {
    throw new Error("Hosted preview requires server-only HTTP Basic credentials (password >=24 characters).");
  }
  if (stage === "production") {
    throw new Error("Production release blocked: verify live schema/import, accounts, ads/consent, SEO and launch approval first.");
  }
  if(value.QUIZEEY_CONTENT_SOURCE==='local-archive' && (stage!=='local'||input.VERCEL_ENV!==undefined||!!input.VERCEL||!value.QUIZEEY_LOCAL_CONTENT_FILE)){
    throw new Error('Private archive review requires a local process and an explicit private content file. Hosted use is blocked.');
  }
  if (value.QUIZEEY_CONTENT_SOURCE === "supabase") {
    if(stage!=='preview'||input.QUIZEEY_SUPABASE_URL!=='https://tfkhnrbshvyfmrzxqfmq.supabase.co'||
      value.QUIZEEY_CONTENT_DATASET_SHA256!=='88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'||
      !/^sb_secret_[A-Za-z0-9_-]+$/.test(input.QUIZEEY_SUPABASE_SECRET_KEY??'')) {
      throw new Error("Supabase study preview requires the verified project, dataset and server-only credential.");
    }
  }
  return { stage, origin: origin.origin, contentSource: value.QUIZEEY_CONTENT_SOURCE,
    previewUser: value.QUIZEEY_PREVIEW_USER, previewPassword: value.QUIZEEY_PREVIEW_PASSWORD,
    protectedReview,localContentFile:value.QUIZEEY_LOCAL_CONTENT_FILE,
    contentDatasetSha256:value.QUIZEEY_CONTENT_DATASET_SHA256,
    adsEnabled: false, analyticsEnabled: false } as const;
}
