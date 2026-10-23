# Staging, publishing and risk

## Everything stages

- Every write, in every course state (draft, test mode, hidden or live) and through every tool, goes into your **open changeset** for that course. There is one open changeset per teacher per course; it collects all your unpublished changes across calls.
- Reads show the staged state by default, so later edits build on earlier staged ones. `state: "published"` shows what students see.
- Changesets belong to the teacher who made them. Another teacher's edits publish independently.
- A changeset expires 14 days after its last write. Results and the review page warn a few days before.

## Publishing

- `publish_changeset {course, changeset}` publishes the whole changeset; the id comes from the write result or `list_changesets`. It needs the `material:publish` permission.
- It is **refused when the changeset holds risky changes**. Those are published by the teacher on the review page; the result gives the link. Give the link to the teacher with a short summary of what's risky and why.
- The review page accepts any changeset, so a teacher who didn't grant `material:publish` publishes everything there. The teacher publishes exactly the revision they reviewed: if you stage more changes while they have the page open, they must look again before publishing. Tell the teacher when you add to a changeset they're reviewing.
- Publishing applies the changeset onto the current live version. If a page or entity it touches changed live after you staged it (for example the teacher edited the page in the editor), the publish is rejected with a `publish_conflict` error that lists the conflicting entity ids. Then call `discard_changeset {course, changeset, entities: [ids]}` with the ids from the `publish_conflict` error to drop only those entities, re-read their published state, redo your edit on top of it, and publish again. If dropping those entities would break the rest of the changeset (for example a staged page would be left in a chapter that no longer exists), nothing is dropped and the error says why; resolve that first, or discard the whole changeset and redo the work. Tell the teacher what happened.

## What is risky

Only these changes in **live content** need the teacher's confirmation:

- removing an exercise block that has submissions, or removing or replacing a page or chapter that contains one
- removing a page or chapter that isn't hidden
- moving a deadline earlier, or adding a deadline to a chapter that is already open
- moving an opening time later on a chapter that is already open
- changing a completion policy or the module completion requirement after students have completed the course
- turning chapter locking on or off

Not risky: moving exercises (their submissions follow), removing blocks that feedback points at, unhiding pages, and large changes. Size alone never makes a change risky.

Draft courses, test-mode courses, hidden pages and chapters that haven't opened aren't live content, so nothing there is risky.

## Undo

- **Before publishing:** `discard_changeset {course, changeset}` drops the whole changeset; with `entities: [ids]` it drops only those pages or entities. To undo part of an entity's changes, make the opposite change (re-add, move back) in a new call.
- **After publishing:** `get_history {course, entity?}` lists recent changes; each write call is one entry with a call id. `revert_change {course, call}` restores everything one call touched to the version before it. It is rejected if those entities changed again later; the error lists them. A revert is a change like any other: it stages, and the risk rules apply.

## Summarising a changeset for the teacher

Before publishing or handing over, tell the teacher:

- which pages, chapters, settings or glossary items changed, and in one sentence each, what changed
- what is risky and its consequence, quoting the server's reason
- redirects created and links that point at moved content
- what you checked (preview, links, accessibility) and what you couldn't check
- the review link, when the teacher has to publish
