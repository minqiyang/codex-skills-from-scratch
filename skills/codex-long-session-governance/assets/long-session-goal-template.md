# Long Session Goal Template

```text
/goal Continue <repo/project> from latest verified state and complete exactly one PR-sized checkpoint: <stage/task name>.

Before work:
- Use $codex-long-session-governance.
- AGENTS.md should already be loaded if present.
- First read only: <handoff>, <repo_map>, <controller>, <stage_plan>.
- Then targeted-read only files needed for this checkpoint.
- Do not broad-read long logs or generated reports.

Context:
<1-3 lines of latest verified state>

Objective:
<1-3 lines>

Scope:
- <deliverable 1>
- <deliverable 2>
- <deliverable 3>
- <deliverable 4>
- <deliverable 5>

Out of scope:
<hard no-go items>

Validation:
<commands>

Stop gates:
- Git/PR: follow repo controller protected PR merge policy; non-high-risk PRs
  may enable GitHub auto-merge or use normal protected PR merge only when risk,
  trusted author/pusher identity, branch protection, required checks, required
  reviews, and changed-file scope are verified. Never direct-push or
  direct-merge to the protected base branch, bypass protections, or use
  `--admin`.
- PR gate: if an existing PR is not verified merged, report once and enter a paused external wait state; on automatic resume without a user-stated merge/resume/inspect request, do not query GitHub, repeat gate reports, print repeated pause notes, mark complete, or mark blocked. If forced to respond, say only `Waiting for PR #X to merge; no checks run.`
- dirty worktree or unrelated changes;
- failing checks not safely fixable within scope;
- credentials, secrets, or config access required;
- destructive operation required;
- scope conflict or high-risk ambiguity;
- after PR/checkpoint is opened or completed.

Final report:
Stage, branch, commit/PR if any, risk classification, author/pusher
verification, protection/check/review verification, auto-merge or normal
protected PR merge status, files changed, checks run, issues, assumptions,
updated handoff path, next recommended stage, and confirmation that no direct
merge, no `--admin`, and no bypass were used.
```
