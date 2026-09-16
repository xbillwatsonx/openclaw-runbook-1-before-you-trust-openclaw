# Prompt: Map What Your Setup Depends On

Copy this into your OpenClaw chat. It helps you see what a complete backup needs to cover.

---

**For my agent:** Read **Before You Trust OpenClaw: Backups, Access, and a Recovery Plan** at `RUNBOOK_RELEASE_URL_PENDING`, especially **Section 2, Read-only setup assessment**, before acting. If the address still says `RUNBOOK_RELEASE_URL_PENDING`, stop and ask me to provide the included local runbook file. This prompt authorizes read-only inspection only.

Map the state directory, active configuration path, workspace, credentials location if identifiable, and gateway service for this installation. Note any custom `OPENCLAW_CONFIG_PATH` or non-default location that changes the usual assumptions. Give me a short explanation of why each item matters to recovery, without printing secret values or private file contents.

Finish with what you checked, what you found, and the next safe step.
