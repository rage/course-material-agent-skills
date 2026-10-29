# Accessibility: WCAG 2.2 and the law

Which WCAG criteria are the teacher's to meet in course content and how much each matters, and, when the teacher asks, what the law requires.

## What it is

Web Content Accessibility Guidelines 2.2, a W3C Recommendation first published on 5 October 2023; the current edition is dated 12 December 2024. Free. Finnish law refers to WCAG 2.1 AA (see **Is it required?**); agents may target 2.2 AA. [W3C-2024] [Traficom-WCAG21]

## When it fits

Fits:
- Whenever content is added or edited: images, headings, links, lists, tables, embedded media, exercise instructions. Every course language.
- Accessibility review, and writing new pages.

Doesn't fit:
- The site's header, footer, player, theme, keyboard and focus behaviour, the accessibility statement and the institution's compliance: not the teacher's content.
- Linked files the agent can't open: list them as not checked.

## Applies here

- **1.1.1 Non-text Content (A)**: High. Informative images, charts and diagrams the teacher adds.
- **1.3.1 Info and Relationships (A)**: High. Headings, lists and table headers built with the editor's blocks, not formatting.
- **2.4.4 Link Purpose (In Context) (A)**: High. Link texts.
- **1.4.1 Use of Color (A)**, **1.3.3 Sensory Characteristics (A)**: High. Exercise instructions and figure references.
- **2.4.6 Headings and Labels (AA)**: High. Headings the teacher writes.
- **1.2.1–1.2.3, 1.2.5 (A, AA)**: Medium. Media the teacher adds; the agent can check that captions or a transcript exist, not their quality. 1.2.4 (live captions) doesn't concern course pages.
- **1.4.3 Contrast (Minimum) (AA)**, **1.4.11 Non-text Contrast (AA)**: Medium. Colours the teacher sets in text, charts and diagrams; contrast inside images usually can't be measured.
- **1.4.5 Images of Text (AA)**: Medium. Screenshots of tables, code or slides.
- **2.4.2 Page Titled (A)**, **3.1.2 Language of Parts (AA)**, **3.3.2 Labels or Instructions (A)**: Medium. Page titles; passages in another language, where the editor allows marking them; exercise instructions.
- **1.3.2 Meaningful Sequence (A)**, **2.2.2 Pause, Stop, Hide (A)**, **2.3.1 Three Flashes (A)**, **1.4.2 Audio Control (A)**, **3.1.1 Language of Page (A)**, **4.1.2 Name, Role, Value (A)**: Low. Reading order in tables and side-by-side layouts; animated images and autoplaying media; the course language setting; a title for embedded iframes.
- Not the teacher's content: resize, reflow, text spacing, keyboard, focus, target size, authentication and navigation criteria. AAA criteria aren't required.

## Is it required?

Read only when the teacher asks whether something is required, or what to do with old files, videos or third-party embeds. Directive (EU) 2016/2102 covers public-sector websites; Finland implements it in Act 306/2019, supervised by Traficom. The harmonised standard is EN 301 549 V3.2.1. Facts per Traficom. [EC-WAD] [Traficom-scope]

- **Level**: the Act requires WCAG 2.1 A and AA, except 1.2.4 live captions. [Traficom-WCAG21]
- **Teaching material**: material used year after year, and online courses, are covered; only temporary content, e.g. for one term, is not. [Traficom-exempt]
- **Recordings**: those published from 23 September 2020 must be accessible. Live broadcasts are exempt, but a recording kept online must be made accessible within 14 days. Automatic captions need human editing. [Traficom-media] [Traficom-periods]
- **Office files**: those published before 23 September 2018 are exempt unless needed to exercise rights or duties. [Traficom-periods]
- **Third-party content** the organisation neither funds, develops nor controls is exempt. [Traficom-exempt]
- **EN 301 549**: ETSI also lists V4.1.1, dated 2 September 2026; don't assume it is in force. [ETSI-301549]

## How agents use it

- Name the criterion in each accessibility finding. Say "required" only for what **Is it required?** supports; otherwise "recommended".
- Never tell a teacher something is legally exempt: report the facts, don't rule. Never claim conformance.
- The teacher and `course-rules.md` come first (`course-material/references/writing/styles.md` **Whose style comes first**).

## Sources

- [W3C-2024] W3C (2024). *Web Content Accessibility Guidelines (WCAG) 2.2*. Recommendation, free. https://www.w3.org/TR/WCAG22/; history: https://www.w3.org/standards/history/WCAG22/. Checked 2026-10-29.
- [EC-WAD] European Commission. *Web accessibility*. Free. https://digital-strategy.ec.europa.eu/en/policies/web-accessibility. Checked 2026-10-29.
- [Traficom-scope] Traficom. *Scope: does the Act apply to us?* Free guidance. https://www.saavutettavuusvaatimukset.fi/en/scope-does-act-apply-us. Checked 2026-10-29.
- [Traficom-exempt] Traficom. *Mitä palveluja ja sisältöjä laki koskee*. Free guidance, Finnish. https://www.saavutettavuusvaatimukset.fi/fi/mita-palveluja-ja-sisaltoja-laki-koskee. Checked 2026-10-29.
- [Traficom-periods] Traficom. *Transition periods*. Free guidance. https://www.saavutettavuusvaatimukset.fi/en/transition-periods. Checked 2026-10-29.
- [Traficom-media] Traficom. *Videoiden ja äänilähetysten saavutettavuus*. Free guidance, Finnish. https://www.saavutettavuusvaatimukset.fi/fi/videoiden-ja-aanilahetysten-saavutettavuus. Checked 2026-10-29.
- [Traficom-WCAG21] Traficom. *WCAG 2.1 -ohjeistuksen vaatimukset laissa*. Free guidance, Finnish. https://www.saavutettavuusvaatimukset.fi/fi/wcag-21-lain-vaatimukset. Checked 2026-10-29.
- [ETSI-301549] ETSI. *EN 301 549 versions*. Free downloads. https://www.etsi.org/deliver/etsi_en/301500_301599/301549/. Checked 2026-10-29.
- The legal texts: Directive (EU) 2016/2102, https://eur-lex.europa.eu/eli/dir/2016/2102/oj, and Act 306/2019, https://www.finlex.fi/fi/lainsaadanto/2019/306. Reached, not read.
