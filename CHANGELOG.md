# Changelog

This changelog follows a simple Keep a Changelog-style format.

## [Unreleased]

### Added

- Project logs for engineering history, decisions, troubleshooting notes, and reader-facing project narrative.

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
