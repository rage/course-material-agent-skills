---
name: course-material-accessibility-review
description: Review and fix accessibility of courses.mooc.fi material: alt texts, headings, link texts, tables, contrast, plus an axe check. Use for an accessibility (a11y, WCAG, saavutettavuus) review or fixes. Not for spelling or plain language (use course-material-language-review) or broken links (use course-material-link-check).
---

# Accessibility review of course material

Needs the `course-material` skill loaded too; write any text you add or change by its **Writing style** rule. Aim for WCAG 2.2 level AA.

## Steps

1. **Scope**: pages or chapters; report only, or fix too.
2. **Check the content** (raw reads of the blocks in question; `get_exercise` for exercise instructions):
   - **Images**: every informative image has an `alt` that says what it shows or means in context, without "image of". Decorative images have `alt: ""`. Charts and diagrams have the essentials in alt text or in the text or caption next to them. Text in an image is also in the alt or the text.
   - **Headings**: one logical outline per page, no skipped levels (h2 to h4), not used only for looks. Bold paragraphs acting as headings become `core/heading`.
   - **Link texts** say where the link goes without the surrounding text: no "click here", "read more" or bare URLs.
   - **Lists** are `core/list` blocks, not paragraphs starting with "-".
   - **Tables** have a header row, and a header column when rows are labelled; aren't used for layout; have a caption when the context doesn't explain them. Cell shapes: `guide` for `core/table`.
   - **Colour**: meaning isn't carried by colour alone. Text contrast is at least 4.5:1, or 3:1 for large text (24 px, or 18.5 px bold) and for icons and lines that carry meaning.
   - **Language**: passages in another language than the page are marked if the editor allows it; otherwise report them.
   - **Media**: videos and audio have captions or transcripts; iframes have a title.
   - **Math**: a formula that carries the main point has a text explanation nearby.
3. **Run axe** on each page in scope, on a `get_preview_link` URL:
   ```bash
   playwright-cli open "<preview URL>"
   playwright-cli eval "await new Promise((resolve, reject) => { const s = document.createElement('script'); s.src = 'https://cdn.jsdelivr.net/npm/axe-core@4.14.0/axe.min.js'; s.onload = resolve; s.onerror = reject; document.head.appendChild(s) })"
   playwright-cli --raw eval "JSON.stringify((await axe.run()).violations.map(v => ({id: v.id, impact: v.impact, help: v.help, nodes: v.nodes.map(n => n.target.join(' ')).slice(0, 5)})))"
   playwright-cli close
   ```
   If the script is blocked (content security policy) or `playwright-cli` is missing, say so and rely on step 2. axe finds only part of the problems; a clean run never replaces step 2. Report violations in the site header and footer separately as platform issues: the teacher can't fix them.
4. **Report** by severity: blockers (missing alt on informative images, no headings, unreadable tables), then improvements. Each with page, block path, problem, suggested fix.
5. **Fix what the teacher approves** with what the editor offers; ARIA attributes and raw HTML are rejected. Replace a bold paragraph acting as a heading with a `core/heading` holding its text without `<strong>`; `structural_replace` `retype_to` keeps the markup. Writing alt text needs the image's meaning in context: if you can't see or understand the image, ask the teacher. Exercise edits: `guide` topic `exercises`.
6. **Re-check** each changed page: re-read the changed blocks and run step 3 again.

**Done** when every finding is fixed, declined or reported, and axe shows no new violations in the course content.
