# Engineering Log

This log records meaningful project stages. It is factual project history, not private chain-of-thought.

## 2026-06-02 - Skill Maker setup

- Source: git history
- Stage name: Initial Codex Skill Maker starter kit
- Goal: Create a starter repo containing Skill Maker, templates, examples, install support, audit support, and beginner documentation.
- Files changed: `.gitignore`, `README.md`, `examples\market-research\SKILL.md`, `prompt-templates.md`, `scripts\audit-skills.ps1`, `scripts\install.ps1`, `skills\skill-maker\SKILL.md`, `templates\task-skill-template.md`
- Checks run: not verified from local evidence
- Result: Initial starter kit committed. Git confirms README, prompt templates, the task Skill template, the market-research example Skill, `install.ps1`, `audit-skills.ps1`, and `skills\skill-maker\SKILL.md` were added in this commit.
- Risks: Early repo structure still needed stronger audit behavior, controller guidance, and public-facing positioning.
- Commit hash: `a2bbdff`
- Next recommended stage: Stabilize audit and controller workflow.

## 2026-06-02 - Repo source-of-truth and controller setup

- Source: git history
- Stage name: Stabilize Skill Maker controller workflow
- Goal: Clarify the repo as source of truth, add controller and GitHub workflow docs, and improve static audit behavior.
- Files changed: `README.md`, `docs\codex_long_running_controller.md`, `docs\github_workflow.md`, `prompt-templates.md`, `scripts\audit-skills.ps1`
- Checks run: not verified from local evidence
- Result: Controller runbook, GitHub workflow docs, Skill iteration workflow prompts, and improved audit classification were added.
- Risks: The repo still needed beginner-facing positioning and portable path cleanup.
- Commit hash: `4a44ab1`
- Next recommended stage: Position the repo for beginner GitHub use.

## 2026-06-02 - Beginner repo positioning

- Source: git history
- Stage name: Position repo as Codex Skills From Scratch
- Goal: Reposition the repo as a beginner-friendly starter project and add GitHub issue and PR templates.
- Files changed: `.github\ISSUE_TEMPLATE\bug_report.md`, `.github\ISSUE_TEMPLATE\feature_request.md`, `.github\PULL_REQUEST_TEMPLATE.md`, `README.md`
- Checks run: not verified from local evidence
- Result: README now presents the project as Codex Skills From Scratch, with clearer audience, quick start, safe usage rules, and repo identity.
- Risks: Some path examples still needed portability cleanup.
- Commit hash: `40f65ea`
- Next recommended stage: Make paths portable for cloned setups.

## 2026-06-02 - Path portability cleanup

- Source: git history; user-provided conversation record for the prior concern that path portability and public-readiness needed a dedicated stage
- Stage name: Stage J: Path portability and public-readiness cleanup
- Goal: Replace hard-coded personal local paths with portable placeholders while keeping Windows-first examples clear.
- Files changed: `README.md`, `docs\codex_long_running_controller.md`, `prompt-templates.md`
- Checks run: local audit, diff check, Markdown fence check, and status check were required by the stage; exact output is not preserved in Git history.
- Result: Docs now use `<repo-root>`, `%USERPROFILE%\.agents\skills`, and `%USERPROFILE%\.codex\AGENTS.md` as the default path model.
- Risks: One local repo path remains as a clearly labeled example.
- Commit hash: `5899bd9`
- Next recommended stage: Add behavior eval prompts.

## 2026-06-02 - Skill Maker behavior evals

- Source: git history
- Stage name: Stage H: Skill Maker behavior evaluation prompts
- Goal: Add lightweight manual eval prompts for common Skill Maker behavior checks.
- Files changed: `README.md`, `docs\skill_maker_behavior_evals.md`
- Checks run: local audit, diff check, Markdown fence check, and status check were required by the stage; exact output is not preserved in Git history.
- Result: Seven manual eval cases were added for one-off tasks, repeated tasks, existing Skills, iteration mode, safe handling of sensitive-looking files, example Skills, and audit mode.
- Risks: These are manual eval prompts, not automated tests.
- Commit hash: `f81f6df`
- Next recommended stage: Add public-readiness project docs.

## 2026-06-02 - Public-readiness docs

