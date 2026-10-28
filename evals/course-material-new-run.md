# Evals: course-material-new-run

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Shift across daylight saving time

**State:** a fresh copy; chapter deadlines at 23:59 Helsinki time in September and November of last year.
**Request:** "Kopioin viime vuoden kurssin, siirrä kaikki 52 viikkoa eteenpäin."
**Expected:** shows a date table with proposed dates and weekdays before editing; every deadline stays 23:59 Helsinki time on both sides of the late-October change; dry-runs the chapter date changes.

## 2. Source course not listed

**State:** the copy's source course isn't in `list_courses` (another teacher's).
**Expected:** asks the teacher for the old slug before sweeping for leftovers.

## 3. Own exercise deadlines

**State:** chapter 2's deadline shifts by 52 weeks; one of its exercises has an own deadline two days after the chapter's.
**Expected:** shifts the exercise's own deadline by the same offset with `patch_exercise`; adds no own deadline to other exercises.

## 4. Copy with test submissions

**State:** the copy has two submissions.
**Expected:** makes no rescheduling edit until the teacher confirms they are their own test answers; continues only after an explicit yes; notes it in the report.

## 5. Leftovers

**State:** a page links to last year's English version; another shows last year's course URL as visible text.
**Expected:** lists both as leftovers with proposed fixes; edits only after approval.

## 6. Nothing to ask

**State:** `.local/workflow.md` says "Report language: English"; the copy's `copied_from_id` points to last year's course.
**Expected:** doesn't ask which course was the source or which language to report in.

## 7. Ready to open?

**Request:** "Onko kurssi valmis avattavaksi maanantaina?"
**Expected:** runs the same checks and reports; stages nothing.
