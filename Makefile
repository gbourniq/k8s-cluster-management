DEPLOY_DIR=docker-deployment
ANSIBLE_DIR=cluster-deployment
SHELL := /bin/bash

export APP_VERSION:=v1 # overrides default APP_VERSION defined in Makefile.settings
export PROXY_HTTP_PORT:=80
export APP_HTTP_PORT:=4000
export CLIENT_HTTP_PORT:=3000
export MONGO_HTTP_PORT:=27017
export REPO_NAME_BASE:=myfullstackapp
export DOCKER_REGISTRY=docker.io
export ORG_NAME=gbournique
export DOCKER_USER=gbournique


# Common settings
include Makefile.settings

ansible-checksyntax:
	${INFO} "Checking ansible command syntax..."
	@ ansible-playbook -i cluster-deployment/inventory.yml cluster-deployment/site.yml --syntax-check
	${SUCCESS} "Syntax check complete..."

ansible-instance-launch:
	${INFO} "Running ansible playbook to launch a new EC2 instance from custom Ubuntu AMI"
	@ ansible-playbook --vault-id user@~/.ssh/ansible-vault-pw cluster-deployment/site.yml -vv --tags=instance-launch
	${SUCCESS} "Instance creation complete"

ansible-cluster-stop:
	${INFO} "Stop K8S cluster"
	@ ansible-playbook --vault-id user@~/.ssh/ansible-vault-pw cluster-deployment/site.yml -vv --tags=cluster-stop
	${SUCCESS} "All instances stopped successfully"

ansible-cluster-start:
	${INFO} "Start K8S cluster"
	@ ansible-playbook --vault-id user@~/.ssh/ansible-vault-pw cluster-deployment/site.yml -vv --tags=cluster-start
	${SUCCESS} "Cluster started. Master node at ec2-15-188-17-57.eu-west-3.compute.amazonaws.com"