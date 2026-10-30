---
name: course-material-language-review
description: "Proofread courses.mooc.fi material: spelling, grammar, consistent terms, glossary use and understandability (plain language). Not for translations (course-material-translation-sync)."
---

# Language review

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
3. Infer the readers from the course's audiences; ask only if it changes the outcome.
4. Collect, check and report as below, in the course's language; never translate. Then fix what the teacher approves.

## Collect

Text blocks raw, exercise names and instructions (`get_exercise`), and the text outside blocks (titles, glossary). Note the course's own conventions before judging: spelling variants, compound spelling, quotation marks, British or American English. Infer them from the course and from how the teacher writes; never ask the teacher to choose.

## Check

- Follow the language's official norms and the course's conventions over your own taste. Read the file for the text's language: Finnish `course-material/references/writing/finnish.md`, Swedish `course-material/references/writing/swedish.md`, English `course-material/references/writing/english.md`; other languages: the course's own conventions.
- Read every text in scope yourself for spelling and grammar; regexes and other checks' output don't replace that. Text you didn't read is reported as not proofread.
- Mechanical issues across the course (double spaces, hyphens for dashes, straight quotes) with `find_replace` regexes; find doubled words by reading the text yourself.
- **Glossary**: each term in `get_course_glossary_and_references` is used as defined, and the definition matches how the text uses it. Report inflected or variant uses; never rewrite text to force a match.
- **Understandability**, by the style the text needs (`course-material/references/writing/styles.md`, read for this check, not for mechanical fixes; exercise questions and feedback: its **Exercise text**), under the teacher's style. Concise and easy to understand, never flattened:
  - Relevant: each page's purpose is clear early; nothing essential missing, nothing there out of habit; no padding, filler or repeated points.
  - Findable: headings say what follows; lists for steps and parallel items; tables for comparisons.
  - Understandable: a familiar word where it is as precise; terms kept and explained on first use; one term per concept; short sentences by default, a long one only where the thought needs it; the actor named where it matters; examples near abstractions; abbreviations explained.
  - Usable: instructions as steps in the reader's order.
- **Certainty**, only when claims aren't checked in the same run (the `course-material-claim-check` skill owns it then): read `course-material/references/guidance/trust.md` and `course-material/references/guidance/honesty.md`'s **Confidence that doesn't match the evidence** and **Unstated scope** points, and report wording more certain or general than the claim allows ("always", "proves", "all studies show"). Changing a claim's meaning is the teacher's call.
- Every edit must trace to spelling, grammar, a convention, a preference or a checklist item. Changes to meaning, structure or voice are reported, not made.

## Report

- Findings by `course-material/references/reviewing.md`.
- **Course style sheet**: the conventions the course follows consistently (spellings, quotation marks, terms, forms of address), offered as one offer to save to `preferences.md`. Save only the lines the teacher approves.

## Fix

- Replace whole text attributes, keeping links, `[latex]`, `\cite{}` and glossary terms intact; never touch code or quotations. Show before and after for rewritten passages.
- Unifying a term across pages is a bulk edit: propose the course's majority form and ask first.
