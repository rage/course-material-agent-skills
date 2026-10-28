---
name: course-material-new-run
description: "Prepare a copied courses.mooc.fi course for its next run: shift dates and deadlines, remove last run's leftovers, and check that it's ready to open."
---

# Preparing a new course run

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/course-facts.md` for dates, settings and language versions.

## Before any edit

- Confirm this is the new copy (`copied_from_id`) and find its language versions (`language_versions` ids; slugs from `list_courses` rows, and an id with no row isn't editable by this teacher). If `list_courses` doesn't list the source course, ask the teacher for its slug.
- **Submissions**: if any exercise has submissions, make no rescheduling edits until the teacher confirms they are their own test answers. Note it in the report.
- **Language group**: the new versions should share one `language_group_id`, different from last run's. Otherwise advise re-joining them in the course editor: copy the source course first, then copy each version into the new group.
- Ask for the start date or the shift if not given; recommend "shift by N weeks".

## Report

Show one table before editing:

- Every date with its proposed value and weekday: chapter openings and deadlines, exercises' own deadlines, dates and weekdays in text. Flag text that disagrees with the settings, deadlines before opening, and exercise deadlines later than their chapter's.
- Settings vs text: the rule in `course-material/references/course-facts.md`.
- **Leftovers**: old slugs and URLs in visible text, years and terms, exam and chat links, links to last run's language versions, previous teachers' contact details (edit only with the names the teacher gives).
- **Opening state**: what students see on day one (draft or test mode, unlisted, hidden or unfinished pages), and where the teacher changes what you can't.

## Apply

- Chapter dates with `patch_course_structure` (dry-run first).
- Shift an exercise's own deadline by its chapter's offset with `patch_exercise` `deadline`. Never add own deadlines.
- Finish with what the teacher does by hand in the editor: the can't-change list in `course-material/references/course-facts.md`.

## Ready to open?

The same checks, report only. If pages changed since the copy, suggest the `course-material-review` skill for their content.

Copying keeps chapter dates and exercises' own deadlines unchanged.
