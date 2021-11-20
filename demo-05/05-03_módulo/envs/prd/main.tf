resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
# Coletar recursos compartilhados do ambiente compartilhado
data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-mvpconf21-prd-tf"
    storage_account_name = "sargmvpconf21prdtf"
    container_name       = "terraform-state"
    key                  = "mvpconf21/shared/terraform.tfstate"
    subscription_id      = "50d52bc3-6efa-4846-ab98-20f218cf2ae4"
  }
}

module "redis" {
  source              = "../modules/redis-cache"
  name                = "redis-mvpconf21-prd"
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
  storage_account_name = "stgmvpconf21prd"
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "stgaccfuncmvpconf21" {
  source               = "../modules/storage-account"
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "stgfuncmvpconf21appprd"
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "azfunc" {
  source              = "../modules/functions"
  resource_group_name = azurerm_resource_group.rg.name
  vertical            = "mvpconf21"
  produto             = "mvpconf21"
  ambiente            = "prd"
  func_plan_sku_tier  = "Dynamic"
  func_plan_sku_size  = "Y1"
  func_apps = {
    "mvpconf21-details-prd" = {
      "storage_name"               = module.stgaccfuncmvpconf21.storage_account_name
      "storage_primary_access_key" = module.stgaccfuncmvpconf21.storage_access_key
    }
  }
  depends_on = [
    azurerm_resource_group.rg,
    module.stgaccfuncmvpconf21
  ]
}

