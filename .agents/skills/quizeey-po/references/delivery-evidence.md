# Delivery evidence and learning

Use for incidents, repeated failures, important change reviews and weekly/monthly retrospectives. Apply only the portions the task needs; an urgent containment action already within authority need not wait for a full strategy exercise.

## Investigate before extending a fix

Capture the symptom, expected behavior, exact local reproduction, affected boundary and recent relevant changes. Compare a working and failing case. State a falsifiable cause and the smallest check that would distinguish it from alternatives. Change one causal variable at a time and preserve the useful evidence. If reproduction is unavailable, report the gap and collect evidence rather than presenting a speculative cause as confirmed.

When two fixes based on the same premise fail the same check, write down and test that shared premise before a third fix. A larger timeout or more retries are not evidence of a product fix. A test-harness adjustment needs evidence of the harness problem, preserved behavioral coverage and the required review. Keep investigation bounded to the task/time budget and continue independent work when blocked.

Prefer simplifying the affected path or reusing an existing mechanism over adding a parallel one. Removal still needs evidence of unused behavior and impact; this is not permission for unrelated cleanup, deleting tests or changing public contracts.

## Proportionate pre-mortem

For a nontrivial new exam, growth change or cross-cutting implementation, imagine the intended result fails. Identify the few credible causes that would change the plan, with evidence and uncertainty. For each material risk, record its trigger, affected learner flow, prevention/check, owner and recovery.

Separate release blockers, bounded follow-up work and observations. A failed required check, unreviewed publishable question or missing authorization stays a blocker; it cannot be reclassified as follow-up to meet a date. Apply the existing review/approval boundaries to the concrete change, without adding an approval ceremony for routine authorized work.

## Verify claims against the changed revision

Give an independent reviewer the raw source evidence, requirements, actual diff and relevant test results. Ask them to check both intended behavior and plausible breakage; inspect their cited evidence before treating a finding as verified. A reviewer persona in the author's own response is not an independent review. Reopen affected review/checks when a later edit invalidates their evidence.

In the existing journal, connect each material completion claim to its artifact/revision, check command or procedure, result and remaining gap. Read actual outputs and exit status. Do not combine passing stages from different failed runs into one successful required run. Code changes follow the repository's local `npm run check:local` gate; explicitly list skipped DB/Auth flows. Skill-only maintenance uses skill validation, link checks and decision-scenario review; it is not an application regression or a release. If a release is requested, all applicable release gates still apply.

Keep **implemented locally**, **reviewed**, **released and read back**, and **measured impact** distinct. Store private evidence where the main skill requires it; public records contain only safe references and conclusions. Do not create a second decision log or copy private transcripts into Git.

## Review outcomes and carry learning forward

At weekly/monthly review, start with prior decisions and their evaluation windows. For each due item, compare expected versus observed behavior, classify the outcome, identify a supported explanation or unresolved uncertainty, and choose the next action. Keep immature experiments in observation. Do not use commit count, lines of code or article volume as proof of learner value.

Check whether the last review's actions were completed, partially completed or still open. Select the most consequential process improvement and attach an owner/evidence checkpoint to the existing backlog. Encode a recurring, demonstrated failure in the narrowest useful place: implementation invariant, type/check/test, then skill guidance when the lesson is about decisions. Avoid growing this skill from a single speculative anecdote.

The method draws on PStack, Superpowers and GStack retrospective practices; see [source-research.md](source-research.md).
