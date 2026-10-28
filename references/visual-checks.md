# Visual checks

If `playwright-cli` has its own skill installed, it covers the details; these commands are enough here.

```bash
playwright-cli open "<preview URL>"
playwright-cli console error              # render and script errors
playwright-cli requests                   # failed image and file loads (4xx/5xx)
playwright-cli snapshot                   # text structure: blocks, headings, link texts
playwright-cli eval "document.querySelectorAll('.katex-error').length"   # LaTeX errors
playwright-cli screenshot --filename=page-desktop.png
playwright-cli resize 390 844             # mobile, when layout matters
playwright-cli screenshot --filename=page-mobile.png
playwright-cli close
```

- Quote the URL: in PowerShell and cmd an unquoted `&` ends the command.
- Snapshots are cheap and exact for text and structure; screenshots are for layout, colour and images. Open each screenshot and look at it. A long page scales down until text is unreadable, so screenshot the changed element (`playwright-cli screenshot <ref>`) instead.
- Look for: missing or duplicated blocks, raw tags or `[latex]` shown as text, broken images, empty boxes, text overflowing its box, tables wider than a phone screen, and anything that differs from what you meant.
- Read exercises with `get_exercise`.
- Installing `playwright-cli` needs the teacher's consent and Node.js; with both, follow step 7 of AGENT-SETUP.md in the `course-material` skill folder.
- Codex's default sandbox may block network access, so the browser can't reach the preview. Codex asks for approval; tell the teacher why you need it.

## axe

```bash
playwright-cli open "<preview URL>"
playwright-cli eval "await new Promise((resolve, reject) => { const s = document.createElement('script'); s.src = 'https://cdn.jsdelivr.net/npm/axe-core@4.14.0/axe.min.js'; s.onload = resolve; s.onerror = reject; document.head.appendChild(s) })"
playwright-cli --raw eval "JSON.stringify((await axe.run()).violations.map(v => ({id: v.id, impact: v.impact, help: v.help, nodes: v.nodes.map(n => n.target.join(' ')).slice(0, 5)})))"
playwright-cli close
```

If the script is blocked (content security policy) or `playwright-cli` is missing, say so; never claim the page passed an automated check.
