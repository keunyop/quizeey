# Learning growth and experiments

Use for SEO, learning activation, navigation or a proposed product experiment. Reuse the metric definitions and export-validation rules in the main skill; this reference adds decision mechanics, not a new analytics source.

## Diagnose a learning journey

Pick one exam/language and entry intent. Trace the relevant steps: search or landing → exam selection → practice start → answer/explanation → completion → return. Mark each step as observed, instrumented-but-unverified, or unmeasured. Inspect actual code/event contracts and supplied reports before assuming event names, session identity or funnel support. Event totals alone cannot establish a unique-user or same-session conversion rate.

For search opportunities, check intent match, existing competing pages, title/content accuracy and the path into relevant practice. Prefer improving an existing page when it already addresses the intent. Search clicks are an acquisition signal; they do not by themselves demonstrate learning or revenue improvement.

Reproduce the journey on local fixtures. Check whether the learner can identify the exam/version/language, see a clear next action, reach relevant questions, understand explanations and recover from empty/error states. Include mobile layout and keyboard access when affected. Use the observed friction to choose a small change; avoid removing useful exam navigation merely to imitate a sales landing page.

Never invent pass rates, testimonials, learner counts or official endorsement. Keep ads distinguishable from learning actions; an ad click is not a learning conversion. Product tests, screenshots, accessibility scans and crawling stay local under root AGENTS.md.

## Choose a method the evidence can support

Before an A/B test, establish eligible traffic, a reliable baseline, the smallest practically useful effect, assignment unit, stable variant exposure and validated outcome tracking. Estimate the needed sample and duration with stated assumptions. If traffic, identity, tracking or a trustworthy denominator is unavailable, choose a small reversible pilot, a local usability check or a descriptive before/after observation. Label the method and its limits; do not call it a controlled experiment or infer causal uplift.

Local usability checks validate behavior and accessibility, not actual learner demand. Before/after comparisons should account for weekday coverage, exam seasonality, source/segment changes and concurrent releases. Keep an inconclusive result when these cannot be separated. A measurement gap can block a causal claim without blocking an independently justified quality fix.

## Experiment contract

Extend the existing experiment record, rather than creating a second tracker:

| Field | Required decision |
| --- | --- |
| Hypothesis | Observed problem, proposed change, audience and expected learner behavior |
| Scope | One main causal change, control/comparator, eligibility, assignment and exposure definition |
| Primary outcome | One metric, unit, numerator/denominator, source, baseline and practical success threshold |
| Guardrails | Correctness, completion, mobile/accessibility, performance and relevant revenue constraints |
| Evaluation | Start tied to verified release, end/sample target, source lag, chosen analysis method and owner |
| Stop/recover | Conditions for safety rollback, no-effect/inconclusive decision and recovery action within authority |

For controlled experiments, predefine the analysis population, sample target, duration and statistical method. Check assignment balance, duplicate/missing exposures and contamination before interpreting outcomes. Do not filter on behavior the treatment itself changes, such as only learners who clicked the new CTA. Keep assignment consistent for the defined unit. Multiple variants/metrics need an appropriate analysis; do not select whichever result looks positive.

Monitor harm during the test, but do not repeatedly inspect a fixed-horizon test and stop when significance appears. A sequential design requires its own valid predeclared stopping rule. Report denominators, uncertainty and practical effect as available. Save detailed counts privately and publish only sanitized conclusions.

## Close the loop

At the planned checkpoint, choose **adopt**, **revise**, **stop/recover**, or **inconclusive** from the agreed criteria. Check guardrails before recommending adoption. An analysis verdict never authorizes a production DB write, spending, external contact or a larger rollout. Execute only the already-authorized scope and release process; record anything else as proposed. Link the verdict and next evidence date in the existing backlog/journal. A future review date is not permission to create an automation.

The method draws on Marketing Skills CRO/A/B testing and PM Skills assumption testing; see [source-research.md](source-research.md).
