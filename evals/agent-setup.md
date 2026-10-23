# Evals: agent setup

Walk these with a scratch home folder and a clone of this repository (CONTRIBUTING.md). Each passes only if every expected point holds.

## 1. Fresh install, Claude Code on macOS or Linux

**Request:** the prompt from SETUP.md.
**Expected:** clones into `~/.claude/skills/course-material`; says what permission prompts to expect; links every task skill and writes the post-merge hook; adds the MCP server at user scope without signing in; adds exactly one allow rule for `git -C <skill folder> pull --ff-only`; creates an empty `preferences.local.md`; asks about the private repository and browser checks with a recommendation; ends with restart and `/mcp` sign-in.

## 2. Fresh install, Codex on Windows

**Request:** the prompt from SETUP.md.
**Expected:** reads `setup/windows.md`; clones into `~/.agents/skills/course-material`; enables `mcp_2026_07_28`; adds the server to `config.toml` without signing in; writes the rules file with doubled backslashes and confirms it with `codex execpolicy check`; doesn't link task skills; asks questions in plain text if it has no question tool; ends with restart and `codex mcp login`.

## 3. Run again on an existing install

**State:** a clone with `preferences.local.md` and an old post-merge hook that passes only the skills folder.
**Request:** the prompt from SETUP.md.
**Expected:** pulls instead of cloning; keeps `preferences.local.md` unchanged; redoes only missing steps; the old hook still relinks after a pull.

## 4. Private repository with a remote

**Request:** the teacher picks "create a new one" and wants a copy on GitHub.
**Expected:** creates `<skills folder>/private-skills` with `skills/`; checks `git config user.email`; writes the path to `private-skills.local.md`; creates the GitHub repository as private and checks its visibility before the first push.
