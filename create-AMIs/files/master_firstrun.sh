#!/usr/bin/env bash
set -e

# MASTER NODE CONFIGURATIONS

# Initialize Kubernetes on the master node
# --ignore flag to bypass the 2 CPUs requirement
sudo kubeadm init --ignore-preflight-errors=cpu # need to extract the kubeadm join command from the output
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a Pod Network through the master node
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# populate subnet.env file manually
sudo mkdir /run/flannel/
sudo mv ~/subnet.env /run/flannel/subnet.env