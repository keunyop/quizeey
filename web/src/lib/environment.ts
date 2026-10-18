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
  QUIZEEY_RELEASE_READY:z.enum(['true','false']).default('false'),
  QUIZEEY_PRODUCTION_REVIEW:z.enum(['true','false']).default('false'),
  QUIZEEY_ADS_VERIFIED:z.enum(['true','false']).default('false'),
  QUIZEEY_GA4_MEASUREMENT_ID:z.string().regex(/^G-[A-Z0-9]{6,20}$/).optional(),
  QUIZEEY_CMP_SCRIPT_URL:z.url().optional(),
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
  const productionReview=stage==='production'&&value.QUIZEEY_PRODUCTION_REVIEW==='true';
  const protectedReview=stage==='preview'||productionReview||value.QUIZEEY_CONTENT_SOURCE==='local-archive';
  if (protectedReview && (!value.QUIZEEY_PREVIEW_USER || value.QUIZEEY_PREVIEW_USER.includes(':') || (value.QUIZEEY_PREVIEW_PASSWORD?.length ?? 0) < 24)) {
    throw new Error("Hosted preview requires server-only HTTP Basic credentials (password >=24 characters).");
  }
  if (stage === "production") {
    if(value.QUIZEEY_CONTENT_SOURCE!=='supabase'||origin.origin!=='https://quizeey.com'||!value.QUIZEEY_GA4_MEASUREMENT_ID||
      (!productionReview&&(value.QUIZEEY_RELEASE_READY!=='true'||value.QUIZEEY_ADS_VERIFIED!=='true'||!value.QUIZEEY_CMP_SCRIPT_URL))){
      throw new Error("Production release blocked: verified live content, ads/consent, existing GA4 and release configuration required.");
    }
    if(productionReview&&value.QUIZEEY_RELEASE_READY==='true')throw new Error('Production review cannot be marked release-ready.');
    if(!value.QUIZEEY_PREVIEW_USER||value.QUIZEEY_PREVIEW_USER.includes(':')||(value.QUIZEEY_PREVIEW_PASSWORD?.length??0)<24)throw new Error('Production candidate requires protected review credentials.');
  }
  if(value.QUIZEEY_CONTENT_SOURCE==='local-archive' && (stage!=='local'||input.VERCEL_ENV!==undefined||!!input.VERCEL||!value.QUIZEEY_LOCAL_CONTENT_FILE)){
    throw new Error('Private archive review requires a local process and an explicit private content file. Hosted use is blocked.');
  }
  if (value.QUIZEEY_CONTENT_SOURCE === "supabase") {
    if(!['preview','production'].includes(stage)||input.QUIZEEY_SUPABASE_URL!=='https://tfkhnrbshvyfmrzxqfmq.supabase.co'||
      value.QUIZEEY_CONTENT_DATASET_SHA256!=='88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'||
      !/^sb_secret_[A-Za-z0-9_-]+$/.test(input.QUIZEEY_SUPABASE_SECRET_KEY??'')) {
      throw new Error("Supabase study preview requires the verified project, dataset and server-only credential.");
    }
  }
  if(value.QUIZEEY_CMP_SCRIPT_URL){
    const cmp=new URL(value.QUIZEEY_CMP_SCRIPT_URL);
    if(cmp.protocol!=='https:'||cmp.hostname!=='fundingchoicesmessages.google.com'||cmp.username||cmp.password||!cmp.pathname.startsWith('/i/pub-8362228066874729'))throw new Error('Unverified CMP script.');
  }
  return { stage, origin: origin.origin, contentSource: value.QUIZEEY_CONTENT_SOURCE,
    previewUser: value.QUIZEEY_PREVIEW_USER, previewPassword: value.QUIZEEY_PREVIEW_PASSWORD,
    protectedReview,productionReview,localContentFile:value.QUIZEEY_LOCAL_CONTENT_FILE,
    contentDatasetSha256:value.QUIZEEY_CONTENT_DATASET_SHA256,
    adsEnabled: stage==='production'&&!productionReview&&value.QUIZEEY_ADS_VERIFIED==='true',analyticsEnabled:stage==='production'&&!productionReview&&!!value.QUIZEEY_GA4_MEASUREMENT_ID,
    ga4MeasurementId:value.QUIZEEY_GA4_MEASUREMENT_ID,cmpScriptUrl:value.QUIZEEY_CMP_SCRIPT_URL } as const;
}
