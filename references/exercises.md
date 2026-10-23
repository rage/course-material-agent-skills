# Exercises

Agents edit an exercise's name, its task instructions and its peer and self review instructions. Everything else about an exercise is read-only: questions, answers, grading, task specs, points, tries, deadlines and review thresholds. The teacher edits those in the editor. Name and instruction edits are never risky.

An exercise block on a page holds only the exercise id (`exercise_id` in reads). Moving, copying and removing the block is done with `patch_page_content`; see [page-content.md](page-content.md).

## Reading: `get_exercise {course, exercise, selectors?}`

Returns the exercise `name`, its `page`, its `tasks` (each with a `/tasks/<task id>` path), `reviews` and the read-only settings. `reviews` has `needs_peer_review`, `needs_self_review`, `config` and `path`:

| `config` | Meaning |
|---|---|
| `course_default` | The exercise uses the course's default review config, shared with other exercises |
| `own` | The exercise has its own copy |
| `unset` | The exercise has no review config |

Without `selectors` you get an outline of each task's instructions and of the review instructions. Fetch the blocks you will change with selectors like those of `get_page_content`, with paths starting at `/tasks/<task id>` or `/review_instructions` (see [reading.md](reading.md)).

## Editing: `patch_exercise {course, exercise, name?, ops?, review_config?, dry_run?}`

```json
{"course":"c1","exercise":"ex1","name":"Loops: sum of numbers"}
{"course":"c1","exercise":"ex1","ops":[{"op":"replace","path":"/tasks/t1/b7/attributes/content","value":"Write a program that ..."}],"dry_run":true}
{"course":"c1","exercise":"ex1","review_config":"edit_course_default","ops":[{"op":"replace","path":"/review_instructions/b2/attributes/content","value":"Check that ..."}]}
```

- `name` is one line of plain text.
- `ops` are the page-content ops of [page-content.md](page-content.md), applied to the blocks of one task's instructions (paths start at `/tasks/<task id>`) or of the review instructions (paths start at `/review_instructions`). `to_page` isn't available. There is no `read_back`; read the exercise again with `get_exercise`.
- Instructions take the blocks the editor allows there; `guide` checks them. Exercise blocks can't be nested in them.
- `dry_run: true` stages nothing and returns the diff.

### Review instructions and the course default

Most exercises use the course default review config, so its instructions are shared. Editing review instructions of such an exercise needs an explicit `review_config`:

| `review_config` | Effect |
|---|---|
| `edit_course_default` | The review ops edit the course default, for every exercise that uses it. **Prefer this.** |
| `fork` | The exercise gets its own copy of the default settings and questions; the review ops edit the copy. Use it only when the exercise has needs that differ from the other exercises in the course. |
| `use_course_default` | The exercise drops its own copy and uses the course default again. The result lists what it drops. |

Review instructions show only for exercises with peer or self reviews. Task instruction edits need no `review_config`.

Forking or un-forking an exercise that already has reviews hides those reviews from students. The tool warns about it; tell the teacher before they publish.

When you edit the course default, tell the teacher which exercises it affects.

## Bulk edits

`find_replace` searches and replaces in task and review instructions by default (`include_exercise_instructions`, default `true`), and in exercise names with `include_exercise_names` (default `false`). `structural_replace` also includes instructions unless `include_exercise_instructions` is `false`. A match in the course default review instructions is edited once and listed under it in the result; it changes every exercise that uses the default. Bulk tools never fork. See [find-and-replace.md](find-and-replace.md).
