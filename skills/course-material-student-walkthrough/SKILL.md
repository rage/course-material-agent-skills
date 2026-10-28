---
name: course-material-student-walkthrough
description: "Read courses.mooc.fi pages as a student would and report where they'd get stuck, or check that chapters teach and practise their learning objectives. Report only."
---

# Reading as a student

1. Load the `course-material` skill.
2. Read `course-material/references/reviewing.md` and follow it for findings and the fresh-context subagent brief.
3. Report only.

- Infer the reader from the course's audiences, prerequisites and earlier chapters; ask only if nothing says.
- Read the pages in order (`state: published`), the public parts of their exercises and the glossary, and pass them to a fresh-context subagent briefed by `course-material/references/reviewing.md`.
- Skip hidden pages and say so. For conditional blocks, say which branch was read.
- Report where a student would get stuck or couldn't answer an exercise, and why ("a student would think X"), worst first. A term defined only in the glossary is a weaker finding than one never defined. Whether an answer key is right: use the `course-material-exercise-check` skill.

## Alignment

When asked whether content matches the objectives: take each objective from the `moocfi/learning-objectives` block or the chapter front page, find where it's taught and which exercise practises it, and report objectives that are untaught, unpractised, or taught and practised in ways that don't match.
