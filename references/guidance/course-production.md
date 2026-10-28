# Planning, evaluating and improving a course

How to advise a teacher who asks how to plan a course, decide between designs, judge whether a change worked, or keep a course correct over time. Read it for those questions, not for routine checks.

## What to check

- **Start from outcomes**: before discussing activities, ask what students should know and be able to do at the end, and what evidence would show it; then plan activities. [Wiggins-2005]
- **Name the trade-off**: when the teacher weighs two designs, state what each costs (time, effort, scale, accessibility, assessment security) and what it buys. Suggest the decision questions below for consequential choices. (editorial)
- **Constraints before optimisation**: accuracy, honesty, safety where relevant, legal and accessibility obligations are not traded for engagement or cost. Clarity, variety, efficiency and maintainability are. (editorial)
- **"Scores went up, so the change worked"**: suggest the other explanations (different cohort, easier exam, changed grading, more tutoring, dropouts, outside help) and a fairer comparison before drawing the conclusion, and say where the result was observed rather than claiming it works everywhere. [WWC-2022]
- **Satisfaction as learning**: course feedback scores read as learning; the finding is `course-material/references/guidance/engagement.md` **Enjoyment treated as evidence of learning**. For a course evaluation, suggest pairing the scores with a learning measure, ideally after a delay. [Uttl-2017]
- **Process proportional to risk**: a low-stakes tutorial needs light review; safety-critical, certification or professional courses need specialist review, documented checks and validation. Don't recommend paperwork that supports no decision. (editorial)
- **Pilot one unit first**: suggest building and testing one representative unit before the whole course; it exposes structural problems while they are cheap to fix. (editorial)

## Background

### Goals and trade-offs

| Dimension | Question |
|---|---|
| Accuracy and justification | Are claims correct and supported in the way their field requires? |
| Understanding and retention | Do students build accurate models and remember them later? |
| Competence and judgment | Can they apply knowledge, evaluate evidence, weigh alternatives? |
| Methods | Do the activities support the intended outcomes? |
| Motivation | Do students have reasons and chances to keep going? |
| Assessment | Do results justify the conclusions drawn from them? |
| Access and fairness | Can students show the competence without irrelevant barriers? |
| Sustainability | Can the course be maintained and corrected? |

Goals often conflict: more review of basics leaves less time for advanced topics; formal proofs deepen understanding for prepared students and lose beginners; authentic projects cost instructor time and are hard to grade consistently; personal feedback is costly at scale; strict exam controls can create access and privacy problems. Make the conflict explicit rather than pretending one design serves all. (editorial, after [HPL-2018])

### Decision questions

For consequential choices: What outcome are we after? Which constraints are fixed? What alternatives exist? What does each gain and cost? What evidence supports that, and how sure is it? What resources does each use? What will we measure to know if it was right? When do we reconsider? Example: more syntax drills or more debugging practice depends on whether syntax is actually what limits these students now. (editorial)

### Evaluating a change

A causal claim asks what would have happened to comparable students without the change. A before-and-after score difference alone can't answer it. [WWC-2022]

| Approach | Gives | Main limits |
|---|---|---|
| Interviews, observation | Where students get confused | Not evidence of improvement |
| Formative assessment analysis | Specific gaps | Only as good as the questions |
| Before/after comparison | Change over time | Cohort, maturation, test changes |
| Concurrent comparison group | Better contrast | Groups may differ |
| Quasi-experiment | Stronger causal evidence | Needs baseline equivalence; confounding |
| Randomised evaluation | Strongest causal evidence | Feasibility, contamination, generalisation |

[WWC-2022]

Routine course revision doesn't need a trial; claims just shouldn't exceed the design. (editorial)

Protocol when the teacher wants to know whether a change helped: define the change and the outcomes; pick measures; get a baseline; use a comparison where feasible; record how the change was delivered; check attrition, missing data and outside help; report effect sizes with uncertainty; look for side effects; separate what was observed from what caused it; revise in proportion to the evidence. [WWC-2022]

Assessment results are evidence for particular interpretations, not general proof of quality; check what a score can support before using it to judge a change. [Standards-2014]

### Claim register

