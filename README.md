# Codex Skills Starter

This folder is the local source-of-truth for reusable Codex Skill Maker files, templates, examples, and Windows helper scripts.

Installed Codex locations:

- Codex global instruction file: `%USERPROFILE%\.codex\AGENTS.md`
- Codex user-level Skill installation location: `%USERPROFILE%\.agents\skills`
- Installed Skill Maker target: `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md`

Repo source locations:

- Skill Maker source: `skills\skill-maker\SKILL.md`
- Canonical task Skill template: `templates\task-skill-template.md`
- Example Skill: `examples\market-research\SKILL.md`

`examples\market-research` is only an example. It should not become a real callable Skill unless it is explicitly installed into `.agents\skills`.

## Recommended workflow

1. For a trivial one-off task, ask directly and do not create a Skill.
2. For a repeatable or tool-heavy task, use one of the prompts in `prompt-templates.md`.
3. When creating a new Skill, start from `templates/task-skill-template.md`.
4. Put personal cross-project Skills in `%USERPROFILE%\.agents\skills\<skill-name>\SKILL.md`.
5. Put project-specific Skills in `.agents\skills\<skill-name>\SKILL.md` inside that project.

## Windows helper scripts

Run scripts from PowerShell:

```powershell
.\scripts\audit-skills.ps1
.\scripts\install.ps1
.\scripts\install.ps1 -Install
```

`install.ps1` defaults to dry-run mode. It only copies `skills\skill-maker\SKILL.md` to `%USERPROFILE%\.agents\skills\skill-maker\SKILL.md` when `-Install` is provided.

install.ps1 defaults to dry-run mode.

## Manual verification

Inside Codex, run `/skills` or explicitly mention `$skill-maker`.

From a terminal, you can also run:

```powershell
codex --ask-for-approval never "Summarize the current instructions and tell me whether the skill-maker Skill is available."
```

## Files here

- `prompt-templates.md`: reusable daily prompts for Skill-first work.
- `templates/task-skill-template.md`: the standard structure for new task Skills.
- `examples/market-research/SKILL.md`: an example Skill showing the expected level of detail.
- `scripts/install.ps1`: dry-run by default installer for the Skill Maker.
- `scripts/audit-skills.ps1`: read-only local audit for this starter repo.
