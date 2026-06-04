# Current Context

This file gives future Codex sessions a compact public-facing snapshot of the repo.

## Current status

- Repository: `minqiyang/codex-skills-from-scratch`
- Public release: `v0.1.0`
- Release notes: `docs\release_notes_v0.1.0.md`
- Core Skill source: `skills\skill-maker\SKILL.md`
- Installed Skill Maker target: `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md`
- Local audit mode checks the installed user-level Skill Maker.
- CI audit mode checks repo source structure without requiring a user-level Codex installation.

## Public positioning

Codex Skills From Scratch is a beginner-friendly starter repo for creating, auditing, installing, and evolving Codex Skills from scratch.

The first-screen message should stay focused on:

- the Skill Maker meta Skill;
- dry-run-first installation;
- Local vs CI audit modes;
- examples staying separate from installed Skills;
- project logs and handoff context;
- supervised Codex workflows.

## Next-stage guidance

Good next stages are public polish, documentation clarity, beginner evals, or small maintenance fixes. Avoid expanding this repo into a large Skill catalog unless that becomes an explicit project goal.

Do not store sensitive values, `.env` contents, credentials, private keys, or local-only files here.
