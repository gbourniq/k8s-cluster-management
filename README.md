# Activate conda environment
- conda activate k8s

# Stop cluster:
- make cluster-start

# Create cluster:
- make cluster-stop

# Steps create cluster:
- create master and node amis using packer > save ami ids
- populate ami ids, instance label name (k8s-node), and exact count
- run make instance-create for each instance
- ssh into the manager instance
    - sudo hostnamectl set-hostname k8s-master
    - run the manager_config.sh script and note the join command
- ssh into node instances
    - sudo hostnamectl set-hostname k8s-node-1,2,...z
    - use the join command to join the cluster
- need to configure elastic ips for master instance so it ip stays the same when restarted

# steps to create Amazon Machine Images (Instance templates) for Master and Node instances:
- check variables in package.json
    - give proper name to the "ami_name" key. eg. AWS Ubuntu 18.04 Base Image with Kubernetes - Node Configuration
- run make build-ami
- note the ami id for the relevant instances (master and nodes)

# create ansible encrypted password
ansible-vault encrypt_string --vault-id user@~/.ssh/ansible-vault-pw 'uCCTvzTZZCrmT3nR+2EZPuGqwefqwefqwefweqfweKBEQIXcuLEwefzErCkgf' --name 'aws_secret_key'

# Note:
- For ansible to support instance creation in eu-west-3, need to replace endpoints.json.
- Ex of file locations:
    - /Users/guillaume.bournique/anaconda3/envs/k8s/lib/python3.7/site-packages/boto (ideal - when boto is install in a conda environment)
    - /Users/guillaume.bournique/.local/lib/python3.6/site-packages/boto/endpoints.json
    - /Users/guillaume.bournique/anaconda3/lib/python3.7/site-packages/boto


# Note:
`boto3` must also be installed in the system python, which you can perform as follows:

```bash
$ sudo -H /usr/bin/python -m easy_install pip
...
...
$ sudo -H /usr/bin/python -m pip install boto3 --ignore-installed six
...
...
```
Once you have installed `boto3` in your system python, it is recommended to run the following commands to ensure your Homebrew and system python environments are configured correctly:

```
$ brew unlink python
...
$ brew link --overwrite python
...
```