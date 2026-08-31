# CSCI 331 — Web Development (MSU, Fall 2026)

Instructor: Daniel DeFrance · Gianforte Hall 160-C · daniel.defrance@montana.edu
Lecture: MWF 1:10–2:00 p.m., Gianforte Hall 200
Course site: https://www.cs.montana.edu/defrance/classes/331/
Syllabus: https://www.cs.montana.edu/defrance/classes/331/syllabus.html
Policies: https://www.cs.montana.edu/defrance/policies/index.html

## AI-assistance policy — READ FIRST, it binds every session in this directory

The instructor's policy page states, verbatim:

> "Homework copyright rules and the Student Code of Conduct forbid the use tools
> like ChatGPT to do your homework for you. However, such tools are excellent for
> debugging If used properly and fairly."

> "Never submit code for grading that you did not write and do not understand as a
> solution to a homework problem, thereby claiming the solution as your own -- that
> is a violation of the Student Code of Conduct."

Penalty: 0 on the assignment + report to the Dean of Students. Repeat: course
failure, possible expulsion.

**So, in this directory:**

- **Do not write graded solution code for Quinn.** Not the HTML for the assignment,
  not the JS function, not the PHP handler. That is the prohibited case, plainly.
- **Do** debug code Quinn wrote: read the error, explain the cause, point at the
  line, explain the concept behind it.
- **Do** explain concepts, spec-level questions, MDN semantics, why the box model
  behaves as it does, what a promise settles to.
- **Do** review Quinn's finished code and say what is wrong or fragile — and let
  Quinn make the edit.
- When a fix genuinely needs a code shape shown, show the *minimal* illustrative
  snippet in chat with the concept named, not a drop-in answer written into the
  assignment file. If in doubt, explain instead of type.
- Scratch/experimental work outside the graded assignment is unrestricted.

Collaboration rule (same page): high-level discussion is fine; sharing verbatim
code, modifying someone else's solution, or submitting others' work is not.

## Grading

| Component | Weight |
|---|---|
| Assignments | 45% |
| Midterm exam | 20% |
| Final project | 30% — published site 20%, GitHub repo 5%, presentation 5% |
| Peer evaluations | 5% |

Scale: A 93 · A- 90 · B+ 87 · B 83 · B- 80 · C+ 77 · C 73 · C- 70 · D+ 67 · D 63 · D- 60 · F <60

## Late work

One **seven-day late pass**, usable once, on any assignment due through **Week 12**.
Email the course assistant **before** the original deadline to invoke it. The
general department policy is no late work at all; the syllabus pass is the only
exception, so it is worth spending deliberately.

## Submission

- Assignments → **Canvas**.
- Final project → published website **and** a GitHub repository.
- A free **GitHub account** is required.
- Off-campus access to some resources needs the **MSU VPN**.

## Tech stack

No textbook; online resources only.

- Frontend: HTML, CSS, JavaScript, DOM
- Backend: PHP + MySQL (LAMP), then Node.js/Express
- Frameworks: React, and Next.js in Week 12
- Tooling: VS Code, Git/GitHub, AMPPS (or MAMP) for localhost, FileZilla for FTP
- Validators the course points at: https://validator.w3.org/ and
  https://jigsaw.w3.org/css-validator/ — run these before submitting markup/CSS.

Note the split: the syllabus advertises Node/Express/React, while the schedule
spends Weeks 6–9 on PHP/MySQL/LAMP first and reaches MERN in Week 9. Both are in
the course; LAMP comes first.

## Working conventions for this directory

- Keep each assignment in its own subdirectory, named for the assignment.
- Prefer plain HTML/CSS/JS with no build step until the course introduces one —
  the graded artifact is what the instructor can open and validate.
- `SCHEDULE.md` holds the week-by-week plan and assignment list.
