all: cleanup prepare-readme

.PHONY: cleanup

cleanup: 
	rm ./README.md

prepare-readme: 
	echo "Preparando nova documentação"
	terraform-docs -c .terraform-docs.yml . > README.md

all-steps: create-steps modify-steps destroy

create-steps: plan-vnet01 apply-vnet01

modify-steps: plan-vnet02

plan-vnet01:
	@echo "Criando Plano de execução da VNET original"
	@terraform plan -var-file="vnet-01.tfvars" -out ./vnet01.tfplan

apply-vnet01:
	@echo "Preparando VNET original"
	@terraform apply -auto-approve ./vnet01.tfplan

plan-vnet02:
	@echo "Criando plano de Execução da VNET a ser modificada"
	@terraform plan -var-file="vnet-02.tfvars" -out ./vnet02.tfplan

destroy:
	@echo "Destroying demo environment"
	@terraform plan -destroy -out destroy.tfplan -var-file=vnet-01.tfvars
	@terraform apply -destroy destroy.tfplan