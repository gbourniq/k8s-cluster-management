#!/bin/bash

# Download HELM version
wget https://get.helm.sh/helm-v3.1.0-linux-amd64.tar.gz

# Unpack it
tar -zxvf helm-v3.1.0-linux-amd64.tar.gz

# Move helm binary to its desired destination
mv linux-amd64/helm /usr/local/bin/helm

# check version
helm version