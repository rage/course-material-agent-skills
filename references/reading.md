# Reading pages and the course tree

`get_page_content`, `get_course_structure` and the `read_back` argument of the patch tools share one set of selectors. Pass one selector object or a list of them.

## Selectors

| Selector | Meaning | Example |
|---|---|---|
| `path` | A block or entity, one of its attributes or fields, or a children list. `""` is the page's top level. | `{"path": "/p7"}`, `{"path": "/p7/attributes/content"}`, `{"path": "/box1/innerBlocks"}`, `{"path": "/ch3"}` |
| `through` | With `path`: a run of siblings from `path` to `through`, both included | `{"path": "/p5", "through": "/p9"}` |
| `around` | With `path`: n siblings before and after the block | `{"path": "/p7", "around": 2}` |
| `offset` / `limit` | A window over a children list | `{"path": "", "offset": 40, "limit": 20}` |
| `mode` | `outline` (ids, types, short text previews) or `raw` (full stored JSON) | `{"path": "", "mode": "outline"}` |
| `state` | `staged` (default: includes changes waiting to be published) or `published` (what students see). Not allowed in `read_back`. | `{"path": "", "state": "published"}` |

`p7`, `box1`, `ch3` stand for the full UUIDs you got from an earlier read.

## Results

- Every block has its `clientId` and every structure entity its `id`, plus a ready-made `path` to use in ops.
- `total` is the length of the children list; `has_more` and `next` continue a paged read. `next` is a selector anchored on an id; pass it back as is.
- Results stay within a size budget. The server returns whole blocks and stops with `has_more` rather than cutting a block in half.
- In staged reads, blocks and entities with unpublished changes are marked.
- There is no version or hash to send back with writes.

## Good habits

- Outline first, raw only where you edit. A long page in raw mode costs many tokens.
- Re-read after a failed write before retrying; the error may mean the page changed.
- Ids are stable: a block keeps its `clientId` when moved, even to another page. Copies get new ids.
- Text in reads is exactly the stored form (normalised HTML), so it is what `find_replace` matches.
- Use `read_back` on a write instead of a separate read when you want to see the result. Labels from the same call work there: `{"path": "/$box"}`.
