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

## 3. Plain-language rewrite keeps the voice

**Request:** "Make the introduction page easier to read."
**Expected:** shows before and after for each rewritten passage and waits for approval; keeps the teacher's terms, register and direct address, and uses the fallback writing style only where the teacher's style doesn't settle it; doesn't change meaning or touch code samples; cuts padding and repetition, but doesn't replace precise terms with vaguer everyday words or cut nuance to shorten sentences.

## 4. Routing

**Request:** "Translate chapter 1 into Swedish."
**Expected:** doesn't use this skill; uses `course-material-translation-sync` when a Swedish version exists, else asks the teacher.

## 5. Meaning-changing "fix"

**State:** a sentence is grammatical but, read literally, says something the teacher may not mean.
**Expected:** reports it as a question; doesn't edit it.

## 6. Course style sheet

**State:** the course consistently uses ” ” quotes, "sinä" and "tehtävä".
**Request:** "Oikolue luku 1."
**Expected:** lists the conventions in the report and offers them as one offer; saves only the lines the teacher approves.

## 7. Doubled word

**State:** "the the" appears on a page.
**Expected:** found by reading, without a `find_replace` backreference.

## 8. Glossary term

**State:** the glossary defines "algoritmi"; a page uses "algoritmin" in a different sense.
**Expected:** reports the use; doesn't rewrite the sentence to force the term.

## 9. Overstated certainty

**State:** a page says "Studies prove that spaced practice always works."
**Expected:** in a language review alone, reports the wording by `honesty.md` and leaves the meaning to the teacher. In a full review with claims checked, the finding appears once, from the claim check.

## 10. Spelling variety

**State:** an English course mixes "colour" and "color"; most pages and the teacher's own messages use British spelling.
**Expected:** infers British spelling from the course and the teacher's writing, reports the American forms as inconsistencies, and doesn't ask the teacher which variety to use.

## 11. Concise, not flattened

**Request:** "Proofread the introduction."
**State:** the page repeats its goal in three paragraphs and uses the field's precise terms correctly.
**Expected:** reports the repetition as padding; keeps the precise terms; doesn't simplify the text into easy-to-read Finnish or swap terms for everyday words.

## 12. Explanations keep a book's register

**Request:** "Oikolue luku 2."
**State:** chapter 2 explains its topic in the teacher's voice, addressing the student as "sinä" and building an argument over several paragraphs; its first page has the chapter's deadlines.
**Expected:** fixes spelling and punctuation by the ohjepankki and reports unclear sentences; doesn't make the explanation impersonal or official (no passive or "opiskelija" in place of "sinä"); clarity findings for the deadline text may cite the Kotus official-language guidance.

## 13. Each text in its style

**Request:** "Improve the language of chapter 4."
**State:** chapter 4 has an explanatory page, a page of deadlines and grading, and a deliberately dense source reading the teacher quotes at length.
**Expected:** reads `styles.md`; reviews the explanation as explanatory text and the deadlines page as instructional text; leaves the source reading's register alone and checks only its findability; never applies one style to all three.
