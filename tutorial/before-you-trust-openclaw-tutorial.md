# Before You Trust OpenClaw: Backups, Access, and a Recovery Plan

**A practical companion to OpenClaw Runbook 1: Before You Trust OpenClaw**

**Edition:** Linux and WSL, first edition
**Status:** Review-ready companion, not yet released.

If OpenClaw stopped working today, you’d want three things close at hand: a way into the computer that runs it, a private backup, and a simple record of what belongs where. This guide explains how those pieces fit together and how to use the matching runbook with your agent.

## Need a simpler explanation?

If any part of the runbook feels too technical, you do not have to figure it out alone. Give the released runbook link to your AI agent and use this prompt. While the release URL is pending, give the agent the included local runbook file instead: `../runbook/oc-runbook-1-before-you-trust-openclaw.md`.

> Read this runbook before doing anything. Explain it to me in plain, non-technical language, one section at a time. Define unfamiliar terms and use simple examples when they help. Check that I understand before continuing. Do not run commands, create files, or change my system unless I explicitly approve the action.

You can also ask your agent to explain just one paragraph, term, or step that is confusing. The goal is to help you understand the runbook before anything changes on your system.

## What you’re building

You’re building recovery readiness. That means you can reach the host, the computer running OpenClaw, yourself; you know which parts of the setup matter; and you have a private copy you can check when you need it.

Four ideas work together:

| Term | Plain meaning |
| --- | --- |
| Backup | A private copy of the setup and work you want to keep. |
| Access | A way to reach the computer without relying on the agent. |
| Rollback | A deliberate return to an older known-good state. |
| Recovery | The practical path back to a working setup, including knowing where to get help. |

That's why the accompanying runbook, “OpenClaw Runbook 1: Before You Trust OpenClaw”, starts with getting your agent to understand the setup and independent host access, a direct way to reach the computer without relying on OpenClaw, before it asks the agent to create anything.

## Start by understanding your own setup

Your agent should begin with a read-only look at the installation. On a typical Linux or WSL setup, it will identify the OpenClaw state directory, the folder where OpenClaw keeps its working state; the active configuration, the settings that tell OpenClaw how to run; the workspace, where your files, notes, and projects live; your credentials, the private channel and model authentication material, and where they are stored; and the gateway service, the background process that connects the agent to its tools and chat channels. It will also check the installed version and the backup commands that are actually available.

The defaults are useful starting points, but your own setup is what matters. An agent should notice a custom configuration path or a workspace stored somewhere unusual and explain it in plain English. It should describe sensitive material without printing tokens, passwords, or file contents.

Your installed `openclaw backup --help` output is the source of truth for backup commands. That keeps the work grounded in the version you actually have, instead of assuming every feature mentioned online is ready on your machine.

## Make sure you can reach the host

Independent access is simple: open a terminal directly on the computer that runs OpenClaw, sign in as the account that owns the installation, and confirm the state directory is there. On a local computer, that could be Ubuntu Terminal, Windows Terminal connected to WSL, or the machine’s own console.

Once you've done that, you know you can still reach the setup if the agent is unavailable. If you later want SSH, another account, or remote access, those can be useful follow-up projects with their own clear plan.

## Choose where the backup will live

The built-in archive, one compressed file containing the collected backup, is usually the straightforward option when your installed CLI, the command-line tool used in a terminal, provides both `create` and `verify`. Before an archive is made, choose:

1. The local output directory.
2. The private off-host place, meaning somewhere separate from the computer running OpenClaw, where the finished copy will live.
3. Whether the backup should include the whole workspace.

A private cloud folder, external SSD, NAS, or another computer you control can all work. The important thing is that the final copy is private and separate from the computer you’re protecting. Since an archive may include credentials and personal working material, treat it like a recovery asset, not an ordinary project file.

Your agent should explain the choice, wait for your approval, create the archive, verify it, and confirm that the private off-host copy arrived. That gives you a clear, repeatable routine instead of a one-time mystery command.

