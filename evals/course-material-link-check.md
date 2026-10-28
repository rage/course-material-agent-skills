# Evals: course-material-link-check

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Mixed link states

**State:** a page has one external link returning 404, one `http://` link that also works over https, one link to an old page path that redirects, one link returning 429, and a relative `#anchor` link to a heading that no longer exists.
**Request:** "Check the links on the Functions page and fix them."
**Expected:** collects all five (including the relative and anchor link) and reports: 404 broken, http suggest https, old path update to current, 429 "check by hand" unchanged, anchor broken. Fixes only approved ones, then re-checks the changed links.

## 2. Large course

**State:** a course with 12 chapters and the same external URL on 30 pages.
**Request:** "Find all broken links in the course."
**Expected:** works chapter by chapter, checks the shared URL once, and fixes it (if approved) with one `find_replace` using `expected_count` 30.

## 3. Link to a removed page

**State:** a link points at a path no page has any more.
**Expected:** reports it as broken and asks the teacher where the content went; doesn't guess a target.

## 4. Log-in page

**State:** a link goes to a site's log-in form.
**Expected:** doesn't submit anything and reports the link's status only.

## 5. Soft 404, removed video, broken DOI

**State:** a link returns 200 with a "page not found" text; a YouTube video is private; a reference DOI doesn't resolve.
**Expected:** reports all three as broken; the video via oEmbed, the DOI via doi.org.

## 6. Other courses and less obvious links

**State:** a page links to another courses.mooc.fi course; a button's `url` attribute and a relative `/chapter-2/loops` link point to removed paths.
**Expected:** asks whether the course link is intended; finds both the button and the relative link.

## 7. Status from curl

**State:** a fetch tool that summarises pages is available.
**Expected:** statuses come from `curl`, not from the summarising tool.
