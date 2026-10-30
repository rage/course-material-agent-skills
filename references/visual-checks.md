# Visual checks

If `playwright-cli` has its own skill installed, it covers the details; these commands are enough here.

```bash
playwright-cli open "<preview URL>"
playwright-cli console error              # render and script errors
playwright-cli requests                   # failed image and file loads (4xx/5xx)
playwright-cli snapshot                   # text structure: blocks, headings, link texts
playwright-cli eval "document.querySelectorAll('.katex-error').length"   # LaTeX errors
playwright-cli screenshot <ref> --filename=table.png   # each new or moved block, cropped at full size
playwright-cli screenshot --full-page --filename=page.png   # whole page, only under about 1500 px tall
playwright-cli resize 390 844             # phone width, for tables, columns and images
playwright-cli screenshot <ref> --filename=table-mobile.png
playwright-cli close
```

- `get_preview_link` without `page` gives one link for the whole changeset; its page lists the changed pages, so open it once and move between them. In a review, keep one browser session: `open` the first preview, `goto` the next, and run the console, requests and anchor checks on each page in that visit; axe likewise in its own session (**axe**). Screenshots and the mobile pair only for pages with new or moved layout blocks (images, tables, columns).
- Quote the URL: in PowerShell and cmd an unquoted `&` ends the command.
- Snapshots are cheap and exact for text and structure; screenshots are for layout, colour and images. Open each screenshot and look at it. Screenshot blocks, not the viewport: a viewport shot is mostly margin, and a long page scales down until text is unreadable. Take the ref from `snapshot`; no scrolling needed.
- Read the page's own title and headings from `snapshot`, not the first `h1`: the preview adds its own banner. Check that heading levels don't skip (an H3 straight under the title) after blocks moved or were removed.
- Look for: missing or duplicated blocks, raw tags or `[latex]` shown as text, broken images, empty boxes, text overflowing its box, tables wider than a phone screen, and anything that differs from what you meant.
- Something you put down to the preview (a failed request, an empty block or heading) stays a finding: after publishing, check it on the live page; if you can't, hand it over as unchecked.
- Report what each check covered: which pages, and which of console, requests, snapshot, screenshot and axe ran on each. Never extend a result to pages you didn't open, and keep errors seen earlier: a page that logged an error is not "no console errors" because a later run counted none.
- Installing `playwright-cli` needs the teacher's consent and Node.js; with both, follow AGENT-SETUP.md **Browser checks** in the `course-material` skill folder.
- Codex's default sandbox may block network access, so the browser can't reach the preview. Codex asks for approval; tell the teacher why you need it.

## axe

Run axe in its own browser session: it needs the page's content security policy bypassed, which would hide policy errors from the console check. Write `{"browser":{"contextOptions":{"bypassCSP":true}}}` to `axe.json` in a work folder, then:

```bash
playwright-cli -s=axe open --config=<work folder>/axe.json "<preview URL>"
playwright-cli -s=axe --raw run-code "async page => { await page.waitForLoadState('networkidle'); if (!await page.evaluate(() => 'axe' in window)) await page.addScriptTag({ url: 'https://cdn.jsdelivr.net/npm/axe-core@4.14.0/axe.min.js' }); return await page.evaluate(async () => JSON.stringify((await axe.run()).violations.map(v => ({id: v.id, impact: v.impact, help: v.help, nodes: v.nodes.map(n => n.target.join(' ')).slice(0, 5)})))) }"
playwright-cli -s=axe goto "<next preview URL>"   # then run-code again
playwright-cli -s=axe close
```

`[]` means no violations. The wait matters: run before the page settles, axe reports half-rendered content. If the script doesn't load or `playwright-cli` is missing, say so; never claim the page passed an automated check.
