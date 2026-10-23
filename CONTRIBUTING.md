# Contributing

## Layout

| Path | What it is |
|---|---|
| `SKILL.md` | The main skill. The repository root is the skill folder, so a clone into a skills folder works as is. |
| `VERSION` | The skill version (semver). Agents send it as `skill_version` on every tool call. |
| `references/` | Reference files the main skill loads on demand. `references/index.md` lists them. |
| `skills/<name>/SKILL.md` | Task skills. The folder name is the skill `name` and starts with `course-material-`. |
| `setup/` | Setup scripts for teachers, and the task-skill linker Claude Code needs. |

## Releases and versioning

`main` is the release branch: teachers' agents run `git pull --ff-only` on it. Merge only reviewed changes, never rewrite its history, and keep it fast-forwardable.

Bump `VERSION` in every change merged to `main`:

- **patch**: wording, fixes, new examples
- **minor**: new guidance or task skills, guidance for new server features
- **major**: the skill no longer works with older servers, or older skills no longer work with the server

The server has a current and a minimum skill version in its configuration. After merging:

- set the server's current version to the new `VERSION`, so older skills get the "update available" hint
- raise the minimum only when older skills would produce wrong content against the server; agents below the minimum are refused until they update

The server stays compatible with every skill version at or above its minimum. Change the minimum only together with the server change that needs it.

## Task skills

- One folder per skill under `skills/`, holding `SKILL.md` with `name` (same as the folder) and `description` (what it does and when to use it, under 1,024 characters).
- Claude Code discovers skills only one level below its skills folder, so the setup links each task skill there. The git `post-merge` hook the setup installs relinks after every pull, so new and removed task skills need no extra step.
- Codex scans its skills folder recursively and finds them in place.
- Task skills say to load the main `course-material` skill. Refer to it by name, not by relative path: in Claude Code the task skill is reached through a link, so `../..` points elsewhere.

## Testing the setup scripts

Run them against a scratch home folder and a local clone so you don't touch your own configuration:

```bash
COURSE_MATERIAL_SKILLS_REPO=$PWD HOME=$(mktemp -d) bash setup/install.sh --agent codex --yes --no-playwright --server-url http://project-331.local/api/v0/mcp
```

`COURSE_MATERIAL_SKILLS_REPO` and `COURSE_MATERIAL_SKILLS_BRANCH` override the repository and branch for both scripts. The scripts call the real `claude` or `codex`; put stub commands first in `PATH` to test without changing agent configuration.

## Commits

Subject line only, imperative, sentence case, no trailing period, at most 72 characters.
