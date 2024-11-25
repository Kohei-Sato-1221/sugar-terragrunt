DEV_DIR=environments/develop
DEV_PROFILE=e-playground-kohei

help: ## print this message
	@echo ""
	@echo "Command list:"
	@printf "\033[36m%-35s\033[0m %s\n" "[Sub command]" "[Description]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-35s\033[0m %s\n", $$3 ? $$3 : $$1, $$2}'
	@echo ''

apply: prepare ## execute terragrunt apply ## apply e={environment} m=[module]
ifeq "$(e)" "dev"
	$(eval PROFILE := ${DEV_PROFILE})
	$(eval WORK_DIR := ${DEV_DIR})
else ifeq "$(e)" "stg"
	$(eval PROFILE := ${STG_PROFILE})
	$(eval WORK_DIR := ${STG_DIR})
	$(eval USE_AWS_VAULT := true)
else ifeq "$(e)" "prod"
	$(eval PROFILE:= ${PROD_PROFILE})
	$(eval WORK_DIR := ${PROD_DIR})
else
	$(eval PROFILE := ${DEV_PROFILE})
	$(eval WORK_DIR := ${DEV_DIR})
endif
ifeq "$(m)" ""
	cd $(WORK_DIR) && AWS_PROFILE=$(PROFILE) terragrunt run-all apply
else
	cd $(WORK_DIR)/$(m) && AWS_PROFILE=$(PROFILE) terragrunt apply
endif

prepare:
	make fmt
	make tfenv
	make tgenv

fmt: ## execute terraform fmt
	terraform fmt -recursive
	terragrunt hclfmt

tfenv: ## change terraform version to use 1.9.8 ## tfenv
	tfenv use 1.9.8

tgenv: ## change terragrunt version to use 0.69.1 ## tfenv
	tgenv use 0.69.1


sso: ## login to aws via aws sso ## sso
	@echo "=== input as follows ==="
	@echo "SSO session name:e-playground-kohei"
	@echo "SSO URL:https://d-956742f338.awsapps.com/start"
	@echo "SSO region:ap-northeast-1"
	@echo "========================"
	@echo ""
	aws configure sso