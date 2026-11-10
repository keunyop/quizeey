# Quizeey development and release workflow

- Develop and run regression tests locally. In `web`, use `npm run dev:local` for the app and `npm run check:local` for typecheck, lint, unit tests, build and browser tests. The browser tests start their own server at `http://127.0.0.1:3100`.
- Use fixture content and, when needed, the isolated PostgreSQL/Auth fixtures. Never point regression, accessibility, crawling, screenshot or load tests at `quizeey.com` or a Vercel deployment. Report skipped DB/Auth tests explicitly; a fixture-only run does not verify those flows.
- Do not create Preview/production deployments as a way to test a change. Complete local verification first. Deploy only when the user requests a release or an explicitly scoped hosted check.
- For a requested or standing-authorized routine release, use one deployment mechanism. Low-risk Quizeey PO work may be completed directly on `master` after local verification. Use a development branch for risky, destructive, hard-to-review, or multi-change work. A `master` push triggers the production Git deployment; do not also invoke a CLI/API deployment for the same change.
- After a requested release, use only a small read-only smoke check of the affected paths. Run full regressions locally. Do not automatically retry deployments or crawl the hosted app.
- `web/vercel.json` disables automatic deployments of development branches and preserves `master` production deployments. Keep it that way unless the user requests a different workflow.
- Local fixture builds are test artifacts. Never upload them with `--prebuilt` as a production release. A future prebuilt release must use Production configuration in a compatible build environment and preserve the existing content/auth/release guards.
- Preserve production credentials in ignored, explicitly loaded files such as `web/.env.forum.production.local`. Do not copy them into automatically loaded `.env.local` files for local tests. Never print credential values.

## Product operations

- Use [.agents/skills/quizeey-po/SKILL.md](.agents/skills/quizeey-po/SKILL.md) for PO runs; resume [docs/quizeey-ops/state.json](docs/quizeey-ops/state.json) and its last report first.
- Policy, access, metrics and priorities: [docs/quizeey-ops/README.md](docs/quizeey-ops/README.md). The repository is public. Keep private metrics, user reports, source IDs and credentials in ignored `.modernization/quizeey-ops/`, never public issues or commits.
- Questions and important code require independent evidence-based review. Local fixes are prepared/awaiting release, not resolved. Check both the current DB inbox and legacy GitHub issues.
- Every PO run reads the latest entry under [docs/quizeey-ops/journal/](docs/quizeey-ops/journal/), chooses today's highest-priority feasible work without waiting for the owner to assign it, and appends verified progress, release state, results, blockers, and the next queue. Keep private source IDs and business metrics outside Git.
- The owner has granted standing authorization to push routine low-risk verified Quizeey PO changes to `master`. A failed or incomplete required check blocks that release. Production DB changes, moderation, destructive changes, new spending, external messages, permanent bans, and large public changes still require their specific approval boundary.
