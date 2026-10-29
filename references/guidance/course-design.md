# Course design

How a course's parts fit together: outcomes, order, depth and consistency. Read it when reviewing a chapter or a whole course as a learning sequence, or when the teacher asks how to structure material.

## What to check

- **Vague objectives**: objectives like "understand functions" or "know the basics" that no exercise could show were met. "Understand" can mean anything from restating to synthesising. Ask what a student who understands could do, and suggest observable objectives: "predict what a simple function returns; write a function that meets a specification". Don't turn important abilities into trivial behaviours. [Wiggins-2005] [Biggs-1996] [Krathwohl-2002]
- **Outcome level read from the verb**: an objective judged too low or too high by its verb alone. Verb lists disagree, and the same verb ("explain", "select") appears at several levels; judge the level by what the student must do with what, and against the course's place in the programme. Bloom's revised taxonomy and SOLO help name the level and spot what's missing (Background); they classify, they are not evidence. [Newton-2020] [Krathwohl-2002] [Biggs-1982]
- **Outcomes, teaching and exercises out of line**: an objective nothing teaches or nothing assesses, content no objective or exercise uses, or exercises that test something other than what the objective says. Report the mismatch per objective; the `course-material-student-walkthrough` skill runs this check objective by objective. [Biggs-1996] [Wiggins-2005]
- **Core content not marked**: a chapter where what later chapters and exercises depend on gets the same space and emphasis as detail that's nice to know, or where the core is buried in it. Suggest marking the core and making the rest visibly optional; caveats that change the meaning stay core (**Limitations hidden in optional depth**). Fixed percentage splits between core and extra content are rules of thumb. [HYPE-2026] (editorial)
- **Workload not estimated from the student's side**: credits stated, but no estimate of a typical student's time per part, or some weeks much heavier than the rest. Suggest adding up the tasks at a student's pace, telling students the estimate, and checking it against their reports. A credit is typically 25–30 hours; individual time varies. Enough time is the precondition for a manageable workload, and in one school's survey clearer expectations improved perceived workload. [ECTS-2015] [Kyndt-2013] [Scully-2014]
- **Order that breaks prerequisites**: a concept used before the page that introduces it. List the dependency and where it's first taught. The right order depends on the subject and approach; check only that each page has what it needs. [HPL-2018] (editorial) Prior knowledge predicts final scores well, but its effect on how much students learn varies widely between settings, so check the actual gap. [Simonsmeier-2022]
- **Hard transitions passed quickly**: concepts that need students to rebuild their mental model get the same space as routine material. Suggest more examples, practice and a diagnostic question there. [Meyer-2005] Typical cases: proof, limits, references vs values, recursion, statistical inference, concurrency; calling one a "threshold concept" needs a specific argument. (editorial)
- **Mastery as one fixed percentage**: a single pass mark for everything. Suggest criteria that fit what's at stake: some errors may be unacceptable in a safety-critical procedure whatever the total, while a low-stakes quiz can lead to feedback and more practice. Mastery programmes help, most for weaker students, but cost time and can lower completion in self-paced courses. [Kulik-1990]
- **Immediate success read as lasting competence**: a chapter that only checks performance right after a worked example. Suggest a later, unfamiliar question that checks retention and transfer. [Barnett-2002] [HPL-2018]
- **Inconsistency across chapters**: the same concept defined differently, changed notation or terminology, conflicting mental models, or examples that assume different prior knowledge. Report each with both locations. (editorial)
- **Simplification that misleads**: a beginner explanation that later has to be unlearned, or a universal claim where the truth has conditions. Suggest a simplification that stays true and leaves room to refine it. Example: "electrons orbit the nucleus like planets" vs "a simple model gives electrons fixed energy levels; a later chapter refines it". [Smith-1994] (editorial)
- **Limitations hidden in optional depth**: a caveat that changes how the main explanation should be understood, placed only in an "extra" box. Suggest moving it into the main text; proofs, history and advanced cases can stay optional. (editorial)
- **Decorative or distant visuals**: images that add interest but nothing to understand, or a diagram far from the text that explains it. Suggest removing the decoration or placing words and picture together. [Mayer-2017] [Rey-2012] Diagrams suit processes, structures, relationships and program execution. (editorial)
- **Missing reference features**: definitions far from first use, no glossary entry for a term used across chapters, no summary or cross-references in a long chapter. Suggest the one or two that would help most; not every course needs every feature. (editorial)

