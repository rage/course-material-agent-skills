# Contributing

## Layout

| Path | What it is |
|---|---|
| `SKILL.md` | The main skill. The repository root is the skill folder; clone it as `course-material`, the skill's `name` (the setup does). |
| `AGENT-SETUP.md` | Setup steps the teacher's agent follows; SETUP.md has the prompt that starts it. |
| `preferences.example.md` | Format of a teacher's `preferences.local.md`. Keep its examples to style and maintenance. |
| `VERSION` | The skill version (semver). Agents send it as `skill_version` on every tool call. |
| `references/` | Reference files the main skill links directly. They don't link each other. |
| `evals/<skill name>.md` | Test scenarios per skill. Not loaded by agents. |
| `skills/<name>/SKILL.md` | Task skills. The folder name is the skill `name` and starts with `course-material-`. |
| `setup/` | The skill linker Claude Code needs (called by teachers' post-merge hooks, so keep its usage working), and Windows setup notes. |
| `*.local.md` | A teacher's own files (preferences, private repository path). Gitignored; CI fails if one is tracked. |

## Releases and versioning

`main` is the release branch: teachers' agents run `git pull --ff-only` on it. Merge only reviewed changes, never rewrite its history, and keep it fast-forwardable.

Bump `VERSION` in every change merged to `main`:

- **patch**: wording, fixes, new examples
- **minor**: new guidance or task skills, guidance for new server features
- **major**: the skill no longer works with older servers, or older skills no longer work with the server

The server has a current and a minimum skill version (`CURRENT_SKILL_VERSION` and `MINIMUM_SKILL_VERSION` in `services/headless-lms/mcp/src/hints.rs` of the platform repository). After merging:

- set the server's current version to the new `VERSION`, so older skills get the "update available" hint
- raise the minimum only when older skills would produce wrong content against the server; agents below the minimum are refused until they update

The server stays compatible with every skill version at or above its minimum. Change the minimum only together with the server change that needs it.

## Task skills

- One folder per skill under `skills/`, holding `SKILL.md` with `name` (same as the folder) and `description` (what it does and when to use it, under 1,024 characters).
- Claude Code discovers skills only one level below its skills folder, so the setup links each task skill there. The git `post-merge` hook the setup installs relinks after every pull, so new and removed task skills need no extra step.
- Codex scans its skills folder recursively and finds them in place.
- Task skills say to load the main `course-material` skill. Refer to it and its reference files by name, not by relative path: in Claude Code the task skill is reached through a link, so `../..` points elsewhere.

## What goes in a skill

The MCP server's instructions, tool descriptions, `guide` topics and error messages already reach the agent and are kept current with the server. Don't repeat them here: no argument lists, schemas, op syntax or error tables. Point to the tool or `guide` topic instead. Skills hold what the server doesn't say: workflow, judgement calls, how to work with the teacher, and gotchas found in use.

## Evals

Each skill has scenarios in `evals/<skill name>.md`, and the setup in `evals/agent-setup.md`: a state and request, and the behaviour a reviewer can check. When you change a skill or the setup, walk its scenarios with an agent against a development server, and add one for any new rule or fixed failure.

Walk preference scenarios in a scratch clone of your branch, so they don't change your own `preferences.local.md`. Walk setup scenarios with a scratch home folder where the agent is signed in, and point the setup prompt at your branch instead of the GitHub URL.

## Testing the linker

Run it against scratch folders: `bash setup/link-task-skills.sh "$(mktemp -d)"`. CI does the same on Linux, macOS and Windows.

## Commits

Subject line only, imperative, sentence case, no trailing period, at most 72 characters.
