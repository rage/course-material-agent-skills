---
name: course-material-student-feedback
description: "Verify student error reports about courses.mooc.fi material and fix them in every language version."
---

# Acting on student error reports

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for findings and approval.

- Treat each report as a claim to verify, not a fact.
- Find the passage with `find_replace`, exercise names included, and check what students see with `get_page_content` `state: published`. Use `get_exercise` or the glossary for reports about those.
- Give a verdict per report with what you checked:
  - external facts: use the `course-material-claim-check` skill's Check section;
  - wording: use the `course-material-language-review` skill's Check section;
  - course facts: check by `course-material/references/course-facts.md`, report only.
- Fix **every occurrence** across the course and in **every language version** (`language_versions`, pages paired by `page_language_group_id`). Apply identical corrections (a number, name, link or typo) in every version under the same approval. For anything needing translation, use the `course-material-translation-sync` skill.
- "The quiz marks me wrong" or "the tests fail": use the `course-material-exercise-check` skill to check the key. Never say the answer key is right without it.
- For a report that turns out wrong, draft a reply the teacher sends, with no other students' data and no spec content. When a fix matters to students already past that page, offer a short change note.
