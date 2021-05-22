.PHONY: up down tf-validate bootstrap ssh-gen tf-init pack install-ansible

install-deps:
	sudo apt install vim curl wget dos2unix -y

install-nodejs:
	cd /tmp && \
	curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
	sudo apt-get install nodejs -y && \

install-tf:
	cd /tmp && \
	wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip && \
	unzip terraform_0.15.4_linux_amd64.zip && \
	sudo mv terraform /usr/local/bin

install-ansible:
	cd /tmp && \
	sudo apt install software-properties-common -y && \
	sudo add-apt-repository --yes --update ppa:ansible/ansible && \
	sudo apt install ansible -y && \

up:
	cd infra && terraform apply --auto-approve
	cd ansible && dos2unix ./scripts/run-ansible.sh && ./scripts/run-ansible.sh

down:
	cd infra && terraform destroy --auto-approve
	cd bootstrap && terraform destroy --auto-approve

tf-plan:
	cd infra && terraform plan

tf-validate:
	cd infra && terraform validate
	cd infra && terraform fmt

bootstrap:
	cd bootstrap && terraform init
	cd bootstrap && terraform apply --auto-approve

ssh-gen:
	mkdir -p ~/keys
	yes | ssh-keygen -t rsa -b 4096 -f ~/keys/ec2-key -P ''
	chmod 0644 ~/keys/ec2-key.pub
	chmod 0600 ~/keys/ec2-key

tf-init:
	cd infra && terraform init

pack:
	cd src && npm pack
	if [ -d "ansible/files/" ];	\
	then mv src/simpletodoapp-1.0.1.tgz ansible/files/simpletodoapp-1.0.1.tgz;\
	else \
	mkdir ansible/files/ && \
	mv src/simpletodoapp-1.0.1.tgz ansible/files/simpletodoapp-1.0.1.tgz; \
	fi
