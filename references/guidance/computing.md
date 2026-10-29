# Computing and mathematics

What to notice in computer science, software engineering, programming and mathematics material. Read it when the course teaches one of these.

## What to check

- **Which kind of claim**: a statement about an algorithm (provable), a program (testable), a system in production (needs empirical evidence and requirements) or a practice (context-dependent). Flag text that justifies one kind with evidence suited to another, e.g. "the proof shows the program is fast". [CS2023] [SWEBOK-2025]
- **Big-O read as speed**: "O(n log n), so it is always faster than O(n²)". Suggest the qualification: asymptotic bounds ignore constants, input size and hardware; for small or nearly sorted inputs the "slower" algorithm can win. (editorial)
- **Upper bound read as exact cost**: Big-O used where the text means a tight bound (Θ) or an exact count. Suggest the precise term where the course has introduced it. (editorial)
- **Tests read as proof**: "all tests pass, so the program is correct". Testing shows behaviour on the inputs tried; suggest "passes these tests". (editorial)
- **Verification read as a guarantee**: a verified property holds relative to the specification and to assumptions about compiler, hardware and environment. [Fetzer-1988] A wrong specification is verified just as well. (editorial)
- **Benchmarks without conditions**: a measured speed-up stated without hardware, versions, compiler and runtime settings, inputs, warm-up, repetitions and variation. Small setup changes (environment size, link order) can flip a result; suggest stating the conditions or softening to "in this setup". [Mytkowicz-2009] [Georges-2007]
- **Engineering heuristics stated as laws**: "microservices are better than monoliths", "static typing prevents bugs", "TDD produces better software", "more abstraction is more maintainable", "OOP (or FP) is superior". Suggest naming the context and trade-off. Evidence on several is mixed or weak: TDD shows a small quality gain and an unclear productivity effect; a much-cited language/defect association largely failed reanalysis. [Rafique-2013] [Berger-2019]
- **Experience presented as research**: "teams that do X ship faster" from one author's career. Suggest labelling it as experience, or citing evidence. [Kitchenham-2004]
- **Mental-model shortcuts**: "a variable is a box" or similar, never revisited when references, aliasing or mutation arrive. Suggest a later page that refines it, or a wording that fits the course's language (e.g. in Python, "assignment binds a name to an object"). [Sorva-2013] [Qian-2018]
- **Known misconceptions not addressed**: assignment as equality, a variable holding several values, loops "remembering", references copied as values, recursion as looping. Where the material introduces these constructs, check it shows the execution, not just the syntax. [duBoulay-1986] [Qian-2018]
- **Only code-writing exercises**: no reading, tracing, predicting output or explaining code before writing. Tracing and explaining correlate with writing ability and may be stepping stones; suggest adding some. [Lister-2004] [Lopez-2008]
- **Debugging never taught**: errors appear only as fixed code. Suggest an exercise that isolates a fault systematically (reproduce, hypothesise, test, fix). [McCauley-2008]
- **Copy-adapt without understanding**: exercises solvable by pattern-matching the example. Suggest a modify-then-make step or asking students to predict before running. [Sentance-2019]
- **Worked examples without labelled steps**: long solutions shown in one block. Labelling subgoals helps novices transfer the method. [Morrison-2015]
- **Generated code or text unchecked**: AI-generated examples, explanations or citations in the material. Check code runs, explanations match the code, and cited sources exist. [Prather-2023]
- **Mathematics: examples as proof**: "it works for n = 1…5, so it holds for all n". Suggest marking it as a pattern or conjecture, then proving it or saying the proof is omitted. [Stylianides-2009]
- **Mathematics: procedures vs concepts**: a chapter of only procedures, or only concepts, with no link between them. The two support each other; suggest one exercise connecting them. [RittleJohnson-2015]

## Background

**Three distinct things.** Computer science studies computation, algorithms and languages through proof, formal methods, analysis and experiment. Software engineering develops and maintains software under real constraints: requirements, cost, risk, people. Programming is a skill central to both but equal to neither. Check that the course says which of the three it aims at. [CS2023] [SWEBOK-2025]

| Claim | Suitable justification |
|---|---|
| An algorithm meets a complexity bound | Proof |
| A program passed a test suite | Recorded test results |
| A function meets a formal specification | Verification argument, relative to the spec |
| An implementation is fastest for a workload | Controlled benchmark with stated conditions |
| A system is usable for its users | Usability evidence with those users |
| A system is secure against named threats | Threat analysis, testing, review; never one alone |

