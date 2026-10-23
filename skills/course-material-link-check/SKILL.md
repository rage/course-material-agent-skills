---
name: course-material-link-check
description: Find and fix broken or outdated links, images and files in courses.mooc.fi material. Use when a teacher asks about broken or dead links, missing images or links to old pages, or after content moved. Not for moving content (use course-material-restructuring) or link wording alone (use course-material-accessibility-review).
---

# Checking links in course material

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule.

## Steps

1. **Agree on the scope**: a page, a chapter or the course; fix or only report. On a large course, work chapter by chapter (`scope.chapter`), then each top-level page (`scope.page`).
2. **Collect the links** with `find_replace` without `replace`: `{"find": "href=|src=|https?://|mailto:|^/", "regex": true, "attributes": ["/.*/"]}`. This covers rich text, block attributes (`url`, `href`) and exercise instructions. Previews are truncated: read matching blocks raw for full URLs. Record block path and link text; check each unique URL once.
3. **Check internal links**: relative paths, `#anchors`, and links containing `/<course slug>/` (slug from `list_courses`).
   - Compare the path with the pages' `url_path` in `get_course_structure`.
   - An old path still works through a redirect; update it to the current path.
   - A path no page has is broken. Ask the teacher where the content went.
   - A link to a hidden page works only for the teacher; report it.
   - An `#anchor` must exist on the target page; check it in the page's preview.
4. **Check external links.** Fetch each URL (HEAD, then GET if HEAD fails), following redirects:
   - 2xx: fine
   - 3xx to another site or a generic page: likely moved; find the new address
   - 404 or 410: broken
   - 401, 403, 429 or timeouts: can't tell (bot blocking); report as "check by hand", don't change
   - `http://` that also works with `https://`: suggest `https://`
   - `mailto:`: check the address looks right; send nothing
5. **Check images and files**: in each page's preview, `playwright-cli requests` lists failed loads; otherwise fetch the URLs directly.
6. **Report** a table: page, link text, URL, status, suggested fix. Broken links first.
7. **Fix what the teacher approves.** For a replacement address prefer the same organisation's new page, or an archived copy (`https://web.archive.org/...`) the teacher agrees to. The link text must still match the target.
8. **Re-check**: run steps 3 to 5 again on the changed links.

**Done** when every link is fine, fixed, declined or marked "check by hand".

## Care

- Don't follow log-in pages or forms; submit nothing.
- At most a few requests a second per host.
