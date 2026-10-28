---
name: course-material-review
description: "Review a page, chapter or whole courses.mooc.fi course for many issues at once (links, language, facts, accessibility, gaps, duplication, dates and points vs settings, code examples) and report suggestions. For one named check, use that check's skill."
---

# Reviewing course material

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
3. Agree the scope and checks (below).
4. Read each page once (`state: published`) and each exercise once (`get_exercise`), and run every chosen check on that text:
   - links: use the `course-material-link-check` skill's Collect and Check sections;
   - language: use the `course-material-language-review` skill's Collect and Check sections;
   - claims and currency: use the `course-material-claim-check` skill's Collect and Check sections;
   - accessibility: use the `course-material-accessibility-review` skill's Collect and Check sections;
   - the review-only checks below.
   Scope, report and approval stay in this skill.
5. Report one merged list by `course-material/references/reviewing.md`. Mention `course-material-student-walkthrough` or `course-material-exercise-check` only when findings point there.
6. Fix approved items by the Fix section of the check's skill. Show additions longer than a paragraph as draft text first. For duplication fixes, use the `course-material-restructuring` skill.

## Scope and checks

- Take the checks from the request or a `workflow.md` line. Otherwise run the default set and say so in one line: links, language, claims with currency, accessibility, and the review-only checks except running code. Ask only when the scope is genuinely unclear.
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
