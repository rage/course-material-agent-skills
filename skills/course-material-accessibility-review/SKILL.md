---
name: course-material-accessibility-review
description: Review and fix accessibility of courses.mooc.fi course material - image alt texts, heading order, link texts, tables, colour-only meaning, plus an automated axe check of the rendered page. Use when a teacher asks for an accessibility (a11y, WCAG, saavutettavuus) review or fixes on a courses.mooc.fi course, chapter or page.
---

# Accessibility review of course material

This skill works with the `course-material` skill. Load that one too: it has the workflow, the tool rules and the `skill_version` to send on every call.

Aim for WCAG 2.2 level AA, the level EU public-sector accessibility rules require.

## Steps

1. **Agree on the scope**: pages or chapters, report only or also fixes.
2. **Check the content** (raw page reads):
   - **Images** (`core/image`, image children of other blocks): every informative image has an `alt` that says what the image shows or means in context, without "image of". Decorative images have `alt: ""`. Complex images (charts, diagrams) have the essentials in alt text or in the text or caption next to them. Text in images is also in the text.
   - **Headings**: one logical outline per page; no skipped levels (h2 to h4); headings aren't used only for looks; bold paragraphs that act as headings become `core/heading`.
   - **Link texts** say where the link goes without the surrounding text: no "click here", "here", "read more" or bare URLs. Links that open a new tab are rare and expected.
   - **Lists** are real `core/list` blocks, not paragraphs starting with "-".
   - **Tables** have a header row (`head` cells with `tag: "th"`, `scope: "col"`), aren't used for layout, and have a caption when the context doesn't explain them.
   - **Colour**: meaning isn't carried by colour alone (inline colour, coloured boxes); text colours have enough contrast.
   - **Language**: passages in another language than the page are marked if the editor allows it; otherwise report them.
   - **Media**: videos and audio have captions or transcripts; embedded content (iframes) has a title.
   - **Math**: formulas have a text explanation nearby when they carry the main point.
3. **Check the rendered page** for each page in scope: get a link with `get_preview_link`, then with `playwright-cli`:
   ```bash
   playwright-cli open "<preview URL>"
   playwright-cli eval "await new Promise((resolve, reject) => { const s = document.createElement('script'); s.src = 'https://cdn.jsdelivr.net/npm/axe-core@4/axe.min.js'; s.onload = resolve; s.onerror = reject; document.head.appendChild(s) })"
   playwright-cli --raw eval "JSON.stringify((await axe.run()).violations.map(v => ({id: v.id, impact: v.impact, help: v.help, nodes: v.nodes.map(n => n.target.join(' ')).slice(0, 5)})))"
   playwright-cli close
   ```
   If the page blocks the script (content security policy), say so and rely on the content checks. If `playwright-cli` isn't available, skip this step and say so. Ignore violations in the platform's own navigation and chrome; report them separately as platform issues, since the teacher can't fix them.
4. **Report** findings by severity: blockers (missing alt on informative images, no headings, unreadable tables), then improvements. For each: page, block path, problem, suggested fix.
5. **Fix what the teacher approves**: set `alt` attributes, change heading levels (`/h2/attributes/level`), turn bold paragraphs into headings (`replace` on `name`), rewrite link texts, set table header cells. Writing alt text needs the image's meaning in context; when you can't see or understand the image, ask the teacher rather than guess.
6. Summarise the changeset as the main skill describes and run the main skill's visual check on changed pages.

## Care

- Edit exercise names and task and review instructions with `patch_exercise` (see [exercises.md](../../references/exercises.md)). Everything else in an exercise can't be edited by agents; report problems there for the teacher.
- Don't add ARIA attributes or HTML the editor can't produce; the server rejects them.
