---
name: course-material-translation-sync
description: Bring a language version of a courses.mooc.fi course or page in line with its source language version - find what changed in the source, translate the new or changed parts and keep structure, ids and terminology aligned. Use when a teacher asks to update, sync or align a translation or language version of a courses.mooc.fi course.
---

# Syncing a language version with its source

This skill works with the `course-material` skill. Load that one too: it has the workflow, the tool rules and the `skill_version` to send on every call.

Language versions are separate courses on courses.mooc.fi, each with its own `language_code`. Pages and blocks have their own ids in each course, so you match them by position, structure and content, not by id.

## Steps

1. **Identify both courses** with `list_courses`: the source (for example `fi-FI`) and the target (for example `en-US`). Confirm with the teacher which is the source and what to sync: everything, one chapter or one page.
2. **Map the structure.** Read `get_course_structure` for both. Pair modules, chapters and pages by order and meaning, and list what has no partner (new or removed in the source). Show the mapping to the teacher when it isn't one-to-one.
3. **Find what changed in the source.** Use `get_history` on the source course or pages since the last sync the teacher names, or compare paired pages block by block (outline mode first). For each difference note: added, changed, removed or moved blocks.
4. **Collect the terminology.** Read both glossaries (`get_course_glossary_and_references`) and the target's existing wording for key terms. Reuse the target's established terms; list new terms you had to choose.
5. **Plan and confirm.** Tell the teacher what you will add, change, move and remove in the target, page by page. Removals from visible pages in a live target course are risky and go to the teacher's review page.
6. **Apply** per page with `patch_page_content`:
   - new blocks: translate and `add` them at the matching position
   - changed blocks: translate the changed text and `replace` the attribute
   - moved blocks: `move` the target's existing block, so its id and any feedback stay
   - images: reuse the same file URL unless the image contains text in the source language; then tell the teacher it needs a localised image
   - links to the source course: point them at the target course's matching page
   New pages and chapters go through `patch_course_structure`, with `blocks` to fill them in one call.
7. **Glossary and references**: add translated glossary terms for new terms; references usually stay as they are.
8. **Check** changed pages with the main skill's visual check and summarise the changeset.

## Care

- Translate meaning, not words, in the target course's register and plain-language style. Keep code, LaTeX, citation keys and product names unchanged.
- Don't overwrite target text that the teacher has deliberately adapted for its audience. If a target block differs from a literal translation of an unchanged source block, leave it.
- Agents can't create exercises or edit their questions, answers or grading; they can translate an exercise's name and task and review instructions with `patch_exercise`. Report source exercises that are missing, or whose contents changed, in the target for the teacher.
- Don't change the source course.
