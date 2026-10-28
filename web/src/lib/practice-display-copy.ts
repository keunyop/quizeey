// Keep archived catalog copy intact while presenting the current product wording.
// Exact replacements retain exam scope, jurisdiction and practice-format limits.
const displayReplacements: readonly (readonly [string, string])[] = [
  ["this supplemental set is independent foundational study material, not an official exam or a current-blueprint simulation.", "this supplemental set reviews foundational concepts and does not simulate a current replacement-exam blueprint."],
  ["Independent practice, not official exam questions, a full exam simulation or a score predictor.", "Not a full exam simulation or a score predictor."],
  ["Independent material; not a College Board test, an adaptive simulation or a score predictor.", "Not an adaptive simulation or a score predictor."],
  ["Independent material; not a College Board test or adaptive simulation.", "Not an adaptive simulation."],
  ["Multiple-choice review only; not a full GED test or an official GED Ready assessment.", "Multiple-choice review only; not a full GED test."],
  ["not a full-length or official GED assessment.", "not a full-length assessment."],
  ["Independent review, not an official DMV test; consult the current handbook for complete rules.", "Consult the current handbook for complete rules."],
  ["Independent review; not an official DriveTest or MTO examination or a complete two-section simulation.", "Not a complete two-section simulation."],
  ["Independent material; not an official ICBC examination or a full test simulation.", "Not a full test simulation."],
  ["Independent practice material, not an official CompTIA exam.", ""],
  ["It is independent study material, not an official ServSafe exam.", ""],
  ["This is independent study material, not an official ServSafe exam.", ""],
  ["Independent practice material, not an official California DRE examination.", ""],
  ["Independent study material, not an official TDI or Pearson VUE examination.", ""],
  ["Independent study material, not an official examination.", ""],
  ["Independent study material, not an official GED assessment.", ""],
  ["Independent material, not an official IRCC examination.", ""],
];

export function practiceDisplayCopy(value: string | undefined) {
  if (value === undefined) return undefined;
  let copy = value;
  for (const [before, after] of displayReplacements) copy = copy.replaceAll(before, after);
  copy = copy.replace(/\boriginal /gi, "").replace(/\s+/g, " ").trim();
  return copy ? copy[0].toUpperCase() + copy.slice(1) : copy;
}
