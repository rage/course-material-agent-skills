# Course structure

`get_course_structure {course, selectors?}` returns the course tree; `patch_course_structure {course, ops, dry_run?, read_back?}` changes it. Course and module settings aren't in this tree; see [course-settings.md](course-settings.md).

## Model

```json
{
  "course": {
    "id": "c1",
    "pages": [
      {"id": "pg0", "title": "Ohjelmoinnin perusteet", "url_path": "/", "hidden": false, "block_count": 4, "exercise_count": 0},
      {"id": "pg40", "title": "FAQ", "url_path": "/faq", "hidden": false, "block_count": 12, "exercise_count": 0}
    ],
    "modules": [
      {"id": "m1", "default": true, "name": null,
       "chapters": [
         {"id": "ch1", "chapter_number": 1, "name": "Basics", "color": null,
          "opens_at": null, "deadline": "2026-12-01T21:59:00Z",
          "pages": [
            {"id": "pg1", "title": "Basics", "url_path": "/chapter-1", "hidden": false, "block_count": 6, "exercise_count": 0},
            {"id": "pg2", "title": "Variables", "url_path": "/chapter-1/variables", "hidden": false, "block_count": 31, "exercise_count": 3, "has_submissions": true}
          ]}
       ]},
      {"id": "m2", "default": false, "name": "Advanced", "chapters": []}
    ]
  }
}
```

- A course has top-level pages (`/course/pages`) and modules (`/course/modules`). Modules hold chapters; chapters hold pages.
- Children lists are in display order. Order and parent are expressed only by position; `chapter_number` and similar fields are derived and read-only.
- The first page of a chapter is its front page. The course front page (`url_path` `/`) is first in `/course/pages`.
- The default module comes first and has `name: null`. Other modules must have a name.
- `block_count`, `exercise_count` and `has_submissions` help you judge risk. They aren't student data.

## Addressing

Paths start at an entity id: `/m2/name`, `/ch3/deadline`, `/pg7/title`, `/ch3/pages`, `/m2/chapters`, `/course/modules`, `/course/pages`. Placement uses `position` as in page ops: `before`/`after` a sibling, `start`/`end` of a children list.

## Examples

| Edit | Op(s) |
|---|---|
| Set a field | `{"op":"replace","path":"/m2/name","value":"Advanced topics"}`; likewise `/ch3/name`, `/ch3/deadline`, `/ch3/color`, `/pg7/title`, `/pg7/url_path`, `/pg7/hidden` |
| Clear a nullable field | `{"op":"remove","path":"/ch3/deadline"}` |
| Add a module | `{"op":"add","path":"/course/modules","position":"end","value":{"name":"Advanced"}}`, `{"op":"add","path":"/m2","position":"after","value":{"name":"Project"}}` |
| Delete an empty module | `{"op":"remove","path":"/m3"}` |
| Add a chapter | `{"op":"add","path":"/m2/chapters","position":"end","value":{"name":"Recursion"}}`, `{"op":"add","path":"/ch4","position":"before","value":{"name":"Recursion","color":"#1F6964"}}` |
| Add a chapter with pages and content | `[{"op":"add","path":"/m2/chapters","position":"end","value":{"label":"$ch","name":"Recursion"}},{"op":"add","path":"/$ch/pages","position":"end","value":[{"title":"Base cases","blocks":[{"name":"core/paragraph","attributes":{"content":"…"}}]},{"title":"Tail calls"}]}]` |
| Set a chapter's opening time | `{"op":"replace","path":"/ch5/opens_at","value":"2027-02-01T08:00:00Z"}` |
| Move a module, chapter or page | `{"op":"move","from":"/m3","path":"/m2","position":"before"}`, `{"op":"move","from":"/ch5","path":"/ch3","position":"after"}`, `{"op":"move","from":"/pg9","path":"/pg7","position":"after"}` |
| Move into another parent | `{"op":"move","from":"/ch4","path":"/m2/chapters","position":"end"}`, `{"op":"move","from":"/pg9","path":"/course/pages","position":"end"}` |
| Move a range of pages | `{"op":"move","from":"/pg9","through":"/pg12","path":"/ch4/pages","position":"end"}` |
| Make a page the chapter's front page | `{"op":"move","from":"/pg7","path":"/ch3/pages","position":"start"}` |
| Re-sort all children | `{"op":"reorder","path":"/m1/chapters","value":["ch2","ch1","ch3"]}` (`value` must list exactly the current children) |
| Duplicate and rename (copies get new ids and a `-copy` path suffix) | `[{"op":"copy","from":"/pg7","path":"/pg7","position":"after","label":"$c"},{"op":"replace","path":"/$c/title","value":"For loops, part 2"}]` |
| Delete a chapter with its pages | `{"op":"remove","path":"/ch5"}` |
| Add a page | `{"op":"add","path":"/ch3/pages","position":"end","value":{"title":"While loops","blocks":[...]}}`, `{"op":"add","path":"/course/pages","position":"end","value":{"title":"FAQ","url_path":"/faq"}}` |
| Delete pages | `{"op":"remove","path":"/pg8"}`, `{"op":"remove","path":"/pg9","through":"/pg12"}` |
| Split a chapter | `[{"op":"add","path":"/ch3","position":"after","value":{"label":"$ch","name":"Loops, part 2"}},{"op":"move","from":"/pg10","through":"/pg12","path":"/$ch/pages","position":"end"}]` |
| Merge a chapter into the previous one | `[{"op":"move","from":"/pg20","through":"/pg24","path":"/ch3/pages","position":"end"},{"op":"remove","path":"/ch4"}]` |

## What the server does for you

- **New entities.** A new chapter gets a front page automatically. A new module starts with manual completion and certificates off (change that with the settings tool). A page created in a live course without `blocks` starts hidden.
- **Paths.** `url_path` is optional on new pages; the server derives `/chapter-N/<slug>` or `/<slug>` and resolves clashes. Paths must be unique after the whole call, so you can swap two paths in one call.
- **Redirects.** Every changed path gets a redirect from the old one automatically, whatever changed it. You can't turn this off and don't need to create redirects. Pages removed in a call get no redirect. The result lists redirects created and internal links that point at old paths; those links keep working through the redirect, but updating them is tidier.
- **Front pages.** When a chapter's first page changes, the paths swap by role: the new front page gets `/chapter-N` and the old one gets `/chapter-N/<slug of its title>`.
- **Numbers.** Chapter numbers and path prefixes are recomputed after the call; the result lists what changed.
- **Exercises** move with their page and keep their submissions. A page with exercises can't move to the top level.

## Rules that cause errors

- Unknown fields, settings fields (the error names the settings tool) and derived fields (`chapter_number`, `order_number`, `course_module_id`, `chapter_id`, `id`) are rejected.
- The default module can't be moved, renamed or removed. A module can be removed only when empty; the error lists its chapters.
- A chapter always has at least one page.
- The course front page can't be moved, removed or displaced from the start of `/course/pages`.

## Risk

In a live course, removing a non-hidden page or chapter, removing pages or chapters with exercise submissions, moving a deadline earlier or adding one to an open chapter, and moving an opening time later on an open chapter are risky: only the teacher can publish them. See [staging-and-publishing.md](staging-and-publishing.md).
