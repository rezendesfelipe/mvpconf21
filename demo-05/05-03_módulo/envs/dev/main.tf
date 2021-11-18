resource "azurerm_resource_group" "rg" {
  name     = "rg-mvpconf21-dev"
  location = "eastus2"
  tags     = {}
}

module "redis" {
  source              = "../modules/redis-cache"
  name                = "redis-mvpconf21-dev"
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = 1
  sku_name            = "Premium"
  enable_non_ssl_port = true
  shard_count         = 1
  minimum_tls_version = "1.0"
  subnet_id           = data.terraform_remote_state.shared.outputs.vnet_subnet_ids[33]
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "stgacc" {
  source               = "../modules/storage-account"
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "stgmvpconf21dev"
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "stgaccfuncmvpconf21" {
  source               = "../modules/storage-account"
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "stgfuncmvpconf21appdev"
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "azfunc" {
  source              = "../modules/functions"
  resource_group_name = azurerm_resource_group.rg.name
  vertical            = "mvpconf21"
  produto             = "mvpconf21"
  ambiente            = "dev"
  func_plan_sku_tier  = "Dynamic"
  func_plan_sku_size  = "Y1"
  func_apps = {
    "mvpconf21-details" = {
      "storage_name"               = module.stgaccfuncmvpconf21.storage_account_name
      "storage_primary_access_key" = module.stgaccfuncmvpconf21.storage_access_key
    }
  }
  depends_on = [
    azurerm_resource_group.rg,
    module.stgaccfuncmvpconf21
  ]
}

# Coletar recursos compartilhados do ambiente compartilhado

data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-mvpconf21-dev-tf"
    storage_account_name = "sargmvpconf21devtf"
    container_name       = "terraform-state"
    key                  = "mvpconf21/shared/terraform.tfstate"
    subscription_id      = "05853494-3f9a-49ed-922f-d00105861b22"
  }
}

locals {
  vm_size = {
    mvpconf    = "Standard_E4s_v3"
    mvpconf_tf_routine = "Standard_E4ds_v4"
    ansible      = "Standard_B1ms"
    prometheus   = "Standard_D8s_v3"
  }
}

#--------------------------
# mvpconf Cluster 0
#--------------------------

module "mvpconf-cluster-0" {
  count               = 3 # Qtde de VMs no cluster
  source              = "../modules/vm-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  public_key          = var.public_key
  tags = {
    role        = "mvpconf-cluster"
    team        = "mvpconf21"
    suite       = "mvpconf21"
    product     = "mvpconf21"
    env         = "dev"
    provisioner = "terraform"
  }
  sn_id         = data.terraform_remote_state.shared.outputs.vnet_subnet_ids[4]  # subnet-mvpconf21-mvpconf
  vm_name       = join("", ["mvpconf21-cluster0-mvpconf-1", count.index]) # nome da VM no formato desejado
  vm_size       = local.vm_size.mvpconf
  img_publisher = "Canonical"
  img_offer     = "UbuntuServer"
  img_sku       = "14.04.5-LTS"
  data_disks = [
    {
      storage_account_type = "Premium_LRS"
      disk_size_gb         = "512"
      disk_caching         = "ReadOnly"
    }
  ]
  depends_on = [
    data.terraform_remote_state.shared,
    azurerm_resource_group.rg
  ]
}

module "mvpconf_tf-routine-0" {
  count               = 1 # Qtde de VMs no cluster
  source              = "../modules/vm-linux"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  public_key          = var.public_key
  tags = {
    role        = "mvpconf-cluster"
    team        = "mvpconf21"
    suite       = "mvpconf21"
    product     = "mvpconf21"
    env         = "dev"
    provisioner = "terraform"
  }
  sn_id         = data.terraform_remote_state.shared.outputs.vnet_subnet_ids[4]      # subnet-mvpconf21-mvpconf-1
  vm_name       = join("-", ["mvpconf21-cluster0-routine", count.index]) # nome da VM no formato desejado
  vm_size       = local.vm_size.mvpconf_tf_routine
  img_publisher = "Canonical"
  img_offer     = "UbuntuServer"
  img_sku       = "14.04.5-LTS"
  data_disks = [
    {
      storage_account_type = "Premium_LRS"
      disk_size_gb         = "512"
      disk_caching         = "ReadOnly"
    }
  ]
  depends_on = [
    data.terraform_remote_state.shared,
    azurerm_resource_group.rg
  ]
}

