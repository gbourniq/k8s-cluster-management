#!/usr/bin/env bash
set -e

# MASTER NODE CONFIGURATIONS

# Initialize Kubernetes on the master node
sudo kubeadm init # need to extract the kubeadm join command from the output
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a Pod Network through the master node
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


# Join any number of minion nodes by running the following on each node:
# sudo kubeadm join 172.31.44.16:6443 --token avg3je.gyxegquhr5qtxmyq \
#     --discovery-token-ca-cert-hash sha256:df45bd626455599695eadb8d4712a5da72a23e8d6b88f0c34e9ecd8975af3b54
# Tokens are given from the output of the sudo kubeadm init command

# Check that pod are ready now
# sudo kubectl get nodes