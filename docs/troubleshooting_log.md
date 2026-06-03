# Troubleshooting Log

This file records project problems and fixes. It does not include private chain-of-thought.

## Windows command mismatch

- Source: user-provided conversation record
- Problem: Some common shell examples do not work consistently in Windows PowerShell or Windows CMD.
- Symptoms: Commands such as `mkdir -p`, `touch`, and `~` can fail or behave differently from Unix shells.
- Root cause: The project is Windows-first, while many generic examples assume Bash.
- Fix: Use Windows-compatible PowerShell commands and Windows-first path examples.
- Prevention: Keep docs on `%USERPROFILE%` and `<repo-root>` by default; label any machine-specific path as an example only.
- Related files: `README.md`, `docs\codex_long_running_controller.md`

## Audit false positives for safety wording

- Source: user-provided conversation record for the problem; git history for the refined audit behavior
- Problem: The audit script could block safe documentation that mentioned expected safety patterns.
- Symptoms: Expected `.gitignore` patterns and guardrail wording were reported as risk items.
- Root cause: Keyword matching did not distinguish allowed documentation references from actual risky content.
- Fix: `scripts\audit-skills.ps1` now separates pass items, allowed references, and risk items.
- Prevention: Keep safety examples in README or docs with clear guardrail context, and run the audit before committing.
- Related files: `scripts\audit-skills.ps1`, `.gitignore`, `README.md`, `docs\codex_long_running_controller.md`

## Placeholder Skill iteration prompt could not run as a real iteration

- Source: user-provided conversation record
- Problem: A Skill iteration prompt with placeholders is not actionable by itself.
- Symptoms: The prompt names the needed inputs but cannot compare artifacts until the target Skill, original prompt, produced artifact, and reviewer-approved target are provided.
- Root cause: Iteration mode requires concrete comparison evidence.
- Fix: Keep the placeholder prompt as a reusable template and require users to fill in real inputs before running iteration mode.
- Prevention: Use `docs\skill_maker_behavior_evals.md` and `prompt-templates.md` to show the expected inputs for iteration.
- Related files: `prompt-templates.md`, `docs\skill_maker_behavior_evals.md`

## Hard-coded personal paths created portability risk

- Source: user-provided conversation record for the concern; git history for the cleanup commit
- Problem: Beginner docs can become confusing if they imply the repo must live at one personal local path.
- Symptoms: Local examples may look like required setup paths.
- Root cause: Early Windows setup examples included machine-specific paths.
- Fix: Replace required paths with `<repo-root>`, `%USERPROFILE%\.agents\skills`, and `%USERPROFILE%\.codex\AGENTS.md`; keep one path only as a labeled example.
- Prevention: Use portable placeholders in docs and reserve machine-specific paths for clearly labeled examples.
- Related files: `README.md`, `docs\codex_long_running_controller.md`, `prompt-templates.md`

## GitHub Actions audit required local Skill installation

- Source: GitHub Actions run evidence and local repo history
- Problem: GitHub Actions audit failed because the user-level Skill Maker path was missing on the CI runner.
- Symptoms: The `Audit` workflow failed during `scripts\audit-skills.ps1` with the user-level Skill Maker check reported as a risk.
- Root cause: The audit script mixed local installation checks with repo-source checks.
- Fix: Add `Local` and `CI` audit modes. Local mode remains strict about the installed user-level Skill Maker. CI mode audits repo source structure without requiring the local user-level installation.
- Prevention: GitHub Actions runs `scripts\audit-skills.ps1 -Mode CI`; local audits use Local mode by default.
- Related files: `scripts\audit-skills.ps1`, `.github\workflows\audit.yml`
