# Evals: routing

Walk by hand when a description changes. Give a fresh session only every skill's name and description and ask, for each request, which skills it would load. One trial per row; rerun a failing row three times, and it fails if two of the three miss.

A row passes when the expected task skill is among those loaded (with `course-material`), or `course-material` alone where that is expected. An extra neighbouring skill is a warning, not a failure.

| Request | Expected |
|---|---|
| Tarkista osa 3: linkit, kieli, väitteet ja ehdota parannuksia | review |
| I inherited this course, what's wrong with it? | review |
| Granska kapitel 1 | review |
| Find duplicated content in the course | review |
| Do the code examples in chapter 3 still run? | review |
| Check the dates in the course (a running course) | review |
| Do the points in the text match the settings? | review |
| Tarkista linkit luvussa 2 | link-check |
| Onko luvun 3 videot vielä katsottavissa? | link-check |
| Is chapter 5 still up to date with current practice? | claim-check |
| Onko tämä materiaali ajan tasalla? | claim-check |
| Etsi tutkimusta hajautetun harjoittelun hyödyistä luvun 3 sivua varten | research |
| What do practitioners say about React Server Components for our web course? | research |
| I need sources for a new page on code review | research |
| Kirjoita uusi sivu testivetoisesta kehityksestä lähteineen | research |
| Oikolue johdanto | language-review |
| Korrekturläs sidan | language-review |
| Check alt texts and headings | accessibility-review |
| Onko kurssi saavutettava? | accessibility-review |
| Jaa luku 4 kahdeksi | restructuring |
| Poista päällekkäisyys lukujen 2 ja 4 väliltä | restructuring |
| Päivitä englanninkielinen versio vastaamaan suomenkielistä | translation-sync |
| Is the English translation correct? | translation-sync |
| Kopioin viime vuoden kurssin, valmistele syksyn toteutus | new-run |
| Onko kurssi valmis avattavaksi maanantaina? | new-run |
| Opiskelija sanoo, että tehtävän 3.4 ohje on ristiriidassa materiaalin kanssa | student-feedback |
| A student emailed that the link on page 2 is wrong (pasted email) | student-feedback |
| Read chapter 3 as a beginner would | student-walkthrough |
| Vastaako sisältö osaamistavoitteita? | student-walkthrough |
| Tarkista luvun 2 monivalintatehtävät | exercise-check |
| Are the peer review questions clear? | exercise-check |
| How should I structure the exercises in chapter 2? | design-advice |
| Are these exercises good practice? | design-advice |
| Are the learning objectives in chapter 2 taught and practised? | student-walkthrough |
| Skip the pedagogy suggestions from now on | course-material |
| Suggest improvements to chapter 3 | review |
| Miten motivoisin opiskelijoita paremmin? | design-advice |
| Mitä tutkimus sanoo palautteen ajoituksesta? | design-advice |
| Scores went up after the redesign. Did it work? | design-advice |
| Change chapter 3's deadline to 15 November | course-material |
| Korjaa kirjoitusvirhe toisessa kappaleessa | course-material |
| Miten tarkistan linkit? | course-material (answers with link-check) |
| Muista että otsikot ovat virkekirjaimin | course-material |
| Use plain language in chapter 2 | language-review |
| Tee tästä sivusta selkokielinen versio | course-material |
| Translate chapter 1 into Swedish | translation-sync |
| Proofread chapter 3 and fix typos | language-review |
| Publish my changes | course-material |
| Make me a skill for weekly announcements | course-material |

Skill names in the table drop the `course-material-` prefix.
