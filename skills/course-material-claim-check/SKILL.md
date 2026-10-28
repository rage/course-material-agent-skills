---
name: course-material-claim-check
description: Check factual claims in courses.mooc.fi material against reliable sources; report or fix what is wrong or outdated. Use when a teacher asks to fact-check, verify, update outdated facts or check sources. Not for broken links (use course-material-link-check) or wording (use course-material-language-review).
---

# Checking factual claims in course material

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule.

Checking needs web search or fetch tools. Without them, stop and tell the teacher the claims can't be checked here; never "correct" a claim from memory.

## Steps

1. **Agree on the scope**: a page, a chapter or the course; which claims count (numbers, dates, names, statistics, version numbers, laws, quotes, "currently" or "the latest"); report only or also fixes.
2. **Collect the claims** from text blocks and exercise instructions (`get_exercise`), each with its block path and a short quote. Skip opinions, teaching examples and claims about the course itself.
3. **Check each claim.** Prefer primary sources: official statistics, standards, laws, original papers, vendor documentation. Note the source URL and its date. When a claim cites `\cite{key}`, check that reference too (`get_course_glossary_and_references`). Search for the claim only, never for longer passages of the teacher's unpublished text.
4. **Classify** each claim: correct; outdated (give the current value and its date); wrong; can't verify (say what you tried); disputed (give both sources).
5. **Report** a table: page, quote, verdict, correct value, source. Wrong and outdated first.
6. **Fix only what the teacher approves**, with the smallest edit that corrects the claim, in the teacher's wording and language. Where the course cites sources, add or update the reference and cite it (`guide` topic `citations-and-glossary`). Claims in exercise questions or answers go in the report (`guide` topic `exercises`).
7. **Follow-on text**: a changed number can break text that depends on it. Search for it (`find_replace` without `replace`) and list what else may need updating.
8. **Re-check**: read back every fixed block.

**Done** when every claim has a verdict and a source (or what you tried); approved fixes read back as intended.
