# Tools

Every tool also takes an optional `skill_version`; always send the value from this skill's `VERSION` file. Ids (`course`, `page`, `changeset`, ...) are the UUIDs from read and write results. `?` marks optional arguments.

Read tools are read-only and safe to retry or run in parallel. Write tools stage changes; nothing they do is visible to students until the changeset is published.

## Permissions

The teacher chooses at sign-in what the agent may do. Tools outside those permissions aren't listed.

| Permission | Covers |
|---|---|
| `material:read` | every read tool (including `get_exercise`), `guide`, `get_preview_link`, `list_changesets`, `get_history`, and `find_replace` without `replace` (search only) |
| `material:stage` | the patch tools except settings, `find_replace` with `replace`, `structural_replace`, `upload_file`, `discard_changeset`, `revert_change` |
| `material:publish` | `publish_changeset` |
| `settings:write` | `patch_course_settings` |

## Finding things

### `list_courses {}`

Lists the courses the teacher can edit: id, name, slug, language, `is_draft`, `is_test_mode` and organisation. Start here when you don't have a course id. Several courses can share a name across organisations or languages; ask the teacher when unsure.

### `get_course_structure {course, selectors?}`

The course tree: top-level pages, modules, chapters and their pages, with titles, paths, `hidden`, chapter dates, block and exercise counts and whether a page has submissions. See [course-structure.md](course-structure.md) for the shape and [reading.md](reading.md) for selectors.

### `get_page_content {course, page, selectors?}`

A page's blocks. Start with `mode: "outline"` (ids, types, short previews), then fetch full JSON with `mode: "raw"` for the blocks you need. See [reading.md](reading.md).

### `get_exercise {course, exercise, selectors?}`

An exercise's name, page, tasks (with `/tasks/<task id>` paths), review status (`reviews`: needs peer or self review, whether it uses the course default review config or its own) and read-only settings. `exercise` is the `exercise_id` of an exercise block. Selectors start at `/tasks/<task id>` or `/review_instructions`. See [exercises.md](exercises.md).

### `get_course_settings {course}`

Course settings and each module's completion and certificate settings. See [course-settings.md](course-settings.md).

### `get_course_glossary_and_references {course}`

Glossary terms and BibTeX references with their ids. See [glossary-and-references.md](glossary-and-references.md).

### `guide {block_types?, topics?}`

Current guidance from the server.

- `block_types`: for example `["core/paragraph", "moocfi/infobox"]`. Returns each block's schema, an annotated example, nesting rules and allowed rich-text formats.
- Without arguments: the block types allowed on each page type.
- `topics`: any of `editing`, `course-structure`, `publishing-and-risk`, `previews-and-checks`, `citations-and-glossary`, `rich-text`, `exercises`.

Call it for a block type before you create or change that type for the first time in a session: `{"block_types": ["moocfi/infobox"]}`.

## Changing content

The patch tools take `ops`: a list of JSON-Patch-style operations applied in order, all or nothing. Op fields are `op`, `path`, `from`, `through`, `value`, `position`, `to_page`, `label` and `at_text`. `dry_run: true` stages nothing and returns the full before/after diff.

### `patch_page_content {course, page, ops, dry_run?, read_back?}`

Adds, replaces, moves, copies, removes, wraps, unwraps, splits and merges blocks, and sets attributes at any depth. Can move or copy blocks to another page with `to_page`. Doesn't change page title, path or visibility; that is `patch_course_structure`. `read_back` is a selector run on the result. See [page-content.md](page-content.md).

### `patch_course_structure {course, ops, dry_run?, read_back?}`

Creates, moves, copies, reorders, renames and removes modules, chapters and pages; sets page titles, paths and `hidden`; sets chapter names, colours, opening times and deadlines. A new page can carry its `blocks`. See [course-structure.md](course-structure.md).

### `patch_exercise {course, exercise, name?, ops?, review_config?, dry_run?}`

Edits an exercise's name, task instructions and review instructions; everything else about an exercise is read-only. `ops` are page-content ops with paths starting at `/tasks/<task id>` or `/review_instructions`. `review_config` (`edit_course_default`, `fork`, `use_course_default`) says which review settings the review ops change. No `read_back`; read again with `get_exercise`. See [exercises.md](exercises.md).

### `patch_course_settings {course, ops, dry_run?}`

Course name, description, listing, AI policy, audiences, chapter locking; module completion policies and certificates. Needs `settings:write`, which teachers may not have granted. No `read_back`; read again with `get_course_settings`. See [course-settings.md](course-settings.md).

### `patch_course_glossary_and_references {course, ops, dry_run?}`

Adds, changes and removes glossary terms and BibTeX references. Renaming a citation key rewrites the citations in page content. No `read_back`; read again with `get_course_glossary_and_references`. See [glossary-and-references.md](glossary-and-references.md).

### `find_replace {course, scope?, find, replace?, regex?, attributes?, include_exercise_instructions?, include_exercise_names?, expected_count?, dry_run?}`

Searches text attributes in the course, a chapter or a page, and optionally replaces matches. `scope` is `{"chapter": "<id>"}` or `{"page": "<id>"}`; leave it out for the whole course. Without `replace` it only searches. Always dry-run a replacement first and pass `expected_count`. See [find-and-replace.md](find-and-replace.md).

### `structural_replace {course, scope?, match, action, include_exercise_instructions?, expected_count?, dry_run?}`

Finds blocks by type and text and acts on each one.

- `match`: any of `name`, `text_starts_with`, `text_contains`, `text_regex`
- `action`: exactly one of `wrap_in` (block type), `retype_to` (block type), `unwrap: true`, `remove: true`

See [find-and-replace.md](find-and-replace.md).

### `upload_file {course, file_name, content_base64}`

Uploads an image or other file for the course and returns its URL. `file_name` includes the extension (`diagram.png`); `content_base64` is the file's bytes, base64-encoded. Put the URL in an image or file block attribute (`url`, `href`). Give images an `alt` text.

## Changesets, previews and history

### `list_changesets {course?}`

Your open changesets with their ids, the pages and entities they touch, which changes are risky, expiry, and review links.

### `publish_changeset {course, changeset}`

Publishes a changeset (id from `list_changesets` or a write result). Refused when the changeset contains risky changes (the result has the review link for the teacher) or when something it touches changed live after you staged it: the `publish_conflict` error lists the conflicting entity ids; drop them with `discard_changeset` and `entities`, re-read, redo the edit and publish again.

### `discard_changeset {course, changeset, entities?}`

Drops a changeset and everything in it, or with `entities` (page, chapter, module, glossary term or reference ids) only those entities' staged changes. This is the undo before publishing. If dropping the given entities would leave the rest inconsistent (for example a page in a missing chapter), nothing is dropped and the error says why. Ask the teacher before discarding work they haven't seen.

### `get_preview_link {course, page}`

A read-only link to one page's staged version, valid about 15 minutes, no login needed. Use it for visual checks. See [visual-checks.md](visual-checks.md).

### `get_history {course, entity?, limit?}`

Recent write calls in the course: who, when, through which client, which changeset, and the call id. `entity` (a page, chapter, module, glossary term or reference id) narrows it to one entity.

### `revert_change {course, call, dry_run?}`

Undoes one write call (`call` is its id from `get_history`) by restoring every entity it touched to the version before it. Rejected if an entity changed again afterwards; the error lists them. The revert is itself a change and stages like any other.
