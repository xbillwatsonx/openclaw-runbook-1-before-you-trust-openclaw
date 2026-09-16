# Glossary

Plain definitions for the terms this runbook uses.

| Term | What it means |
|------|---------------|
| **Agent** | The OpenClaw assistant that can inspect and, with your approval, work on the setup. |
| **Archive** | One compressed file containing a collected backup. |
| **Backup** | A private copy of your configuration, workspace, credentials, and state that you can use during recovery. |
| **Access** | An independent route to the machine that runs OpenClaw. |
| **Rollback** | Deliberately returning to an older known-good state. |
| **Recovery** | The practical path back to a working setup, including knowing where to get help. |
| **Gateway** | The OpenClaw process that runs the agent, manages sessions, and connects channels. |
| **State directory** | `~/.openclaw`, where sessions, memory, and runtime state live. |
| **Config file** | `~/.openclaw/openclaw.json`, how the gateway behaves, who can talk to it, and what it can do. |
| **Credentials** | Private channel and model authentication material that OpenClaw uses to connect to chat channels and AI providers. Keep private. |
| **Workspace** | `~/.openclaw/workspace`, where your files, notes, projects, and memory live. |
| **Service unit** | The systemd user unit (`openclaw-gateway.service`) that starts and keeps the gateway running. |
| **Loopback** | A network address (`127.0.0.1`) reachable only from the local machine, not the wider network. |
| **systemd user service** | A service managed per-user (not system-wide), started with `systemctl --user`. |
| **Manifest** | A file inside a backup archive that lists what it contains, used for verification. |
| **Off-host** | Stored somewhere separate from the computer that runs OpenClaw, not on the same disk or failure domain. |
| **Recovery information sheet** | A single page of recovery details kept outside OpenClaw. |
| **Scratch directory** | A temporary, empty directory used for a safe extraction test. |
| **Terminal** | A text-based window for working directly on a computer. |
| **Verification** | A check that an archive exists, is intact, and contains the material you expect. |
| **WSL** | Windows Subsystem for Linux, which lets Windows run Linux tools. |
| **Destructive restore** | Restoring a backup over the live install, which can overwrite a working setup. |
| **Ratchet state** | Security counters or keys that advance forward over time and can fall out of sync if you restore an older backup. |
