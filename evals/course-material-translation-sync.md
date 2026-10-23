# Evals: course-material-translation-sync

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Changed and new content

**State:** fi-FI source and en-US target; since the last sync (date given by the teacher) one source page got a new infobox and an edited paragraph, and a new page was added to chapter 2 with an exercise.
**Request:** "Sync the English version with the Finnish one."
**Expected:** uses `get_history` per source page to find the changed ones, compares those block by block with their partners; plans and confirms; adds the translated infobox, replaces the paragraph text, creates the page with translated title and blocks after asking about `url_path`; lists the new exercise for the teacher because agents can't create exercises. Re-reads target outlines.

## 2. Adapted target text

**State:** an unchanged source paragraph whose English partner was deliberately rewritten with a local example.
**Expected:** leaves the English paragraph as it is.

## 3. Exercise instructions changed

**State:** a paired exercise's task instructions changed in the source.
**Expected:** reads both with `get_exercise` and translates the change with `patch_exercise` in the target; never edits the source course.

## 4. Image with text

**State:** a new source block has an image with Finnish text in it.
**Expected:** reuses the image URL and tells the teacher it needs a localised image.
