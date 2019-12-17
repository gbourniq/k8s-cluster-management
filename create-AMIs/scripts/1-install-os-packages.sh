#!/usr/bin/env bash
set -e

# Additional operating system packages
packages="git bash-completion"

sudo apt-get update

# echo "### Installing extra packages: $packages ###"
sudo apt-get -y install $packages 