#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > scripts/inventory.yml
echo "  hosts:" >> scripts/inventory.yml
echo "    "$(cd ../infra && terraform output instance_public_ip) >> scripts/inventory.yml

## Running ansible-playbook and parsing docdb variables
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml \
                                                -u ec2-user playbook.yml \
                                                --private-key ~/keys/ec2-key \
                                                -e db_endpoint=$(cd ../infra && terraform output docdb_endpoint | tr -d '"') \
                                                -e db_user=$(cd ../infra && terraform output docdb_username | tr -d '"') \
                                                -e db_password=docdb_password=$(cd ../infra && terraform output docdb_password | tr -d '"') \
                                                -e db_port=$(cd ../infra && terraform output docdb_port)