# Agent setup

You cloned this repository as `course-material` into the user-level skills folder: Claude Code `~/.claude/skills` (or `$CLAUDE_CONFIG_DIR/skills`), Codex `~/.agents/skills`. Below, `<skills folder>` is that folder and `<skill folder>` the clone, both absolute. On Windows, also follow [setup/windows.md](setup/windows.md).

- Before each step, tell the teacher in one sentence what it does. Ask with your question tool (plain text if you have none) and recommend an option.
- Delete or overwrite nothing you didn't create in this setup without asking; change no tracked file in the clone; never delete or empty an existing `*.local.md` file.
- Another agent harness: do the same as the Claude Code or Codex steps the way your harness does it (skills folder, MCP server, allow rule).
- Folder-only install, if the teacher asks: work out the matching paths for your client, follow the same steps, and tell the teacher to start the agent in that folder.
- Existing install: `git -C <skill folder> pull --ff-only`, then redo only the steps whose result is missing.

## 1. Expectations

Tell the teacher that you'll ask permission to run commands and write to the skills folder and agent settings (Claude Code asks separately for its own settings; Codex asks to leave its sandbox), and that they restart the agent and sign in at the end.

## 2. Task skills (Claude Code only)

Claude Code finds skills one folder deep. Link the task skills and add a hook that relinks after updates:

```bash
bash <skill folder>/setup/link-task-skills.sh <skills folder>
printf '#!/bin/sh\nexec bash "$(git rev-parse --show-toplevel)/setup/link-task-skills.sh" %s\n' "'<skills folder>'" > <skill folder>/.git/hooks/post-merge
chmod +x <skill folder>/.git/hooks/post-merge
```

## 3. MCP server

Server `https://courses.mooc.fi/api/v0/mcp` unless the teacher gave another; name `courses-mooc-fi`. Don't start a sign-in. If a `courses-mooc-fi` server already exists with another address, ask before replacing it.

- Claude Code: `claude mcp add --transport http --scope user courses-mooc-fi <server>` (to replace one, `claude mcp remove --scope user courses-mooc-fi` first).
- Codex: `codex features enable mcp_2026_07_28`. In `$CODEX_HOME/config.toml` (default `~/.codex`), add or replace this table, keeping the rest; `codex mcp add` would start a sign-in:

  ```toml
  [mcp_servers.courses-mooc-fi]
  url = "<server>"
  ```

## 4. Update rule

Allow exactly `git -C <skill folder> pull --ff-only`, with the path written as [references/updating.md](references/updating.md) runs it (quoted if it has spaces):

- Claude Code: add `Bash(git -C <skill folder> pull --ff-only)` to `permissions.allow` in `$CLAUDE_CONFIG_DIR/settings.json` (default `~/.claude`), keeping the rest.
- Codex: write `$CODEX_HOME/rules/course-material-agent-skills.rules` (default `~/.codex`), then run `codex execpolicy check --rules <rules file> -- git -C <skill folder> pull --ff-only`. If the output doesn't say `allow`, tell the teacher Codex will ask once per update.

  ```
  prefix_rule(
      pattern = ["git", "-C", "<skill folder>", "pull", "--ff-only"],
      decision = "allow",
      justification = "Updates the course material skill",
  )
  ```

## 5. Preferences

Create an empty `<skill folder>/preferences.local.md` unless it exists. Tell the teacher you can offer to remember style changes there, and that they can edit it (format: `preferences.example.md`).

## 6. Private skills repository

Always ask: use an existing one, create one, or skip; when `<skill folder>/private-skills.local.md` exists, keeping that one is the first option. Recommend skipping unless the teacher plans skills of their own ([references/skill-placement.md](references/skill-placement.md)).

- Existing: ask where it is; clone it into `<skills folder>` if it isn't on this computer.
- New: `git init <skills folder>/private-skills` with a `skills/` folder. If `git config user.email` is empty, ask for the name and email to commit with.
- Write its absolute path as the only line of `<skill folder>/private-skills.local.md`, and allow `git -C <private repo> pull --ff-only` as in step 4.
- Claude Code: run `bash <skill folder>/setup/link-task-skills.sh <skills folder> <private repo>`, and add a post-merge hook in the private repository that runs the same command.
- Codex: if the repository is outside `~/.agents/skills`, link its `skills/` folder there.
- Push: ask whether to keep a copy on a git host; recommend no unless they use several computers. Create the remote repository as private and check its visibility before the first push (GitHub: `gh repo view <repo> --json visibility`); if you can't check, ask the teacher to check it on the host's website.

## 7. Browser checks

If `playwright-cli --version` fails, ask whether to install it (needs Node.js): `npm install -g @playwright/cli@latest`. If it works and `<skills folder>/playwright-cli` is missing, in an empty scratch folder, run `playwright-cli install --skills=claude` (Codex: `--skills=agents`) and copy `.claude/skills/playwright-cli` (Codex: `.agents/skills/playwright-cli`) into `<skills folder>`.

## 8. Finish

Summarise what you set up and where, point to "Remove" in SETUP.md, and give the last steps: restart the agent; sign in (Claude Code: `/mcp`, choose `courses-mooc-fi`; Codex: `codex mcp login courses-mooc-fi` in a terminal); then ask "List my courses on courses.mooc.fi."