(editorial, after [SWEBOK-2025] and [NIST-2022])

**Execution model.** Novices struggle less with syntax than with the "notional machine": what the computer does when a program runs (values, bindings, control flow, scope, references, state, recursion). Material that shows execution step by step addresses the root of many difficulties. [Sorva-2013] [duBoulay-1986]

**Programming competencies.** Reading, tracing, predicting, explaining, writing, testing, debugging, refactoring and maintaining are related but separate skills. Recognising a solution, reproducing a shown one and solving a new problem are different levels. A typical progression: questions about constructs, reading and predicting output, tracing, completing partial programs, modifying examples, debugging, writing independently, testing and explaining, larger design. Illustrative, not mandatory. [Lopez-2008] [Sentance-2019]

**Engineering trade-offs.** Correctness, security, reliability, performance, maintainability, scalability, development and operating cost, complexity, usability and team skills pull against each other. The best choice is the one justified against the stated requirements, not the most elegant. [SWEBOK-2025]

**Evidence in software engineering.** Distinguish proven properties, empirical findings, expert recommendations, industry conventions, context-dependent heuristics and personal preference. The field lacks medicine's evidence infrastructure, and practitioner skill confounds many comparisons, so strong general claims about practices deserve caution. [Kitchenham-2004] Curriculum guides say what practitioners should know, not which practice is best. [CS2023] [SWEBOK-2025]

**AI-assisted programming.** In one exploratory study (37 students, 23 used a GPT-3.5 chatbot, one task, one course), most of the 23 eventually asked it for a full solution, and many cycled through wrong generated code. [Rahe-2025] It may not generalise. (editorial) In a controlled study with 69 novices aged 10–17, access to Codex raised code-writing scores without lowering later manual code-modification performance. [Kazemitabaar-2023] Findings depend on the tool, task, learners and how use is structured; treat any single study as tentative and expect results to date quickly. [Prather-2023] [Denny-2024]

**Mathematics.** Theorems are established by proof; examples build intuition and suggest conjectures but don't establish a general claim. Students often accept empirical checks as proof and need to see why they fall short. [Stylianides-2009] Procedural fluency and conceptual understanding support each other; evidence doesn't favour one fixed order of teaching them. [RittleJohnson-2015]

## Sources

