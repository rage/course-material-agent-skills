---
name: course-material-language-review
description: Review the language of courses.mooc.fi material: plain language (ISO 24495-1), spelling, grammar, consistent terms. Use when a teacher asks to proofread, simplify, check spelling or unify terms, in any language. Not for translating (use course-material-translation-sync), fact-checking (use course-material-claim-check) or alt texts and headings (use course-material-accessibility-review).
---

# Language review of course material

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule.

Goal: text readers can find, understand and use. Review in the course's own language; don't translate.

## Steps

1. **Agree on the scope and depth**: pages or chapters; spelling and grammar only, terminology, or a full plain-language edit. Ask who the readers are if it isn't obvious (`get_course_settings` lists audiences).
2. **Read** the outline, then the text blocks you review in raw mode; exercise names and instructions with `get_exercise`. Note the course's own conventions (for example "e-mail" or "email", Finnish compound spelling, British or American English) and keep them rather than impose yours.
3. **Review** against the checklist below. Note per block: path, quote, problem, suggested text.
4. **Report** grouped by kind: errors (spelling, grammar, wrong terms) first, then clarity suggestions. For a rewritten passage, show before and after.
5. **Edit what the teacher approves**: replace whole text attributes, keeping markup, links, `[latex]`, `\cite{}` and glossary terms intact; don't touch code samples or quoted material. Terminology across pages is a bulk edit (the `course-material` skill).
6. **Re-check** each edited block (`read_back`, or `get_exercise` for exercises): only the text changed, and markup, links, LaTeX and citations are as before.

**Done** when every approved edit reads back correctly and the rest of the findings are in the report.

## Checklist (ISO 24495-1)

Use it within the **Writing style** rule: the teacher's style and preferences win over this list.

- **Relevant**: each page's purpose is clear early, the most important thing first; nothing essential missing, nothing there out of habit.
- **Findable**: headings say what follows and work as a table of contents; lists for steps and parallel items; tables for comparisons.
- **Understandable**: familiar words; terms explained on first use (or in the glossary), one term per concept; short sentences, one idea each; active voice; concrete examples near abstractions; no unexplained abbreviations.
- **Usable**: instructions are numbered steps in the reader's order; links say where they go.
- **Correct**: spelling and grammar; names, terms, numbers, units and dates written consistently.

## Care

- Keep the teacher's voice, meaning and the course's level; when unsure what the teacher meant, ask.
