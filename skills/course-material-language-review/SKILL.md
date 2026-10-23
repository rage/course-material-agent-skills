---
name: course-material-language-review
description: Review and improve the language of courses.mooc.fi course material - plain language per ISO 24495-1, spelling, grammar and consistent terminology. Use when a teacher asks to proofread, simplify, make clearer, check spelling or unify terms in a courses.mooc.fi course, chapter or page, in any language.
---

# Language review of course material

This skill works with the `course-material` skill. Load that one too: it has the workflow, the tool rules and the `skill_version` to send on every call.

The goal is text that the course's readers can find, understand and use, as ISO 24495-1 (plain language) defines it. Review in the course's own language; don't translate.

## Steps

1. **Agree on the scope and depth.** Pages or chapters; spelling and grammar only, terminology, or a full plain-language edit. Ask who the readers are if it isn't obvious (the course settings list audiences).
2. **Read** the text blocks in raw mode. Note the course's existing terms and spelling conventions (for example "e-mail" or "email", Finnish compound conventions, British or American English) so you keep them consistent rather than impose your own.
3. **Review** against the checklist below. Collect findings per block: path, quote, problem, suggested text.
4. **Report** to the teacher grouped by kind: errors (spelling, grammar, wrong terms) first, then clarity suggestions. For a full rewrite of a passage, show before and after.
5. **Edit what the teacher approves.** Replace whole text attributes with `patch_page_content`; keep markup, links, `[latex]`, `\cite{}` and glossary terms intact. Use `find_replace` with `expected_count` for terminology changes across pages (dry run first, and handle inflected forms one by one).
6. Summarise the changeset as the main skill describes.

## Checklist (ISO 24495-1 principles)

**Relevant: readers get what they need.**
- The purpose of each page is clear early; the most important thing comes first.
- Nothing essential is missing; nothing is there only out of habit.

**Findable: readers can find what they need.**
- Headings say what follows, are in a logical order (no skipped levels) and work as a table of contents.
- Lists for steps and parallel items; tables for comparisons.

**Understandable: readers understand what they find.**
- Familiar words; technical terms explained on first use (or in the glossary) and used consistently. One term per concept.
- Mostly short sentences, one main idea each. Active voice and direct address where the course uses it.
- Concrete examples near abstract explanations.
- No unexplained abbreviations.

**Usable: readers can act on the information.**
- Instructions are numbered steps, in the order the reader does them.
- Links say where they go.

**Correctness**
- Spelling and grammar in the course language. Consistent spelling of names and terms.
- Numbers, units and dates written consistently.

## Care

- Keep the teacher's voice and the level of the course. Plain language isn't childish language.
- Don't change meaning. When unsure what the teacher meant, ask.
- Don't touch code samples, quoted material, LaTeX or citations.
- Edit exercise names and task and review instructions with `patch_exercise` (see [exercises.md](../../references/exercises.md)). Everything else in an exercise can't be edited by agents; report language issues there for the teacher.
