# Prompt: Create a Verified Backup

Copy this into your OpenClaw chat after you have independent host access.

---

**For my agent:** Read **Before You Trust OpenClaw: Backups, Access, and a Recovery Plan** at `https://raw.githubusercontent.com/xbillwatsonx/openclaw-runbook-1-before-you-trust-openclaw/v0.1.0/runbook/oc-runbook-1-before-you-trust-openclaw.md`, especially **Sections 4 and 5, Choose a backup method and destination** and **Create and verify the supported archive**, before acting.

First, run `openclaw backup --help` and tell me whether this build provides both `create` and `verify`. Then help me choose a private output directory, a private off-host destination, and whether the workspace should be included. Explain the choice and wait for my explicit approval before creating an archive.

After I approve, use the supported archive command from the runbook, verify the resulting archive again, and report its filename, size, verification result, and privacy-safe destination description. Do not print credentials or create a manual backup unless I separately approve that new plan.
