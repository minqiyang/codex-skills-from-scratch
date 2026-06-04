# Codex Skills From Scratch

Build your first reusable Codex Skill system from scratch.

A beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills.

Latest release: [v0.1.0](docs/release_notes_v0.1.0.md)

## Start Here

Use this repo if you want a small working system for turning repeatable Codex work into reusable Skills, scripts, prompts, logs, and checks.

### Who this is for

- Beginners who want a clear first Codex Skills setup.
- Builders who want reusable personal or project-specific Codex workflows.
- Maintainers who want Skill changes to be auditable, reviewable, and reversible.
- Users who want examples and templates without automatically installing extra Skills.

### What users get

- A `skill-maker` meta Skill for creating, auditing, reviewing, and updating Skills.
- A reusable task Skill template.
- Prompt templates for common Skill Maker workflows.
- A dry-run-first installer for the user-level Skill Maker.
- Local and CI audit modes for checking structure and safety references.
- Example Skills that are not installed unless you explicitly install them.
- Persistent project logs, release notes, and supervised workflow docs.

### Quick start: 10-minute path

1. Clone or open the repo, then review the structure and safety rules.
2. Run the repo-source audit before installation:

```powershell
.\scripts\audit-skills.ps1 -Mode CI
```

3. Preview installation:

```powershell
.\scripts\install.ps1
```

4. Install only after reviewing the dry-run, then run the local install audit:

```powershell
.\scripts\install.ps1 -Install
.\scripts\audit-skills.ps1 -Mode Local
```

5. In Codex, mention `$skill-maker` for your first repeatable task.

### Safety promise

- Dry-run first: `scripts\install.ps1` changes nothing unless `-Install` is provided.
- No secrets: this repo is not a place for sensitive values, `.env` contents, credentials, or private keys.
- Examples stay separate: example Skills are not installed by default.
- CI included: pushes and pull requests run the audit workflow.

## Why This Repo Exists

Fresh Codex sessions do not automatically carry every project lesson forward unless reusable workflow knowledge is externalized. This repo gives beginners a concrete way to turn those lessons into Skills, scripts, prompts, logs, and release discipline instead of starting from a blank page.

## What Makes This Different

- Skill Maker is a meta Skill for building and improving other Skills.
- Local audit mode checks the installed user-level Skill Maker; CI mode checks repo source structure.
- `install.ps1` defaults to dry-run.
- Examples stay separate from installed Skills.
- Project logs and handoff context preserve decisions across sessions.
- The long-running controller supports supervised Codex workflows.

## What problem this solves

Codex Skills are most useful when they capture repeatable workflows, quality standards, known pitfalls, and deterministic checks. Beginners often need a small, safe starting point that shows where Skills live, how to audit them, and how to evolve them without turning every note into a giant instruction file.

This repo gives you that starting point.

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

Local audit mode also checks the installed user-level Skill Maker. CI audit mode checks repo source structure only, because GitHub Actions runners do not have your local Codex Skill installation.

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

## Project logs

- `CHANGELOG.md`: user-facing changes by release state.
- `docs\engineering_log.md`: chronological stage history, files changed, checks, results, and risks.
- `docs\decision_log.md`: concise ADR-style decisions and consequences.
- `docs\troubleshooting_log.md`: problems encountered, fixes, and prevention notes.
- `docs\project_journal.md`: readable narrative overview and lessons learned.

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
