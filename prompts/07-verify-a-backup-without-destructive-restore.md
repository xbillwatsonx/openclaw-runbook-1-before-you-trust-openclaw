# Prompt: Verify a Backup Safely

Copy this into your OpenClaw chat after you have a backup archive.

---

**For my agent:** Read **Before You Trust OpenClaw: Backups, Access, and a Recovery Plan** at `https://raw.githubusercontent.com/xbillwatsonx/openclaw-runbook-1-before-you-trust-openclaw/v0.1.0/runbook/oc-runbook-1-before-you-trust-openclaw.md`, especially **Section 7, Verify the archive without touching the live install**, before acting.

Help me confirm that my archive exists, passes `openclaw backup verify <archive-path>`, and has a sensible contents listing. If I ask for a stronger extraction check, explain what will be written, wait for my approval, create a scratch directory, a temporary empty directory used for a safe extraction test, with `mktemp -d`, and extract only there. Clean up only that exact scratch directory after I confirm the result.

Report what you checked, what you found, and the next safe step. Do not restore over the live installation.
