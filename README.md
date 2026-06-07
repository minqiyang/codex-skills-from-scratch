# Codex Skills From Scratch

[![Audit](https://github.com/minqiyang/codex-skills-from-scratch/actions/workflows/audit.yml/badge.svg)](https://github.com/minqiyang/codex-skills-from-scratch/actions/workflows/audit.yml)
[![Release](https://img.shields.io/github/v/release/minqiyang/codex-skills-from-scratch?label=release)](https://github.com/minqiyang/codex-skills-from-scratch/releases)
[![License](https://img.shields.io/github/license/minqiyang/codex-skills-from-scratch)](LICENSE)

Build your first reusable Codex Skill system from scratch.

A beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills.

Latest release: [v0.1.0](docs/release_notes_v0.1.0.md)

## Why Skill Maker

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

<details>
<summary>Decide whether a task deserves a Skill</summary>

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

</details>

<details>
<summary>Create a project-specific Skill</summary>

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

</details>

<details>
<summary>Use an existing Skill and run a retrospective</summary>

```text
Use $<skill-name> for this task.

After completing the task, run a short retrospective:
1. Did the Skill help?
2. What was missing?
3. What caused friction?
4. What verified lesson should future Codex sessions know?

Only update the Skill if there is a reusable, verified lesson.
```

</details>

<details>
<summary>Audit whether a project needs Skills</summary>

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

</details>

<details>
<summary>Improve a Skill with a gold standard</summary>

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

</details>

<details>
<summary>Verify that a Skill setup is usable</summary>

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

</details>

## Quick start

Clone the repo, review the safety rules, then run the safe path below:

```powershell
.\scripts\audit-skills.ps1 -Mode CI
.\scripts\install.ps1
.\scripts\install.ps1 -Install
.\scripts\audit-skills.ps1 -Mode Local
```

Use `-Mode CI` before installation. Use `-Mode Local` after installing Skill Maker. The `-Install` command is the first command that copies Skill Maker into your user-level Codex Skills folder.

## Safety promise

- Dry-run first: `scripts\install.ps1` changes nothing unless `-Install` is provided.
- No secrets: this repo is not a place for sensitive values, `.env` contents, credentials, or private keys.
- Examples stay separate: example Skills are not installed by default.
- CI included: pushes and pull requests run the audit workflow.

## Paths and files

- Repo source: `<repo-root>`
- Installed user-level Skills: `%USERPROFILE%\.agents\skills`
- Installed Skill Maker: `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md`
- Repo Skill Maker source: `skills\skill-maker\SKILL.md`
- Task Skill template: `templates\task-skill-template.md`
- Example Skill: `examples\market-research\SKILL.md`
- Installer: `scripts\install.ps1`
- Audit script: `scripts\audit-skills.ps1`

## More resources

- `prompt-templates.md`: reusable Skill-first prompts.
- `docs\skill_maker_behavior_evals.md`: manual behavior eval prompts.
- `docs\codex_long_running_controller.md`: supervised stage-runner workflow.
- `docs\github_workflow.md`: GitHub setup and review workflow.
- `CHANGELOG.md` and `docs\engineering_log.md`: project history.
- `CONTRIBUTING.md`, `SECURITY.md`, and `LICENSE`: project policies.
