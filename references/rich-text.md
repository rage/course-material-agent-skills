# Text conventions

Allowed markup comes from `guide` (`rich_text_formats`, and `x-rich-text-formats` per attribute). These are plain text that the renderer interprets:

- **Inline LaTeX**: `[latex]x^2 + y^2[/latex]` in paragraphs, list items, quotes, table cells and captions. Inside, only `&amp;` is decoded. A display formula goes in a `moocfi/latex` block as plain LaTeX without the tags.
- **`[latex]` or `<math>`**: course text uses `[latex]`, rendered with KaTeX like the rest of the course; inline `<math>` renders as browser MathML and looks different. Keep the page's convention, also where the `guide` rich-text topic suggests the editor's math format.
- Headings, preformatted text, verse, pullquotes and code blocks render neither LaTeX nor glossary highlights.
- **Plain-text fields that look like rich text**: hero section `label`, course objective section `title`, terminology block `blockName`, expandable section `name`, `moocfi/latex` `text`. Write no markup there.
