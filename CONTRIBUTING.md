# Contributing

## Layout

| Path | What it is |
|---|---|
| `SKILL.md` | The main skill. The repository root is the skill folder; clone it as `course-material`, the skill's `name` (the setup does). |
| `AGENT-SETUP.md` | Setup steps the teacher's agent follows; SETUP.md has the prompt that starts it. |
| `*.example.md` | Formats of the teacher files in `.local/`: `preferences.example.md`, `course-rules.example.md`, `workflow.example.md`, `guidance.example.md`. Example lines never grant consent (to publish, run code, install or make risky changes). |
| `.local/` | The teacher's files and the agent's notes. Gitignored except `.gitkeep`; CI fails if anything else is tracked. |
| `VERSION` | The skill version (semver). Agents send it as `skill_version` on every tool call. |
| `references/` | Reference files the main skill and task skills name. Links stay one level deep: reference files don't markdown-link each other; naming one by its full `course-material/references/...` path is fine. |
| `references/guidance/` | Guidance on rigor, teaching and course design, and `trust.md` on how far to rely on it. Each file: a purpose line, What to check, Background, Sources. Every What to check point ends with a source key from its Sources list, or `(editorial)`; table rows may share the key after the table. Sources are checked online and dated. One key and one URL per source across files. CI checks the keys. |
| `references/writing/` | `styles.md`: whose style comes first, what holds in every style, and the writing styles with when each fits. `finnish.md`, `swedish.md`, `english.md`: each language's norms and references. Language files: a lead line, What it is, When it fits, Applies here, How agents use it, Sources. |
| `references/accessibility.md` | WCAG criteria for course content and what the law requires. Like the language files: a lead line, What it is, When it fits (Fits and Doesn't fit), Applies here, sections of its own where needed, How agents use it, Sources. It names parts and rates their relevance; agents know the standards, so never restate rules. Sources are checked online and dated; a paywalled or unreadable text says so instead. |
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
| Findings format, course-wide method, fresh-context brief | `references/reviewing.md` | check skills, review, student-feedback, walkthrough, exercise-check, design-advice, `SKILL.md` (subagents), `references/guidance/trust.md` |
| Remembering, `.local/` | `SKILL.md` (short), `references/local.md` | all |
| Tool and agent gotchas → drafted public issue | `references/skill-placement.md` | `SKILL.md`, `AGENT-SETUP.md` |
| Rich-text markup in block attributes | `references/rich-text.md` | `SKILL.md` |
| Previews, screenshots, axe runs | `references/visual-checks.md` | `SKILL.md`, accessibility-review, link-check |
| Updating the skills | `references/updating.md` | `SKILL.md`, `AGENT-SETUP.md` |
| Setup and connection errors | `references/setup-errors.md` | `SKILL.md` |
| Integrity, position references (finding), overlap, running code | `course-material-review` | restructuring fixes position references after a move |
| Duplication fixes | `course-material-restructuring` | review hands over |
| Dates, settings vs text, language-version pairing, copies, what tools can't read | `references/course-facts.md` | new-run, review, student-feedback, claim-check, exercise-check, translation-sync, restructuring |
| Opening state, rescheduling, copy leftovers | `course-material-new-run` | — |
| Effective deadline of moved exercises, lock-chapter on new chapters | `course-material-restructuring` | — |
| Links | `course-material-link-check` | review |
| Claims, sources, currency, deprecated APIs | `course-material-claim-check` | review, student-feedback |
| Language and glossary use, course style sheet | `course-material-language-review` | review, student-feedback |
| How far to rely on guidance, raising it with the teacher, saving trust settings without asking | `references/guidance/trust.md` | every skill using guidance, `SKILL.md` (disagreement) |
| Kinds of claims and their justification, models, pseudoscience | `references/guidance/knowledge-and-method.md` | claim-check; review and student-feedback via claim-check |
| Evidence types, expertise, consensus | `references/guidance/evidence.md` | claim-check; review and student-feedback via claim-check |
| Fallacies, statistics and method errors, biases | `references/guidance/reasoning-errors.md` | claim-check; review and student-feedback via claim-check |
| Uncertainty, scope, interests, corrections | `references/guidance/honesty.md` | claim-check, language-review, `SKILL.md` (writing style), `references/writing/styles.md`; review and student-feedback via claim-check |
| How students learn, feedback, UDL, generic skills | `references/guidance/learning.md` | design-advice, exercise-check, walkthrough, review |
| Objectives and their level, prerequisites, progression, simplification, core content, workload | `references/guidance/course-design.md` | design-advice, walkthrough, restructuring, review |
| What exercises can show, fairness, criteria, AI use | `references/guidance/exercises.md` | design-advice, exercise-check, walkthrough, review, `references/writing/styles.md` |
| Motivation and engagement, pacing | `references/guidance/engagement.md` | design-advice, review |
| Computing, software engineering, programming teaching, mathematics | `references/guidance/computing.md` | claim-check, design-advice, exercise-check, walkthrough, review |
| Planning and evaluating a course | `references/guidance/course-production.md` | design-advice (new-run hands over) |
| Accessibility | `course-material-accessibility-review` | review |
| WCAG criteria for course content; what the law requires | `references/accessibility.md` | accessibility-review, `references/writing/styles.md` |
| Whose style comes first, writing styles and when each fits, plain language | `references/writing/styles.md` | language-review, exercise-check, translation-sync, restructuring, student-feedback, review, `SKILL.md` (writing style), `references/guidance/exercises.md` |
| Finnish norms and clarity; easy-to-read Finnish on request | `references/writing/finnish.md` | language-review, translation-sync, restructuring, new-run, `SKILL.md` (writing style), `references/writing/styles.md` |
| Swedish (Finland Swedish) norms and clarity | `references/writing/swedish.md` | language-review, translation-sync, restructuring, new-run, `references/writing/styles.md` |
| English usage and clarity | `references/writing/english.md` | language-review, translation-sync, restructuring, new-run, `references/writing/styles.md` |
| Stuck points, objectives alignment | `course-material-student-walkthrough` | design-advice hands over alignment |
| Answer keys, review questions, key parity | `course-material-exercise-check` | student-feedback, walkthrough and design-advice hand over |
| Identical corrections in every version | `course-material-student-feedback` | — |
| Cross-version drift, code-sample choice | `course-material-translation-sync` | — |
| Reading other teachers' courses as reference | `SKILL.md` (reference courses) | `references/guidance/trust.md`, `references/course-facts.md`, translation-sync |

## Evals

Each skill has scenarios in `evals/<skill name>.md`, and the setup in `evals/agent-setup.md`: a state and request, and the behaviour a reviewer can check. When you change a skill or the setup, walk its scenarios with an agent against a development server. Add a scenario when a rule is easy to get wrong or guards safety.

Walk scenarios that remember things in a scratch clone of your branch, so they don't change your own `.local/`. Walk setup scenarios with a scratch home folder where the agent is signed in, and point the setup prompt at your branch instead of the GitHub URL. When a description changes, walk `evals/routing.md` by hand.

## Testing the linker

Run it against scratch folders: `bash setup/link-task-skills.sh "$(mktemp -d)"`. CI does the same on Linux, macOS and Windows.

## Commits

Subject line only, imperative, sentence case, no trailing period, at most 72 characters.
