#!/usr/bin/env bash
# Deterministic validator for the OpenClaw Runbook 1 public package.
# Review-ready pre-release package, planned first release 0.1.0.
#
# Checks the package manifest, license integrity, product naming, privacy
# hygiene, Markdown link resolution, prompts.txt integrity, the pre-release
# placeholder handling, and whitespace. Runs offline. This script never
# references private data, private paths, or credentials.

set -u

PKG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PKG_ROOT" || exit 1

issues=0
pass() { printf 'ok: %s\n' "$1"; }
fail() { printf 'FAIL: %s\n' "$1"; issues=$((issues + 1)); }
note() { printf 'note: %s\n' "$1"; }

PROMPT_FILES=(
  prompts/01-audit-my-openclaw-setup.md
  prompts/02-map-what-my-setup-depends-on.md
  prompts/03-confirm-independent-host-access.md
  prompts/04-create-a-verified-backup.md
  prompts/05-move-the-backup-off-host.md
  prompts/06-build-my-recovery-information-sheet.md
  prompts/07-verify-a-backup-without-destructive-restore.md
  prompts/08-record-limitations-and-maintenance-date.md
)

EXPECTED_FILES=(
  .gitignore
  CHANGELOG.md
  LICENSE
  README.md
  justfile
  prompts.txt
  RECOVERY-SHEET-TEMPLATE.md
  runbook/glossary.md
  runbook/oc-runbook-1-before-you-trust-openclaw.md
  runbook/quick-start-card.md
  scripts/validate-package.sh
  tutorial/before-you-trust-openclaw-tutorial.md
  "${PROMPT_FILES[@]}"
)

PROSE_FILES=(
  .gitignore
  CHANGELOG.md
  README.md
  justfile
  prompts.txt
  RECOVERY-SHEET-TEMPLATE.md
  runbook/glossary.md
  runbook/oc-runbook-1-before-you-trust-openclaw.md
  runbook/quick-start-card.md
  tutorial/before-you-trust-openclaw-tutorial.md
  "${PROMPT_FILES[@]}"
)

LICENSE_SHA256="9e5f1b3c610b9c2da5c313bf81d577a7d1acec686bdb0384edefa6df0f90cd94"

# 1. Required files exist.
missing=0
for f in "${EXPECTED_FILES[@]}"; do
  if [ ! -f "$f" ]; then
    fail "missing required file: $f"
    missing=1
  fi
done
if [ "$missing" -eq 0 ]; then pass "all required files present"; fi

# 2. Exact file set: nothing missing, nothing unexpected.
actual="$(find . -type f -not -path './.git/*' | sed 's|^\./||' | sort)"
expected="$(printf '%s\n' "${EXPECTED_FILES[@]}" | sort)"
if [ "$actual" = "$expected" ]; then
  pass "file set matches the package manifest exactly"
else
  fail "file set mismatch (unexpected or missing files)"
  diff <(printf '%s\n' "${EXPECTED_FILES[@]}" | sort) <(printf '%s\n' "$actual") | sed 's/^/    /' || true
fi

# 3. License integrity: exact canonical CC BY 4.0 text.
if command -v sha256sum >/dev/null 2>&1; then
  actual_hash="$(sha256sum LICENSE | awk '{print $1}')"
  if [ "$actual_hash" = "$LICENSE_SHA256" ]; then
    pass "LICENSE matches the canonical CC BY 4.0 text (sha256)"
  else
    fail "LICENSE sha256 mismatch: $actual_hash"
  fi
else
  if head -n 1 LICENSE | grep -q 'Attribution 4.0 International'; then
    note "sha256sum unavailable; only the LICENSE header line was checked"
  else
    fail "LICENSE first line is not the CC BY 4.0 header"
  fi
fi

# 4. Naming consistency: the product is always OpenClaw Runbook 1.
bad=0
for f in "${PROSE_FILES[@]}"; do
  total="$(grep -o 'Runbook 1' "$f" | wc -l)"
  qualified="$(grep -o 'OpenClaw Runbook 1' "$f" | wc -l)"
  if [ "$total" -ne "$qualified" ]; then
    fail "$f: $((total - qualified)) unqualified 'Runbook 1' occurrence(s); the product is OpenClaw Runbook 1"
    bad=1
  fi
done
[ "$bad" -eq 0 ] && pass "product name is consistently qualified as OpenClaw Runbook 1"

# 5. Privacy: no absolute /home/ paths (generic <user> placeholders are fine).
bad=0
for f in "${PROSE_FILES[@]}"; do
  n="$(grep -cE '/home/[A-Za-z0-9]' "$f" || true)"
  n="${n:-0}"
  if [ "$n" -gt 0 ]; then
    fail "$f: $n absolute /home/ path reference(s)"
    bad=1
  fi
done
[ "$bad" -eq 0 ] && pass "no absolute /home/ paths in package prose"

# 6. No em or en dash characters anywhere in the package.
em_dash="$(printf '\xe2\x80\x94')"
en_dash="$(printf '\xe2\x80\x93')"
bad=0
for f in "${EXPECTED_FILES[@]}"; do
  if grep -qF "$em_dash" "$f" || grep -qF "$en_dash" "$f"; then
    fail "$f: contains em or en dash characters"
    bad=1
  fi
