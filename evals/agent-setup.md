# Evals: agent setup

Walk these with a scratch home folder and a clone of this repository (CONTRIBUTING.md). Each passes only if every expected point holds.

## 1. Fresh install, Claude Code on macOS or Linux

**Request:** the prompt from SETUP.md.
**Expected:** clones into `~/.claude/skills/course-material`; says what permission prompts to expect; links every task skill and writes the post-merge hook; adds the MCP server at user scope without signing in; adds exactly one allow rule for `git -C <skill folder> pull --ff-only`; creates no file in `.local/` and tells the teacher about the three teacher files; asks about each step with its question tool, recommending a private repository; installs `playwright-cli`, Chromium and the playwright-cli skill without asking first, and passes the example.com title check before the summary; ends with a summary, then restart and `/mcp` sign-in.

## 2. Fresh install, Codex on Windows

**Request:** the prompt from SETUP.md.
**Expected:** reads `setup/windows.md`; clones into `~/.agents/skills/course-material`; enables `mcp_2026_07_28`; adds the server to `config.toml` without signing in; writes the rules file with doubled backslashes and confirms it with `codex execpolicy check`; doesn't link task skills; asks questions in plain text if it has no question tool; ends with restart and `codex mcp login`.

## 3. Run again on an existing install

**State:** a clone with `.local/preferences.md`, `.local/workflow.md` and an old post-merge hook that passes only the skills folder.
**Request:** the prompt from SETUP.md.
**Expected:** pulls instead of cloning; keeps the `.local/` files unchanged; redoes only missing steps; the old hook still relinks after a pull.

## 4. Private repository with a remote

**Request:** the teacher picks "create a new one" and wants a copy on GitHub.
**Expected:** creates `<skills folder>/private-skills` with `skills/`; checks `git config user.email`; writes `Private skills: <path>` in `.local/workflow.md` (the only teacher file it creates); adds its update rule, links it and adds its post-merge hook; creates the GitHub repository as private and checks its visibility before the first push.

## 5. Different private repository path

**State:** `.local/workflow.md` already has a `Private skills:` line with another path.
**Request:** the teacher picks "use an existing one" with a new path.
**Expected:** asks before replacing the line; touches nothing else in the file.

## 6. Installed in the middle of a task, auto mode on

**State:** Claude Code in auto mode with `courses-moocfi` connected and signed in; no skill installed.
**Request:** "Split chapter 4 into two chapters." The server answers that the skill is missing; the teacher agrees to install it.
**Expected:** clones the skill and follows AGENT-SETUP.md before any course work; asks about each step with AskUserQuestion, never together with questions about the course; runs each step's commands separately; when a step is still refused, gives the exact `! <command>` and waits for the teacher; skips nothing silently; asks the teacher to run `/reload-skills`, waits, checks that `course-material` and the task skills are available, and only then goes back to the course.

## 7. Browser tools can't be installed by the agent

**State:** macOS without Node.js; `npm install -g` would fail with EACCES; the agent's sandbox blocks the browser.
**Request:** the prompt from SETUP.md.
**Expected:** installs Node.js or gives the teacher the exact command and waits; sets a user npm prefix instead of using sudo; never skips or postpones step 7; searches the web for an error the fixes don't cover; when the sandbox blocks the browser, asks to run outside it or has the teacher run the check and paste the output; goes on to the summary only once the title is `Example Domain`.

## 8. Course work before the browser check passes

**State:** setup is done except step 7, which still fails.
**Request:** "Fix the typos in chapter 2."
**Expected:** reads chapter 2 and lists the typos; calls no write or publish tool; explains that edits wait for the browser check and keeps working on it with the teacher.
