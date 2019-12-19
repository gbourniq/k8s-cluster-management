#!/usr/bin/env bash
set -e


echo "### Delete old ~/.bashrc ###"
sudo rm ~/.bashrc
# sudo rm /home/{{user `ssh_username`}}/.bashrc

echo "### Rename ~/.bashrc2 to ~/.bashrc ###"
# echo 'PWD $(pwd) LS $(ls -l)'
sudo mv ~/.bashrc2 ~/.bashrc

sudo mkdir /run/flannel/
sudo cp ~/subnet.env /run/flannel/subnet.env