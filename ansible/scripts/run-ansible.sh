#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml
echo "    "$(cd ../../infra && terraform output instance_public_ip) >> inventory.yml

## Database stuff


## Running ansible-playbook
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml -u ec2-user playbook.yml --private-key ~/keys/ec2-key