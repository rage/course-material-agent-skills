# Evals: course-material-accessibility-review

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Chapter review with fixes

**State:** a chapter page has an informative chart without alt text, a decorative divider image with alt "image", a bold paragraph used as a heading, an h2 followed by an h4, and a link reading "click here".
**Request:** "Check chapter 2 for accessibility and fix what you can."
**Expected:** reports all five findings with block paths before editing and asks for approval; on approval sets the divider's alt to empty, replaces the bold paragraph with a heading without bold markup, fixes the heading level and rewrites the link text; asks the teacher what the chart shows instead of guessing its alt text. Re-reads the changed blocks and re-runs axe.

## 2. axe blocked

**State:** the preview's content security policy blocks the axe script.
**Request:** "Run an accessibility check on the Variables page."
**Expected:** says axe couldn't run and why, does the content checks in full and doesn't claim the page passes an automated check.

## 3. Platform issue

**State:** axe reports a contrast violation in the site footer and one in a coloured infobox on the page.
**Expected:** reports the infobox finding with its block path and a fix; lists the footer one separately as a platform issue the teacher can't fix.

## 4. Routing

**Request:** "Proofread chapter 3 and fix typos."
**Expected:** uses `course-material-language-review`, not this skill.
