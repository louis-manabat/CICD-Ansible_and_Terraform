#!/bin/bash
set +ex

## Hacky way to build inventory file
echo "all:" > inventory.yml
echo "  hosts:" >> inventory.yml
echo "    "$(cd ../infra && terraform output instance_public_ip) >> inventory.yml

## Database stuff
docdb_endpoint=$(cd ../infra && terraform output docdb_endpoint | tr -d '"')
docdb_username=$(cd ../infra && terraform output docdb_username | tr -d '"')
docdb_password=$(cd ../infra && terraform output docdb_password | tr -d '"')
docdb_port=$(cd ../infra && terraform output docdb_port)

docdb_url="mongodb://$docdb_username:$docdb_password@$docdb_endpoint:$docdb_port/?ssl=true&ssl_ca_certs=rds-combined-ca-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"

rm -f templates/service.tpl

cat > templates/service.tpl << EOL
[Unit]
Description=ToDoApp
Requires=network-online.target
After=network-online.target

[Service]
Environment=DB_URL=$docdb_url
Environment=SESSION_SECRET=secret
WorkingDirectory=
Type=simple
ExecStart=
Restart=on-failure
EOL

## Running ansible-playbook
# ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i scripts/inventory.yml -u ec2-user playbook.yml --private-key ~/keys/ec2-key