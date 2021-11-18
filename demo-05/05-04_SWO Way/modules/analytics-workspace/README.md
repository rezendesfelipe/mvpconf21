# Módulo de Azure analytics-workspace
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `location`: Localidade onde a Workspace será criada.
* [Opcional] `retention_agent`: Periodo de retention dos logs.
* [Obrigatório] `workspace_name`: Nome da workspace analytics.
* [Opcional] `skue_agent`: Determina a SKU do workspace, default PerGB2018.


## Casos de uso

### Exemplo de utilização da Feature Extensions Analytics
Terraform 0.14.x
``` Go
module "analytics" {
  source = "../terraform-cloud/modules/analytics-workspace"
  
  workspace_name          = "worksana"
  location            = azurerm_resource_group.rg.location
  resource_group_name = "tf-rafa-testes-az"
  sku_agent           =  "PerGB2018"
  retention_agent     = 30
}
```

### Exemplo de utilização da Feature Extensions Analytics na VM linux
Terraform 0.14.x
``` Go
module "vm" {
  #count               = 1 # Qtde de VMs no cluster
  source              = "../terraform-cloud/modules/vm-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDREE9sVnJdt5fyCG7SMtgw91Q5FUzuAWhyPXO+zTlgFf4NhnB9yvzwXFiGsVSxBPzw1NInqcpt4sPnv9j/PavvsaDPNhxmNpJEbjyB1+MoKUVmcDF4m2LkCU50OWH3QiWl8hrdvwMAj7mupheJ/w300J7GCp7mZRTkVUCSSN6G+WplfcngkD7WvOY6HW8DlyD+b48PWg9fUIfx1vd5LAUwAPrgkdcL4msDbuYHASN7Q+VoCNrRTHZ5dBCGAuBXJ9/Ki/Tvke+MlsdAQMR8C/Jm6ATOnsdyt2lLUNiCoZsZGzxBq2pe63K0HpNJCFsRpwwAf0Gn15YbxIocsGeIkzkiah2QTewmaTc6RnDYwo8PQWe/geRFII/WcY8rSLEN/J3FGBJYUqGYN4CmvLNoLavgTainyPr6oWs2ANlaviBo1v0rOsEfgoXrSDg6Cux/xg8TBuaX/YCzkvYkPtyypEhMvJCKKl/K+5vvqC9BQxQ3cquH0HsY8FNcYx21+VZm6p9i5PuACPwMo68Mxxgy214i0iQHTcbdeU2Zi2JXV0TzDgTokL62mWYWNqEfrvF7onyTUICOZ+XI1TXtVzpRUOqzvHyk4WGUiKpb9nrTOGHB9pFLoE++kKKXZv2fwVC5ZrOP6lOQCsKxKdmnO21OnHyA/QpbwBARF3OcoaWUeP4kQ== azureuser"
  tags = {
    role        = "backfront-cluster"
    team        = "search"
    suite       = "impulse"
    product     = "search"
    env         = "dev"
    provisioner = "terraform"
  }
  sn_id                = module.vnet.vnet_subnet_ids[1]
  is_public_ip_enabled = true
  vm_name              = "newvm" # nome da VM no formato desejado
  vm_size              = "Standard_D2s_v3"
  img_publisher        = "Canonical"
  img_offer            = "UbuntuServer"
  img_sku              = "14.04.5-LTS"
  data_disks = [
    {
      storage_account_type = "Premium_LRS"
      disk_size_gb         = "100"
      disk_caching         = "ReadOnly"
    },
    {
      storage_account_type = "Premium_LRS"
      disk_size_gb         = "100"
      disk_caching         = "ReadOnly"
    }
  ]

  is_log_analytics_enabled = true
  extension_log_name      = "log-names-workspace"
  workspaceId             = module.analytics.workspace_id 
  workspaceKey            = module.analytics.primary_shared_key 
}

```