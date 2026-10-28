---
name: course-material-restructuring
description: "Split, merge, move or reorder modules, chapters, pages and sections of a courses.mooc.fi course, or remove duplication, and fix the links and references the move breaks."
---

# Restructuring a course

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/course-facts.md` for deadlines and completion thresholds.
3. Read `course-material/references/guidance/course-design.md`. When the teacher asks you to propose the structure rather than giving one, also follow the `course-material-design-advice` skill for the plan and say so.

## Plan first

Agree a before/after outline before writing anything. When you propose it:

- Alternatives differ in substance (grouping, order, what becomes its own page), not in naming.
- Say which pages end up thin or mixed, and why you still propose them.
- Check the order concept by concept: list each concept the pages use with the page that first teaches it, and fix or report every use before that page.
- Restructuring moves and splits what exists. New teaching text (self-checks, explanations, examples) is a separate offer the teacher accepts on its own; write it by `course-material/references/writing/new-material.md`.

Give the outline's consequences: changed paths, chapter renumbering, moved exercises and their effective deadline (`course-material/references/course-facts.md` **Dates**), module point totals against completion thresholds, and removals. Ask which dates a new chapter gets when the course has chapter dates. A new module starts with manual completion and certificates off; say so.

A move that makes an exercise's effective deadline earlier needs its own, separate confirmation.

## Apply

- Structure with `patch_course_structure`, dry-run first. Blocks between pages with `patch_page_content` `move` and `to_page`.
- Move exercise blocks; never copy, or remove and recreate, them: a copy is a new exercise without submissions. After a move, check in the structure that each moved page kept its `exercise_count` and `has_submissions`.
- In a course with chapter locking, give created or split chapters a `moocfi/lock-chapter` block.
- A page added (not copied) in one language version to match another needs `pair_with` its source page.

## Fix what moved

- Internal links a result lists as pointing at old paths, above all those it says now open another page, and position references in any course language ("in chapter 3", "the second chapter", "luvussa 3", "på föregående sida"): search every page with `find_replace` for chapter and page numbers and words such as previous, next, above and below.
- Hero labels set by hand that name a chapter number.
- Chapter front pages that list their pages or topics.
- **Duplication** found by a review: keep one home (the course rule's, if one names it) and replace the others with a short pointer and a link.
- Write new text (pointers, front pages, titles, position references) by `course-material/references/writing/styles.md` and the page language's file.

Finish with a list of changed paths, old → new; anchors aren't redirected. Offer the `course-material-student-walkthrough` skill to check that the new order reads well. If a topic's home page moved, say the course rule naming it needs updating. If the course has other language versions, say they need the same change, with the `course-material-translation-sync` skill.
