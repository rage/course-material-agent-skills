# Where a teacher's skill goes

Read this when the teacher wants to create or change a skill. Recommend a place and ask every time; the teacher decides.

Recommend the public repository for skills every teacher can use the same way, such as checks and maintenance. Recommend the teacher's own repository for skills that depend on their own way of working: personal workflows, steps for one course, anything that mentions unpublished material or people, and skills that draft larger amounts of content. When unsure, recommend their own repository.

## Public repository

`rage/course-material-agent-skills`. Changes go in as a pull request that the maintainers review (CONTRIBUTING.md); never push to it or change the installed clone. Help the teacher draft the change, or an issue describing it.

A tool or skill gotcha you ran into (a misleading tool result, a rule that led you wrong) belongs in a drafted issue for this repository, without course content or personal data; the teacher decides whether to file it. Never record it in `.local/`.

## The teacher's own repository

Its path is the `Private skills: <path>` line in `.local/workflow.md` of the `course-material` skill folder. If the line is missing, offer to set the repository up as in step 6 of AGENT-SETUP.md.

- One folder per skill, `skills/<name>/SKILL.md`; the `name` matches the folder and never starts with `course-material`.
- Write it like the public skills: the description says what it does and when to use it; the body holds only what the agent wouldn't do right unaided.
- After a change the teacher approved: commit with a one-line message, and push if the repository has a remote.
- Teacher guidance documents (named in `.local/guidance.md`) go in its `guidance/` folder.
- Claude Code: a new skill needs linking. Run the repository's post-merge hook, or the link command from AGENT-SETUP.md step 6.
