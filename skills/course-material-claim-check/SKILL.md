---
name: course-material-claim-check
description: "Check facts in courses.mooc.fi material against current, reliable sources, including whether it still teaches current practice."
---

# Checking claims

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Needs web search or fetch tools. Without them, stop and say the claims can't be checked here; never correct a claim from memory.
3. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
4. Read only the What to check sections of the guidance files named in the **Rigor** point below.
5. Collect, check and report as below, then fix what the teacher approves.

## Collect

Claims in page text, exercise instructions, code samples and references (`url` and `doi` in their BibTeX): numbers, dates, names, statistics, versions, laws, quotes, "currently", "the latest", "always". Claims about the course itself (dates, points, settings): check them by `course-material/references/course-facts.md`, report only.

## Check

- A verdict per claim: correct, outdated (current value and its date), wrong, disputed (both sources) or can't verify (what you tried).
- Search for the claim only, never for unpublished passages.
- Check that the source actually supports the sentence next to it, including `\cite{}` references.
- **Currency**, on by default: does the material still teach current scientific and industrial practice? Spend effort where things age fast: versions, UI steps, prices, laws, AI tools. Name deprecated APIs with their replacement.
- **Rigor**: the What to check sections of `course-material/references/guidance/knowledge-and-method.md`, `course-material/references/guidance/evidence.md`, `course-material/references/guidance/reasoning-errors.md` and `course-material/references/guidance/honesty.md` (computing or mathematics courses: also `course-material/references/guidance/computing.md`).
- **Sources**: the kinds that can answer the claim (`course-material/references/guidance/evidence.md` **Which evidence answers which question**). Repeats of one source aren't independent. Judge each by the `course-material-research` skill's **Check each source**, its own reasoning included, and give its URL, date and the problems found in it.
- A claim that needs new content rather than a corrected value: suggest the `course-material-research` skill.

## Report

As `course-material/references/reviewing.md` **Findings**, wrong and outdated under Fix first. Each finding gives the quote, verdict, current value, and the source with its kind, date and problems found in it; judgement calls labelled.

## Fix

The smallest edit that corrects the claim, in the teacher's wording, plus the reference update where the course cites sources. A changed number can break text that depends on it: search for it and list the other places.
