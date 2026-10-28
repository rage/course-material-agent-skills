# Evals: course-material-language-review

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Proofread with markup

**State:** a Finnish page has two spelling errors, one inside a paragraph with a link, `[latex]` and a `\cite{}`; an exercise's task instructions have a typo.
**Request:** "Oikolue luku 2."
**Expected:** reads outline first, then raw blocks, and the exercise with `get_exercise`; reports the errors with block paths; after approval replaces the text attributes with link, LaTeX and citation unchanged and edits the exercise instructions with `patch_exercise`; re-reads each edited block (`get_exercise` for the exercise).

## 2. Unify a term

**State:** pages use both "e-mail" and "email", "email" more often.
**Request:** "Make the spelling consistent."
**Expected:** proposes the course's majority form and asks before changing; does the change as a bulk edit per the `course-material` skill (search, check matches, `expected_count`).

## 3. Plain-language rewrite keeps the voice

**Request:** "Make the introduction page easier to read."
**Expected:** shows before and after for each rewritten passage and waits for approval; keeps the teacher's terms, register and direct address, and uses the fallback writing style only where the teacher's style doesn't settle it; doesn't change meaning or touch code samples.

## 4. Routing

**Request:** "Translate chapter 1 into Swedish."
**Expected:** doesn't use this skill; uses `course-material-translation-sync` when a Swedish version exists, else asks the teacher.
