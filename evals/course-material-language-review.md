# Evals: course-material-language-review

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Proofread with markup

**State:** a Finnish page has two spelling errors, one inside a paragraph with a link, `[latex]` and a `\cite{}`; an exercise's task instructions have a typo.
**Request:** "Oikolue luku 2."
**Expected:** reads outline first, then raw blocks, and the exercise with `get_exercise`; reports the errors by page and short quote; after approval replaces the text attributes with link, LaTeX and citation unchanged and edits the exercise instructions with `patch_exercise`; re-reads each edited block (`get_exercise` for the exercise).

## 2. Unify a term

**State:** pages use both "e-mail" and "email", "email" more often.
**Request:** "Make the spelling consistent."
**Expected:** proposes the course's majority form and asks before changing; does the change as a bulk edit per the `course-material` skill (search, check matches, `expected_count`).

## 3. Meaning-changing "fix"

**State:** a sentence is grammatical but, read literally, says something the teacher may not mean.
**Expected:** reports it as a question; doesn't edit it.

## 4. Course style sheet

**State:** the course consistently uses ” ” quotes, "sinä" and "tehtävä".
**Request:** "Oikolue luku 1."
**Expected:** lists the conventions in the report and offers them as one offer; saves only the lines the teacher approves.

## 5. Doubled word

**State:** "the the" appears on a page.
**Expected:** found by reading, without a `find_replace` backreference.

## 6. Glossary term

**State:** the glossary defines "algoritmi"; a page uses "algoritmin" in a different sense.
**Expected:** reports the use; doesn't rewrite the sentence to force the term.

## 7. Overstated certainty

**State:** a page says "Studies prove that spaced practice always works."
**Expected:** in a language review alone, reports the wording by `honesty.md` and leaves the meaning to the teacher. In a full review with claims checked, the finding appears once, from the claim check.

## 8. Spelling variety

**State:** an English course mixes "colour" and "color"; most pages and the teacher's own messages use British spelling.
**Expected:** infers British spelling from the course and the teacher's writing, reports the American forms as inconsistencies, and doesn't ask the teacher which variety to use.

## 9. Concise, not flattened

**Request:** "Make the introduction page easier to read."
**State:** the page repeats its goal in three paragraphs and uses the field's precise terms correctly.
**Expected:** cuts the repetition as padding; keeps the precise terms, the teacher's register and direct address; doesn't simplify the text into easy-to-read Finnish, swap terms for everyday words or cut nuance to shorten sentences; doesn't change meaning or touch code samples; shows before and after for each rewritten passage and waits for approval.

## 10. Each text in its style

**Request:** "Improve the language of chapter 4."
**State:** chapter 4 has an explanatory page, a page of deadlines and grading, and a deliberately dense source reading the teacher quotes at length.
**Expected:** reads `styles.md`; reviews the explanation as explanatory text and the deadlines page as instructional text; leaves the source reading's register alone and checks only its findability; never applies one style to all three. In a Finnish course, the explanation keeps "sinä" and doesn't turn passive or official, and clarity findings on the deadlines may cite the Kotus guidance.
