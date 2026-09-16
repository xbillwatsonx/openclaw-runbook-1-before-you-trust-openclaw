# OpenClaw Runbook 1: Before You Trust OpenClaw

**Status:** Review-ready, not yet released. Planned first release: 0.1.0.
**Scope:** Linux and WSL, single operator, self-hosted OpenClaw.

OpenClaw Runbook 1 helps you establish four separate capabilities before OpenClaw becomes important to your daily life: a private verified backup, independent access to the host, a deliberate rollback path, and a practical recovery plan. It is written for a technically comfortable self-hosted operator working with an OpenClaw agent, and the procedure was technically validated against a live OpenClaw installation before this package was assembled.

## Quick start

1. Give your agent the runbook first: [runbook/oc-runbook-1-before-you-trust-openclaw.md](runbook/oc-runbook-1-before-you-trust-openclaw.md). Your agent reads the whole runbook before acting.
2. Want the short version? Start with the quick-start card: [runbook/quick-start-card.md](runbook/quick-start-card.md).
3. Copy the eight prompts into your OpenClaw chat one at a time, in order, from the [prompts directory](prompts/) or all together in [prompts.txt](prompts.txt).
4. Finish with your recovery information sheet. Fill in [RECOVERY-SHEET-TEMPLATE.md](RECOVERY-SHEET-TEMPLATE.md) and keep the completed sheet outside OpenClaw.

The runbook address inside the prompts and tutorial says `RUNBOOK_RELEASE_URL_PENDING` until the package is released. Until then, each prompt tells your agent to stop and ask you for the included local runbook file from step 1, so the package is fully usable before release.

## Complete file map

| File | What it is |
| --- | --- |
| [README.md](README.md) | This overview: quick start, file map, and release status. |
| [CHANGELOG.md](CHANGELOG.md) | Package history and the planned 0.1.0 first release. |
| [LICENSE](LICENSE) | Creative Commons Attribution 4.0 International. |
| [.gitignore](.gitignore) | Ignores OS and editor artifacts for package maintainers. |
| [justfile](justfile) | Common commands for agents and maintainers. |
| [runbook/oc-runbook-1-before-you-trust-openclaw.md](runbook/oc-runbook-1-before-you-trust-openclaw.md) | The canonical agent-facing runbook. |
| [runbook/quick-start-card.md](runbook/quick-start-card.md) | One-page summary: prompt order and the first message to send your agent. |
| [runbook/glossary.md](runbook/glossary.md) | Plain definitions for the terms the runbook uses. |
| [tutorial/before-you-trust-openclaw-tutorial.md](tutorial/before-you-trust-openclaw-tutorial.md) | Reader-facing explanation of the concepts and how to use the prompts. |
| [prompts/01-audit-my-openclaw-setup.md](prompts/01-audit-my-openclaw-setup.md) | Prompt 1: audit your current setup. |
| [prompts/02-map-what-my-setup-depends-on.md](prompts/02-map-what-my-setup-depends-on.md) | Prompt 2: map what your setup depends on. |
| [prompts/03-confirm-independent-host-access.md](prompts/03-confirm-independent-host-access.md) | Prompt 3: confirm independent host access. |
| [prompts/04-create-a-verified-backup.md](prompts/04-create-a-verified-backup.md) | Prompt 4: create a verified backup. |
| [prompts/05-move-the-backup-off-host.md](prompts/05-move-the-backup-off-host.md) | Prompt 5: move the backup off-host. |
| [prompts/06-build-my-recovery-information-sheet.md](prompts/06-build-my-recovery-information-sheet.md) | Prompt 6: build your recovery information sheet. |
| [prompts/07-verify-a-backup-without-destructive-restore.md](prompts/07-verify-a-backup-without-destructive-restore.md) | Prompt 7: verify a backup safely. |
| [prompts/08-record-limitations-and-maintenance-date.md](prompts/08-record-limitations-and-maintenance-date.md) | Prompt 8: record limitations and your maintenance date. |
| [prompts.txt](prompts.txt) | All eight paste-ready prompts in order, in one plain text file. |
| [RECOVERY-SHEET-TEMPLATE.md](RECOVERY-SHEET-TEMPLATE.md) | Blank recovery information sheet to fill in and keep outside OpenClaw. |
| [scripts/validate-package.sh](scripts/validate-package.sh) | Deterministic package validator used by the justfile. |

## The eight prompts

Work through them in order:

1. [Audit your setup](prompts/01-audit-my-openclaw-setup.md)
2. [Map what your setup depends on](prompts/02-map-what-my-setup-depends-on.md)
3. [Confirm independent host access](prompts/03-confirm-independent-host-access.md)
4. [Create a verified backup](prompts/04-create-a-verified-backup.md)
5. [Move the backup off-host](prompts/05-move-the-backup-off-host.md)
6. [Build your recovery information sheet](prompts/06-build-my-recovery-information-sheet.md)
7. [Verify a backup safely](prompts/07-verify-a-backup-without-destructive-restore.md)
8. [Record your maintenance plan](prompts/08-record-limitations-and-maintenance-date.md)

Complete all eight before calling the recovery-readiness session finished.

## Release status

This is the review-ready pre-release package for version 0.1.0, and it has not been released yet. The only expected release blocker: the runbook address inside the prompts and tutorial still says `RUNBOOK_RELEASE_URL_PENDING`. At release time, replace that placeholder with the published runbook URL everywhere it appears. Do not invent or guess the URL before then; the included local runbook file is the usable fallback.

## Commands for agents and maintainers

From the package root:

- `just help`: list all commands.
- `just validate`: run the deterministic package validator.
- `just agent-preflight`: preflight checks before working on the package.
- `just agent-verify`: verification after edits.
- `just agent-status`: current package state.

## License

Creative Commons Attribution 4.0 International. See [LICENSE](LICENSE).
