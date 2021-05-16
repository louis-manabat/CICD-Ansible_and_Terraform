#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml
echo "    "$(cd ../infra && terraform output instance_public_ip) >> inventory.yml

## Database stuff
# echo "  vars:" >> inventory.yml
# echo "    docdb_endpoint="$(cd ../../infra && terraform output docdb_endpoint) >> inventory.yml
# echo "    docdb_username="$(cd ../../infra && terraform output docdb_username) >> inventory.yml
# echo "    docdb_password="$(cd ../../infra && terraform output docdb_password) >> inventory.yml

rm -f templates/service.tpl

cat > templates/service.tpl << EOL
[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment=DB_URL="password" "assignment2-app.cluster..." "5432" from terraform output tute 5
Environment=SESSION_SECRET=secret
WorkingDirectory=
Type=simple
ExecStart=
Restart=on-failure
EOL

## Running ansible-playbook
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml -u ec2-user playbook.yml --private-key ~/keys/ec2-key