#!/usr/bin/env bash
set -e

echo "### Setting up git aliases ###"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

echo "### Installing Docker completion for Linux ###"
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

echo "### Editing ~/.inputrc for improved tab completion ###"
cat > ~/.inputrc << EOF
# mappings to have up and down arrow searching through history:
"\e[A": history-search-backward
"\e[B": history-search-forward

set colored-stats on
set show-all-if-ambiguous on
set show-all-if-unmodified on
set menu-complete-display-prefix on
set completion-ignore-case on

"\t": menu-complete
"\e[Z": menu-complete-backward
EOF

echo "### Delete old ~/.bashrc ###"
sudo rm ~/.bashrc
# sudo rm /home/{{user `ssh_username`}}/.bashrc

echo "### Rename ~/.bashrc2 to ~/.bashrc ###"
# echo 'PWD $(pwd) LS $(ls -l)'
sudo mv ~/.bashrc2 ~/.bashrc
