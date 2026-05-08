#!/usr/bin/env bash
set -euo pipefail

echo "Updating package lists..."
sudo apt-get update

echo "Upgrading packages..."
sudo apt-get upgrade -y

echo "Removing unused packages..."
sudo apt-get autoremove -y

echo "Done."