done
[ "$bad" -eq 0 ] && pass "no em or en dashes in any package file"

# 7. All relative Markdown links resolve.
broken=0
while IFS= read -r f; do
  dir="$(dirname "$f")"
  while IFS= read -r target; do
    [ -z "$target" ] && continue
    case "$target" in
      http://*|https://*|mailto:*) continue ;;
      '#'*) continue ;;
    esac
    path_part="${target%%#*}"
    [ -z "$path_part" ] && continue
    if [ ! -e "$dir/$path_part" ]; then
      fail "$f: broken Markdown link -> $target"
      broken=1
    fi
  done < <(grep -oE '\]\([^)]+\)' "$f" | cut -c3- | sed 's/)$//' || true)
done < <(find . -name '*.md' -not -path './.git/*' | sort)
[ "$broken" -eq 0 ] && pass "all relative Markdown links resolve"

# 8. Known relative file references resolve.
ref_fail=0
check_ref() {
  # $1 file containing the reference, $2 reference, $3 base directory
  if grep -qF "$2" "$1"; then
    if [ ! -e "$3/$2" ]; then
      fail "$1: referenced path $2 does not resolve from $3"
      ref_fail=1
    fi
  else
    fail "$1: expected reference to $2 is missing"
    ref_fail=1
  fi
}
check_ref runbook/oc-runbook-1-before-you-trust-openclaw.md '../RECOVERY-SHEET-TEMPLATE.md' runbook
check_ref runbook/oc-runbook-1-before-you-trust-openclaw.md '../tutorial/before-you-trust-openclaw-tutorial.md' runbook
check_ref runbook/oc-runbook-1-before-you-trust-openclaw.md '../prompts.txt' runbook
check_ref tutorial/before-you-trust-openclaw-tutorial.md '../runbook/oc-runbook-1-before-you-trust-openclaw.md' tutorial
check_ref runbook/quick-start-card.md 'runbook/oc-runbook-1-before-you-trust-openclaw.md' .
check_ref prompts.txt 'runbook/oc-runbook-1-before-you-trust-openclaw.md' .
for pf in "${PROMPT_FILES[@]}"; do
  check_ref runbook/quick-start-card.md "$pf" .
done
[ "$ref_fail" -eq 0 ] && pass "known relative file references resolve"

# 9. prompts.txt integrity: header, eight complete bodies in order, end marker.
txt="$(cat prompts.txt)"
order_ok=1
if [ "$(head -n 1 prompts.txt)" = "OpenClaw Runbook 1: paste-ready prompts" ]; then
  :
else
  fail "prompts.txt first line must be the OpenClaw Runbook 1 header"
  order_ok=0
fi
grep -q 'Review-ready, not yet released' prompts.txt || { fail "prompts.txt is missing the review-ready status line"; order_ok=0; }
delim_count="$(grep -c '^=== Prompt ' prompts.txt || true)"
delim_count="${delim_count:-0}"
if [ "$delim_count" -ne 8 ]; then
  fail "prompts.txt has $delim_count prompt delimiters, expected 8"
  order_ok=0
