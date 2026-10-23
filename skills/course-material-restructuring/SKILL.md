---
name: course-material-restructuring
description: Restructure a courses.mooc.fi course: split, merge, move or reorder chapters, pages, sections and modules, then check links, exercises and dates. Use when a teacher asks to reorganise, split, merge, move or reorder. Not for fixing links alone (use course-material-link-check) or language versions (use course-material-translation-sync).
---

# Restructuring a course

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule. Ops and paths: the `patch_course_structure` and `patch_page_content` tool descriptions and `guide` topics `course-structure` and `editing`.

## Steps

1. **Read the current state**: `get_course_structure` for hidden pages, chapter dates, and each page's `exercise_count` and `has_submissions`; `list_courses` for whether the course is a draft or in test mode. Keep these notes for step 5.
2. **Write the plan** as a before/after outline (modules, chapters, pages in order) with its consequences: changed paths, chapter renumbering, exercises that move, removals and which of them are risky (`guide` topic `publishing-and-risk`), and dates that change for students. A new chapter has no opening time or deadline: when exercise pages move into one, ask the teacher which dates it gets. A new module starts with manual completion and certificates off; tell the teacher (`patch_course_settings` changes them). Agree the plan before writing anything.
3. **Apply one logical step per call** (for example "split chapter 3": add the chapter and move its pages in one call), dry-running each first and reading its diff, redirects and renumbering.
   - Split: add the chapter and move the pages into it in one call; fill its front page.
   - Merge: move the pages, then remove the empty chapter.
   - Content between pages: `patch_page_content` `move` with `to_page`.
4. **Fix what the move broke**:
   - internal links the results list as pointing at old paths (the `course-material` skill)
   - text that refers to positions ("in chapter 3", "luvussa 3", "on the previous page"): search with `find_replace` without `replace` and fix
   - chapter front pages that list the chapter's pages or topics
5. **Re-check**: `get_course_structure` matches the plan, and every moved page has the `exercise_count` and `has_submissions` noted in step 1.
6. If the course has other language versions, tell the teacher they need the same change (`course-material-translation-sync`).

**Done** when the structure equals the plan; no exercise lost its page or dates without agreement; links and position references are fixed or listed.

## Care

- Prefer `move` to remove-and-recreate (keeps ids, exercises, submissions, feedback); don't change chapter dates as a side effect.
