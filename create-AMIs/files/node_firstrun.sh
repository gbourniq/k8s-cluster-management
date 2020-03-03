#!/usr/bin/env bash
set -e

# populate subnet.env file manually
sudo mkdir /run/flannel/
sudo mv ~/subnet.env /run/flannel/subnet.env

# if need to get join command, use the following on master node
# kubeadm token create --print-join-command