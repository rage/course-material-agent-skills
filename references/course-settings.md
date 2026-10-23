# Course settings

`get_course_settings {course}` returns the course's and its modules' settings; `patch_course_settings {course, ops, dry_run?}` changes them (no `read_back`; read again to check). The tool needs the `settings:write` permission; if the teacher didn't grant it, it isn't available and the teacher changes settings in the web UI. Module creation, removal, order and names are in the structure tool.

## Model

```json
{
  "course": {
    "id": "c1", "slug": "ohpe", "language_code": "fi-FI",
    "name": "Ohjelmoinnin perusteet", "description": "...",
    "is_draft": false, "is_test_mode": false, "is_unlisted": false,
    "chapter_locking_enabled": false,
    "base_module_completion_requires_n_submodule_completions": 0,
    "ai_policy": "no-ai",
    "audiences": [{"id": "au1", "name": "Upper secondary students"}],
    "closed_at": null
  },
  "modules": [
    {"id": "m1", "name": null,
     "completion_policy": {"policy": "automatic", "number_of_points_treshold": 60, "number_of_exercises_attempted_treshold": null, "requires_exam": false},
     "certification_enabled": true},
    {"id": "m2", "name": "Advanced", "completion_policy": {"policy": "manual"}, "certification_enabled": false}
  ]
}
```

`treshold` is spelled that way in the platform; use it as is.

## Examples

| Edit | Op(s) |
|---|---|
| Set a course field | `{"op":"replace","path":"/course/name","value":"Ohjelmoinnin perusteet 2027"}`; likewise `/course/description`, `/course/is_unlisted`, `/course/ai_policy`, `/course/base_module_completion_requires_n_submodule_completions` |
| Turn on chapter locking (risky) | `{"op":"replace","path":"/course/chapter_locking_enabled","value":true}` |
| Add or remove an audience | `{"op":"add","path":"/course/audiences","value":{"name":"Upper secondary students"}}`, `{"op":"remove","path":"/au1"}` |
| Set a completion policy, or one threshold | `{"op":"replace","path":"/m2/completion_policy","value":{"policy":"automatic","number_of_points_treshold":60,"number_of_exercises_attempted_treshold":null,"requires_exam":false}}`, `{"op":"replace","path":"/m2/completion_policy/number_of_points_treshold","value":50}` |
| Enable certificates for a module | `{"op":"replace","path":"/m2/certification_enabled","value":true}` |

Audiences are an unordered list, so `add` there needs no `position`.

## Read-only for agents

`slug`, `language_code`, and the switches that publish, unpublish or close a course (`is_draft`, `is_test_mode`, `closed_at` and the closing fields). The teacher changes these in the web UI. Don't suggest workarounds.

## Risk

Changing a completion policy or `base_module_completion_requires_n_submodule_completions` after students have completed the course, and turning chapter locking on or off, are risky: only the teacher can publish them.