- Source: git history; user-provided conversation record for the earlier public-readiness concern
- Stage name: Public-readiness documentation stage
- Goal: Add project policy docs so the private repo can later become public with fewer beginner-facing gaps.
- Files changed: `LICENSE`, `CONTRIBUTING.md`, `SECURITY.md`, `README.md`
- Checks run: `.\scripts\audit-skills.ps1`, `git diff --check`, `git diff --cached --check`, Markdown fence check, and `git status --short --untracked-files=all`
- Result: MIT license, contribution guide, safety reporting guide, and README policy links were added.
- Risks: Local `main` remained ahead of `origin/main` after commit; no push was performed in that stage.
- Commit hash: `38c9dc5`
- Next recommended stage: Add CI audit workflow.

## 2026-06-02 - CI audit workflow

- Source: git history
- Stage name: CI setup stage
- Goal: Add a minimal GitHub Actions workflow for repository audit checks on pull requests and pushes.
- Files changed: `.github\workflows\audit.yml`, `README.md`
- Checks run: `.\scripts\audit-skills.ps1`, `git diff --check`, `git diff --cached --check`, Markdown fence check, and `git status --short --untracked-files=all`
- Result: A Windows runner workflow now runs the Skill audit and `git diff --check`.
- Risks: Local `main` remained ahead of `origin/main` after commit; no push was performed in that stage.
- Commit hash: `121bdac`
- Next recommended stage: Add project logs and implementation history.

## 2026-06-03 - Project logs and implementation history

- Source: git history for committed files; user-provided conversation record for the stage goal and logging boundary
- Stage name: Stage K: Add project logs and implementation history
- Goal: Add lightweight project logs so future readers can understand changes, rationale, problems, fixes, tradeoffs, and lessons learned.
- Files changed: `CHANGELOG.md`, `README.md`, `docs\codex_long_running_controller.md`, `docs\engineering_log.md`, `docs\decision_log.md`, `docs\troubleshooting_log.md`, `docs\project_journal.md`
- Checks run: `.\scripts\audit-skills.ps1`, `git diff --check`, Markdown fence check for changed Markdown files, path sanity check, diff review, and `git status --short --untracked-files=all`
- Result: Project logs were created, README was linked to those logs, and the controller runbook now requires log updates for meaningful stages.
- Risks: This stage reconstructs history from Git history, existing docs, and current conversation-visible context; exact early-stage check output is not available in local Git history.
- Commit hash: `46ef204`
- Next recommended stage: Backfill project logs from the user-provided conversation record.

## Date not verified from local evidence - User-level Skill Maker audit discovery

- Source: user-provided conversation record
- Stage name: Audit mode check for Skill Maker discoverability
- Goal: Check whether the current Skill Maker setup would be discoverable and usable by a future Codex session.
- Files changed: none; the requested task was audit-only.
- Checks run: conversation record requested checks for `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md`, Codex instruction files, duplicate Skill names, frontmatter, Markdown fences, and sensitive-content risk markers.
- Result: The conversation record explicitly includes the official user-level Skill Maker path and later sessions show `$skill-maker` available from that user-level path.
- Risks: Exact audit command output and date are not preserved in local Git history.
- Commit hash: not applicable.
- Next recommended stage: Keep repo source and installed user-level Skill location clearly separated.

## 2026-06-03 - Log backfill from conversation record

- Source: user-provided conversation record
- Stage name: Log backfill mode
- Goal: Backfill project logs only for events explicitly visible in the conversation record, using Git history as higher-confidence evidence where available.
- Files changed: `CHANGELOG.md`, `docs\engineering_log.md`, `docs\decision_log.md`, `docs\troubleshooting_log.md`, `docs\project_journal.md`
- Checks run: `.\scripts\audit-skills.ps1`, `git diff --check`, Markdown fence check for changed Markdown files, and `git status --short --untracked-files=all`
- Result: Project logs now distinguish `Source: git history` from `Source: user-provided conversation record`.
- Risks: Conversation-sourced entries have lower confidence than Git-confirmed entries and should not introduce exact commit hashes unless Git confirms them.
- Commit hash: pending; a commit cannot include its own final hash.
- Next recommended stage: Run final read-only release audit and decide whether to push.
