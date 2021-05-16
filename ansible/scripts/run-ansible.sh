#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml
echo "    "$(cd ../../infra && terraform output instance_public_ip) >> inventory.yml

## Database stuff
echo "  vars:" >> inventory.yml
echo "    docdb_endpoint="$(cd ../../infra && terraform output docdb_endpoint) >> inventory.yml
echo "    docdb_username="$(cd ../../infra && terraform output docdb_username) >> inventory.yml
echo "    docdb_password="$(cd ../../infra && terraform output docdb_password) >> inventory.yml

## Running ansible-playbook
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml -u ec2-user playbook.yml --private-key ~/keys/ec2-key