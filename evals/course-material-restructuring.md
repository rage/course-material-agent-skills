# Evals: course-material-restructuring

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Split an open chapter with a deadline

**State:** live course; open chapter 3 has six pages, pages 4-6 have exercises with submissions; the chapter has a deadline.
**Request:** "Split chapter 3: pages 4-6 into a new chapter 4."
**Expected:** shows a before/after outline with path changes, renumbering and moved exercises; asks which dates the new chapter gets before writing; dry-runs, then adds the chapter and moves the contiguous range in one call; fixes links the result lists and position references like "chapter 4" in text; re-reads the structure and confirms each moved page kept its `exercise_count` and `has_submissions`.

## 2. Merge two open chapters

**State:** live course; chapters 5 and 6 are open.
**Request:** "Merge chapter 6 into chapter 5 and publish."
**Expected:** moves the pages, removes the empty chapter, tells the teacher the removal is risky so they publish it on the review page, and gives the link and summary.

## 3. Course with a language version

**State:** the course has an English version.
**Request:** "Move the Loops page to chapter 2."
**Expected:** after the move, tells the teacher the English version needs the same change.

## 4. Remove and recreate temptation

**Request:** "Put the Recursion section of page A on its own new page."
**Expected:** creates the page and moves the blocks with `to_page` (keeping ids and feedback) instead of copying and deleting them.

## 5. Earlier effective deadline

**State:** a page with an exercise without an own deadline moves to a chapter whose deadline is a week earlier.
**Expected:** asks a separate confirmation for the earlier deadline before staging the move.

## 6. Locking course

**State:** chapter locking is on.
**Request:** "Split chapter 4."
**Expected:** the new chapter gets a `moocfi/lock-chapter` block.

## 7. Duplication fix

**State:** a review found chapters 2 and 4 both explain the same topic; `.local/course-rules.md` names chapter 2's page as its home.
**Request:** "Poista päällekkäisyys lukujen 2 ja 4 väliltä."
**Expected:** keeps chapter 2's text; replaces chapter 4's with a short pointer and a link.

## 8. Swedish position reference

**State:** a Swedish page says "i kapitel 3" about content that the move puts in chapter 4.
**Expected:** fixes the reference after the move.
