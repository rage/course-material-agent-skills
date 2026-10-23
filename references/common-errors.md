# Common errors

Errors from the server say what went wrong and usually show the correct form or list the valid choices. Read the error before retrying; don't repeat the same call.

| Error is about | Cause | Fix |
|---|---|---|
| `position` `start`/`end` with a block path | `start`/`end` need a children list | Use `/box1/innerBlocks` (or `""` for the page top level) instead of `/box1` |
| Numeric index or `-` in a path | Paths are id-based | Use the block's id and `position` |
| Unknown id | The id isn't on this page or in this course, or it came from another course or an old read | Re-read; check you passed the right `page` and `course` |
| Missing ids in an array replace | A list `replace` must mention every existing child | Add `{"clientId": "..."}` stubs for blocks to keep; `remove` the ones to delete in a separate op |
| Range not contiguous or reversed | `from`/`path` and `through` aren't siblings in order | Use the sibling list in the error to pick the right ends |
| Moving into itself | Target is inside the moved block or range | Pick a target outside it |
| Label reused, or used before it exists | Labels are per call and must be defined by an earlier op | Rename the label or reorder the ops |
| `replace` on an exercise | Exercises are read-only for agents | Use `move`, `copy` or `remove` for the block; `patch_exercise` for its name and instructions; tell the teacher to edit anything else in the editor |
| Block not allowed here (`not_allowed_here`, `invalid_nesting`) | Wrong page type or parent, or a block that depends on a course setting (chapter locking, chatbot) | Check the block's page types, allowed parents and required settings with `guide {"block_types": [...]}` |
| Unknown or forbidden block (`unknown_block`, `invalid_block`) | The block type doesn't exist or agents may not write it (`core/html`, `core/block`, exercise internals) | Use a block `guide` lists for the page type |
| Duplicate block id (`duplicate_client_id`) | Two blocks on the page would share a `clientId`, e.g. a copied block sent with its id | Leave `clientId` out of new blocks; use `copy` to duplicate |
| Invalid attribute (`invalid_attribute`, `forbidden_attribute`) | Unknown attribute, wrong type or value, or an attribute agents may not set (free-form `style`, `metadata`) | Check the attribute table in the block's file or `guide`; leave out defaults |
| Disallowed markup | Rich text contains markup the editor can't produce, possibly from before your edit | Rewrite the field with allowed markup only; see [rich-text.md](rich-text.md) |
| Read-only or derived field | `slug`, `language_code`, publish switches, `chapter_number`, `id`, ... | The error names the right op or says the teacher changes it in the web UI |
| Review ops on an exercise using the course default | Review instructions are shared; the call needs an explicit `review_config` | Pass `edit_course_default` (preferred) or `fork` to give only this exercise its own copy |
| Settings field in the structure tool | Settings live elsewhere | Use `patch_course_settings` |
| Path already in use | Two pages would share a `url_path` after the call | Pick another path, or swap both in one call |
| Module not empty | Only empty modules can be removed | Move or remove its chapters first (the error lists them) |
| Ambiguous match, several candidates | More than one course, page or block matches | Pick from the candidates in the error, or ask the teacher |
| `expected_count` mismatch | `find_replace` found a different number of matches | Run the search again and look at the matches before deciding |
| Validation service unavailable (retryable) | The platform's block validator is busy or starting | Wait a few seconds and retry the same call; nothing was stored |
| `publish_conflict` | Someone edited a page or entity live after you staged it; the error lists their ids | `discard_changeset {course, changeset, entities: [ids]}`, re-read the published state, redo your edit, publish again |
| Discard refused | Dropping those entities would break the rest of the changeset (e.g. a page left in a missing chapter) | Follow the error: drop the related entities too, or discard the whole changeset and redo the work |
| `staged_state_changed` (retryable) | Another call changed the staged state after this call read it, or the changeset was closed while the call ran | Re-read, then retry the call; nothing was stored |
| Publish refused: risky changes | The changeset has changes only the teacher can publish | Give the teacher the review link and a summary |
| Changeset expired | No writes for 14 days | The staged changes are gone; redo them if still wanted |
| Permission or scope missing | The teacher didn't grant that permission, or lacks the course role | Tell the teacher; they can sign in again and grant it, or do it in the web UI |
| Skill version below minimum | This skill is too old for the server | Update the skill (see SKILL.md), then retry |
| Tool "isn't available yet" | The server lists the tool but doesn't implement it yet | Do the task another way or tell the teacher; don't retry |
| Unsupported protocol version | The client speaks an older MCP version | Codex: rerun the setup script, which enables the newer protocol; Claude Code: update Claude Code |

## Authentication

- **Sign-in needed:** in Claude Code run `/mcp` and choose the server, or `claude mcp login <server>` in a terminal; in Codex run `codex mcp login <server>`. The browser opens the courses.mooc.fi sign-in.
- Access lasts while the teacher keeps using it; after about a month without use they sign in again.
