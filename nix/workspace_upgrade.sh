#!/usr/bin/env bash
set -euo pipefail

# Configuration: adjust these as needed
FLAKE_DIR="$HOME/.dotfiles/nix/nix-workspace"
PROFILE_ENTRY="nix/nix-workspace"

error_exit() {
  echo "ERROR: $1" >&2
  exit 1
}

echo "Updating flake in $FLAKE_DIR..."
if [[ ! -d "$FLAKE_DIR" ]]; then
  error_exit "Flake directory $FLAKE_DIR not found."
fi

pushd "$FLAKE_DIR" > /dev/null
if ! nix flake update; then
  error_exit "nix flake update failed."
fi
popd > /dev/null

echo "Upgrading Nix profile entry: $PROFILE_ENTRY..."
if ! nix profile list | grep -q "$PROFILE_ENTRY"; then
  error_exit "Profile entry $PROFILE_ENTRY not found."
fi

if ! nix profile upgrade "$PROFILE_ENTRY"; then
  error_exit "nix profile upgrade $PROFILE_ENTRY failed."
fi

echo "Running nix store optimise and nix store gc..."
if ! nix store optimise; then
  error_exit "nix store optimise failed."
fi

if ! nix store gc; then
  error_exit "nix store gc failed."
fi

echo "Done."
