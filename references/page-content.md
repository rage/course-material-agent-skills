# Page content ops

`patch_page_content {course, page, ops, dry_run?, read_back?}` edits one page's block tree. The page must belong to `course`. Ops apply in order on a staged copy; the whole call commits or nothing does.

`p1`, `h2`, `box1`, `pg2` etc. stand for full UUIDs from a read.

## Addressing

- A path starts with the id of a block anywhere on the page, with no parent chain: `/p5`, `/p1/attributes/content`, `/h2/attributes/level`.
- Children lists are paths too: `/box1/innerBlocks`. The page's top level is `""`.
- Numeric array indexes and `-` are rejected. To place something, use `position`.
- Where an id is expected outside a path (`to_page`), both `pg7` and `/pg7` work.

## Placement

`add`, `move` and `copy` need `position`:

- `before` / `after`: `path` names an existing sibling.
- `start` / `end`: `path` names a children list (`""`, `/box1/innerBlocks`), never a block.

## New blocks

- Send new blocks without `clientId`; the server assigns ids and returns them in op order.
- `"label": "$name"` inside a new value lets later ops in the same call use `/$name`. `copy` has no value, so its `label` goes on the op. Labels don't survive the call.
- `add` takes one value or a list, inserted in order.
- Leave out attributes that should keep their default. Block schemas: `guide`.

## Examples

| Edit | Op(s) |
|---|---|
| Insert before or after a block | `{"op":"add","path":"/p2","position":"before","value":{"name":"core/heading","attributes":{"level":2,"content":"Loops"}}}` |
| Insert at the start or end of the page or a container | `{"op":"add","path":"","position":"end","value":{...}}`, `{"op":"add","path":"/col1/innerBlocks","position":"start","value":{...}}` |
| Insert several blocks in order | `{"op":"add","path":"/p1","position":"after","value":[{...A},{...B},{...C}]}` |
| Insert a container, then fill it | `[{"op":"add","path":"","position":"end","value":{"label":"$box","name":"moocfi/infobox","innerBlocks":[]}},{"op":"add","path":"/$box/innerBlocks","position":"end","value":[{...},{...}]}]` |
| Replace a block, keeping its id | `{"op":"replace","path":"/p2","value":{"name":"core/paragraph","attributes":{"content":"Rewritten."}}}` |
| Replace one block with several | `[{"op":"add","path":"/p2","position":"after","value":[{...},{...}]},{"op":"remove","path":"/p2"}]` |
| Remove a block or a range | `{"op":"remove","path":"/p4"}`, `{"op":"remove","path":"/p5","through":"/p9"}` |
| Move a block or range | `{"op":"move","from":"/p4","path":"/h2","position":"after"}`, `{"op":"move","from":"/p5","through":"/p9","path":"/h2","position":"before"}` |
| Move into a container | `{"op":"move","from":"/p4","path":"/box1/innerBlocks","position":"end"}` |
| Move to another page | `{"op":"move","from":"/p5","through":"/p9","to_page":"pg2","path":"/h1","position":"after"}` |
| Copy (new ids), here or to another page | `{"op":"copy","from":"/box1","path":"/box1","position":"after"}`, `{"op":"copy","from":"/p5","through":"/p9","to_page":"pg2","path":"","position":"end"}` |
| Set an attribute, including text | `{"op":"replace","path":"/h2/attributes/level","value":3}`, `{"op":"replace","path":"/p1/attributes/content","value":"Use <code>for</code> to <em>iterate</em>."}` |
| Remove an attribute | `{"op":"remove","path":"/h2/attributes/anchor"}` |
| Change a block's type | `{"op":"replace","path":"/p3/name","value":"core/heading"}` (attributes are validated for the new type) |
| Wrap a run of siblings | `{"op":"wrap","path":"/p5","through":"/p6","value":{"name":"moocfi/infobox"}}` |
| Unwrap a container | `{"op":"unwrap","path":"/box1"}` |
| Split a text block | `{"op":"split","path":"/p7","at_text":"However,"}` |
| Merge two text blocks (p8 into p7) | `{"op":"merge","from":"/p8","path":"/p7"}` |
| Replace a container's children | `{"op":"replace","path":"/box1/innerBlocks","value":[{"clientId":"c2"},{"name":"core/paragraph","attributes":{"content":"New"}},{"clientId":"c1"}]}` |
| Replace the whole page | `{"op":"replace","path":"","value":[{"clientId":"h1"},{...}]}` |
| Move an exercise | `{"op":"move","from":"/ex1","path":"","position":"end"}` |

## Replacing a list of blocks

When the value of a `replace` is a list (a container's children or the whole page):

- A block with its `clientId` and content replaces that block and keeps its id.
- A bare `{"clientId": "..."}` keeps that block unchanged.
- A block without an id is new.
- An id that isn't on the page is an error listing the unknown ids.
- Leaving out an existing block is an error listing the missing ids. Delete with an explicit `remove`.

Whole-page replace can undo someone else's concurrent edit. Prefer targeted ops.

## Ranges

`through` names the last block of a run of siblings, included. The run must be contiguous siblings under one parent; otherwise the error lists the actual siblings.

## Exercises

- An exercise block on the page is just `{"name": "moocfi/exercise", "attributes": {"id": "..."}, "innerBlocks": []}`; its slides and tasks live elsewhere.
- `moocfi/exercise` blocks stay at the top level of the page. They can't be wrapped or nested.
- They can be moved (within the page or to another page), copied and removed. `replace` on an exercise block or anything inside it is rejected. To edit an exercise's name or instructions, use `patch_exercise`; see [exercises.md](exercises.md).
- Moving an exercise keeps its submissions and student progress. Copying creates a new exercise with no submissions.
- Removing an exercise that has submissions is a risky change; only the teacher can publish it.
- Exercises aren't allowed on top-level pages.

## Moving and copying between pages

- Both pages change in the same call and the same changeset.
- `move` keeps every block id, so feedback attached to a block follows it. `copy` assigns new ids.
- The target page type is checked (for example, no exercises on top-level pages). Page types are `course-page`, `chapter-front-page`, `top-level-page` and `course-front-page` (the page at `/`); `guide` lists the blocks allowed on each.

## Results

Created ids in op order, the label map, warnings, changed paths, and links that pointed at moved content. With `dry_run: true` nothing is staged and the result has the full before/after diff.
