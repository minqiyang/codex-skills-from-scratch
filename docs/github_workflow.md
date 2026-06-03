# Private GitHub Workflow

This document describes the manual private GitHub workflow for this Codex Skills Starter repo.

## Create a private GitHub repo manually

1. Open GitHub in a browser while signed into the account that should own the repo.
2. Create a new repository.
3. Set visibility to private.
4. Do not initialize it with a README, `.gitignore`, or license if this local repo already has those files.
5. Copy the new repository URL after GitHub creates it.

Codex should not create the GitHub repo, create a remote, or push unless the human explicitly approves those actions.

## Add the remote

After the private GitHub repo exists and the human approves linking it, run:

```powershell
git remote add origin <private-repo-url>
git remote -v
```

Confirm that `origin` points to the intended private repository before pushing.

## Push the first branch

After the remote is confirmed and the human approves the first push, run:

```powershell
git branch -M main
git push -u origin main
```

Do not push if the working tree is dirty, if the remote URL is wrong, or if any secret, credential, `.env`, private key, token, or temporary debug file is staged or tracked.

## Use PRs as human approval gates

Use pull requests for changes that affect reusable workflow behavior, installed Skill behavior, or repo governance.

Recommended flow:

1. Create a topic branch for the stage.
2. Make a small scoped change.
3. Run local checks, including `scripts\audit-skills.ps1` when Skill files changed.
4. Commit only the intended files.
5. Push the topic branch only after explicit approval.
6. Open a PR for human review.
7. Treat merge as a human approval gate.

Do not merge a PR automatically. Do not approve or merge a PR on behalf of the human supervisor.

## Request Codex review

After opening a PR, the human can request a review by commenting:

```text
@codex review
```

Codex should review for correctness, safety, scope control, missing checks, and whether the change follows this repo's Skill-first workflow.

## Ask Codex to fix PR feedback

When PR review feedback is actionable, the human can ask:

```text
@codex fix it
```

Codex should inspect the PR feedback, apply only the requested fixes, run relevant local checks, and report what changed. It should not broaden the PR scope without approval.

## Pre-push checklist

Before any push:

- `git status --short` is clean except for intentional staged changes.
- `.gitignore` excludes secrets and temporary files.
- No secret, credential, `.env`, private key, token, or temporary debug file is staged or tracked.
- `git remote -v` points to the intended private GitHub repo.
- Local checks pass.
- Human approval to push has been given.
