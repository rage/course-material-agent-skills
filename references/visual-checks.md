# Visual checks

The server doesn't render screenshots. You check staged pages with your own browser tooling, normally `playwright-cli`. Results say when staged pages haven't been checked yet.

## Preview links

- `get_preview_link {course, page}` returns a link to one page's staged version. It needs no login, is read-only, and expires in about 15 minutes. Ask for a new one when it expires.
- The preview shows the page on its own: no chapter navigation, and exercises appear as read-only placeholders. Check exercises by their position and title, not their contents.
- The link gives anyone who has it a short look at unpublished content. Don't put it in files, commits or messages that outlive the session.

## With playwright-cli

Check that the tool exists first: `playwright-cli --version`. If its own skill is installed, follow that for details; the commands below are enough for these checks.

```bash
playwright-cli open "<preview URL>"
playwright-cli console error              # render and script errors
playwright-cli requests                   # failed image and file loads (4xx/5xx)
playwright-cli snapshot                   # text structure: blocks present, headings, link texts
playwright-cli eval "document.querySelectorAll('.katex-error').length"   # LaTeX errors
playwright-cli screenshot --filename=page-desktop.png
playwright-cli resize 390 844
playwright-cli screenshot --filename=page-mobile.png
playwright-cli close
```

- Quote the URL. In PowerShell and cmd an unquoted `&` ends the command.
- Open each screenshot and look at it. A long page is scaled down until text is unreadable; screenshot the changed parts (`playwright-cli screenshot <ref>` for one element) instead of the whole page.
- Look for: missing or duplicated blocks, raw HTML tags or `[latex]` shown as text, broken images, empty boxes, text running out of its box, tables wider than the screen on mobile, and anything that differs from what you meant.
- Snapshots are cheaper than screenshots and exact for text and structure; screenshots are for layout, colour and images.
- Close the browser when done.

For the accessibility part, see the accessibility review skill in `skills/course-material-accessibility-review/`.

## Without playwright-cli

Use any browser tool you have (another browser automation tool, a browser MCP server). If you have none:

- Don't install anything without the teacher's consent. Installing is `npm install -g @playwright/cli@latest`, which needs Node.js.
- Tell the teacher the visual check wasn't done and give them the preview link to open themselves, with what to look for.

## Codex sandbox

In Codex's default sandbox, network access may be off, so the browser can't reach the preview. Codex asks for approval when a command needs the network; tell the teacher why you need it.
