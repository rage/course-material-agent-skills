---
name: course-material-restructuring
description: "Split, merge, move or reorder modules, chapters, pages and sections of a courses.mooc.fi course, or remove duplication, and fix the links and references the move breaks."
---

# Restructuring a course

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/course-facts.md` for deadlines and completion thresholds.

## Plan first

Agree a before/after outline before writing anything, with its consequences: changed paths, chapter renumbering, moved exercises and their effective deadline (own, else the target chapter's), module point totals against completion thresholds, and removals. Ask which dates a new chapter gets. A new module starts with manual completion and certificates off; say so.

A move that makes an exercise's effective deadline earlier needs its own, separate confirmation.

## Apply

- Structure with `patch_course_structure`, dry-run first. Blocks between pages with `patch_page_content` `move` and `to_page`.
- Never remove and recreate exercises: that destroys their submissions. After a move, check in the structure that each moved page kept its `exercise_count` and `has_submissions`.
- In a course with chapter locking, give created or split chapters a `moocfi/lock-chapter` block.
- A page added (not copied) in one language version to match another needs `pair_with` its source page.

## Fix what moved

- Links to old paths, and position references in any course language ("in chapter 3", "luvussa 3", "på föregående sida").
- Chapter front pages that list their pages or topics.
- **Duplication** found by a review: keep one home (the course rule's, if one names it) and replace the others with a short pointer and a link.

Finish with a list of changed paths, old → new; anchors aren't redirected. If a topic's home page moved, say the course rule naming it needs updating. If the course has other language versions, say they need the same change, with the `course-material-translation-sync` skill.