- [Berger-2019] Berger, E. D., Hollenbeck, C., Maj, P., Vitek, O., & Vitek, J. (2019). *On the Impact of Programming Languages on Code Quality: A Reproduction Study*. ACM Transactions on Programming Languages and Systems. Reanalysis. https://doi.org/10.1145/3340571. Checked 2026-10-29.
- [CS2023] Kumar, A. N., Raj, R. K., et al. (2024). *Computer Science Curricula 2023*. ACM, IEEE-CS, AAAI. Curriculum guideline. https://doi.org/10.1145/3664191. Checked 2026-10-29.
- [Denny-2024] Denny, P., Prather, J., Becker, B. A., et al. (2024). *Computing Education in the Era of Generative AI*. Communications of the ACM. Review. https://doi.org/10.1145/3624720. Checked 2026-10-29.
- [duBoulay-1986] du Boulay, B. (1986). *Some Difficulties of Learning to Program*. Journal of Educational Computing Research. Review. https://doi.org/10.2190/3LFX-9RRF-67T8-UVK9. Checked 2026-10-29.
- [Fetzer-1988] Fetzer, J. H. (1988). *Program Verification: The Very Idea*. Communications of the ACM. Philosophical argument. https://doi.org/10.1145/48529.48530. Checked 2026-10-29.
- [Georges-2007] Georges, A., Buytaert, D., & Eeckhout, L. (2007). *Statistically Rigorous Java Performance Evaluation*. OOPSLA. Methodology study. https://doi.org/10.1145/1297027.1297033. Checked 2026-10-29.
- [Kazemitabaar-2023] Kazemitabaar, M., Chow, J., Ma, C. K. T., Ericson, B. J., Weintrop, D., & Grossman, T. (2023). *Studying the Effect of AI Code Generators on Supporting Novice Learners in Introductory Programming*. CHI. Controlled experiment. https://doi.org/10.1145/3544548.3580919. Checked 2026-10-29.
- [Kitchenham-2004] Kitchenham, B. A., Dybå, T., & Jørgensen, M. (2004). *Evidence-Based Software Engineering*. ICSE. Position paper. https://doi.org/10.1109/ICSE.2004.1317449. Checked 2026-10-29.
- [Lister-2004] Lister, R., Adams, E. S., Fitzgerald, S., et al. (2004). *A Multi-National Study of Reading and Tracing Skills in Novice Programmers*. ITiCSE working group. Empirical study. https://doi.org/10.1145/1041624.1041673. Checked 2026-10-29.
- [Lopez-2008] Lopez, M., Whalley, J., Robbins, P., & Lister, R. (2008). *Relationships Between Reading, Tracing and Writing Skills in Introductory Programming*. ICER. Empirical study. https://doi.org/10.1145/1404520.1404531. Checked 2026-10-29.
- [McCauley-2008] McCauley, R., Fitzgerald, S., Lewandowski, G., et al. (2008). *Debugging: A Review of the Literature from an Educational Perspective*. Computer Science Education. Review. https://doi.org/10.1080/08993400802114581. Checked 2026-10-29.
- [Morrison-2015] Morrison, B. B., Margulieux, L. E., & Guzdial, M. (2015). *Subgoals, Context, and Worked Examples in Learning Computing Problem Solving*. ICER. Experiment. https://doi.org/10.1145/2787622.2787733. Checked 2026-10-29.
- [Mytkowicz-2009] Mytkowicz, T., Diwan, A., Hauswirth, M., & Sweeney, P. F. (2009). *Producing Wrong Data Without Doing Anything Obviously Wrong!* ASPLOS. Empirical study. https://doi.org/10.1145/1508244.1508275. Checked 2026-10-29.
- [NIST-2022] Souppaya, M., Scarfone, K., & Dodson, D. (2022). *Secure Software Development Framework (SSDF) Version 1.1*. NIST SP 800-218. Guideline. https://csrc.nist.gov/pubs/sp/800/218/final. Checked 2026-10-29.
- [Prather-2023] Prather, J., Denny, P., Leinonen, J., et al. (2023). *The Robots Are Here: Navigating the Generative AI Revolution in Computing Education*. ITiCSE working group report. Review. https://doi.org/10.1145/3623762.3633499. Checked 2026-10-29.
- [Qian-2018] Qian, Y., & Lehman, J. (2018; online 2017). *Students' Misconceptions and Other Difficulties in Introductory Programming: A Literature Review*. ACM Transactions on Computing Education, 18(1). Review. https://doi.org/10.1145/3077618. Checked 2026-10-29.
- [Rafique-2013] Rafique, Y., & Mišić, V. B. (2013). *The Effects of Test-Driven Development on External Quality and Productivity: A Meta-Analysis*. IEEE Transactions on Software Engineering. Meta-analysis. https://doi.org/10.1109/TSE.2012.28. Checked 2026-10-29.
- [Rahe-2025] Rahe, C., & Maalej, W. (2025). *How Do Programming Students Use Generative AI?* Proceedings of the ACM on Software Engineering (FSE). Exploratory experiment. https://doi.org/10.1145/3715762. Checked 2026-10-29.
- [RittleJohnson-2015] Rittle-Johnson, B., Schneider, M., & Star, J. R. (2015). *Not a One-Way Street: Bidirectional Relations Between Procedural and Conceptual Knowledge of Mathematics*. Educational Psychology Review. Review. https://doi.org/10.1007/s10648-015-9302-x. Checked 2026-10-29.
- [Sentance-2019] Sentance, S., Waite, J., & Kallia, M. (2019). *Teaching Computer Programming with PRIMM: A Sociocultural Perspective*. Computer Science Education. Quasi-experiment, 493 students aged 11–14. https://doi.org/10.1080/08993408.2019.1608781. Checked 2026-10-29.
- [Sorva-2013] Sorva, J. (2013). *Notional Machines and Introductory Programming Education*. ACM Transactions on Computing Education. Review. https://doi.org/10.1145/2483710.2483713. Checked 2026-10-29.
- [Stylianides-2009] Stylianides, A. J., & Stylianides, G. J. (2009). *Facilitating the Transition from Empirical Arguments to Proof*. Journal for Research in Mathematics Education. Design experiment. https://doi.org/10.5951/jresematheduc.40.3.0314. Checked 2026-10-29.
- [SWEBOK-2025] IEEE Computer Society (2024, rev. 2025). *Guide to the Software Engineering Body of Knowledge, Version 4.0a*. Body of knowledge. https://www.computer.org/education/bodies-of-knowledge/software-engineering. Checked 2026-10-29.
