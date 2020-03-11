#!/usr/bin/env bash
set -e

# MASTER NODE CONFIGURATIONS

# Initialize Kubernetes on the master node
# --ignore flag to bypass the 2 CPUs requirement
# make sure the IP that the pod is being deployed on, matches with subnet.env
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all # need to extract the kubeadm join command from the output

# admin.conf is created from the kubeadm init command
# it contains the client certificate for the admin user of the cluster
# the config file will be used for the current user to be authenticated against the API server when running kubectl
# Gives admin access to the cluster
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# Change directory ownership to ensure only we can have access to that file
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a Pod Network through the master node
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# populate subnet.env file manually
sudo mkdir /run/flannel/
sudo mv ~/subnet.env /run/flannel/subnet.env

# if master is the only instance running in the cluster, run
# kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-