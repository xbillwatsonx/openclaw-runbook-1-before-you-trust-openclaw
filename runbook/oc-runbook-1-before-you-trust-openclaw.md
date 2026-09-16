# OpenClaw Runbook 1, Before You Trust OpenClaw: Backups, Access, and a Recovery Plan

**Series:** AgentHelpSite OpenClaw Beginner Runbook Series
**Edition:** Linux and WSL only, first edition
**Status:** Review-ready, technically validated, not yet released
**Audience:** An OpenClaw agent working with a technically comfortable self-hosted operator

## Agent instructions

The user reaches this runbook through its matching prompt. They do not need to read this document. Read it completely before acting.

1. Confirm the user's installation matches the Linux/WSL, single-operator scope. Report any mismatch and stop before making changes.
2. Keep assessment separate from changes. Explain the proposed change, its effect, and the rollback or recovery path before requesting approval.
3. Never print credentials, tokens, private paths, or personal data. Describe their presence without exposing values.
4. Do not run destructive commands. This runbook never authorizes `openclaw reset`, `openclaw uninstall`, an in-place restore, or service changes.
5. At the end of each stage, report: what you checked, what you found, what changed, what still needs attention, and the next safe step.

## 1. Outcome and boundaries

Help the user establish four separate capabilities before OpenClaw becomes important to their daily life:

| Capability | Question it answers |
| --- | --- |
| Backup | Do I have a private copy of the material that matters? |
| Access | Can I reach the host without OpenClaw? |
| Rollback | Can I return to a known-good state deliberately? |
| Recovery | Can I actually get working again after a failure? |

Do not treat these as interchangeable. A backup does not prove host access, and a successful archive does not guarantee recovery.

This runbook covers a local Linux or WSL installation, local-console access, private off-host backup storage, meaning storage separate from the computer running OpenClaw, and non-destructive verification. It does not cover macOS, native Windows, Docker, VPS deployments, remote gateway mode, multi-tenant installations, SSH setup, or destructive restore testing.

## 2. Read-only setup assessment

**Goal:** establish the installation's actual paths, version, service model, and backup capability before selecting a backup procedure.

Run the following commands on the OpenClaw host. They are read-only.

```bash
openclaw --version
openclaw status
openclaw backup --help
printf '%s\n' "${OPENCLAW_CONFIG_PATH:-not set}"
ls -ld ~/.openclaw ~/.openclaw/workspace ~/.config/systemd/user/openclaw-gateway.service 2>/dev/null
```

Determine and report, without revealing secret contents:

- the installed OpenClaw version and whether the gateway is running;
- the state directory, where OpenClaw keeps its working state; active configuration path; workspace; credentials location, where private channel and model authentication material is stored, if identifiable; and service unit;
- whether a custom `OPENCLAW_CONFIG_PATH` changes the default assumption;
- which backup subcommands the installed CLI actually offers; and
- any missing or unusual dependency.

Default Linux/WSL locations are `~/.openclaw`, `~/.openclaw/openclaw.json`, `~/.openclaw/workspace`, and the systemd user unit `~/.config/systemd/user/openclaw-gateway.service`. Treat them as defaults, not proof. The configuration path or credentials directory can differ.

Explain that OpenClaw is designed around one trusted operator per gateway. A session key routes a conversation, it is not authorization. Do not turn this task into a security audit. Security and audit work belong in their own runbooks.

## 3. Confirm independent host access

**Goal:** prove the user has independent host access, a direct way to reach the computer running OpenClaw without relying on the agent they are trying to protect.

Ask the user to open a terminal directly on the machine that runs OpenClaw, without first messaging the OpenClaw agent. On a local computer, this can be Ubuntu Terminal, Windows Terminal with WSL, or the host's physical console. Confirm that they can log in as the account that owns the installation. Ask them to run:

```bash
ls -ld ~/.openclaw
```

Mark independent access verified only after the user confirms they completed this from that direct host terminal.

**Stop condition:** if the user cannot independently reach the host, stop the runbook. Explain that an archive cannot solve a host-access problem. Record local console or SSH setup as a separate follow-up. Do not decide on the user's behalf to create accounts, change passwords, open ports, or configure remote access. This does not restrict the user. It simply means those changes need their separate, explicit request.

## 4. Choose a backup method and destination

**Goal:** select a private, off-host destination, meaning somewhere separate from the computer running OpenClaw, before creating an archive.

Recommend the first-class OpenClaw archive when `openclaw backup --help` confirms that `create` and `verify` are available. It is the preferred method because it builds a timestamped archive and can validate it.

Before creating anything, ask the user to choose and explicitly approve:

1. an output directory that is not inside the OpenClaw state or workspace;
2. an off-host destination; and
3. whether the full workspace belongs in the backup.

Offer familiar examples of off-host destinations: a private Google Drive, OneDrive, Dropbox, or iCloud Drive folder; an external USB drive or SSD; a NAS; or another computer they control. A private GitHub repository is suitable only for a separately encrypted backup archive. Do not use GitHub for raw OpenClaw backups because they can contain credentials and personal material.

Explain that the archive must never be placed in a public repository, shared folder, or public link.

Use this decision guide:

| Situation | Method |
| --- | --- |
| The CLI works and the user wants the supported default | First-class archive |
| The CLI is unavailable or broken | Manual archive only after a separate, careful inventory of state, configuration, workspace, and external credentials |
| The user asks about scheduled Git backups shown in newer documentation | Explain that availability is version-dependent and use only commands shown by their installed `openclaw backup --help` |

