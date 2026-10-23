# Course material skills for AI agents

With these skills, an AI agent on your computer can create and edit your course material on [courses.mooc.fi](https://courses.mooc.fi). The agent can be Claude Code or Codex. You describe what you want, for example "add an example about while loops to chapter 2" or "check the links in my course", and the agent makes the changes for you.

Your changes don't go live straight away. The agent saves them as a draft that you can review. Students see the changes only after they are published. Changes that could affect students, for example deleting an exercise that students have already answered, always need your approval on courses.mooc.fi.

## What you need

- A teacher account on courses.mooc.fi with access to the course.
- Claude Code or Codex installed on your computer.
- Git installed on your computer.
- Optional: Node.js, if you want the agent to check pages in a browser.

## Set up

The setup asks which agent you use. It then installs the skills, connects your agent to courses.mooc.fi and opens a browser so that you can sign in.

**macOS and Linux:** open Terminal and run:

```bash
curl -fsSL https://raw.githubusercontent.com/rage/course-material-agent-skills/main/setup/install.sh | bash
```

**Windows:** open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/rage/course-material-agent-skills/main/setup/install.ps1 | iex
```

When you sign in, courses.mooc.fi asks what the agent may do:

- **Read course material.** This is always needed.
- **Prepare changes.** The agent can save changes as drafts.
- **Publish changes.** The agent can publish safe changes after you ask it to. If you uncheck this, you publish everything yourself on courses.mooc.fi.
- **Change course settings.** For example, completion rules. This is off by default.

You can remove the agent's access at any time on your account page on courses.mooc.fi.

## Use

Start your agent and ask for what you need. For example:

- "List my courses on courses.mooc.fi."
- "Add a short summary at the end of each page in chapter 3."
- "Split chapter 4 into two chapters."
- "Check the language of the first chapter. Use plain language."
- "Check the accessibility of the course front page."
- "Update the English version of the course to match the Finnish version."

The agent tells you what it changed. When it is done, it either publishes the changes after you have asked it to, or gives you a link to a review page on courses.mooc.fi. On the review page, you can see each change and publish or discard it.

The agent can also undo changes. Ask it, for example: "Undo the changes you made to page Variables."

## Updates

The agent updates the skills itself when courses.mooc.fi tells it that a new version is available. You don't need to do anything. The setup lets the agent update without asking you each time.

To update by hand, run the setup again, or run this command:

```bash
git -C ~/.claude/skills/course-material pull --ff-only    # Claude Code
git -C ~/.agents/skills/course-material pull --ff-only    # Codex
```

## Remove

1. Remove the connection: `claude mcp remove courses-mooc-fi` or `codex mcp remove courses-mooc-fi`.
2. Delete the skills folder: `~/.claude/skills/course-material` (Claude Code) or `~/.agents/skills/course-material` (Codex). For Claude Code, also delete the links called `course-material-...` in `~/.claude/skills`.
3. Remove the agent's access on your account page on courses.mooc.fi.

## Problems

- **The agent says it can't find the courses.mooc.fi tools.** Start a new session. In Claude Code, type `/mcp` and sign in to `courses-mooc-fi`. In Codex, run `codex mcp login courses-mooc-fi`.
- **Codex says the protocol version isn't supported.** Run the setup again. It turns on the newer protocol version that courses.mooc.fi uses.
- **The agent can't update the skills.** You may have changed files in the skills folder. Move your changes away and run the setup again.
- **The agent doesn't check pages in a browser.** Install Node.js and run the setup again, and answer yes to playwright-cli.

## Setup options

The setup scripts accept options, for example for developers who use a local development server:

```bash
curl -fsSL https://raw.githubusercontent.com/rage/course-material-agent-skills/main/setup/install.sh | bash -s -- --agent claude --server-url http://project-331.local/api/v0/mcp
```

| install.sh | install.ps1 | Meaning |
|---|---|---|
| `--agent claude\|codex` | `-Agent claude\|codex` | Which agent to set up |
| `--server-url URL` | `-ServerUrl URL` | MCP server address (default `https://courses.mooc.fi/api/v0/mcp`) |
| `--server-name NAME` | `-ServerName NAME` | Name of the connection in the agent (default `courses-mooc-fi`) |
| `--playwright`, `--no-playwright` | `-Playwright yes\|no` | Install playwright-cli for browser checks, or skip it |
| `--yes` | `-Yes` | Use the defaults without asking |

On Windows, download `install.ps1` and run it as a file to pass parameters.

### What the setup does

1. Checks that git and your agent are installed.
2. Downloads this repository into your agent's skills folder: `~/.claude/skills/course-material` for Claude Code, `~/.agents/skills/course-material` for Codex.
3. Claude Code only: links each task skill in `skills/` into `~/.claude/skills`, because Claude Code finds skills only one folder deep. A git hook keeps the links up to date after updates. Codex finds the task skills inside the folder by itself.
4. Connects the agent to the MCP server with `claude mcp add --transport http --scope user` or `codex mcp add --url`, and starts the sign-in. For Codex, it first turns on the `mcp_2026_07_28` feature, which the server needs.
5. Allows the exact update command `git -C <skills folder> pull --ff-only` without asking: an allow rule in `~/.claude/settings.json`, or a rule file in `~/.codex/rules/`.
6. Optionally installs playwright-cli and its skill.

## For maintainers

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Apache License 2.0. See [LICENSE](LICENSE).
