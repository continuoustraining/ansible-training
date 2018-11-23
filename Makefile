default:help;

GREEN = \033[0;32m
YELLOW = \x1b[33m
NC = \033[0m

profile?=saml
env?=recette-po
nodeVersion=8.10.0
proxyVersion?=$(shell ./bin/latest-release adspace-booking-http-proxy)
proxyAmiId?=$(shell ./bin/proxy-ami.sh $(proxyVersion) $(profile))
baseDomain?=francetvpub.fr
prId?=$(CPHP_PR_ID)

# set packager tool
packager := apt_get
ifeq ($(shell uname -s),Darwin)
		packager := brew
endif

## Display this help dialog
help:
	@echo "${YELLOW}Usage:${NC}\n  make [command]:\n\n${YELLOW}Available commands:${NC}"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${GREEN}%-30s${NC} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Install required tools
install:
	$(packager) install pyenv
	pyenv install -f 3.7.1
	pyenv global 3.7.1
	pip install awscli --upgrade --user
	$(packager) install ansible
	$(packager) install terraform
	
## Apply Terraform infrastructure
infra-apply:
	cd terraform && \
	AWS_PROFILE=$(profile) terraform apply -auto-approve --var-file=$(env).tfvars -var proxy_image_id=$(proxyAmiId) \
	-var certificate_arn=$(certificateArn) -var base_domain=$(baseDomain) -var pr_id=$(prId)

## Output Terraform infrastructure
infra-output: tf-init
	cd terraform && \
	AWS_PROFILE=$(profile) terraform output

## Destroy Terraform infrastructure
infra-destroy: tf-init
	cd terraform && \
	TF_WARN_OUTPUT_ERRORS=1 AWS_PROFILE=$(profile) terraform destroy --var-file=$(env).tfvars -var proxy_image_id=$(proxyAmiId) \
    -var certificate_arn=$(certificateArn) -var base_domain=$(baseDomain) -var pr_id=$(prId)

## configure hosts
ansible:
	ansible-playbook $(env).yml 