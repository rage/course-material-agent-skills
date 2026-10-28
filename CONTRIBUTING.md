# Contributing

## Layout

| Path | What it is |
|---|---|
| `SKILL.md` | The main skill. The repository root is the skill folder; clone it as `course-material`, the skill's `name` (the setup does). |
| `AGENT-SETUP.md` | Setup steps the teacher's agent follows; SETUP.md has the prompt that starts it. |
| `*.example.md` | Formats of the teacher files in `.local/`: `preferences.example.md`, `course-rules.example.md`, `workflow.example.md`. Example lines never grant consent (to publish, run code, install or make risky changes). |
| `.local/` | The teacher's files and the agent's notes. Gitignored except `.gitkeep`; CI fails if anything else is tracked. |
| `VERSION` | The skill version (semver). Agents send it as `skill_version` on every tool call. |
| `references/` | Reference files the main skill and task skills name. Links stay one level deep: reference files don't link each other. |
| `evals/<skill name>.md` | Test scenarios per skill; `evals/routing.md` tests which skill a request loads. Not loaded by agents. |
| `skills/<name>/SKILL.md` | Task skills. The folder name is the skill `name` and starts with `course-material-`. |
| `setup/` | The skill linker Claude Code needs (called by teachers' post-merge hooks, so keep its usage working), and Windows setup notes. |

## Versioning

`main` is what teachers' agents pull (`git pull --ff-only`). Merge only reviewed changes, never rewrite its history, and keep it fast-forwardable. A skill change goes to `main` once the server features it uses are in production.

Bump `VERSION` when agents must pick a change up:

- **patch**: wording, fixes, new examples
- **minor**: new guidance or task skills, guidance for new server features
- **major**: the skill no longer works with older servers, or older skills no longer work with the server

The server has a current and a minimum skill version (`CURRENT_SKILL_VERSION` and `MINIMUM_SKILL_VERSION` in `services/headless-lms/mcp/src/hints.rs` of the platform repository). Once the change is on `main`:

- set the server's current version to the new `VERSION`, so older skills get the "update available" hint
- raise the minimum only when older skills would produce wrong content against the server; agents below the minimum are refused until they update

The server stays compatible with every skill version at or above its minimum. Change the minimum only together with the server change that needs it.

## Task skills

- One folder per skill under `skills/`, holding `SKILL.md` with `name` (same as the folder) and `description`.
- Claude Code discovers skills only one level below its skills folder, so the setup links each task skill there. The git `post-merge` hook the setup installs relinks after every pull, so new and removed task skills need no extra step.
- Codex scans its skills folder recursively and finds them in place.
- A task skill's first step loads the main `course-material` skill.
- Name a reference file by its full path in the main skill's folder, `course-material/references/<file>.md`, in the step that needs it ("Read `course-material/references/reviewing.md` and follow it for …"). Never a relative path: in Claude Code the task skill is reached through a link, so `../..` points elsewhere.
- To use another skill, say so in the step: "use the `course-material-link-check` skill's Check section for links".

## What goes in a skill

The MCP server's instructions, tool descriptions, `guide` topics and error messages already reach the agent and are kept current with the server. Don't repeat them here: no argument lists, schemas, op syntax or error tables. Point to the tool or `guide` topic instead. Skills hold what the server doesn't say: judgement calls, how to work with the teacher, safety rules, and gotchas found in use.

- Skill text is in English and instructs the agent. State goals and the rules that guard safety, teacher control and students; leave the rest to the agent's judgement rather than numbered steps.
- Descriptions are one or two short sentences: what the skill does. Name a sibling skill only where requests would otherwise land on the wrong one. The steps go in the body.
- One owner per rule. Others link the owner's file instead of restating it.

| Check or rule | Owner | Used by |
|---|---|---|
| Tool workflow, draft-vs-published reads, pitfalls the server doesn't state | `SKILL.md` | all |
| Asking, report first, safety rules, writing style, end summary | `SKILL.md` | all |
| Findings format, course-wide method, fresh-context brief | `references/reviewing.md` | check skills, review, student-feedback, walkthrough, exercise-check |
| Remembering, `.local/` | `SKILL.md` (short), `references/local.md` | all |
| Tool and agent gotchas → drafted public issue | `references/skill-placement.md` | — |
| Integrity, position references (finding), overlap, running code | `course-material-review` | restructuring fixes position references after a move |
| Duplication fixes | `course-material-restructuring` | — |
| Dates, settings vs text, language-version pairing, copies, what tools can't read | `references/course-facts.md` | new-run, review, student-feedback, claim-check, exercise-check, translation-sync, restructuring |
| Opening state, rescheduling, copy leftovers | `course-material-new-run` | — |
| Effective deadline of moved exercises, lock-chapter on new chapters | `course-material-restructuring` | — |
| Links | `course-material-link-check` | review |
| Claims, sources, currency, deprecated APIs | `course-material-claim-check` | review, student-feedback |
| Language and glossary use | `course-material-language-review` | review, student-feedback |
| Course style sheet | `course-material-language-review` | — |
| Accessibility | `course-material-accessibility-review` | review |
| Stuck points, objectives alignment | `course-material-student-walkthrough` | — |
| Answer keys, review questions, key parity | `course-material-exercise-check` | student-feedback hands over |
| Identical corrections in every version | `course-material-student-feedback` | — |
| Cross-version drift, code-sample choice | `course-material-translation-sync` | — |

## Evals

Each skill has scenarios in `evals/<skill name>.md`, and the setup in `evals/agent-setup.md`: a state and request, and the behaviour a reviewer can check. When you change a skill or the setup, walk its scenarios with an agent against a development server. Add a scenario when a rule is easy to get wrong or guards safety.

Walk scenarios that remember things in a scratch clone of your branch, so they don't change your own `.local/`. Walk setup scenarios with a scratch home folder where the agent is signed in, and point the setup prompt at your branch instead of the GitHub URL. When a description changes, walk `evals/routing.md` by hand.

## Testing the linker

Run it against scratch folders: `bash setup/link-task-skills.sh "$(mktemp -d)"`. CI does the same on Linux, macOS and Windows.

## Commits

Subject line only, imperative, sentence case, no trailing period, at most 72 characters.
