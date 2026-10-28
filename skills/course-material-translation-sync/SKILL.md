---
name: course-material-translation-sync
description: Bring a language version of a courses.mooc.fi course in line with its source: find what changed in the source, update the matching parts, keep structure and terms aligned. Use when a teacher asks to update, sync or align a translation or language version. Not for proofreading (use course-material-language-review) or restructuring (use course-material-restructuring).
---

# Syncing a language version with its source

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule.

Language versions are separate courses with their own `language_code`; page, block and exercise ids differ, so match by position, structure and content.

## Steps

1. **Identify both courses** with `list_courses`. Confirm with the teacher which is the source, what to sync (everything, a chapter, a page) and when the last sync was.
2. **Map the structure.** Read `get_course_structure` for both and pair modules, chapters and pages by order and meaning. List what has no partner. Show the mapping when it isn't one-to-one.
3. **Find what changed.** `get_history` with a source page as `entity` gives `last_published_change.at` (when, not what). Compare each source page changed since the last sync with its partner block by block, outlines first; with no sync date, compare every pair.
4. **Collect the terminology.** Read both glossaries and the target's wording for key terms. Reuse the target's terms; list new terms you had to choose.
5. **Plan and confirm** page by page what you will add, change, move and remove in the target. Name every removal.
6. **Apply** per page:
   - new blocks: translate and `add` them at the matching position
   - changed blocks: translate the changed text and `replace` the attribute
   - moved blocks: `move` the target's existing block, so its id and feedback stay
   - images: reuse the file URL unless the image has source-language text; then tell the teacher it needs a localised image
   - links to the source course: point them at the target's matching page
   - new pages and chapters: `patch_course_structure` with `blocks`. Translate titles; ask whether `url_path` keeps the source's or is translated.
   - exercises: compare pairs with `get_exercise` and translate changed names and instructions with `patch_exercise` (`guide` topic `exercises`); list unpaired exercises and other exercise changes for the teacher.
7. **Glossary**: add translated terms for new terms; references usually stay.
8. **Re-check**: re-read the target outlines of the synced pages. Every source block has a partner in the same order, or is in your list for the teacher.

**Done** when every changed source page is synced or listed; the teacher has the list of unpaired pages, exercises and images.

## Care

- Translate meaning, not words, in the target's register. Keep code, LaTeX, citation keys and product names unchanged.
- A target with no text yet follows the teacher's preferences for its language.
- Don't overwrite target text the teacher has adapted: if a target block differs from a literal translation of an unchanged source block, leave it.
- Never change the source course.
