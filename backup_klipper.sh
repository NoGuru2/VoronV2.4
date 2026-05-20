#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${KLIPPER_CONFIG_DIR:-$HOME/printer_data/config}"

cd "$CONFIG_DIR"

if ! command -v git >/dev/null 2>&1; then
    echo "git is not installed or not on PATH"
    exit 127
fi

if [ ! -d .git ]; then
    echo "$CONFIG_DIR is not a git repository"
    exit 1
fi

git add -A

if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

git commit -m "Backup on $(date '+%Y-%m-%d %H:%M:%S')"
git push origin HEAD
