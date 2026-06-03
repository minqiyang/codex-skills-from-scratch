# Project Journal

Codex Skills From Scratch started from a practical idea: make a Skill for writing Skills.

Source: user-provided conversation record for the original framing; git history for the committed starter repo.

The first version focused on Skill Maker, a meta Skill that helps decide when a task deserves a reusable Skill, how to keep that Skill concise, and how to update it only with verified lessons. From there, the project became a small starter repo for people who want a repeatable Codex Skill system instead of scattered prompts.

The repo then added a dry-run-first installer and a static audit script. The installer makes the difference between repo source files and installed user-level Skills explicit. The audit script checks frontmatter, Markdown fences, duplicate Skill names, example installation state, and safety-reference classification.

Source: git history confirms the initial files, installer, audit script, controller runbook, GitHub workflow docs, prompt-template updates, path portability cleanup, and CI audit workflow. The conversation record confirms that the user-level Skill Maker path was checked during audit mode and that path portability and public-readiness were identified as next-stage concerns before their cleanup stages.

As the workflow became more structured, the project added a long-running controller runbook. That runbook treats Codex as a constrained stage runner: each stage has a bounded scope, local checks, a risk report, and a commit only when authorized. GitHub workflow docs and templates then made the repo easier to review through small pull requests and human approval gates.

The repo later shifted toward beginner-friendly GitHub readiness. The README was repositioned around the name Codex Skills From Scratch, path examples were made portable, behavior eval prompts were added, and project policy docs were introduced. A minimal GitHub Actions workflow now runs the audit on pull requests and pushes.

## Lessons learned

- Externalize repeatable workflow knowledge before execution when the task is likely to recur.
- Skills should focus on success criteria, known pitfalls, deterministic tools, and verification.
- Do not turn Skills into bloated SOPs.
- Only write verified reusable lessons back into Skills.
- Keep examples separate from installed Skills.
- Use Git for history, rollback, and review.
- Use audit scripts as safety gates before commits and pull requests.