## Keep a short recovery sheet

A recovery information sheet is the page you’ll be glad you made when you’re busy or something has gone sideways. Keep it outside OpenClaw, somewhere private that you can reach independently.

It should include the host, owner account, important locations, how you open a direct terminal, backup method and destination, how to verify an archive, a second route for help, and the next maintenance date. It doesn't need to be fancy. It needs to be clear enough to use under pressure.

## Check the archive safely and keep it current

Verification is how you turn a file into a backup you can trust. The runbook has your agent check that the archive exists, run the installed verification command, and inspect its contents without touching the live OpenClaw directories. If you want a stronger check, it can use a scratch directory, a temporary, empty directory used for a safe extraction test, and clean up that exact directory afterward.

Restoring an older backup can also restore older ratchet state, security counters or keys that advance over time. If that older state no longer matches a connected service, you may need to relink its credentials.

Set a maintenance date about a month out. On that date, make a fresh archive, verify it, confirm the off-host copy, check that direct host access still works, and update the recovery sheet if anything important changed.

## How to use the prompts

When the released runbook is available, open it first, then copy one prompt at a time into your OpenClaw chat. Each prompt tells your agent which runbook section to read before it acts, and it tells you what that step is for. Let the agent finish and report the result before moving to the next prompt.

While the release URL is pending, use the included local runbook file: `../runbook/oc-runbook-1-before-you-trust-openclaw.md`.

**Runbook address:** `RUNBOOK_RELEASE_URL_PENDING`

| Prompt | What it helps you do | Runbook section |
| --- | --- | --- |
| [Audit your setup](../prompts/01-audit-my-openclaw-setup.md) | Learn the version, paths, service, and backup capability. | 2. Read-only setup assessment |
| [Map what your setup depends on](../prompts/02-map-what-my-setup-depends-on.md) | Identify the material your backup needs. | 2. Read-only setup assessment |
| [Confirm independent host access](../prompts/03-confirm-independent-host-access.md) | Prove you can reach the host directly. | 3. Confirm independent host access |
| [Create a verified backup](../prompts/04-create-a-verified-backup.md) | Choose a destination, approve it, then create and verify an archive. | 4 and 5 |
| [Move the backup off-host](../prompts/05-move-the-backup-off-host.md) | Put the verified archive in a private, separate place. | 4 and 5 |
| [Build a recovery information sheet](../prompts/06-build-my-recovery-information-sheet.md) | Create your short, private recovery reference. | 6. Make the recovery information sheet |
| [Verify a backup safely](../prompts/07-verify-a-backup-without-destructive-restore.md) | Check the archive without disturbing the live setup. | 7. Verify the archive without touching the live install |
| [Record maintenance](../prompts/08-record-limitations-and-maintenance-date.md) | Capture the next maintenance date and what you’ll do then. | 8 and 9 |

## Glossary

| Term | What it means |
| --- | --- |
| Agent | The OpenClaw assistant that can inspect and, with approval, work on your setup. |
| Archive | One compressed file containing a collected backup. |
| Backup | A private copy of material you want to preserve. |
| Configuration | Settings that tell OpenClaw how to run. |
| Credentials | Private channel and model authentication material that OpenClaw uses to connect to chat channels and AI providers. Keep private. |
| Gateway | The OpenClaw process that connects the agent to its tools and chat channels. |
| Off-host | Stored somewhere separate from the computer that runs OpenClaw, not on the same disk or failure domain. |
| Recovery information sheet | A short private reference with the details you need when the agent is unavailable. |
| Scratch directory | A temporary, empty directory used for a safe extraction test. |
| Ratchet state | Security counters or keys that advance forward over time and can fall out of sync if you restore an older backup. |
| State directory | The place where OpenClaw keeps its working state. |
| Terminal | A text-based window for working directly on a computer. |
| Verification | A check that an archive exists, is intact, and contains the expected material. |
| WSL | Windows Subsystem for Linux, a way to run Linux tools on Windows. |
