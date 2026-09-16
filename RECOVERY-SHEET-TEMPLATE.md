# Recovery Information Sheet (blank template)

Fill this in with your real values and keep it somewhere independent of OpenClaw: a password manager, a printed page, a note on a second device, or a file on a different machine. The point is that you can read it when the agent is down.

Do not store this filled sheet inside `~/.openclaw`. It must survive the thing it describes.

---

## Install

- **Host:** (machine name, OS, e.g. "my-laptop, WSL2 Ubuntu")
- **User:** (the account that owns the install)
- **State directory:** (e.g. `/home/<user>/.openclaw`)
- **Config file:** (e.g. `/home/<user>/.openclaw/openclaw.json`)
- **Workspace:** (e.g. `/home/<user>/.openclaw/workspace`)
- **Service:** (e.g. systemd user unit `openclaw-gateway.service`)

## Independent access

- **How I reach the host without OpenClaw:** (e.g. "local console, login as <user>")
- **Remote access:** (none yet, or SSH details if you have them)

## Backups

- **Method:** (e.g. `openclaw backup create --verify --output <dir>`)
- **Destination:** (e.g. Google Drive folder "openclawbackup", external drive, another machine)
- **Last backup date:** (date)
- **How to verify:** (e.g. `openclaw backup verify <archive>`)

## Second route / help

- **Who or what can help if the primary agent is unavailable:** (e.g. a second agent like Hermes or Codex, a friend who knows the setup, a support contact)

## Next maintenance date

- **Date:** (e.g. one month from now)
- **What to do on that date:** re-run the backup, re-verify it, re-check independent access.
