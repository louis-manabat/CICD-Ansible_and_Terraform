.PHONY: up down tf-validate bootstrap ssh-gen tf-init pack

up:

down:

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