## Background

### A flexible lesson shape

A useful order, not a required procedure: purpose, prior knowledge, accurate core explanation, worked examples, reasoning and justification, guided practice, limitations and counterexamples, independent application, later revisit. (editorial)

A chapter often contains these parts. Not every chapter needs all of them in equal measure; each should serve a stated outcome. (editorial)

| Part | Purpose |
|---|---|
| Motivating problem | Why this matters |
| Learning objectives | What students should be able to do |
| Prerequisite check | Whether they're ready |
| Core explanation and worked examples | Accurate concepts and the method in action |
| Recall, guided and conceptual exercises | Strengthen knowledge with support |
| Independent and new-context problems | Competence and transfer |
| Limitations | Where the idea stops applying |
| Feedback, summary, later retrieval | Correct errors and retain |
| Further reading | Optional depth |

### Common pedagogical problems

| Problem | Consequence |
|---|---|
| Conclusions taught without the reasons for them | Students repeat conclusions they can't evaluate |
| Memorisation without understanding | Students can't apply ideas in new situations |
| Too little scaffolding | Students meet complexity without support |
| Poor progression | Concepts arrive before their prerequisites |
| Misconceptions ignored | Wrong mental models persist |
| Reading without practice | Students recognise but can't do |
| Assessments testing only recall or imitation | Intended skills go unmeasured |
| Outdated content without context | Students learn superseded information |

[HPL-2018] [Kirschner-2006] [Smith-1994] (editorial)

### Taxonomies of outcomes

Bloom's revised taxonomy crosses six cognitive processes (remember, understand, apply, analyse, evaluate, create) with four kinds of knowledge (factual, conceptual, procedural, metacognitive). Placing a chapter's objectives, activities and exercises in that table shows gaps, such as no procedural or metacognitive objective, and mismatches between them. Its categories overlap; the hierarchy is looser than the original's. [Krathwohl-2002] SOLO describes how an answer is structured, from unconnected bits through listed points to related and generalised ones, so it suits level descriptions for open answers. [Biggs-1982]

### Retention and transfer

Distinguish performance right after teaching, retention after a delay, near transfer (similar situations) and far transfer (different ones). Each needs its own evidence. Transfer depends on many dimensions (content, setting, time, format), so a single "does it transfer" answer is misleading. [Barnett-2002]

## Sources

