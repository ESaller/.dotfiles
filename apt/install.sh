#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_FILE="$SCRIPT_DIR/packages.txt"

if [[ ! -f "$PACKAGES_FILE" ]]; then
  echo "ERROR: $PACKAGES_FILE not found." >&2
  exit 1
fi

echo "Installing packages from $PACKAGES_FILE..."
sudo apt-get update
grep -v '^\s*#' "$PACKAGES_FILE" | grep -v '^\s*$' | xargs sudo apt-get install -y

echo "Done."