For consequential, disputed, fast-changing or easily misread claims, a teacher can record the exact claim, its sources and their kind, uncertainty, limits, counterevidence, the teaching decision it supports, and what would trigger a revision; not for every sentence. (editorial) Example: spaced retrieval improves delayed retention; effects depend on task, learner, schedule and test; so students retrieve key knowledge across several sessions; revise on strong contrary evidence or local problems. [Carpenter-2022]

### Quality gates

Before publishing, check subject accuracy, justified claims, alignment, fair and reliable-enough assessment, accessibility (tools and people), runnable code and data, learner try-outs and a correction process, scaled to the consequences of error; the evidence behind each check matters, not the ticked box. (editorial)

### Production phases

1. Define the problem: audience, needs, prerequisites, outcomes, resources, constraints, relevant standards. Deliverable: design brief.
2. Curriculum architecture: concept dependencies, course and unit outcomes, difficulty progression, mastery expectations, retention and transfer plan. Deliverable: curriculum map.
3. Assessment: intended inferences, formats, scoring, reliability needs, fairness, formative vs summative use, feedback. Deliverable: assessment blueprint.
4. Material: explanations, examples, diagrams, recall and guided exercises, independent problems, applications, feedback, references. Deliverable: one complete representative unit.
5. Validation: subject, method, pedagogy, assessment and accessibility review; learner testing; technical checks. Deliverable: revised material.
6. Publish and improve: version control, error reporting, corrections, evidence updates, outcome monitoring, periodic review. Deliverable: maintainable course.

(editorial, after [Wiggins-2005]; outcome monitoring and periodic review in phase 6 [ABET-2026])

### Worked example: algorithmic complexity

Module question: why isn't the algorithm with the better asymptotic bound always faster? Outcomes range from recalling notation to justifying an algorithm choice. Lessons: (1) predict whether insertion sort can beat merge sort on small inputs, then short recall questions on notation; (2) guided then independent complexity analysis, separating upper bounds, tight bounds and exact counts; (3) benchmarks under documented conditions; (4) critique "better worst case, so always faster" and rewrite the conclusion; (5) recommend an algorithm for a specified scenario. Each assessment supports one inference and has a stated limit: a definition quiz shows knowledge, not application; a benchmark report depends on its environment; a delayed unfamiliar problem tests retention and transfer. Not every exercise tests every competence. (editorial)

## Sources

- [ABET-2026] ABET. *Criteria for Accrediting Engineering Programs, 2026–2027* (Criterion 4, Continuous Improvement). Accreditation standard. https://www.abet.org/accreditation/accreditation-criteria/criteria-for-accrediting-engineering-programs-2026-2027/. Checked 2026-10-29.
- [Carpenter-2022] Carpenter, S. K., Pan, S. C., & Butler, A. C. (2022). *The science of effective learning with spacing and retrieval practice*. Nature Reviews Psychology. Research review. https://doi.org/10.1038/s44159-022-00089-1. Checked 2026-10-29.
- [HPL-2018] National Academies of Sciences, Engineering, and Medicine (2018). *How People Learn II: Learners, Contexts, and Cultures*. Consensus report. https://doi.org/10.17226/24783. Checked 2026-10-29.
- [Standards-2014] AERA, APA, & NCME (2014). *Standards for Educational and Psychological Testing*. Professional standard (open access). https://www.testingstandards.net/open-access-files.html. Checked 2026-10-29.
- [Uttl-2017] Uttl, B., White, C. A., & Gonzalez, D. W. (2017). *Meta-analysis of faculty's teaching effectiveness: Student evaluation of teaching ratings and student learning are not related*. Studies in Educational Evaluation. Meta-analysis. https://doi.org/10.1016/j.stueduc.2016.08.007. Checked 2026-10-29.
- [Wiggins-2005] Wiggins, G., & McTighe, J. (2005). *Understanding by Design* (2nd ed.). ASCD. Design framework, as summarised by MIT Teaching + Learning Lab, *Backward Design*. https://tll.mit.edu/teaching-resources/course-design/backward-design/. Checked 2026-10-29.
- [WWC-2022] Institute of Education Sciences (2022). *What Works Clearinghouse Procedures and Standards Handbook, Version 5.0* (rev. December 2022). Evaluation standard. https://ies.ed.gov/ncee/wwc/Handbooks. Checked 2026-10-29.
