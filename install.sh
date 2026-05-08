#!/usr/bin/env bash
# backup-core/install.sh
set -euo pipefail
_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_BIN="$_ROOT/cli/bin"
_USER_BIN="${HOME}/bin"
_RC="${HOME}/.bashrc"
_CONF_DIR="${HOME}/.config/sconl"

printf '\n  backup-core install\n  ───────────────────\n\n'
mkdir -p "$_USER_BIN" "$_CONF_DIR"
chmod +x "$_BIN"/*

# PATH guard
if ! grep -qF "$_BIN" "$_RC" 2>/dev/null; then
    printf '\n# xcorekit/backup-core\nexport PATH="%s:$PATH"\n' "$_BIN" >> "$_RC"
    printf '  +  Added to PATH\n'
else
    printf '  ✓  Already in PATH\n'
fi

# Symlinks
for f in "$_BIN"/*; do
    ln -sf "$f" "$_USER_BIN/$(basename "$f")"
    printf '  ~  Linked: %s\n' "$(basename "$f")"
done

# Personal config — copy example if not present
if [[ ! -f "$_CONF_DIR/backups.conf" ]]; then
    cp "$_ROOT/config/backups.conf.example" "$_CONF_DIR/backups.conf"
    printf '  +  Created: ~/.config/sconl/backups.conf (edit to add your jobs)\n'
else
    printf '  ✓  ~/.config/sconl/backups.conf already exists\n'
fi

printf '\n  Done.\n  Run: source ~/.bashrc\n  Then: backupx --list\n\n'
