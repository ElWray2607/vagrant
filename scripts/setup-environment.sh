#!/bin/bash

echo "Setting up docker compose environment"
sudo mkdir -p /var/docker
sudo mkdir -p /var/docker/volumes
sudo git clone https://github.com/ElWray2607/Compose.git /var/docker/compose
sudo chown -R vagrant:vagrant /var/docker
sudo chmod -R u+rwX,g+rwX /var/docker

echo "Setting up docker swarm"
docker swarm init --advertise-addr 192.168.1.206
docker network create -d overlay --attachable roomcontrol

sudo ln -s ~/scripts/deploy-service.sh /usr/local/bin/deploy-service

echo "source ~/scripts/deploy-service-autocomplete.sh" >> ~/.bashrc
source ~/.bashrc