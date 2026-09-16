# OpenClaw Runbook 1 public package.
# Status: review-ready, not yet released. Planned first release: 0.1.0.

# Show all commands
help:
    @just --list

# Open command menu
menu:
    @justx

# Run the deterministic package validator
validate:
    bash scripts/validate-package.sh

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
