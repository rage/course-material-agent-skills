---
name: course-material-link-check
description: "Find and fix broken or outdated links, images, files, videos and DOIs in courses.mooc.fi material."
---

# Checking links

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
3. Collect, check and report as below, then fix what the teacher approves.

## Collect

- Per chapter, `find_replace` without `replace`: `{"find": "href=|src=|https?://|mailto:|^/", "regex": true, "attributes": ["/.*/"]}`. It covers rich text, block attributes such as button `url`, relative `/paths` and exercise instructions. Previews are truncated: read the hit blocks raw for full URLs.
- `url` and `doi` in each reference's `bibtex` from `get_course_glossary_and_references`.
- Check each unique URL once; remember every place it appears.

## Check

- **Internal** (relative paths and absolute URLs into this course): compare paths with `url_path` in `get_course_structure`. An old path works through a redirect but should be updated; a path no page has is broken: ask where the content went, never guess. A link to a hidden page works only for the teacher. Check `#anchors` on the target page's preview.
- **Other courses.mooc.fi courses**: report each as "intended?"; it may point at last year's run.
- **External**: status from `curl` (HEAD, then GET when HEAD fails, following redirects), never from a fetch tool that summarises pages. 404 and 410 are broken; a redirect to another site or a generic page means moved; 401, 403, 429 and timeouts mean "check by hand", left unchanged. Suggest `https://` where it works.
- **Soft 404s**: a 200 page that says "not found" or lands on a front page.
- **Videos**: removed or private YouTube and Vimeo videos fail their oEmbed endpoint.
- **DOIs**: resolve through `https://doi.org/`.
- **Images and files**: failed loads in the preview (how: `course-material/references/visual-checks.md`), else fetch them.
- `mailto:` addresses are checked by eye, never sent. Submit no forms, follow no log-ins, and keep to a few requests a second per host.

## Report

A table: page, link text, URL, status, suggested fix; broken first, "check by hand" last.

## Fix

Change the attribute with `patch_page_content`, or the literal URL with `find_replace` and `expected_count`. Prefer the same organisation's new address, else an archived copy the teacher agrees to. Make sure the link text still matches the target.
