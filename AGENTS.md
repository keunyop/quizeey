# Quizeey development and release workflow

- Develop and run regression tests locally. In `web`, use `npm run dev:local` for the app and `npm run check:local` for typecheck, lint, unit tests, build and browser tests. The browser tests start their own server at `http://127.0.0.1:3100`.
- Use fixture content and, when needed, the isolated PostgreSQL/Auth fixtures. Never point regression, accessibility, crawling, screenshot or load tests at `quizeey.com` or a Vercel deployment. Report skipped DB/Auth tests explicitly; a fixture-only run does not verify those flows.
- Do not create Preview/production deployments as a way to test a change. Complete local verification first. Deploy only when the user requests a release or an explicitly scoped hosted check.
- For a requested release, use one deployment mechanism. `master` pushes already trigger the production Git deployment; do not also invoke a CLI/API deployment for the same change. Batch feature commits on a development branch and merge once after verification.
- After a requested release, use only a small read-only smoke check of the affected paths. Run full regressions locally. Do not automatically retry deployments or crawl the hosted app.
- `web/vercel.json` disables automatic deployments of development branches and preserves `master` production deployments. Keep it that way unless the user requests a different workflow.
- Local fixture builds are test artifacts. Never upload them with `--prebuilt` as a production release. A future prebuilt release must use Production configuration in a compatible build environment and preserve the existing content/auth/release guards.
- Preserve production credentials in ignored, explicitly loaded files such as `web/.env.forum.production.local`. Do not copy them into automatically loaded `.env.local` files for local tests. Never print credential values.
