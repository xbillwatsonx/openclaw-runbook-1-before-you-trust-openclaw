# Quick Start Card

Use this when you want to make your OpenClaw setup recoverable without becoming a sysadmin.

## The Simple Setup

Work through these three things:

1. Confirm you can reach the host, the computer running OpenClaw, without relying on OpenClaw itself.
2. Create a verified backup and move it off-host, meaning somewhere separate from that computer.
3. Fill in a recovery information sheet, a short private record of the details needed during recovery, and keep it outside OpenClaw.

## Prompt Order

### Do Today

1. `prompts/01-audit-my-openclaw-setup.md`: audit your current setup
2. `prompts/02-map-what-my-setup-depends-on.md`: identify what a backup must capture
3. `prompts/03-confirm-independent-host-access.md`: prove you can reach the host
4. `prompts/04-create-a-verified-backup.md`: make a verified backup
5. `prompts/05-move-the-backup-off-host.md`: store it off-host
6. `prompts/06-build-my-recovery-information-sheet.md`: write your recovery sheet
7. `prompts/07-verify-a-backup-without-destructive-restore.md`: prove the backup works
8. `prompts/08-record-limitations-and-maintenance-date.md`: set a maintenance date

Complete all eight prompts before calling the recovery-readiness session finished.

## What To Tell The Agent First

```text
Please use the included OpenClaw Runbook 1 file at `runbook/oc-runbook-1-before-you-trust-openclaw.md` to help me make my OpenClaw setup recoverable. Start by inspecting my current setup: what version I am running, how it is installed, what config and workspace files exist, and whether I have any backups. Do not change files yet. First explain what you found and what I should do first.
```

## What Good Looks Like

- you know what "working" looks like before any change
- you have a verified backup stored off-host
- you can reach the host without OpenClaw
- you have a recovery information sheet outside OpenClaw
- you know the four jobs (backup, access, rollback, recovery)

## Safety Boundary

Do not ask the agent to run `openclaw reset`, `openclaw uninstall`, or any destructive restore. Verification is non-destructive. Back up before any `update`, `reset`, or `uninstall`.
