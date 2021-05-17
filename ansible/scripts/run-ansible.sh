#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml
echo "    "$(cd ../infra && terraform output instance_public_ip) >> inventory.yml

## Running ansible-playbook and parsing docdb variables
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml -u ec2-user playbook.yml --private-key ~/keys/ec2-key -e db_endpoint=$(cd ../infra && terraform output docdb_endpoint | tr -d '"') db_user=$(cd ../infra && terraform output docdb_username | tr -d '"') db_password=docdb_password=$(cd ../infra && terraform output docdb_password | tr -d '"') db_port=$(cd ../infra && terraform output docdb_port)