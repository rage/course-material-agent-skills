---
name: course-material-accessibility-review
description: "Review and fix the accessibility of courses.mooc.fi material against WCAG 2.2 AA: alt texts, headings, link texts, tables, contrast, captions."
---

# Accessibility review

1. Load the `course-material` skill and write by its **Writing style** rule.
2. Read `course-material/references/reviewing.md` and follow it for scope, findings and approval.
3. Collect, check and report as below, naming the WCAG 2.2 criterion in each finding. Then fix what the teacher approves.

## Collect

Raw blocks of the pages in scope, exercise instructions (`get_exercise`), and an axe run on each page's preview (command in `course-material/references/visual-checks.md`).

## Check

- **Images**: informative images have alt text saying what they show or mean in context; decorative ones `alt: ""`; charts carry their essentials in alt or nearby text; text in an image is also in the alt or text; a linked image needs a name. Filenames as alt text are findings.
- **Headings**: one logical outline, no skipped levels, not used for looks. A bold paragraph acting as a heading is a finding.
- **Link texts** make sense alone: no "click here", "read more" or bare URLs.
- **Lists and tables**: real list blocks; tables with header rows (and columns where rows are labelled), not used for layout.
- **Colour**: meaning never carried by colour alone ("click the green button"); text contrast 4.5:1, large text and meaningful graphics 3:1.
- **Media**: captions or transcripts; iframes with a title.
- **Other languages**: passages in another language marked where the editor allows, else reported.
- A clean axe run never replaces these checks. Report axe findings in the site header and footer separately, as platform issues the teacher can't fix.
- List linked PDFs and slides as not checked, and offer to check them with a local tool (installing only with consent).
- One "Couldn't check" line for exercise widgets, video captions, contrast inside images and what images show when you can't see them.

## Report

Blockers first (informative images without alt text, pages without headings, unreadable tables), then improvements.

## Fix

With `patch_page_content`. A bold paragraph becomes a `core/heading` with a `level` via `replace`; `structural_replace` `retype_to` can't set a level. Upload replaced images with `upload_file`. Ask the teacher what an image means when you can't tell. Run axe again on changed pages.
