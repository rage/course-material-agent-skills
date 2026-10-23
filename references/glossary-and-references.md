# Glossary and references

`get_course_glossary_and_references {course}` returns two unordered lists, `/glossary` and `/references`, with an id on every item. `patch_course_glossary_and_references {course, ops, dry_run?}` changes them with the usual ops: `add` (no `position`), `replace` on a field, `remove`. It has `dry_run` but no `read_back`; read again to check.

Fields: glossary terms have `term` and `definition`; references have `citation_key` and `bibtex`.

## Glossary

Glossary terms are highlighted automatically wherever the term appears in page text, as a whole word, outside links. You don't mark terms in the content.

```json
{"op":"add","path":"/glossary","value":{"term":"variable","definition":"A named place that stores a value."}}
{"op":"replace","path":"/g4/definition","value":"..."}
{"op":"remove","path":"/g4"}
```

Renaming or removing a term doesn't change page content; the highlight follows the new term or disappears. The result lists the pages that use the term, so you can check them.

## References and citations

A reference is a BibTeX entry with a citation key. Pages cite it in text as `\cite{key}`, optionally `\cite[pre][post]{key}`.

```json
{"op":"add","path":"/references","value":{"citation_key":"knuth1997","bibtex":"@book{knuth1997, author = {Donald E. Knuth}, title = {The Art of Computer Programming}, year = {1997}, publisher = {Addison-Wesley}}"}}
```

- The BibTeX must be well-formed, the key must be unique in the course, and it must match the entry's own key. The server checks structure only; the course pages render citations with a stricter parser, so keep entries to standard BibTeX and check a citing page in the preview.
- Renaming a key rewrites its `\cite{...}` uses in page content, in the same changeset.
- Removing a reference leaves its citations as they are; the result lists the pages that still cite it. Fix or remove those citations, or tell the teacher.

`guide {"topics": ["citations-and-glossary"]}` covers the topic.
