# Agent setup

You cloned this repository as `course-material` into the user-level skills folder: Claude Code `~/.claude/skills` (or `$CLAUDE_CONFIG_DIR/skills`), Codex `~/.agents/skills`. Below, `<skills folder>` is that folder and `<skill folder>` the clone, both absolute. On Windows, also follow [setup/windows.md](setup/windows.md).

- Before each step, tell the teacher in one sentence what it does and ask with your question tool (Claude Code: AskUserQuestion; plain text if you have none), recommending an option. A yes there lets permission checks such as Claude Code's auto mode allow the step.
- Run each step's commands on their own, never chained with another step's or with reads.
- Never skip a step or part of one silently. If a step is refused or fails after the teacher's yes, give them the exact command to run themselves (Claude Code: type `! <command>` at the prompt) and wait for them to say it ran before going on.
- Ask setup questions on their own, never in the same question batch as the teacher's course task.
- Setup started in the middle of a task (the server said the skill is missing): finish every step here, through step 9, before going back to the task.
- Delete or overwrite nothing you didn't create in this setup without asking; change no tracked file in the clone; never delete the teacher's files in `<skill folder>/.local/` or change them beyond step 6.
- Another agent harness: do the same as the Claude Code or Codex steps the way your harness does it (skills folder, MCP server, allow rule).
- Folder-only install, if the teacher asks: work out the matching paths for your client, follow the same steps, and tell the teacher to start the agent in that folder.
- Existing install: `git -C <skill folder> pull --ff-only`, then redo only the steps whose result is missing.

## 1. Expectations

Tell the teacher that you'll ask permission to run commands and write to the skills folder and agent settings (Claude Code asks separately for its own settings; Codex asks to leave its sandbox), and that at the end they reload the skills, or restart the agent and sign in.

## 2. Task skills (Claude Code only)

Claude Code finds skills one folder deep. Link the task skills and add a hook that relinks after updates:

```bash
bash <skill folder>/setup/link-task-skills.sh <skills folder>
printf '#!/bin/sh\nexec bash "$(git rev-parse --show-toplevel)/setup/link-task-skills.sh" %s\n' "'<skills folder>'" > <skill folder>/.git/hooks/post-merge
chmod +x <skill folder>/.git/hooks/post-merge
```

## 3. MCP server

Server `https://courses.mooc.fi/api/v0/mcp` unless the teacher gave another; name `courses-moocfi`. Don't start a sign-in. If a `courses-moocfi` server already exists with another address, ask before replacing it.

- Claude Code: `claude mcp add --transport http --scope user courses-moocfi <server>` (to replace one, `claude mcp remove --scope user courses-moocfi` first).
- Codex: `codex features enable mcp_2026_07_28`. In `$CODEX_HOME/config.toml` (default `~/.codex`), add or replace this table, keeping the rest; `codex mcp add` would start a sign-in:

  ```toml
  [mcp_servers.courses-moocfi]
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

## 5. What the agent remembers

Create no file. Tell the teacher that, when they ask, you remember how they want text written, what content goes where and how you work, in `<skill folder>/.local/`, which they can edit themselves. A writing preference stated as a standing rule, and a trust setting they clearly show, are saved straight away, with how to undo it.

## 6. Private skills repository

Always ask: use an existing one, create one, or skip; when `<skill folder>/.local/workflow.md` has a `Private skills:` line, keeping that one is the first option. Recommend keeping or creating one: it holds the teacher's own skills and guidance ([references/skill-placement.md](references/skill-placement.md)). For an existing or new one, do every bullet below that applies.

- Existing: ask where it is; clone it into `<skills folder>` if it isn't on this computer.
- New: `git init <skills folder>/private-skills` with a `skills/` folder. If `git config user.email` is empty, ask for the name and email to commit with.
- Write `Private skills: <absolute path>` in `<skill folder>/.local/workflow.md` (create the file with a `# Workflow` heading if missing; if a different path is there, ask first), and allow `git -C <private repo> pull --ff-only` as in step 4: in Claude Code, a second `permissions.allow` entry; in Codex, a second `prefix_rule` in the same rules file, keeping the first, then check both commands.
- Claude Code: run `bash <skill folder>/setup/link-task-skills.sh <skills folder> <private repo>`, and add a post-merge hook in the private repository that runs the same command.
- Codex: if the repository is outside `~/.agents/skills`, link its `skills/` folder there.
- Push: ask whether to keep a copy on a git host; recommend no unless they use several computers. Create the remote repository as private and check its visibility before the first push (GitHub: `gh repo view <repo> --json visibility`); if you can't check, ask the teacher to check it on the host's website.

## 7. Browser checks

If `playwright-cli --version` fails, ask whether to install it (needs Node.js): `npm install -g @playwright/cli@latest`. If it works and `<skills folder>/playwright-cli` is missing, in an empty scratch folder, run `playwright-cli install --skills=claude` (Codex: `--skills=agents`) and copy `.claude/skills/playwright-cli` (Codex: `.agents/skills/playwright-cli`) into `<skills folder>`.

## 8. Summary

Summarise what you set up and where, and any step the teacher declined, and point to "Remove" in SETUP.md.

## 9. Load the skills

- If step 3 added or replaced the server: the teacher restarts the agent and signs in (Claude Code: `/mcp`, choose `courses-moocfi`; Codex: `codex mcp login courses-moocfi` in a terminal), then asks "List my courses on courses.mooc.fi." The new session loads the skills.
- Otherwise ask the teacher to reload skills (Claude Code: `/reload-skills`; other harnesses have their own command, or a new session) and wait for them to say it's done. Then check that `course-material` and the `course-material-*` task skills are among your available skills (Claude Code: load `course-material` with the Skill tool). If any is missing, say which and redo step 2 or the reload; start no course work until they load.
