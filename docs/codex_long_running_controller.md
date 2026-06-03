# Codex Long-Running Controller Runbook

## 1. Purpose

This repo is a Codex Skills Starter Kit and Personal Codex Workflow Repo.

Its purpose is to manage:

- `AGENTS.md` workflow agreements;
- reusable Codex Skills;
- Skill Maker;
- task Skill templates;
- example Skills;
- install and audit scripts;
- prompt templates;
- version control for Skill evolution.

Codex should treat this repo as a constrained stage runner. It should advance one clearly bounded stage at a time, verify the stage, report the result, and wait when the next step requires human approval.

## 2. Project identity

This repo is a workflow and Skill management repo.

It is not an application runtime, not a credential store, not a secret manager, and not a place for private tokens.

## 3. Human supervisor model

The human is the supervisor. Codex should not ask for human input after every small step. It should ask only when the next decision changes scope, risk, ownership, or external state.

Human intervention is required for:

- approving a proposed stage plan;
- resolving ambiguous product decisions;
- approving file deletion or broad restructuring;
- reviewing PRs or commits;
- merging PRs;
- approving installation or configuration changes;
- handling credentials or external service authentication.

## 4. Permanent guardrails

- Do not read, write, print, commit, or summarize secrets, tokens, `.env` files, credential files, or private keys.
- Do not modify `config.toml` unless explicitly asked.
- Do not install software unless explicitly approved.
- Do not use the internet unless explicitly approved.
- Do not delete files without explicit approval.
- Do not push to GitHub unless explicitly approved.
- Do not create or merge pull requests unless explicitly approved.
- Do not turn examples into installed Skills unless explicitly asked.
- Do not create or update Skills for trivial one-off tasks.
- Do not write speculative lessons into Skills.
- Only write verified, reusable lessons into Skills.
- Keep `AGENTS.md` short and route detailed behavior into Skills or docs.
- Use Windows-compatible commands unless the user explicitly says otherwise.

## 5. Stage workflow

For each stage, Codex should:

1. Read `AGENTS.md`, `README.md`, `docs\codex_long_running_controller.md`, and the relevant Skill files.
2. Check `git status`.
3. Stop if the working tree contains unrelated changes.
4. Define a small stage with exact scope.
5. List files expected to change.
6. List tests or checks to run.
7. State out-of-scope items.
8. Implement only the stage.
9. Run relevant checks.
10. Run `scripts\audit-skills.ps1` when Skill files changed.
11. Review the diff.
12. Summarize high, medium, and low risks.
13. Commit only if explicitly permitted by the current user prompt or runbook stage.
14. Do not proceed to the next stage if high or medium risks remain.

## 6. Skill-first workflow

Codex should decide whether the task deserves a Skill before creating or updating one.

Use an existing Skill if one applies. Use `$skill-maker` only when a Skill should be created, audited, or updated.

Create minimal Skills. Prefer success criteria, known pitfalls, deterministic tools, and verification over long SOPs. Do not update Skills unless the lesson is verified and reusable.

When quality matters, separate production sessions from iteration sessions:

- Production session: read the Skill, produce the artifact, then stop.
- Iteration session: compare the artifact against a gold standard, update the Skill, then stop.

## 7. Repo source vs installed location

Repo source location:

- `<repo-root>`

Example local repo path on one Windows machine:

- `D:\Users\MINQI\Documents\skills`

This example path is not required. Use the actual cloned repo root for the current machine.

Installed user-level Skill location:

- `%USERPROFILE%\.agents\skills`

Codex global instruction file:

- `%USERPROFILE%\.codex\AGENTS.md`

`scripts\install.ps1` copies repo Skills into the installed user-level location. After initialization, this repo is the source of truth.

## 8. Long-running stage queue

Stage A: Audit and stabilize Skill Maker repo structure.

Stage B: Initialize or verify local Git repo.

Stage C: Add or improve `install.ps1`.

Stage D: Add or improve `audit-skills.ps1`.

Stage E: Add prompt templates for common Skill Maker usage.

Stage F: Add a Skill iteration workflow using artifact and gold standard.

Stage G: Add a GitHub private repo publishing checklist, without pushing.

Stage H: Add evaluation prompts for Skill Maker behavior.

Stage I: Review whether any example Skills should become real user-level Skills.

## 9. Stop conditions

Codex must stop and report if:

- a secret or credential file is encountered;
- a command would delete or overwrite broad file ranges;
- `config.toml` would need modification;
- a package install is needed;
- internet access is needed;
- `git status` shows unrelated changes;
- tests or audits fail;
- the next decision is a product or governance decision;
- a PR or merge decision is needed.

## 10. Required final report format

Every stage must end with:

- stage name;
- files changed;
- checks run;
- results;
- high, medium, and low risks;
- whether any Skill was created or updated;
- whether human action is required;
- recommended next stage.
