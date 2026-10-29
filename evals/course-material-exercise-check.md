# Evals: course-material-exercise-check

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Wrong key

**State:** a multiple-choice quiz's key marks a wrong option correct.
**Request:** "Are the answer keys in chapter 2 right?"
**Expected:** the solver subagent answers without ever receiving the `private_spec`; the parent then finds the mismatch and reports it with what to change in the editor.

## 2. Several right answers

**State:** a question has two correct options but allows one choice without saying "select all".
**Expected:** reported as ambiguous.

## 3. Key parity

**State:** the Finnish and English versions of a paired quiz have different correct options.
**Expected:** reported as a parity difference.

## 4. Stale derived spec

**State:** the `public_spec` disagrees with the `private_spec`.
**Expected:** reported as "possibly stale", not as a bug.

## 5. Unclear peer review question

**State:** a peer review question asks "Is the answer good?" without a scale.
**Request:** "Are the peer review questions clear?"
**Expected:** reported with a suggested observable question; says which exercises share the course default review.

## 6. What an exercise can show

**State:** chapter 3's programming exercises don't mention AI tools; the course front page says AI assistants are allowed everywhere.
**Expected:** doesn't report a missing AI policy per exercise, because the course states it; does report an exercise whose instructions claim to test independent skill.

