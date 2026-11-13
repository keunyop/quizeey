# Quizeey UI and learning experience

Use for visual polish, exam discovery friction, practice readability or a design review. This is a focused product workflow, not a reason to expand a small correction into a redesign.

## Direction before decoration

Quizeey is an online practice book for exam learners. Its character is calm, clear and steady. Preserve the Q mark, locally hosted Pretendard, existing blue accent and language-specific content. Keep the page neutral; reserve color for search/focus, selection, progress and meaningful correct/incorrect feedback. The questions and real exam names are the product's visual content; decorative illustrations, made-up progress or marketing claims are unnecessary.

Inspect local screenshots and the rendering components before deciding how much to change. Audit actual symptoms: competing outlines, weak heading hierarchy, cramped long names, small targets, arbitrary spacing or excessive motion. A mostly coherent screen needs polish, not a new identity. Preserve section order and working journeys. State a short direction; a direction the owner has already accepted does not need another confirmation.

## Apply the smallest useful passes

1. **Spacing:** use a 4px rhythm for the changed layout; keep related controls closer than separate sections. Preserve the compact practice header. At 390px, the existing fixture's question card should start above 260px; do not add a hero or instructional panel above it.
2. **Color:** use the shared light/dark tokens in `web/src/app/globals.css`. `--line` is for passive separators and surfaces; `--control-line` is for inputs and controls that need a distinguishable boundary. Do not replace control borders with faint decorative hairlines or hardcode a light-theme border for both themes. Blue means action/selection; green and red mean grading.
3. **Icons and copy:** reuse `Icon`; retain accessible names and native controls. Prefer concrete search guidance such as “시험 이름 또는 초성 검색.” Never relabel original practice as official past questions or change exam identity as a design shortcut.
4. **Type:** retain readable Korean and English, normal tracking on small text, tabular counts and deliberate heading sizes. Keep mobile question and answer text at 16px and code at 14px. Do not make explanatory or status text faint to make the page look quieter.
5. **Layout and details:** at narrow widths, let long exam names use the available row width. Keep bookmark targets independent from exam navigation and at least 44×44px. Filters, search-clear and disclosure controls should remain easy to touch and use by keyboard. English category labels can occupy many more rows than Korean: use the mobile native category select and desktop category buttons with shared state, rather than shrinking text or hiding categories. A native `details` can disclose secondary study-guide links without JavaScript; keep every link available and test the resulting journey.
6. **Motion:** use short, named color/border transitions. Avoid hover movement that changes targets, looping decoration and blanket transitions. Preserve reduced-motion support.

For example, a quiet exam-card edge may use `--line`, while an answer choice uses `--control-line` until selected. A 44px bookmark target can contain an 18px icon; enlarging the glyph is not necessary. Reducing the number of columns on mobile can improve name legibility without removing exam content.

## Verify learner outcomes, not just screenshots

- Run only local fixtures using `npm run dev:local` and the required `npm run check:local` in `web`. On Windows PowerShell with script execution disabled, use `npm.cmd`; do not change machine execution policy. Report the DB/Auth skips emitted by the workflow.
- Inspect Korean and English, light and dark, narrow 320/390px and desktop layouts. Keep horizontal overflow at zero. Compare before/after at the same viewport, theme and fixture route. Use actual bounding boxes to check touch targets and first-exam/question placement.
- Walk search (including initials), clear/focus recovery, categories, favorites, reset, sorting, more results and guide links. Collection and archive filters need a reachable reset even with no search query. Check keyboard and no-JavaScript disclosure navigation.
- Responsive control changes also affect `tools/modernization/test_monetization.mjs`, a separate 390px browser harness run at the end of `check:local`. Update its user interaction to the visible control, preserving all consent, ad-suppression and no-real-network assertions; passing the Playwright suite alone is not the complete gate.
- Preserve answer selection, strict multiple-answer grading, feedback text, explanation, next-question focus, saved progress and review modes. Use existing regression coverage; add tests when a changed interaction introduces a new behavioral contract.
- Check article and static pages that inherit the global tokens, not just the homepage. Keep contrast and focus visible in both themes. An axe pass complements visual review; it does not prove every touch target or control boundary is usable.
- Use independent review for important code, as required by the main skill. Record implementation, test results, skipped coverage and release state separately. A shorter scroll distance or passing test is not measured learning/conversion uplift.

UI work in a user-requested development session stays on a development branch when it spans multiple changes. Do not infer a production release from a request to improve design. During a PO run, record decisions and evidence in the existing journal rather than adding a parallel design log.

## Source and adaptation

Adapted from **unslop by Damir Sokolovsky ([@heydamir](https://x.com/heydamir))**, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Upstream: [heydamir/unslop](https://github.com/heydamir/unslop), reviewed at commit `97daa3eb365670ea3f87ed85356cbfcee18105a5` on 2026-11-13: [skill](https://github.com/heydamir/unslop/blob/97daa3eb365670ea3f87ed85356cbfcee18105a5/skills/unslop/SKILL.md), [audit signs](https://github.com/heydamir/unslop/blob/97daa3eb365670ea3f87ed85356cbfcee18105a5/skills/unslop/references/signs.md), [tokens](https://github.com/heydamir/unslop/blob/97daa3eb365670ea3f87ed85356cbfcee18105a5/skills/unslop/references/tokens.md).

This adaptation narrows the method to Quizeey's existing brand, learning-first layout and local verification rules. It does not install the upstream skill or copy its scripts. Generic landing-page image generation, story videos and mandatory redesign are omitted; accessibility and actual learning behavior take precedence over cosmetic token prescriptions.