- [Barnett-2002] Barnett, S. M., & Ceci, S. J. (2002). *When and where do we apply what we learn? A taxonomy for far transfer*. Psychological Bulletin. Research review. https://doi.org/10.1037/0033-2909.128.4.612. Checked 2026-10-29.
- [Biggs-1982] Biggs, J. B., & Collis, K. F. (1982). *Evaluating the Quality of Learning: The SOLO Taxonomy*. Academic Press. Book, framework. https://doi.org/10.1016/C2013-0-10375-3. Checked 2026-10-29.
- [Biggs-1996] Biggs, J. (1996). *Enhancing teaching through constructive alignment*. Higher Education. Design framework. https://doi.org/10.1007/BF00138871. Checked 2026-10-29.
- [ECTS-2015] European Commission (2015). *ECTS Users' Guide 2015*. Publications Office of the European Union. Official guide. https://doi.org/10.2766/87192. Checked 2026-10-29.
- [HPL-2018] National Academies of Sciences, Engineering, and Medicine (2018). *How People Learn II: Learners, Contexts, and Cultures*. Consensus report. https://doi.org/10.17226/24783. Checked 2026-10-29.
- [HYPE-2026] University of Helsinki, Centre for University Teaching and Learning (HYPE) (2026). *Constructive Alignment in Course Design*. Open online course. https://courses.mooc.fi/org/uh-hype/courses/course-design-in-higher-education. Checked 2026-10-29.
- [Kirschner-2006] Kirschner, P. A., Sweller, J., & Clark, R. E. (2006). *Why Minimal Guidance During Instruction Does Not Work*. Educational Psychologist. Theoretical argument and review. https://doi.org/10.1207/s15326985ep4102_1. Checked 2026-10-29.
- [Krathwohl-2002] Krathwohl, D. R. (2002). *A Revision of Bloom's Taxonomy: An Overview*. Theory Into Practice. Framework overview by a co-author of the revision. https://doi.org/10.1207/s15430421tip4104_2. Checked 2026-10-29.
- [Kulik-1990] Kulik, C.-L. C., Kulik, J. A., & Bangert-Drowns, R. L. (1990). *Effectiveness of Mastery Learning Programs: A Meta-Analysis*. Review of Educational Research. Meta-analysis. https://doi.org/10.3102/00346543060002265. Checked 2026-10-29.
- [Kyndt-2013] Kyndt, E., Berghmans, I., Dochy, F., & Bulckens, L. (2013). *'Time is not enough.' Workload in higher education: a student perspective*. Higher Education Research & Development. Interview study, 40 students. https://doi.org/10.1080/07294360.2013.863839. Checked 2026-10-29.
- [Mayer-2017] Mayer, R. E. (2017). *Using multimedia for e-learning*. Journal of Computer Assisted Learning. Research review. https://doi.org/10.1111/jcal.12197. Checked 2026-10-29.
- [Meyer-2005] Meyer, J. H. F., & Land, R. (2005). *Threshold concepts and troublesome knowledge (2): Epistemological considerations and a conceptual framework for teaching and learning*. Higher Education. Conceptual framework. https://doi.org/10.1007/s10734-004-6779-5. Checked 2026-10-29.
- [Newton-2020] Newton, P. M., Da Silva, A., & Peters, L. G. (2020). *A Pragmatic Master List of Action Verbs for Bloom's Taxonomy*. Frontiers in Education. Document analysis of 47 verb lists. https://doi.org/10.3389/feduc.2020.00107. Checked 2026-10-29.
- [Rey-2012] Rey, G. D. (2012). *A review of research and a meta-analysis of the seductive detail effect*. Educational Research Review. Meta-analysis. https://doi.org/10.1016/j.edurev.2012.05.003. Checked 2026-10-29.
- [Scully-2014] Scully, G., & Kerr, R. (2014). *Student Workload and Assessment: Strategies to Manage Expectations and Inform Curriculum Development*. Accounting Education. Survey study. https://doi.org/10.1080/09639284.2014.947094. Checked 2026-10-29.
- [Simonsmeier-2022] Simonsmeier, B. A., Flaig, M., Deiglmayr, A., Schalk, L., & Schneider, M. (2022). *Domain-specific prior knowledge and learning: A meta-analysis*. Educational Psychologist. Meta-analysis. https://doi.org/10.1080/00461520.2021.1939700. Checked 2026-10-29.
- [Smith-1994] Smith, J. P., diSessa, A. A., & Roschelle, J. (1994). *Misconceptions Reconceived: A Constructivist Analysis of Knowledge in Transition*. Journal of the Learning Sciences. Theoretical analysis. https://doi.org/10.1207/s15327809jls0302_1. Checked 2026-10-29.
- [Wiggins-2005] Wiggins, G., & McTighe, J. (2005). *Understanding by Design* (2nd ed.). ASCD. Design framework, as summarised by MIT Teaching + Learning Lab, *Backward Design*. https://tll.mit.edu/teaching-resources/course-design/backward-design/. Checked 2026-10-29.
