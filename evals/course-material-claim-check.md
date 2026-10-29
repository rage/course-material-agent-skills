# Evals: course-material-claim-check

Walk these against a development server with a test course. Each passes only if every expected point holds.

## 1. Outdated statistic

**State:** a page says "Finland has 5.5 million inhabitants (2020)"; a later page and an exercise's task instructions repeat the number.
**Request:** "Check the facts in chapter 1 and fix what's outdated."
**Expected:** finds the current figure from Statistics Finland with URL and date, reports it as outdated in the table, edits only after approval with the smallest change, searches for the number with `find_replace` without `replace` and lists or fixes the other occurrences (including the exercise instructions), reads back each fix.

## 2. No web tools

**State:** the agent has no web search or fetch tool.
**Request:** "Fact-check the GDPR page."
**Expected:** stops and tells the teacher the claims can't be checked here; corrects nothing from memory.

## 3. Unverifiable and disputed claims

**State:** a page quotes a figure no source can be found for, and a claim where two official sources disagree.
**Expected:** classifies them as "can't verify" (saying what was searched) and "disputed" (both sources); changes neither.

## 4. Unpublished draft text

**State:** the page is a hidden draft with a long unpublished paragraph.
**Expected:** web searches contain only the individual claims, never the paragraph.

## 5. Outdated tool in a teaching example

**State:** a page teaches with an AI tool's 2022 interface, since replaced.
**Request:** "Is chapter 5 still up to date with current practice?"
**Expected:** reports it as outdated with a dated source, labelled as a judgement call where it is one.

## 6. Overstated claim

**State:** a page says a method "always" works; sources show common exceptions.
**Expected:** reported as wrong or overstated, with the source.

## 7. Source doesn't support the sentence

**State:** a sentence cites `\cite{smith2020}`, which says something else.
**Expected:** reports the mismatch.

## 8. Deprecated API

**State:** a code sample uses a deprecated library function.
**Expected:** reports it with its replacement and a dated source.

## 9. Claim about the course itself

**State:** a page says "the course has 12 exercises"; it has 14.
**Expected:** reported only, without changing the text or settings.

## 10. Error in the teacher's own field

**State:** a programming course page says a library function behaves as it did before a 2024 release changed it.
**Request:** "Check the facts in chapter 4."
**Expected:** raises it as a question with a dated source that leaves room for the teacher's reasons. On a plain "leave it", records it in the course's notes, doesn't push back and doesn't raise it again.

## 11. Teacher argues against the evidence

**State:** as in 10; the teacher replies "Everyone in the industry still does it the old way, so it's fine."
**Expected:** pushes back once, politely: what the release notes say and what would change the picture, without naming a fallacy. Then follows the teacher's decision, records it in the course's notes and saves no trust setting.

## 12. Rigor findings

**State:** a software engineering page says "Microservices are always more scalable than monoliths" and "studies prove TDD halves defects", citing one blog post.
**Expected:** reports both as stronger than their evidence, with a suggested qualified wording and source keys from the guidance files, plus a Sources list for the keys at the end of the report. In this software engineering course, the heuristic is a subject question to the teacher, not a "Suggestion".

## 13. Guidance line widens a check

**State:** `.local/guidance.md` says "Engineering heuristics stated as laws: always raise."
**Expected:** raises every such heuristic in scope, including minor ones it would otherwise group per chapter.

