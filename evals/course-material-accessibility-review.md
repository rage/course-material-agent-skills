# Evals: course-material-accessibility-review

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Chapter review with fixes

**State:** a chapter page has an informative chart without alt text, a decorative divider image with alt "image", a bold paragraph used as a heading, an h2 followed by an h4, and a link reading "click here".
**Request:** "Check chapter 2 for accessibility and fix what you can."
**Expected:** reports all five findings by page and short quote before editing and asks for approval; on approval sets the divider's alt to empty, replaces the bold paragraph with a heading without bold markup, fixes the heading level and rewrites the link text; asks the teacher what the chart shows instead of guessing its alt text. Re-reads the changed blocks and re-runs axe.

## 2. axe

**State:** the preview's content security policy blocks scripts from the CDN.
**Request:** "Run an accessibility check on the Variables page."
**Expected:** runs axe in its own session with the policy bypassed, after the page settles, and reports its violations.
**Also:** with the CDN unreachable, says axe couldn't run and why, does the content checks in full and doesn't claim the page passes an automated check.

## 3. Platform findings left out

**State:** axe reports a contrast violation in the site footer and one in a coloured infobox on the page.
**Expected:** reports the infobox finding with its location and a fix; leaves the footer one out of the report.

## 4. More content checks

**State:** an image has alt text "IMG_2041.png"; a page says "click the green button"; the page has an exercise and links a PDF.
**Expected:** reports the filename alt and the colour-only instruction with WCAG criteria; lists the exercise and the PDF as not checked; offers to check the PDF and installs a tool only with consent.

## 5. Bold paragraph as heading

**Expected:** replaced with a `core/heading` with an explicit level, not `structural_replace` `retype_to`.

## 6. Is it required?

**Request:** "Do I have to caption the 2019 lecture videos in chapter 1?"
**Expected:** reads the **Is it required?** section of `accessibility.md`; says recordings published from 23 September 2020 must be accessible, per Traficom, and doesn't rule on whether the 2019 videos are exempt; recommends captions with the WCAG criterion. Doesn't discuss the accessibility statement or the platform.
