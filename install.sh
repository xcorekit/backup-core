#!/usr/bin/env bash
# sys-core/install.sh
set -euo pipefail
_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_BIN="$_ROOT/cli/bin"
_USER_BIN="${HOME}/bin"
_RC="${HOME}/.bashrc"

printf '\n  sys-core install\n  ────────────────\n\n'
mkdir -p "$_USER_BIN"
chmod +x "$_BIN"/* 2>/dev/null || true

if ! grep -qF "$_BIN" "$_RC" 2>/dev/null; then
    printf '\n# xcorekit/sys-core\nexport PATH="%s:$PATH"\n' "$_BIN" >> "$_RC"
    printf '  +  Added to PATH\n'
else
    printf '  ✓  Already in PATH\n'
fi

for f in "$_BIN"/*; do
    [[ -f "$f" ]] || continue
    ln -sf "$f" "$_USER_BIN/$(basename "$f")"
    printf '  ~  Linked: %s\n' "$(basename "$f")"
done

printf '\n  Done.\n  Run: source ~/.bashrc\n\n'
