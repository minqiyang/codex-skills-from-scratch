# Security

This repo is for workflow docs, Codex Skills, templates, examples, and local helper scripts.

It is not a vault, not an access-credential store, and not a system for managing sensitive values.

## Reporting safety issues

If you find a safety issue, report the behavior without including real sensitive values.

Good reports include:

- the file or workflow involved;
- the command or prompt pattern that caused the issue;
- the expected safe behavior;
- whether the issue appears in docs, a Skill, or a script.

Do not include:

- real access credentials;
- environment-file contents;
- private local files;
- raw values from your machine or organization.

Use placeholders such as `<redacted-value>` or `<example-sensitive-value>` when a reproduction needs a stand-in value.

## Maintainer response

Maintainers should:

- reproduce with placeholder values only;
- avoid printing or storing sensitive values;
- keep fixes small and auditable;
- run `.\scripts\audit-skills.ps1` before merging;
- update docs or Skills only with verified, reusable lessons.
