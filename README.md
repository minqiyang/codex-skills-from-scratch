# Codex Skills From Scratch

[![Audit](https://github.com/minqiyang/codex-skills-from-scratch/actions/workflows/audit.yml/badge.svg)](https://github.com/minqiyang/codex-skills-from-scratch/actions/workflows/audit.yml)
[![Release](https://img.shields.io/github/v/release/minqiyang/codex-skills-from-scratch?label=release)](https://github.com/minqiyang/codex-skills-from-scratch/releases)
[![License](https://img.shields.io/github/license/minqiyang/codex-skills-from-scratch)](LICENSE)

Build your first reusable Codex Skill system from scratch.

A beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills.

Latest release: [v0.1.0](docs/release_notes_v0.1.0.md)

# Why skill Maker
Use this repo if you want a small working system for turning repeatable Codex work into reusable Skills, scripts, prompts, logs, and checks.

## How to use Skill Maker

Skill Maker is a Skill for writing and improving other Skills.

It helps Codex decide:

- whether a task should become a reusable Skill;
- what kind of `SKILL.md` should be created;
- whether an existing Skill should be used, audited, reviewed, or updated;
- which lessons are reusable, and which details only belong to one task.

### When to use Skill Maker

Use Skill Maker when:

- you may do the same task again;
- the task has clear quality standards, such as a report format, code review rules, or a release process;
- the task uses stable tools, paths, commands, APIs, file formats, or environment setup;
- a previous run failed, and you want future Codex sessions to avoid the same mistake;
- you have an AI output and a human-approved version, and you want to turn the difference into a Skill improvement;
- you want to audit whether a Skill is discoverable, valid, safe, and clear.

### Basic calls

In any Codex project, you can start with:

```text
Use $skill-maker.
```

For a more explicit request, use:

```text
Use $skill-maker and decide whether this task should become a reusable Codex Skill.
```

For a read-only audit, use:

```text
Use $skill-maker and enter audit mode.
Do not modify any files.
```

For retrospective improvement, use:

```text
Use $skill-maker and enter iteration mode.
```

## Prompt examples

### Decide whether a task deserves a Skill

```text
Use $skill-maker.

Goal:
Decide whether the following task should become a reusable Codex Skill.

Task:
<describe the task>

Rules:
1. First decide whether this is a repeatable workflow.
2. If it is not Skill-worthy, explain why and do not create a Skill.
3. If it is Skill-worthy, propose a minimal Skill structure.
4. Do not modify files until you explain the proposed Skill.
```

### Create a project-specific Skill

```text
Use $skill-maker and enter new Skill creation mode.

Goal:
Create a project-specific Codex Skill for this repeated workflow:
<describe the workflow>

Allowed location:
.agents\skills\<skill-name>\SKILL.md

Rules:
- Keep the Skill concise.
- Include success criteria, known pitfalls, deterministic tools, and verification.
- Do not include secrets, tokens, .env contents, credentials, or private keys.
- After creating the Skill, run frontmatter and Markdown code fence checks.
```

### Use an existing Skill and run a retrospective

```text
Use $<skill-name> for this task.

After completing the task, run a short retrospective:
1. Did the Skill help?
2. What was missing?
3. What caused friction?
4. What verified lesson should future Codex sessions know?

Only update the Skill if there is a reusable, verified lesson.
```

### Audit whether a project needs Skills

```text
Use $skill-maker and enter audit mode.

Goal:
Audit this project for repeatable workflows that should become Codex Skills.

Boundaries:
- Do not modify files.
- Do not read secrets, .env files, credentials, tokens, or private keys.
- Use Windows-compatible PowerShell only.

Tasks:
1. Inspect project instructions and relevant docs.
2. Identify repeated workflows.
3. Recommend which workflows should become Skills.
4. Recommend whether each Skill should be user-level or project-specific.
5. Do not create or update any Skill in this step.
```

### Improve a Skill with a gold standard

```text
Use $skill-maker and enter Skill iteration mode.

Target Skill:
$<skill-name>

Original task prompt:
<paste the original prompt>

AI-produced artifact:
<paste or link to the AI output>

Gold-standard artifact:
<paste or link to the human-approved version>

Tasks:
1. Compare the AI-produced artifact against the gold standard.
2. Identify reusable differences.
3. Separate reusable lessons from one-off task details.
4. Propose the minimal Skill update.
5. Update only success criteria, known pitfalls, deterministic tools, verification, or style constraints.
6. Do not paste the entire gold standard into the Skill.
7. Do not add speculative advice.
8. Run relevant audit checks after editing.
```

### Verify that a Skill setup is usable

```text
Use $skill-maker and enter audit mode.

Goal:
Verify that the current Skill setup can be discovered and used by future Codex sessions.

Strict boundaries:
- Do not modify files.
- Do not install software.
- Do not read secrets, tokens, .env files, credential files, or private keys.
- Do not modify config.toml.

Tasks:
1. Confirm the Skill exists in the expected location.
2. Confirm frontmatter has name and description.
3. Confirm the description clearly explains when to use the Skill.
4. Confirm Markdown code fences are balanced.
5. Check for duplicate Skill names.
6. Report pass items, risks, and minimal repair steps.
```

## Quick start: 10-minute path

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

## Safe terminal demo

```powershell
.\scripts\audit-skills.ps1 -Mode CI
.\scripts\install.ps1
.\scripts\install.ps1 -Install
.\scripts\audit-skills.ps1 -Mode Local
```

The `-Install` command is the first command that copies Skill Maker into your user-level Codex Skills folder. Run it only after the dry-run output looks right.

## Safety promise

- Dry-run first: `scripts\install.ps1` changes nothing unless `-Install` is provided.
- No secrets: this repo is not a place for sensitive values, `.env` contents, credentials, or private keys.
- Examples stay separate: example Skills are not installed by default.
- CI included: pushes and pull requests run the audit workflow.

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
