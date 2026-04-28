#!/bin/bash
set -euo pipefail

echo "Installing Git and Git Credential Manager..."

sudo apt-get update
sudo apt-get install -y \
  git \
  curl \
  ca-certificates \
  gpg \
  pass

echo
echo "Git installed:"
git --version

/home/vagrant/scripts/setup-environment.sh