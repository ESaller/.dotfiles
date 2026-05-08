#!/usr/bin/env bash
set -euo pipefail

echo "Updating Homebrew..."
brew update

echo "Upgrading packages..."
brew upgrade

echo "Cleaning up..."
brew cleanup

echo "Done."
