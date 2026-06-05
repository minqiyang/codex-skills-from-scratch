# Changelog

This changelog follows a simple Keep a Changelog-style format.

## [Unreleased]

### Changed

- Updated the GitHub Actions Audit workflow to use `actions/checkout@v5` and the explicit `windows-2025-vs2026` runner label.

## [v0.1.0] - 2026-06-03

### Added

- Skill Maker meta Skill for creating, improving, auditing, running retrospectives for, and updating Codex Skills.
- `scripts\install.ps1` with dry-run behavior by default.
- `scripts\audit-skills.ps1` with Local and CI audit modes.
- Prompt templates for Skill-first work, existing Skill use, new Skill creation, and Skill iteration.
- Long-running controller runbook for constrained, stage-based repo evolution.
- Project logs for engineering history, decisions, troubleshooting notes, and reader-facing project narrative.
- GitHub Actions audit workflow for pull requests and pushes.
- Public-readiness docs, including license, contribution guide, safety guide, changelog, and GitHub templates.
- Beginner-facing README positioning for Codex Skills From Scratch.

### Fixed

- Added explicit Local and CI audit modes so GitHub Actions can audit repo source structure without requiring a user-level Codex Skill installation.

### Notes

- This release is a starter kit, not an official OpenAI repo, not a giant Skill catalog, and not a vault for sensitive values.

## [MVP] - 2026-06-02

### Added

- Skill Maker as the core meta Skill for creating, auditing, reviewing, and updating Codex Skills.
- `scripts\install.ps1` as a dry-run-first installer from repo source to user-level Skill installation.
- `scripts\audit-skills.ps1` as a local static audit for Skill structure, Markdown fences, duplicate names, expected safety wording, and risk classification.
- Prompt templates for Skill-first work, existing Skill use, new Skill creation, and Skill iteration.
- A long-running controller runbook for constrained, stage-based repo evolution.
- GitHub workflow documentation for private repo setup, PR review gates, and Codex review prompts.
- Beginner-oriented README positioning for Codex Skills From Scratch.
- Behavior eval prompts for manually checking Skill Maker behavior.
- Public-readiness project docs, including license, contribution guide, and safety reporting guide.
- Minimal GitHub Actions audit workflow for pull requests and pushes.

### Changed

- Replaced required machine-specific paths with portable placeholders such as `<repo-root>` and `%USERPROFILE%`.
- Clarified that examples are source examples by default, not installed callable Skills.

### Notes

- The current MVP is intended as a starter repo, not a large Skill catalog or an autonomous workflow system.
