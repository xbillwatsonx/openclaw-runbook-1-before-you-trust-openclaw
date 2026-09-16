# OpenClaw Runbook 1 public package.
# Status: released, version 0.1.0.

# Show all commands
help:
    @just --list

# Open command menu
menu:
    @justx

# Run the deterministic package validator
validate:
    bash scripts/validate-package.sh

# Build the version 0.1.0 ZIP and checksum beside the package folder
release-archive:
    @slug="$$(basename "$$PWD")"; cd ..; rm -f "$$slug-v0.1.0.zip" "$$slug-v0.1.0.zip.sha256"; zip -rq "$$slug-v0.1.0.zip" "$$slug" -x "$$slug/.git/*"; sha256sum "$$slug-v0.1.0.zip" > "$$slug-v0.1.0.zip.sha256"

# Agent preflight checks
agent-preflight:
    git status
    just --list
    just validate

# Agent verification after edits
agent-verify:
    git status
    git diff --stat
    just validate

# Show current package state
agent-status:
    git status
    git log --oneline -5
