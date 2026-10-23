# Rich text

Text attributes such as `core/paragraph` `content`, heading text, list items, table cells and captions are stored as an HTML string. You write that string directly; there is no Markdown conversion.

## Allowed markup

Only what a teacher can produce with the editor's toolbar and shortcuts, in exactly the form the editor stores it:

| Format | Stored as |
|---|---|
| Bold | `<strong>…</strong>` |
| Italic | `<em>…</em>` |
| Link | `<a href="https://…">…</a>`; to open in a new tab: `<a href="https://…" target="_blank" rel="noopener">…</a>`; nofollow: `rel="nofollow"` (or `"noopener nofollow"` with `target="_blank"`) |
| Inline code | `<code>…</code>` |
| Strikethrough | `<s>…</s>` |
| Underline | `<span style="text-decoration: underline;">…</span>` |
| Text colour | `<mark style="background-color:rgba(0, 0, 0, 0)" class="has-inline-color has-vivid-red-color">…</mark>` with a palette colour, or `<mark style="background-color:rgba(0, 0, 0, 0);color:#123456" class="has-inline-color">…</mark>`; a highlight replaces `rgba(0, 0, 0, 0)` with a `#rrggbb` colour |
| Subscript, superscript | `<sub>…</sub>`, `<sup>…</sup>` |
| Keyboard key | `<kbd>…</kbd>` |
| Other language | `<bdo lang="fi" dir="ltr">…</bdo>` |
| Inline math | `<math data-latex="x^2"></math>`; leave the element empty, the MathML is generated from `data-latex` |
| Line break | `<br>` |

Some fields allow fewer formats: button text and file block texts can't contain links. The per-attribute list comes from `guide` (the `x-rich-text-formats` of the attribute).

Not allowed, and rejected: `<b>`, `<i>`, `<p>`, `<div>`, headings inside text, `<script>`, event attributes (`onclick`), `style` or `class` values other than the ones above, inline images, and anything else the toolbar can't produce. Use `<strong>` and `<em>`, never `<b>` and `<i>`. Don't convey meaning with colour alone.

Validation is strict for the whole field you write, including markup that was there before your edit. If an error names disallowed markup in text you didn't touch, clean it up as part of your edit and mention it to the teacher.

## Normalisation

The server stores the canonical form the editor would produce: attribute order, entities and whitespace are normalised (`&` is stored as `&amp;`). A pure normalisation is accepted silently. If normalising would change the meaning (drop a tag or text), the write is rejected. Read the block back to see the stored form; it is what `find_replace` matches.

## Text conventions the renderer adds

These are plain text in the stored content, not markup:

- **Inline LaTeX:** `[latex]x^2 + y^2[/latex]` in paragraphs, list items, quotes, table cells, captions and similar text. Inside, only `&amp;` is decoded. For a display formula, use a `moocfi/latex` block with the LaTeX source as plain text, without the tags.
- **`[latex]` or `<math>`:** existing course text uses `[latex]`, which renders with KaTeX like the rest of the course. Inline `<math>` renders as the browser's MathML and can look different; keep to the convention the page already uses.
- **Citations:** `\cite{key}` or `\cite[pre][post]{key}`, with a key from the course references. See [glossary-and-references.md](glossary-and-references.md).
- **Glossary terms** are highlighted automatically; don't mark them.

Headings, preformatted text, verse, pullquotes and code blocks don't render LaTeX or glossary highlights.

## Fields that are plain text

Some fields look like rich text but render as plain text: hero section `label`, course objective section `title`, terminology block `blockName`, expandable section `name`, `moocfi/latex` `text`. Write plain text there. Button text and file block text can't contain links.

## Writing tips

- Keep the teacher's language and terminology. Don't translate unless asked.
- Use proper typography for the language (for example Finnish quotation marks ” ” and a non-breaking space where the course already uses them), but don't change it across a course unasked.
- Link text should say where the link goes; never "click here".
