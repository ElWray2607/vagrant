#!/bin/bash
set -euo pipefail

echo "Installing Docker..."

for package in docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc; do
  sudo apt-get remove -y "$package" >/dev/null 2>&1 || true
done

sudo apt-get update
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add repository to apt sources
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt-get update
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker vagrant || true

docker --version
docker compose version

echo "Docker installed"
echo "User 'vagrant' was added to the docker group. A logout/reboot may be needed before using docker without sudo."