#!/bin/bash
set -euo pipefail

SSH_USER="vagrant"
SSH_PASSWORD="vagrant"

echo "Setting password for user '${SSH_USER}'..."
echo "${SSH_USER}:${SSH_PASSWORD}" | sudo chpasswd

echo "Enabling SSH password authentication..."

sudo mkdir -p /etc/ssh/sshd_config.d

sudo tee /etc/ssh/sshd_config.d/99-password-login.conf > /dev/null <<EOF
PasswordAuthentication yes
PubkeyAuthentication yes
PermitRootLogin no
UsePAM yes
EOF

if sudo sshd -t; then
  echo "SSH config is valid."
else
  echo "SSH config is invalid."
  exit 1
fi

sudo systemctl restart ssh || sudo systemctl restart sshd

echo "SSH password login enabled."
echo
echo "Password:"
echo "  ${SSH_PASSWORD}"