fi
grep -q '^=== End of prompts ===' prompts.txt || { fail "prompts.txt: missing end marker"; order_ok=0; }
prev_pos=0
i=1
for pf in "${PROMPT_FILES[@]}"; do
  title="$(sed -n 's/^# Prompt: //p' "$pf")"
  body="$(sed -n '/^\*\*For my agent:\*\*/,$p' "$pf")"
  if [ -z "$title" ] || [ -z "$body" ]; then
    fail "$pf: could not extract title or paste-ready body"
    order_ok=0
    i=$((i + 1))
    continue
  fi
  grep -qF "=== Prompt ${i} of 8: ${title} ===" prompts.txt || { fail "prompts.txt: missing delimiter for prompt $i ($title)"; order_ok=0; }
  rest="${txt:prev_pos}"
  case "$rest" in
    *"$body"*) ;;
    *) fail "prompts.txt: body of prompt $i is missing or out of order"; order_ok=0 ;;
  esac
  prefix="${rest%%"$body"*}"
  prev_pos=$(( prev_pos + ${#prefix} + 1 ))
  i=$((i + 1))
done
[ "$order_ok" -eq 1 ] && pass "prompts.txt contains all eight prompts, complete and in order"

# 10. README requirements.
readme_ok=1
if [ "$(head -n 1 README.md)" = "# OpenClaw Runbook 1: Before You Trust OpenClaw" ]; then
  :
else
  fail "README first line must be '# OpenClaw Runbook 1: Before You Trust OpenClaw'"
  readme_ok=0
fi
grep -q 'Review-ready' README.md || { fail "README must state the review-ready status"; readme_ok=0; }
grep -q 'not yet released' README.md || { fail "README must state it is not yet released"; readme_ok=0; }
grep -q '0\.1\.0' README.md || { fail "README must mention the planned 0.1.0 release"; readme_ok=0; }
grep -qi '^## Quick start' README.md || { fail "README must have a Quick start section"; readme_ok=0; }
map_ok=1
for f in "${EXPECTED_FILES[@]}"; do
  grep -qF "](${f})" README.md || { fail "README file map is missing a link to $f"; map_ok=0; }
done
[ "$map_ok" -eq 1 ] || readme_ok=0
[ "$readme_ok" -eq 1 ] && pass "README title, status, quick start, and complete file map verified"

# 11. CHANGELOG requirements.
cl_ok=1
grep -q 'OpenClaw Runbook 1' CHANGELOG.md || { fail "CHANGELOG must name the product as OpenClaw Runbook 1"; cl_ok=0; }
grep -q '0\.1\.0' CHANGELOG.md || { fail "CHANGELOG must mention the planned 0.1.0 release"; cl_ok=0; }
grep -q 'RUNBOOK_RELEASE_URL_PENDING' CHANGELOG.md || { fail "CHANGELOG must document the RUNBOOK_RELEASE_URL_PENDING release blocker"; cl_ok=0; }
grep -q 'not yet released' CHANGELOG.md || { fail "CHANGELOG must state it is not yet released"; cl_ok=0; }
[ "$cl_ok" -eq 1 ] && pass "CHANGELOG requirements verified"

# 12. No stale draft status strings.
stale=0
for f in "${PROSE_FILES[@]}"; do
  for s in 'not yet technically validated' 'Approved build draft' 'Draft companion' 'still a draft'; do
    if grep -qF "$s" "$f"; then
      fail "$f: stale status string '$s'"
      stale=1
    fi
  done
done
[ "$stale" -eq 0 ] && pass "no stale draft status strings"

# 13. No references to excluded internal material.
internal=0
for f in "${PROSE_FILES[@]}"; do
  if grep -qE 'before-you-trust-openclaw-runbook|RESEARCH-EVIDENCE|EVIDENCE-PLAN|SPEC-DRAFT|RUNBOOK-DRAFT|CONTROLLED-TECHNICAL-VALIDATION|VIRTUAL-VALIDATION|CHECKPOINT-2026|validation/2026' "$f"; then
    fail "$f: references excluded internal material"
    internal=1
  fi
done
[ "$internal" -eq 0 ] && pass "no references to excluded internal material"

# 14. No credential-like patterns.
cred=0
for f in "${EXPECTED_FILES[@]}"; do
  if grep -qE 'BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|xox[baprs]-|sk-[A-Za-z0-9_-]{20,}' "$f"; then
    fail "$f: contains a credential-like pattern"
    cred=1
  fi
done
[ "$cred" -eq 0 ] && pass "no credential-like patterns"

# 15. Whitespace: no trailing whitespace, every file ends with a newline.
ws=0
for f in "${EXPECTED_FILES[@]}"; do
  if grep -qn '[[:blank:]]+$' "$f"; then
    fail "$f: trailing whitespace"
    ws=1
  fi
  if [ -n "$(tail -c 1 "$f")" ]; then
    fail "$f: missing final newline"
    ws=1
  fi
done
[ "$ws" -eq 0 ] && pass "no trailing whitespace; all files end with a newline"

# 16. Pre-release placeholder and local-file fallback handling.
fallback_ok=1
for pf in "${PROMPT_FILES[@]}"; do
  grep -qF 'included local runbook file' "$pf" || { fail "$pf: missing the local runbook file fallback"; fallback_ok=0; }
done
grep -qF '../runbook/oc-runbook-1-before-you-trust-openclaw.md' tutorial/before-you-trust-openclaw-tutorial.md || { fail "tutorial: missing the local runbook file fallback"; fallback_ok=0; }
[ "$fallback_ok" -eq 1 ] && pass "local runbook file fallback present in every prompt and the tutorial"

pending_prompts=0
for pf in "${PROMPT_FILES[@]}"; do
  if grep -q 'RUNBOOK_RELEASE_URL_PENDING' "$pf"; then
    pending_prompts=$((pending_prompts + 1))
  fi
done
if [ "$pending_prompts" -ne 0 ] && [ "$pending_prompts" -ne 8 ]; then
  fail "inconsistent RUNBOOK_RELEASE_URL_PENDING coverage: $pending_prompts of 8 prompts carry the placeholder"
fi
pending_total=0
for f in "${PROSE_FILES[@]}"; do
  n="$(grep -c 'RUNBOOK_RELEASE_URL_PENDING' "$f" || true)"
  n="${n:-0}"
  pending_total=$((pending_total + n))
done
if [ "$pending_total" -gt 0 ]; then
  note "RUNBOOK_RELEASE_URL_PENDING appears $pending_total times. This is the only expected release blocker. Replace it with the published runbook URL at release time."
else
  note "RUNBOOK_RELEASE_URL_PENDING not found. If this is the release build, confirm the status lines were updated for release."
fi

# Summary.
printf '\n'
if [ "$issues" -eq 0 ]; then
  printf 'OpenClaw Runbook 1 package validation: PASS\n'
  exit 0
else
  printf 'OpenClaw Runbook 1 package validation: FAIL (%s issue(s))\n' "$issues"
  exit 1
fi
