---
name: course-material-translation-sync
description: "Bring a courses.mooc.fi language version in line with its source, check a translation against it, or report where versions differ."
---

# Syncing language versions

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/course-facts.md` for language versions and dates.

## Scope

- Infer source, target and scope from the request and `language_versions`; ask only when ambiguous.
- **Code samples** (comments, strings): a `workflow.md` line decides; else follow what the target already does; ask only when neither says.
- Pair pages by `page_language_group_id` and exercises by `exercise_language_group_id`, by position where those are missing. Show the mapping when it isn't one-to-one.

## Compare

- Compare the content of every pair each time; never infer what changed from history.
- When both sides changed, show both and ask which wins.
- Reuse the target glossary's terms; list new terms you had to choose.
- Plan per page and confirm before editing.

## Apply

- Translate meaning in the target's register. Keep code, LaTeX, citation keys and product names unchanged.
- Move existing target blocks rather than recreating them.
- Leave target text the teacher has adapted (it differs from a literal translation of an unchanged source block).
- Links to the source course point to the target's matching page. Images with source-language text need a localised image: tell the teacher.
- Create new pages with `pair_with` their source page; a source page that isn't published yet must be published first.
- Exercise names and instructions with `patch_exercise`; list unpaired exercises and other exercise changes for the teacher.
- Never write to the source course.

## Drift report

When asked to compare versions, report only: which side is ahead in text, numbers, dates, points, links, exercise and block counts, and settings.
