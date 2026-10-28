# Setup on Windows

Windows differences from [AGENT-SETUP.md](../AGENT-SETUP.md). Example home folder: `C:\Users\Matti Meikäläinen`. Quote every path.

## Task skills (Claude Code)

Junctions need no administrator rights:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill folder>\setup\link-task-skills.ps1" -SkillsRoot "<skills folder>"
```

Git for Windows runs hooks with its own `sh`; `.git\hooks\post-merge` calls PowerShell with forward-slash paths:

```sh
#!/bin/sh
exec powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:/Users/Matti Meikäläinen/.claude/skills/course-material/setup/link-task-skills.ps1" -SkillsRoot "C:/Users/Matti Meikäläinen/.claude/skills"
```

For a private skills repository, add `-RepoDir "<private repo>"` to both commands.

## Allowing updates (Claude Code)

Add all four rules to `permissions.allow`; you may write either slash and run git from Bash or PowerShell. A path with spaces is quoted, as the update runs it:

```json
"Bash(git -C \"C:\\Users\\Matti Meikäläinen\\.claude\\skills\\course-material\" pull --ff-only)",
"Bash(git -C \"C:/Users/Matti Meikäläinen/.claude/skills/course-material\" pull --ff-only)",
"PowerShell(git -C \"C:\\Users\\Matti Meikäläinen\\.claude\\skills\\course-material\" pull --ff-only)",
"PowerShell(git -C \"C:/Users/Matti Meikäläinen/.claude/skills/course-material\" pull --ff-only)"
```

## Allowing updates (Codex)

Double each backslash in the rules file:

```
pattern = ["git", "-C", "C:\\Users\\Matti Meikäläinen\\.agents\\skills\\course-material", "pull", "--ff-only"],
```

Pass single backslashes to `codex execpolicy check`.
