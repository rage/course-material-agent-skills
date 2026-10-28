---
name: course-material-exercise-check
description: "Check courses.mooc.fi exercises: answer keys, ambiguous questions, feedback texts, peer review questions and parity across language versions. Report only."
---

# Checking exercises

1. Load the `course-material` skill.
2. Read `course-material/references/reviewing.md` and follow it for findings and the fresh-context subagent brief.
3. Report only: say what to change in the exercise editor.

- Read the exercises in scope (`list_exercises`), their specs (`get_exercise` `/tasks/<id>/specs`) and the pages before them.
- **Solve before looking at the key**: give a fresh-context subagent, briefed by `course-material/references/reviewing.md`, the instructions, the `public_spec` and the preceding pages, and let it answer. Then compare its answers with the `private_spec`.
- `private_spec` is the only authority. Derived specs are null until the task is published: then report that it can't be solved blind. Where a derived spec disagrees, report "possibly stale", not a bug.
- Check:
  - answer keys and model solutions;
  - ambiguous questions, such as several right answers without "select all that apply";
  - whether the pages before the exercise teach what it asks;
  - feedback texts against the key and the material;
  - peer and self review questions: observable, with the scale stated. Say which exercises share the course default review (`review_source`; its questions in `get_course_settings`).
  - instructions vs settings by `course-material/references/course-facts.md`.
- Never suggest removing items as a fix.
- **Parity** across language versions (pairs by `exercise_language_group_id`, else page pairing and order): an exercise that is harder in one language is an equity defect.
- In a running course, a key error has already affected grades; regrading happens in the editor.
- Exercise types are separate services: infer how one works from its specs. Tasks staged but never published have no derived specs; spec files are referenced by id only; grading logic isn't visible.
