# Contributing

Thanks for improving Codex Skills From Scratch.

Keep contributions small, auditable, and easy for a beginner to understand.

## Before changing files

1. Check the current repo state:

```powershell
git status --short --untracked-files=all
```

2. Run the repo-source audit before installation:

```powershell
.\scripts\audit-skills.ps1 -Mode CI
```

3. Preview installation before any real install:

```powershell
.\scripts\install.ps1
```

`install.ps1` is dry-run by default. Use `-Install` only when you intend to copy the repo Skill into the user-level Skills location.

After installing Skill Maker, run the local install audit:

```powershell
.\scripts\audit-skills.ps1 -Mode Local
```

## Safety rules

- Do not add sensitive values, access credentials, local-only private files, or machine logs.
- Do not include environment-file contents.
- Keep examples as examples unless a maintainer explicitly decides to install them as real Skills.
- Do not broaden a pull request beyond its stated scope.

## Skill changes

When changing a Skill:

- keep the change minimal;
- prefer success criteria, known pitfalls, deterministic tools, and verification;
- avoid speculative lessons;
- run `.\scripts\audit-skills.ps1 -Mode CI` before install-related changes and `.\scripts\audit-skills.ps1 -Mode Local` after installing Skill Maker;
- explain why the lesson is reusable.

## Pull requests

Good pull requests are:

- focused on one stage or one workflow;
- easy to review from the diff;
- backed by local checks;
- clear about what is out of scope.

Use the pull request template and list the checks you ran.
