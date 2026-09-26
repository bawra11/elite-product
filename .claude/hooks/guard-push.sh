#!/bin/bash
# PreToolUse(Bash) guard for the Elite product repo.
#  - blocks any git push from inside tech/codebase/BE (read-only repos)
#  - blocks git push of the product repo until /context-sync has stamped HEAD
input=$(cat)
cmd=$(jq -r '.tool_input.command // ""' <<<"$input")
cwd=$(jq -r '.cwd // ""' <<<"$input")

[[ "$cmd" =~ git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push ]] || exit 0

root=$(cd "$(dirname "$0")/../.." && pwd -P)
dir="$cwd"
if [[ "$cmd" =~ git[[:space:]]+-C[[:space:]]+([^[:space:]]+) ]]; then
  c="${BASH_REMATCH[1]}"; [[ "$c" = /* ]] && dir="$c" || dir="$cwd/$c"
fi
dir=$(cd "$dir" 2>/dev/null && pwd -P) || exit 0

case "$dir/" in
  "$root/tech/codebase/BE/"*)
    echo "Blocked: tech/codebase/BE repos are read-only from Elite. Pull only, never push." >&2
    exit 2 ;;
esac

top=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null) || exit 0
[[ "$(cd "$top" && pwd -P)" == "$root" ]] || exit 0

stamp="$root/.claude/.context-synced"
if [[ "$(cat "$stamp" 2>/dev/null)" != "$(git -C "$root" rev-parse HEAD)" ]]; then
  echo "Blocked: run /context-sync before pushing the Elite product repo. It refreshes the project context docs, commits, and stamps HEAD." >&2
  exit 2
fi
exit 0
