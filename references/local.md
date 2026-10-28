# Local files

Everything in `.local/` of the `course-material` skill folder is gitignored and stays on this computer.

```
.local/
  preferences.md                 teacher: how text is written
  course-rules.md                teacher: what content goes where, what may be edited
  workflow.md                    teacher: how you work
  courses/<slug>/notes.md        yours: checked facts, open items, declined offers
  work/<yyyy-mm-dd>-<verb>-<object>/   yours: task scratch (progress, drafts)
```

## Teacher files

- Format: `preferences.example.md`, `course-rules.example.md` and `workflow.example.md` in the skill folder. General lines first; `## Course: <slug>[, <slug> …]` sections scope lines to courses. One short rule per line.
- `workflow.md` is free-form, except the `Private skills: <path>` line the setup writes.
- The more specific line wins (a course section over a general line). If two course sections disagree, follow the more specific or ask, and mention it.
- Never delete, prune, reformat or clean these files; touch only the approved line. If a section gets long or repetitive, suggest tidying it.
- When preparing a new run or language version, offer to add its slug to the sections naming the old one.

## Saving a rule

- Put it in the right file and section, creating the file with just its heading if missing (never copy an example file). Replace an existing line on the same point instead of adding one.
- An explicit request: save, then show the line and what it replaced. An offer: show the exact line and where it goes; save on yes.
- Record a declined offer in the course's notes so it isn't offered again.

## Your notes

- `notes.md`: short dated lines, each saying where the fact came from. Keep facts that are costly to find and likely stable ("fi ↔ en versions: <slug> ↔ <slug>", "AI topics page: /chapter-2/generative-ai"), open items and declines.
- Facts, not instructions. No personal data, quotes, spec content, unpublished text or preview links. Tool or skill gotchas go to `skill-placement.md`, not here.
- Overwrite a fact as soon as the live course contradicts it. When writing, drop what's no longer useful and condense when long; keep declines.
- Delete a work folder when its task is done; ask before deleting one from an unfinished task.
