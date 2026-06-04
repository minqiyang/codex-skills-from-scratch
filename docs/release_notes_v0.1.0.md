# v0.1.0 Release Notes

## What this release is

v0.1.0 is the first lightweight public release of Codex Skills From Scratch.

It packages a beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills with local safety checks and a small public GitHub workflow.

## Who it is for

This release is for people who want to:

- build their first reusable Codex Skill workflow;
- keep Skill source files in Git;
- install a personal Skill Maker safely;
- use audit checks before changing reusable prompts or Skills;
- learn how to separate examples from installed Skills.

## What is included

- `skills\skill-maker\SKILL.md`: a meta Skill for creating, improving, auditing, retrospecting, and updating Codex Skills.
- `templates\task-skill-template.md`: a compact template for task-specific Skills.
- `examples\market-research\SKILL.md`: an example Skill that is not installed by default.
- `prompt-templates.md`: reusable prompts for Skill-first workflows and Skill iteration.
- `scripts\install.ps1`: a dry-run-first installer for the user-level Skill Maker.
- `scripts\audit-skills.ps1`: Local and CI audit modes for structure and safety checks.
- `docs\codex_long_running_controller.md`: a stage-runner runbook for supervised repo evolution.
- `docs\engineering_log.md`, `docs\decision_log.md`, `docs\troubleshooting_log.md`, and `docs\project_journal.md`: project history and rationale.
- `.github\workflows\audit.yml`: a GitHub Actions workflow that runs the CI audit and `git diff --check`.
- `LICENSE`, `CONTRIBUTING.md`, and `SECURITY.md`: public-readiness project docs.

## What is intentionally not included

- This is not an official OpenAI repo.
- This is not a giant catalog of ready-made Skills.
- This is not a secret manager or a place for API keys.
- This does not install example Skills automatically.
- This does not automate GitHub releases, merges, or deployment.
- This does not replace human review for Skill changes.

## Known limitations

- The repo is Windows-first and uses PowerShell examples.
- The local audit mode expects the user-level Skill Maker installation to exist.
- CI audit mode checks repo source structure only because GitHub Actions runners do not have a local Codex Skill installation.
- Behavior evals are manual prompts, not automated tests.
- The GitHub workflow currently depends on GitHub-hosted runner behavior and `actions/checkout`.

## Safe quick start

1. Clone the repo.
2. Run the repo-source audit before installation:

```powershell
.\scripts\audit-skills.ps1 -Mode CI
```

3. Preview installation:

```powershell
.\scripts\install.ps1
```

4. Install only when ready, then verify the user-level install:

```powershell
.\scripts\install.ps1 -Install
.\scripts\audit-skills.ps1 -Mode Local
```

5. In Codex, mention `$skill-maker` when creating, auditing, or updating a Skill.

## Verification checklist

- CI audit passes with `RISK: none` before installation.
- Local audit passes with `RISK: none` after installing Skill Maker.
- `git diff --check` passes.
- Markdown code fences are balanced.
- `scripts\install.ps1` runs in dry-run mode by default.
- GitHub Actions `Audit` workflow passes on `main`.
- Do not track real sensitive values, credentials, private keys, `.env` contents, debug logs, backups, or large binaries.
- Examples remain examples unless explicitly installed.
