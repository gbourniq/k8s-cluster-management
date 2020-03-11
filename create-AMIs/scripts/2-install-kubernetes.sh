#!/usr/bin/env bash
set -e

# Update apt-get to be able to locate the docker.io package
sudo apt-get update

# Install the Docker utility 
sudo apt install -y docker.io

# Check docker is installed
docker --version

# Enable Docker to start on instance start up
sudo systemctl enable docker

# Run Docker commands without sudo
# Add the docker group if it doesn't already exist
sudo groupadd docker

# Add the connected user $USER to the docker group
sudo gpasswd -a $USER docker

# Restart the docker daemon
sudo service docker restart

# Add the Kubernetes signing key
sudo apt install -y curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

# Add Xenial Kubernetes Repository
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Install Kubeadm
sudo apt install -y kubeadm

# Check version of kubeadm
kubeadm version

# Disable swap memory on both the nodes as Kubernetes does not perform properly on a system that is using swap memory.
sudo swapoff -a

## generate new token and save join command in variable
# cmd=$(kubeadm token create --print-join-command)

