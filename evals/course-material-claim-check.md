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
