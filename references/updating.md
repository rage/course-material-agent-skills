# Keeping this skill up to date

When a result says this skill is out of date, or the server refuses a call because the version is below its minimum:

1. Unless the teacher has asked you to check with them first, run exactly `git -C ${CLAUDE_SKILL_DIR} pull --ff-only`. `${CLAUDE_SKILL_DIR}` is the folder of the `course-material` `SKILL.md`, one level above this file; if your client shows it literally, use the folder's absolute path, quoted if it has spaces.
2. Read `SKILL.md` and `VERSION` again and send the new version from then on.
3. If the pull fails (local changes, no network, no git), stop and tell the teacher the error. Never reset, stash, delete or re-clone the folder.
