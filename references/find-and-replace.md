# Find and replace

## `find_replace`

```json
{"course":"c1","scope":{"chapter":"ch3"},"find":"muuttuja","replace":"variable","expected_count":4,"dry_run":true}
{"course":"c1","scope":{"page":"pg1"},"find":"Python ?3\\.\\d+","regex":true,"replace":"Python 3.13"}
{"course":"c1","find":"deprecated"}
{"course":"c1","find":"example.com","attributes":["href","/^url$/"]}
```

- `scope` is `{"chapter": "<id>"}` or `{"page": "<id>"}`; without it the whole course is searched.
- Without `replace`, it only searches and returns the matching blocks with their paths. Searching needs only the `material:read` permission; replacing needs `material:stage`.
- `regex: true` treats `find` as a regular expression; otherwise it's literal.
- `expected_count` makes the call fail unless exactly that many matches are found. Use it on every real replacement, with the count from the dry run.

### What it matches

- Literal search matches **whole words**: where `find` starts or ends with a letter or digit, the match must start or end at a word edge. `kurssi` doesn't match inside `kurssilla`, and `cat` doesn't match `category`. Use `regex: true` for partial words.
- It matches the **raw stored string** of text attributes, which is HTML. Markup is part of the text: `<em>for</em> loops` doesn't match "for loops", and `&amp;` is how `&` is stored. Read the block in raw mode when a match you expect is missing.
- By default it searches a fixed list of text attributes: content, captions, alt texts, headings and titles. To search others, such as link targets, pass `attributes` with exact names (`"href"`) or regular expressions on attribute names (`"/^url$/"`).
- It also searches exercises' task and review instructions (`include_exercise_instructions`, default `true`; pass `false` to skip them). Exercise names are searched only with `include_exercise_names: true`. Nothing else in an exercise is searched or changed.
- A match in the course default review instructions is edited once and listed under `course_default_review_config` in the result. It changes every exercise that uses the default. `find_replace` never forks an exercise's review config.
- Matching is case-sensitive unless your regex says otherwise.

### Inflected forms

In languages such as Finnish a word appears in many forms (*kurssi*, *kurssin*, *kurssilla*). Because literal search matches whole words, those forms aren't changed; the result lists them as inflected variants instead. Handle each one explicitly, with its own replacement, or tell the teacher. Never assume one replacement covers them all.

### Safe procedure

1. Search without `replace`, or with `dry_run: true`.
2. Look at every match in context; drop the replacement if any match is wrong and use targeted page ops instead.
3. Run the replacement with `expected_count`.
4. Check a sample of changed pages with `read_back` or a read.

## `structural_replace`

Finds blocks by type and text, then wraps, retypes, unwraps or deletes them:

```json
{"course":"c1","match":{"name":"core/paragraph","text_starts_with":"Note:"},"action":{"wrap_in":"moocfi/infobox"},"dry_run":true}
{"course":"c1","scope":{"chapter":"ch3"},"match":{"name":"core/quote"},"action":{"retype_to":"core/pullquote"},"expected_count":2}
{"course":"c1","match":{"name":"moocfi/infobox","text_contains":"TODO"},"action":{"unwrap":true},"dry_run":true}
```

- `match`: any of `name` (block type), `text_starts_with`, `text_contains`, `text_regex` (on the visible text, without markup). All given fields must match.
- `include_exercise_instructions`: also match blocks in exercises' task and review instructions. Default `true`.
- `action`: exactly one of `wrap_in` (wrap each match in a new block of that type), `retype_to` (change the type, keeping attributes and children), `unwrap: true` (replace a container with its children), `remove: true`.

Matches in the course default review instructions change it for every exercise using it; `structural_replace` never forks. Always dry-run first and check the list of matched blocks. Deleting through `structural_replace` follows the same risk rules as any other removal.

## Size

There is no cap on how many places one call changes. A course-wide change is one call and one entry in history, and can be reverted as one. Large changes are not risky by size alone, but the teacher should hear what changed.
