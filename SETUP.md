# Set up and use the skills

With these skills, an AI agent on your computer can check and maintain your course material on [courses.mooc.fi](https://courses.mooc.fi).

## What you need

- A teacher account on courses.mooc.fi with access to the course.
- Claude Code or Codex installed on your computer. Other agents that support skills and MCP servers may work too.
- Git installed on your computer.
- Optional: Node.js, if you want the agent to check pages in a browser.

## Set up

Start Claude Code or Codex and paste this:

```text
Set up the course material skills from https://github.com/rage/course-material-agent-skills. Clone the repository into your user-level skills folder as course-material (Claude Code: .claude/skills/course-material in my home folder, or skills/course-material in $CLAUDE_CONFIG_DIR if it is set; Codex: .agents/skills/course-material in my home folder; use the full path); if that folder already exists, update it with git pull --ff-only instead. Then read AGENT-SETUP.md in it and follow it.
```

The agent explains each step and asks you before it changes anything. It asks, for example, whether you want a private repository for your own skills and whether to install the tools for checking pages in a browser. At the end, you restart the agent and sign in to courses.mooc.fi in your browser.

[AGENT-SETUP.md](AGENT-SETUP.md) lists exactly what the agent does. To use a development server, add its address to the prompt.

## Permissions at sign-in

When you sign in, courses.mooc.fi asks what the agent may do:

- **Read course material.** This is always needed.
- **Prepare changes.** The agent can save changes as drafts.
- **Publish changes.** The agent can publish safe changes after you ask it to. If you uncheck this, you publish everything yourself on courses.mooc.fi.
- **Change course settings.** For example, completion rules. This is off by default.

You can remove the agent's access at any time on your account page on courses.mooc.fi.

## Use

Start your agent and ask for what you need. For example:

- "List my courses on courses.mooc.fi."
- "Check part 3: links, language and facts." ("Tarkista osa 3: linkit, kieli ja faktat.")
- "Split chapter 4 into two chapters."
- "Update the English version of the course to match the Finnish version."
- "I copied last year's course. Prepare it for the autumn run."
- "A student wrote that the example on page 2 has an error." (Paste the message.)
- "Read chapter 3 as a beginner would. Where would students get stuck?"
- "How should I structure the exercises in chapter 2?"

The agent tells you what it changed.

## What the agent remembers

The agent saves rules when you ask it to, when you say yes to its offer, and when you state a writing preference as a standing rule ("never use sinä in this course"): then it saves it straight away and tells you how to undo it. It keeps them in four files in the `.local` folder inside the skills folder:

- `preferences.md`: how text is written, for example "Headings in sentence case."
- `course-rules.md`: what content goes where and what the agent may edit, for example "Chapter 5 is frozen."
- `workflow.md`: how the agent works, for example which checks a review includes.
- `guidance.md`: how far the agent relies on its guidance on scientific rigor and teaching, for example "Statistics: I'm the expert here." When you clearly show how you feel about that guidance, by saying so or by declining the same kind of suggestion several times, the agent saves it here straight away and tells you. It can also point to your own guidance documents in your private skills repository.

You can edit these files yourself. The files `preferences.example.md`, `course-rules.example.md`, `workflow.example.md` and `guidance.example.md` in the skills folder show the format. The agent never deletes them.

The agent also keeps short notes about each course there, such as which courses are language versions of each other, and keeps them tidy.

Some things are never remembered: the agent always asks you before it publishes, makes changes that could affect students, installs software or runs code.

The `.local` folder stays on your computer. It is lost if you delete the skills folder or clone it again. If you use two agents, for example Claude Code and Codex, each has its own folder and its own memory.

## Your own skills

If you want skills of your own, the agent can keep them in a private repository and helps you decide what belongs there and what could be proposed to this repository.

## Review and publishing

Changes don't go live straight away. The agent saves them as a draft. Students see the changes only after they are published.

When the agent is done, it either publishes the changes after you have asked it to, or gives you a link to a review page on courses.mooc.fi. On the review page, you can see each change and publish or discard it.

Changes that could affect students, for example deleting an exercise that students have already answered, always need your approval on courses.mooc.fi.

## Undo

The agent can undo changes. Ask it, for example: "Undo the changes you made to page Variables."

## Updates

The agent updates the skills itself when courses.mooc.fi tells it that a new version is available. You don't need to do anything. The updates come from this public repository, and the setup lets the agent fetch them without asking you each time. Updates never change what the agent remembers.

To update by hand, run this command:

```bash
git -C ~/.claude/skills/course-material pull --ff-only    # Claude Code
git -C ~/.agents/skills/course-material pull --ff-only    # Codex
```

## Remove

1. Remove the connection: `claude mcp remove courses-moocfi` or `codex mcp remove courses-moocfi`.
2. To keep what the agent remembers, copy the `.local` folder out first. Delete the skills folder: `~/.claude/skills/course-material` (Claude Code) or `~/.agents/skills/course-material` (Codex). For Claude Code, also delete the links called `course-material-...` and the links to your private skills in `~/.claude/skills`, and the `git -C ... pull --ff-only` entries in `permissions.allow` of `~/.claude/settings.json`. For Codex, delete `~/.codex/rules/course-material-agent-skills.rules`. The private skills repository and the playwright-cli skill are yours to keep or delete.
3. Remove the agent's access on your account page on courses.mooc.fi.

## Problems

- **The agent says it can't find the courses.mooc.fi tools.** Start a new session. In Claude Code, type `/mcp` and sign in to `courses-moocfi`. In Codex, run `codex mcp login courses-moocfi`.
- **Codex says the protocol version isn't supported.** Run `codex features enable mcp_2026_07_28` and start a new session.
- **The agent can't update the skills.** You may have changed files in the skills folder. Ask the agent to show what changed, and move your changes away; the `.local` folder can stay.
- **Something else in the setup is missing.** Paste the setup prompt again. The agent updates what's there and redoes only the missing steps.

## Installed with the old setup script?

Nothing changes for you: your installation keeps updating. For a repair, paste the setup prompt above.
