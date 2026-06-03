# Codex Skills From Scratch

Build your first reusable Codex Skill system from scratch.

A beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills.

## What problem this solves

Codex Skills are most useful when they capture repeatable workflows, quality standards, known pitfalls, and deterministic checks. Beginners often need a small, safe starting point that shows where Skills live, how to audit them, and how to evolve them without turning every note into a giant instruction file.

This repo gives you that starting point.

## What users get

- A `skill-maker` Skill for creating, auditing, reviewing, and updating Skills.
- A reusable task Skill template.
- Prompt templates for common Skill Maker workflows.
- A safe install script with dry-run behavior by default.
- A local audit script for checking Skill structure and safety references.
- Example Skills that are not installed unless you explicitly install them.
- Controller and GitHub workflow docs for staged, human-supervised repo evolution.

## Who this is for

Use this repo if you are:

- new to Codex Skills and want a working starter layout;
- building a personal Codex workflow repo;
- maintaining reusable prompts, templates, and audit scripts;
- learning how to separate repo source files from installed user-level Skills;
- experimenting with Skill iteration using artifacts and reviewer-approved examples.

## Quick start

1. Review the repo structure.
2. Run a local audit:

```powershell
.\scripts\audit-skills.ps1
```

3. Preview installation:

```powershell
.\scripts\install.ps1
```

4. Install only when ready:

```powershell
.\scripts\install.ps1 -Install
```

5. In Codex, mention `$skill-maker` when creating, auditing, or updating a Skill.

## Safe usage rules

- Do not read, write, print, commit, or summarize secrets, tokens, `.env` files, credential files, or private keys.
- Do not modify `config.toml` unless you explicitly intend to.
- Do not install software unless you explicitly approve it.
- Do not use the internet unless you explicitly approve it.
- Do not turn example Skills into installed Skills unless you explicitly choose to.
- Do not create or update Skills for trivial one-off tasks.
- Only write verified, reusable lessons into Skills.

## Path model

Repo source location:

- `<repo-root>`

Installed user-level Skills:

- `%USERPROFILE%\.agents\skills`

Codex global instructions:

- `%USERPROFILE%\.codex\AGENTS.md`

`scripts\install.ps1` copies from the repo source to the installed user-level Skill location.

Example local repo path on one Windows machine:

- `D:\Users\MINQI\Documents\skills`

This is only an example. Your clone can live anywhere.

## Install and audit workflow

Installed Codex locations:

- Codex global instruction file: `%USERPROFILE%\.codex\AGENTS.md`
- Codex user-level Skill installation location: `%USERPROFILE%\.agents\skills`
- Installed Skill Maker target: `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md`

Repo source locations:

- Skill Maker source: `skills\skill-maker\SKILL.md`
- Canonical task Skill template: `templates\task-skill-template.md`
- Example Skill: `examples\market-research\SKILL.md`

`scripts\install.ps1` defaults to dry-run mode. It only copies `skills\skill-maker\SKILL.md` to `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md` when `-Install` is provided.

`scripts\audit-skills.ps1` checks frontmatter, duplicate Skill names, Markdown code fences, expected safety references, and possible risk patterns.

## What this is not

- Not an official OpenAI repo.
- Not a giant Skill catalog.
- Not a secret manager.
- Not a place for API keys.
- Not an autonomous agent without human supervision.

## Repository name rationale

`codex-skills-from-scratch` is searchable, beginner-friendly, and clear. It names the core topic (`codex-skills`), signals that the repo starts from first principles (`from-scratch`), and avoids implying that this is an official or exhaustive Skill collection.

## Recommended workflow

1. For a trivial one-off task, ask directly and do not create a Skill.
2. For a repeatable or tool-heavy task, use one of the prompts in `prompt-templates.md`.
3. When creating a new Skill, start from `templates/task-skill-template.md`.
4. Put personal cross-project Skills in `%USERPROFILE%\.agents\skills\<skill-name>\SKILL.md`.
5. Put project-specific Skills in `.agents\skills\<skill-name>\SKILL.md` inside that project.

## Long-running controller

Use `docs\codex_long_running_controller.md` as the stage runner runbook when a future Codex session should advance this repo with minimal supervisor back-and-forth.

## GitHub workflow

Use `docs\github_workflow.md` for the private GitHub setup checklist, PR approval gates, and Codex review workflow.

Pull requests and pushes run `.github\workflows\audit.yml`, which executes the Skill audit on a Windows runner and checks `git diff --check`.

## Skill Maker behavior evals

Use `docs\skill_maker_behavior_evals.md` for lightweight manual prompts that check whether Skill Maker behaves correctly in common scenarios.

## Project policies

- License: `LICENSE`
- Contribution guide: `CONTRIBUTING.md`
- Safety reporting: `SECURITY.md`

## Manual verification

Inside Codex, run `/skills` or explicitly mention `$skill-maker`.

From a terminal, you can also run:

```powershell
codex --ask-for-approval never "Summarize the current instructions and tell me whether the skill-maker Skill is available."
```

## Files here

- `prompt-templates.md`: reusable daily prompts for Skill-first work.
- `templates/task-skill-template.md`: the standard structure for new task Skills.
- `examples/market-research/SKILL.md`: an example Skill showing the expected level of detail.
- `scripts/install.ps1`: dry-run by default installer for the Skill Maker.
- `scripts/audit-skills.ps1`: read-only local audit for this starter repo.
