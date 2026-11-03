# Set up and use the skills

With these skills, an AI agent on your computer can check and maintain your course material on [courses.mooc.fi](https://courses.mooc.fi).

> [!IMPORTANT]
> Use the agent responsibly. You are responsible for your course material, including what the agent writes. The agent can make mistakes, so read its changes before they are published and check the facts it adds.

## What you need

- A teacher account on courses.mooc.fi with access to the course.
- Claude Code or Codex on your computer. Other AI agents may work too.
- Git on your computer.

The agent installs the rest.

## Set up

Start Claude Code or Codex and paste this:

```text
Set up the course material skills from https://github.com/rage/course-material-agent-skills. Clone the repository into your user-level skills folder as course-material (Claude Code: .claude/skills/course-material in my home folder, or skills/course-material in $CLAUDE_CONFIG_DIR if it is set; Codex: .agents/skills/course-material in my home folder; use the full path); if that folder already exists, update it with git pull --ff-only instead. Then read AGENT-SETUP.md in it and follow it.
```

The agent explains each step and asks before it changes anything. It also installs tools for checking pages in a browser. If it can't install something, it gives you the commands to run. At the end, it tells you what to do next.

## Permissions at sign-in

When you sign in, courses.mooc.fi asks what the agent may do:

- **Read the material of the courses you teach.** Required.
- **Make changes to course material that you review before they are published.**
- **Publish changes that do not affect students' answers, points or access.** The agent publishes only when you ask. Without this, you publish everything yourself.
- **Change course settings.** For example, completion rules.

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

## Review and publishing

The agent saves changes as drafts. Students see them only after they are published.

When the agent is done, it publishes the changes if you asked it to. Otherwise it gives you a link to a review page on courses.mooc.fi, where you can see each change and publish or discard it.

Changes that could affect students, for example deleting an exercise that students have already answered, you always publish yourself on the review page.

## Undo

Ask the agent, for example: "Undo the changes you made to page Variables."

## What the agent remembers

The agent remembers your rules and preferences when you ask it to or agree to its offer, for example "Headings in sentence case" or "Chapter 5 is frozen". It also keeps short notes about each course. You can read and edit all of this in the `.local` folder inside the skills folder.

The agent always asks you before it publishes, makes changes that could affect students, installs software or runs code, even if you said yes earlier.

If you use both Claude Code and Codex, each remembers separately.

If you want skills of your own, the agent can keep them in a private repository for you.

## Updates

The agent updates the skills itself when courses.mooc.fi says that a new version is available. Updates never change what the agent remembers.

## Remove

> [!CAUTION]
> Deleting the skills folder also deletes what the agent remembers. To keep it, first copy the `.local` folder somewhere else.

1. Remove the connection: run `claude mcp remove courses-moocfi` (Claude Code) or `codex mcp remove courses-moocfi` (Codex).
2. Delete the skills folder: `~/.claude/skills/course-material` (Claude Code) or `~/.agents/skills/course-material` (Codex).
3. Claude Code: in `~/.claude/skills`, delete the links whose names start with `course-material-` and the links to your own skills. In `~/.claude/settings.json`, delete the `git -C ... pull --ff-only` lines under `permissions.allow`.
4. Codex: delete `~/.codex/rules/course-material-agent-skills.rules`.
5. Remove the agent's access on your account page on courses.mooc.fi.

## Problems

- **The agent can't find the courses.mooc.fi tools.** Start a new session. In Claude Code, type `/mcp` and sign in to `courses-moocfi`. In Codex, run `codex mcp login courses-moocfi`.
- **Codex says the protocol version isn't supported.** Run `codex features enable mcp_2026_07_28` and start a new session.
- **The agent can't update the skills.** You may have changed files in the skills folder. Ask the agent to show what changed, and move your changes elsewhere. The `.local` folder can stay.
- **To update by hand**, run `git -C ~/.claude/skills/course-material pull --ff-only` (Claude Code) or `git -C ~/.agents/skills/course-material pull --ff-only` (Codex).
- **Something else in the setup is missing.** Paste the setup prompt again. The agent redoes only the missing steps.
