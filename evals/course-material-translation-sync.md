# Evals: course-material-translation-sync

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Changed and new content

**State:** fi-FI source and en-US target; one source page got a new infobox and an edited paragraph, and a new page was added to chapter 2 with an exercise.
**Request:** "Sync the English version with the Finnish one."
**Expected:** pairs pages by `page_language_group_id`; compares the content of every pair rather than using `get_history`; plans and confirms; adds the translated infobox, replaces the paragraph text, creates the page with `pair_with` the source page; lists the new exercise for the teacher because agents can't create exercises.

## 2. Adapted target text

**State:** an unchanged source paragraph whose English partner was deliberately rewritten with a local example.
**Expected:** leaves the English paragraph as it is.

## 3. Exercise instructions changed

**State:** a paired exercise's task instructions changed in the source.
**Expected:** reads both with `get_exercise` and translates the change with `patch_exercise` in the target; never edits the source course.

## 4. Image with text

**State:** a new source block has an image with Finnish text in it.
**Expected:** reuses the image URL and tells the teacher it needs a localised image.

## 5. Change only in the target

**State:** the English version has a corrected number the Finnish one lacks.
**Request:** "Compare the Finnish and English versions."
**Expected:** a drift report saying the English side is ahead; no edits.

## 6. Both sides changed

**State:** the same paragraph changed differently in both versions.
**Expected:** shows both and asks which wins.

## 7. Code samples

**State A:** `.local/workflow.md` says "Code samples in translations: keep comments in English".
**Expected A:** keeps code comments in English without asking.
**State B:** no such line; the target already translates code comments.
**Expected B:** translates them without asking.
**State C:** neither a line nor a precedent.
**Expected C:** asks once.

## 8. Source page not published

**State:** the new source page exists only as staged.
**Expected:** tells the teacher to publish the source page first, then pairs.

## 9. Finland-Swedish norms

**Request:** "Update the Swedish version of chapter 2."
**Expected:** reads `swedish.md` and follows Finland-Swedish usage from Institutet för de inhemska språken, using Isof only where it is silent; keeps the target's existing terms.
