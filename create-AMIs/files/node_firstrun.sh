#!/usr/bin/env bash
set -e

# populate subnet.env file manually
sudo mkdir /run/flannel/
sudo mv ~/subnet.env /run/flannel/subnet.env