**Stop condition:** if the only available destination is the same disk or failure domain as the host, do not call the backup off-host. Help the user choose a familiar alternative, such as a private Google Drive, OneDrive, Dropbox, or iCloud Drive folder, an external USB drive or SSD, a NAS, or another computer they control. Do not create or upload an archive until they approve the destination. Use a private GitHub repository only if the archive is separately encrypted.

## 5. Create and verify the supported archive

After the user approves the destination, create the archive with the installed CLI. Replace the placeholder only with the chosen directory.

```bash
openclaw backup create --verify --output <approved-output-directory>
```

This command writes an archive, so state clearly before running it that it will create a private `.tar.gz` file in the approved location. Do not substitute `--only-config` or `--no-include-workspace` unless the user understands the missing material and explicitly selects that tradeoff.

Locate the new archive, then verify it again with the exact resulting path:

```bash
openclaw backup verify <archive-path>
ls -lh <archive-path>
```

If the CLI cannot create or verify the archive, stop. Do not invent a successful backup, switch to a manual archive, stop a service, or make a repair without explaining the failure and getting new approval.

Confirm with the user that the archive has reached the approved off-host, private destination. A local staging folder is not enough until that transfer is verified.

Report the method, archive filename, size, verification result, and a privacy-safe description of the destination. Do not report secrets or a public link.

## 6. Make the recovery information sheet

**Goal:** give the user a recovery reference that still exists when OpenClaw does not.

Use `../RECOVERY-SHEET-TEMPLATE.md` as the format. Gather only the values needed for the following fields:

- host and operating-system description;
- owner account;
- state directory, configuration file, workspace, and service name;
- how the user independently reaches the host;
- backup method, private destination description, last-backup date, and verification command;
- a second route for help, if the user chooses one; and
- a maintenance date one month from completion.

Prepare the completed sheet only in a private channel or local private file approved by the user. Tell the user to keep it outside `~/.openclaw`, such as in a password manager, a second device, or a printed page. Do not place real values in a public tutorial, repository, or group chat.

Do not require Hermes, Codex, or a specific person as the second route. The result must work for a user who has none of those.

## 7. Verify the archive without touching the live install

**Goal:** verify that the archive exists, is intact, and can be read without restoring over production state.

Run or guide the user through:

```bash
openclaw backup verify <archive-path>
tar -tzf <archive-path> | head -50
```

Confirm that the listing is consistent with the user's selected scope. Do not print archive entries that expose sensitive names or content into a public chat.

If stronger verification is requested and the user approves a scratch extraction, use a scratch directory, a temporary, empty directory used for a safe extraction test. State exactly what will be written there, then extract only there. Never use a live OpenClaw directory as the destination.

```bash
scratch_dir=$(mktemp -d)
tar -xzf <archive-path> -C "$scratch_dir"
find "$scratch_dir" -maxdepth 2 -mindepth 1 -print | head -50
```

After the user has confirmed the result, remove only the exact scratch directory created by `mktemp -d`. Do not use a broad path, glob, or an assumed directory name.

**Stop condition:** if verification fails, or the archive contents do not match the chosen scope, do not report completion. Preserve the error output without secret values and return to the backup decision stage.

## 8. Explain limits and set maintenance

State these limits plainly:

- A backup reduces avoidable loss, it does not prevent downtime or guarantee recovery.
- An unverified backup is unproven.
- Restoring older state may restore older ratchet state, security counters or keys that advance over time. If that state no longer matches a connected service, channel credentials may need relinking.
- Backup features differ by installed OpenClaw version. Never assume a newer online command exists locally.
- This first edition proves local-console access only. It does not create remote recovery access.

Set the next maintenance date for one month after completion. Offer to schedule a reminder if the user's agent supports it, but do not create one without approval. The reminder should tell the user to create a new backup, verify it, confirm the off-host copy, re-check independent access, and update the recovery sheet after meaningful changes.

## 9. Completion criteria and stop conditions

Mark this recovery-readiness session complete only when all applicable criteria are true:

- [ ] The installation paths, version, service model, and available backup commands were assessed.
- [ ] The user independently accessed the host outside OpenClaw.
- [ ] The user approved a private, off-host backup destination.
- [ ] A supported archive was created and verified.
- [ ] The off-host copy was confirmed without publishing it.
- [ ] The recovery information sheet was completed and stored outside OpenClaw.
- [ ] The archive was non-destructively checked.
- [ ] The user understands the limits and has a next maintenance date.

Stop and report instead of continuing when any of the following occurs:

- The environment is outside the Linux/WSL scope.
- The user lacks independent host access.
- The chosen destination is not private or is only on the same failure domain.
- The available CLI does not support the command proposed by this runbook.
- Archive creation or verification fails.
- The user asks to restore over the live installation.
- A command would expose secrets, change access controls, stop a service, update OpenClaw, reset configuration, or uninstall OpenClaw.

## 10. Evidence and version discipline

This runbook is based on an approved specification, research against a live OpenClaw installation, and current command help from the user's own installation. The research installation used OpenClaw 2026.7.1, where `openclaw backup` exposed `create`, `verify`, and `help`. Newer online documentation may describe additional subcommands. The user's local `--help` output is authoritative for which actions are available to their agent.

For the reader-facing concept explanation, see `../tutorial/before-you-trust-openclaw-tutorial.md`. For copyable prompts, use the `../prompts/` directory or `../prompts.txt`.
