---
name: course-material-restructuring
description: Restructure a courses.mooc.fi course - split or merge chapters, move pages and content between chapters and pages, reorder modules - and check redirects, links and exercises afterwards. Use when a teacher asks to reorganise, split, merge, move or reorder chapters, pages or sections of a courses.mooc.fi course.
---

# Restructuring a course

This skill works with the `course-material` skill. Load that one too: it has the workflow, the tool rules and the `skill_version` to send on every call. The ops are in its `references/course-structure.md` and `references/page-content.md`.

## Steps

1. **Read the current structure** with `get_course_structure` and note: which pages are hidden, which chapters are open, deadlines, and which pages have exercises and submissions (`exercise_count`, `has_submissions`). Check `get_course_settings` for whether the course is a draft, in test mode or live.
2. **Write the plan** as a before/after outline (modules, chapters, pages in order) and list the consequences:
   - pages whose paths change (they get redirects automatically)
   - chapter renumbering
   - exercises that move (they keep their submissions)
   - removals, and whether they are risky (visible pages or chapters in a live course, anything with submissions)
   - chapter dates that would effectively change for students
   Agree the plan with the teacher before writing anything.
3. **Dry-run** the structure change: `patch_course_structure` with `dry_run: true` and all ops of one logical step in one call. Read the diff, the redirects and renumbering in the result.
4. **Apply** step by step, one call per logical step (for example "split chapter 3", then "move the recursion pages into it"). Useful patterns:
   - split a chapter: `add` a chapter after it with a label, then `move` a range of pages into `/$label/pages`
   - merge: `move` the pages into the other chapter, then `remove` the empty chapter
   - move content between pages: `patch_page_content` `move` with `to_page`, which keeps block ids and feedback
   - make a page a chapter's front page: `move` it to the start of the chapter's `pages`
5. **Check afterwards**:
   - links: the result lists internal links that point at old paths. They still work through redirects; update them to the new paths (see the `course-material-link-check` skill)
   - text that refers to positions ("in chapter 3", "on the previous page", "see part 2") now may be wrong; search for chapter and part references with `find_replace` without `replace` and fix them
   - chapter front pages: their content often lists the chapter's pages or topics; update it
   - the structure again with `get_course_structure`, and the changed pages with the main skill's visual check
6. **Summarise** the changeset as the main skill describes, including the redirects created and any risky items for the review page.

## Care

- Prefer `move` over remove-and-recreate: it keeps ids, exercises, submissions and feedback.
- A page with exercises can't become a top-level page.
- Removing visible pages or chapters in a live course, or anything with submissions, is risky and only the teacher can publish it. Hidden pages are safer to remove.
- Don't change chapter opening times or deadlines as a side effect. If the restructuring needs new dates, agree them with the teacher; moving a deadline earlier on an open chapter is risky.
- Keep each call to one logical step so history and reverts stay understandable.
