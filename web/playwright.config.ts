import { defineConfig, devices } from "@playwright/test";
export default defineConfig({
  testDir: "./e2e", fullyParallel: false, workers: 1,
  use: { baseURL: "http://127.0.0.1:3100", trace: "retain-on-failure" },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"], channel: process.env.PLAYWRIGHT_CHANNEL } }],
  webServer: {
    command: "node node_modules/next/dist/bin/next start --hostname 127.0.0.1 --port 3100",
    url: "http://127.0.0.1:3100", reuseExistingServer: false, timeout: 60000,
    env: { QUIZEEY_ENV: "local", QUIZEEY_CONTENT_SOURCE: "fixture", QUIZEEY_LOCAL_FORUM_ORIGIN: "http://127.0.0.1:3100", ...(process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL ? { QUIZEEY_LOCAL_FORUM_DATABASE_URL: process.env.QUIZEEY_LOCAL_FORUM_DATABASE_URL } : {}), ...(process.env.QUIZEEY_AUTH_FIXTURE_URL?{QUIZEEY_AUTH_FIXTURE_URL:process.env.QUIZEEY_AUTH_FIXTURE_URL,QUIZEEY_ADMIN_AUTH_PROVIDER:'fixture',QUIZEEY_ADMIN_USER_IDS:'00000000-0000-4000-8000-000000000101'}:{}) },
  },
});
