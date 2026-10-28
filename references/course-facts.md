# Course facts

What the course states about itself, and where it lives. review, student-feedback and claim-check compare these facts and report only, on any course; only `course-material-new-run` edits dates and settings to match.

## Dates

- Forms to find: Finnish "15.9.2026", "15. syyskuuta", "ma 15.9."; Swedish "15.9.2026", "15 september", "mån 15.9."; English "15 September 2026", "September 15", "Mon 15 Sep". Weekdays and terms ("syksy 2026", "hösten 2026", "autumn 2026") count too.
- Stored in UTC, written in Helsinki time. Convert each date on its own: daylight saving differs between dates, so never shift by a fixed UTC offset across late March or late October.
- Check that every written weekday matches its date.
- Never shift: publication years, cited studies, laws, version release dates, dates inside URLs.
- Dates live in page text, exercise names and instructions, page and chapter titles, chapter `opens_at` and `deadline`, exercise deadlines (`list_exercises`), settings and the glossary.

## Settings vs text

- Compare what the text tells students with the settings: points, tries, peer-review counts and thresholds, completion thresholds and whether they're reachable, AI policy, chapter locking, certificates.
- A module's point total is the sum of `score_maximum` from every page of `list_exercises` over the module's chapters in `get_course_structure`.
- Never change a setting to match the text, or the text to match a setting, without asking which is right.

## Language versions

- Each language version is a separate course; `language_group_id` ties them together. Pages pair by `page_language_group_id`, exercises by `exercise_language_group_id`; ids differ per version.
- Copying a course into a new language group gives its exercises new pairing groups; page pairing is kept.

## Copies

Copying a course rewrites link targets to the new course, not URLs written as visible text. Anchors aren't redirected.

## What the tools can't read or change

Course instances and their start, end and enrolment dates; exercise settings other than name, instructions and deadline; grading; linked PDFs and slides. Point the teacher to the course editor for these.
