#----------------------
# Makefile Commands
#----------------------

all: prepare-documentation prepare-tfvars tf-init validate-code create-environment

validate-code: tf-validate tf-format

create-environment: tf-init tf-plan tf-apply

prepare-readme: cleanup-docs prepare-documentation

#----------------------
# Terraform Steps
#----------------------

terra-tests:
	terraform init && terraform validate && terraform plan -out main.tfplan && checkov -f create-remote-storage.tf

tf-init: 
	@cd ./stacks/mvpconf21/ ; terraform init -reconfigure -backend-config="container_name=$$TF_BACKEND_CONTAINER" -backend-config="storage_account_name=$$TF_BACKEND_STORAGE_ACCOUNT" -backend-config="key=$$TF_BACKEND_KEY" -backend-config="access_key=$$TF_ACCESS_KEY"

tf-format:
	@echo "#---------------------------"
	@echo "📝 Validating Code..."
	@echo "#---------------------------"
	@echo ""
	@cd ./stacks/mvpconf21 ; terraform fmt -check
	@cd ../../
	@echo "...Done 🏁"
	@echo ""

tf-validate:
	@echo "#---------------------------"
	@echo "🖥 Validating Syntax..."
	@echo "#---------------------------"
	@echo ""
	@cd ./stacks/mvpconf21 ; terraform validate
	@cd ../../
	@echo "...Done 🏁"
	@echo ""

tf-plan: 
	@echo "#---------------------------"
	@echo "Creating Execution Plan..."
	@echo "#---------------------------"
	@echo ""
	@cd "./stacks/mvpconf21" ; terraform plan -var-file="../env/${ENV}.tfvars"
	@cd ../../; echo ""
	@echo "...Done 🏁"

tf-apply:
	@echo "#---------------------------"
	@echo "Applying Execution Plan..."
	@echo "#---------------------------"
	@echo ""
	@cd "./stacks/mvpconf21" ; terraform apply -auto-approve -var-file=../env/${ENV}.tfvars
	@cd ../../
	@echo "...Done 🏁"

#----------------------
# Documentation Steps
#----------------------
.PHONY: cleanup-docs

cleanup-docs: 
	@rm ./README.md

prepare-documentation: 
	@echo "Preparing all Environment Documentation..."
	@terraform-docs -c .terraform-docs.yml ./stacks/mvpconf21 > README.md
	@echo "...Done 🏁"

prepare-tfvars:
	@echo "Preparando arquivo de Tfvars..."
	@terraform-docs -c ./docs/.terraform-docs.yml . > terraform.tfvars
	@echo "...Done 🏁"

#--------------------------------------
# Landing Zone Terraform Creation Steps
#--------------------------------------

complete-steps: 

#Faça um login utilizando o device code:
az-login:
	az login --use-device-code

#Crie uma service principal:
create-sp:
	az ad sp create-for-rbac --name $$SERVICE_PRINCIPAL_NAME

# Crie um resource group:
create-rg:
	az group create -l $$TF_BACKEND_LOCATION -n $$TF_BACKEND_RESOURCE_GROUP

# crie um storage account:
create-st:
	az storage account create --resource-group $$TF_BACKEND_RESOURCE_GROUP --name $$TF_BACKEND_STORAGE_ACCOUNT --sku Standard_LRS --encryption-services blob

# crie um container blob:
create-container:	
	az storage container create --name $$TF_BACKEND_CONTAINER --account-name $$TF_BACKEND_STORAGE_ACCOUNT

# Crie uma key vault:
create-kv:
	az keyvault create --name $$KEY_VAULT_NAME --resource-group $$TF_BACKEND_RESOURCE_GROUP --location $$TF_BACKEND_LOCATION

# Garanta o acesso ao key vault:
acesso-kv:
	az keyvault set-policy --name $$KEY_VAULT_NAME --object-id $$ARM_CLIENT_ID --secret-permissions get list --key-permissions get list --certificate-permissions get list

#create secrets key for all env vars:
create-access-all-vars:
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "TF-BACKEND-STORAGE-ACCOUNT" --value $$TF_BACKEND_STORAGE_ACCOUNT
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "TF-BACKEND-KEY" --value $$TF_BACKEND_KEY
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "ARM-TENANT-ID" --value $$ARM_TENANT_ID
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "ARM-CLIENT-ID" --value $$ARM_CLIENT_ID
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "ARM-CLIENT-SECRET" --value $$ARM_CLIENT_SECRET
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "SERVICE-PRINCIPAL-NAME" --value $$SERVICE_PRINCIPAL_NAME
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "ARM-SUBSCRIPTION-ID" --value $$ARM_SUBSCRIPTION_ID
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "TF-BACKEND-RESOURCE-GROUP" --value $$TF_BACKEND_RESOURCE_GROUP
	az keyvault secret set --vault-name $$KEY_VAULT_NAME --name "TF-BACKEND-CONTAINER" --value $$TF_BACKEND_CONTAINER

#terraform init config:
terraform-init:
	terraform init -reconfigure \
	-backend-config "resource_group_name=$$TF_BACKEND_RESOURCE_GROUP" \
	-backend-config "storage_account_name=$$TF_BACKEND_STORAGE_ACCOUNT" \
    -backend-config "container_name=$$TF_BACKEND_CONTAINER" \
    -backend-config "key=$$TF_BACKEND_KEY" \
    -backend-config "subscription_id=$$ARM_SUBSCRIPTION_ID" \
	-backend-config "access_key=$$ACCESS_KEY"
