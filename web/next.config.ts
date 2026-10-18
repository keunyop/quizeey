import type { NextConfig } from "next";
import { environment } from "./src/lib/environment";

const env=environment(process.env);
const config: NextConfig = {
  poweredByHeader: false,
  // Source exports are local review inputs, never deployment artifacts.
  outputFileTracingExcludes: { '/*': ['**/.modernization/**'] },
  async headers() {
    return [{ source: "/:path*", headers: [
      { key: "X-Content-Type-Options", value: "nosniff" },
      { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
      { key: "Content-Security-Policy", value: "frame-ancestors 'none'; object-src 'none'; base-uri 'self'" },
      ...(env.stage==='production'&&!env.protectedReview?[]:[{ key: "X-Robots-Tag", value: "noindex, nofollow, noarchive" }]),
    ] }];
  },
};
export default config;
