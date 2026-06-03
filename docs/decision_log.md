# Decision Log

This file records concise decision history for Codex Skills From Scratch.

## ADR-001: Repo source is the source of truth

- Source: git history
- Decision: Treat `<repo-root>` as the source of truth and installed user-level Skills as installation targets.
- Context: README and the controller runbook separate repo source files from `%USERPROFILE%\.agents\skills`.
- Options considered: edit installed Skills directly, or maintain source files in Git and install them when ready.
- Decision outcome: Maintain source in Git and use `scripts\install.ps1` to copy Skill Maker into the user-level install location.
- Consequences: Git can track reviewable source changes, while installation remains explicit.
- Status: Accepted.

## ADR-002: Skill Maker is a meta Skill

- Source: git history; user-provided conversation record for the earlier framing as a Skill for writing Skills
- Decision: Keep `skill-maker` as a meta Skill for creating, auditing, retrospecting, and updating Skills.
- Context: `skills\skill-maker\SKILL.md` defines audit, retrospective, update, and creation modes instead of one task-specific workflow.
- Options considered: make Skill Maker a normal task Skill, or make it a reusable Skill maintenance helper.
- Decision outcome: Skill Maker remains a compact meta Skill.
- Consequences: It should guide Skill lifecycle work and should not become a giant task catalog.
- Status: Accepted.

## ADR-003: Installation is dry-run by default

- Source: git history
- Decision: `scripts\install.ps1` runs in dry-run mode unless `-Install` is provided.
- Context: Installation copies from repo source into the user-level Skills location, which changes Codex behavior outside this repo.
- Options considered: install immediately by default, or require an explicit install flag.
- Decision outcome: Require `-Install` for real installation.
- Consequences: Beginners can preview install actions before changing user-level Skills.
- Status: Accepted.

## ADR-004: Examples are not installed by default

- Source: git history
- Decision: Keep `examples\market-research\SKILL.md` as an example, not an installed callable Skill.
- Context: README and audit behavior distinguish source examples from user-level installed Skills.
- Options considered: install examples automatically, or keep examples as reference material.
- Decision outcome: Examples stay separate unless a maintainer explicitly installs them.
- Consequences: The repo avoids surprising Codex skill discovery behavior.
- Status: Accepted.

## ADR-005: Audit separates allowed references from actual risks

- Source: git history; user-provided conversation record for the false-positive problem that triggered refinement
- Decision: `scripts\audit-skills.ps1` reports pass items, allowed safety references, and actual risk items separately.
- Context: Earlier audit behavior was too strict for expected `.gitignore` patterns and documented guardrail wording.
- Options considered: flag every sensitive-looking word, ignore all such words, or classify expected references separately.
- Decision outcome: Classify allowed references separately and exit non-zero only for actual risks or structural failures.
- Consequences: Documentation can include safety guidance without blocking safe commits.
- Status: Accepted.

## ADR-006: Codex runs as a constrained stage runner

- Source: git history
- Decision: Use `docs\codex_long_running_controller.md` to constrain Codex to bounded stages.
- Context: This repo evolves through small staged tasks with explicit scopes, checks, and commit boundaries.
- Options considered: let Codex continue autonomously across many stages, or require a stage-by-stage controller.
- Decision outcome: Codex advances one approved stage at a time and stops for scope, risk, external-state, PR, push, or merge decisions.
- Consequences: The workflow is slower than fully autonomous execution but easier to audit and supervise.
- Status: Accepted.

## ADR-007: Production and iteration sessions are separated

- Source: git history
- Decision: Separate artifact production sessions from Skill iteration sessions.
- Context: `prompt-templates.md` defines a production session that does not update the Skill and an iteration session that compares output with a reviewer-approved target.
- Options considered: update Skills during every artifact-producing run, or update only after comparison against a verified target.
- Decision outcome: Use production mode for output and iteration mode for reusable Skill improvements.
- Consequences: Skill changes should be based on verified reusable lessons, not speculative edits.
- Status: Accepted.
