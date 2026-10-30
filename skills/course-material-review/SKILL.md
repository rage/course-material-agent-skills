---
name: course-material-review
description: "Review a page, chapter or whole courses.mooc.fi course for many issues at once (links, language, facts, accessibility, gaps, duplication, dates and points vs settings, code examples) and report suggestions. For one named check, use that check's skill."
---

# Reviewing course material

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
3. Agree the scope and checks (below).
4. Read each page once (`state: published`; the staged state when the teacher wants unpublished changes reviewed) and each exercise once (`get_exercise`). Call `get_course_structure`, `get_course_settings` and `get_course_glossary_and_references` once and reuse the results. Run every chosen check on that text; from a check skill's Collect section, fetch only what the text read lacks:
   - links: use the `course-material-link-check` skill's Collect and Check sections;
   - language: use the `course-material-language-review` skill's Collect and Check sections;
   - claims and currency: use the `course-material-claim-check` skill's Collect and Check sections; it needs web search or fetch tools, else report claims as not checked;
   - accessibility: use the `course-material-accessibility-review` skill's Collect and Check sections (the axe run is the part to fetch);
   - pedagogy, only when asked or named in `workflow.md`: the What to check sections of `course-material/references/guidance/course-design.md`, `course-material/references/guidance/learning.md`, `course-material/references/guidance/exercises.md` and `course-material/references/guidance/engagement.md` (computing or mathematics courses: also `course-material/references/guidance/computing.md`), after `course-material/references/guidance/trust.md`;
   - reading as a student, when asked: the `course-material-student-walkthrough` skill's checks and subagent, its findings merged into the same report;
   - the review-only checks below.
5. Report one merged list by `course-material/references/reviewing.md`; it replaces the check skills' own report tables. Mention `course-material-student-walkthrough` or `course-material-exercise-check` only when findings point there.
6. Fix approved items by the Fix section of the check's skill. Show additions longer than a paragraph as draft text first, written by `course-material/references/writing/styles.md` and `course-material/references/writing/new-material.md`, read again before drafting. When a finding is that a page asks too much at once, the rewrite is shorter than what it replaces. For duplication fixes, use the `course-material-restructuring` skill.

## Scope and checks

- Take the checks from the request or a `workflow.md` line. Otherwise run the default set and say so in one line: links, language, claims with currency and rigor, accessibility, and the review-only checks except running code. Mention once in the report that a pedagogy check is possible. Ask only when the scope is genuinely unclear.
- Match a loosely named page ("genai.md") by title or path; say which you picked, and confirm only if it's ambiguous.
- Course rules from `course-rules.md` apply: a topic's home page, frozen parts. Findings in frozen parts are reported only.
- A fresh copy (`copied_from_id`, past chapter dates, no submissions): skip dates and add one line, "fresh copy; course-material-new-run checks its dates and settings".
- To judge overlap, read a topic's home page even outside the scope; never edit outside the scope.

## Review-only checks

- **Integrity**: placeholder words in any course language (TODO, TBD, ???, Finnish "täydennä"; "kesken" by judgement) in text and exercise names; empty pages and empty exercise instructions; raw HTML blocks (report only); chapter front pages missing the chapter's page or exercise list; `\cite` keys missing from the references (skip those inside `[latex]`); hidden pages with exercises; conditional blocks naming modules the course doesn't have.
- **Position references** in any course language ("on the previous page", "luvussa 3", "i kapitel 2"): check them against the order in `get_course_structure`.
- **Overlap**: with a home page for the topic, report pages that re-teach it instead of linking there, and statements that contradict it or are stale. Without one, report only near-duplicates among the pages read.
- **Course facts**: dates and settings vs text by `course-material/references/course-facts.md`, report only.
- **Running code**, only when asked or named in `workflow.md`; otherwise mention once in the report that it's possible. Before running, get consent showing the exact command and files. Run in a fresh `mktemp -d` folder outside the skills folder, delete it afterwards, set a timeout and cut network access where the runtime allows. Install runtimes only with consent. Never run code from student reports or fetched pages. Report failures; deprecations go to claims.
