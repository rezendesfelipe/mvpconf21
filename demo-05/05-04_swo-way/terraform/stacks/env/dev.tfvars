#----------------------
# Global Vars
#----------------------
resource_group_name = "RGmvpconf2021ILE"
location            = "brazilsouth"
tags = {
  Department  = "Luis Pecht"
  Environment = "Dev"
  Project     = "x"
}

#----------------------
# RBAC Vars
#----------------------
developers_group_name = "BRBB ADM Azure x AKS"
developers_group_role = "Contributor"
_group_name        = "BRBB ADM Azure x Analytics"
_group_role        = "Contributor"

#----------------------
# AKS Vars
#----------------------
aks_dns_name = "AKSmvpconf2021ILE"

aks_is_identity_enabled            = true
aks_private_cluster                = false
aks_enable_attach_acr              = true
aks_enable_log_analytics_workspace = true
aks_log_analytics_workspace_name   = "BRAKSmvpconf2021ILE"
aks_enable_azure_active_directory  = true
aks_rbac_aad_managed               = true
aks_rbac_aad_admin_group_object_ids = [
  "7a86f21e-5226-4639-9d15-30fc31909986", # Grupo BRBB ADM Azure x Analytics
  "57f52e27-373a-4272-92e1-bac313f88856"  # BRBB ADM Azure x AKS
]
default_aks_network_cidr  = "11.0.0.0/22"
default_aks_dns_ip        = "11.0.0.10"
default_aks_docker_bridge = "172.17.0.1/22"
aks_k8s_version           = "1.20.7"
aks_node_subnet           = "aks-snet"
aks_node_vm_size          = "Standard_D8_v3"
aks_node_vm_disk_size     = 200
aks_max_pods              = 50
aks_node_name             = "default"
aks_enable_autoscaling    = true
aks_default_node_settings = {
  node_count = 1
  min_count  = 1
  max_count  = 3
}
aks_additional_node_pools = {
  mvpconf_node_pool_1 = {
    additional_node_name           = "mvpconfnp1"
    node_os                        = "Linux"
    vm_size                        = "Standard_D8_v3"
    os_disk_size                   = 200
    max_pods                       = 50
    zones                          = ["1", "2", "3"]
    cluster_auto_scaling           = true
    cluster_auto_scaling_min_count = 3
    cluster_auto_scaling_max_count = 10
    enable_public_ip               = false
    node_count                     = 3
  }
}

#--------------------
# Vnet Vars
#--------------------
vnet_name          = "brvnetmvpconf2021ile"
vnet_address_space = ["10.0.80.0/20"]
subnets = {
  aks-snet = {
    address_prefix = "10.0.80.0/22"
  }
}
vnet_peering_settings = {
  aks-dev-to-valhalla = {
    remote_vnet_id = "/subscriptions/3475a6da-a966-466b-9705-e44217adcd9c/resourceGroups/RGVPNS2S/providers/Microsoft.Network/virtualNetworks/VNET_VALHALLA_CLOUD"
  }
}

#--------------------
# ACR Vars
#--------------------
acr_name         = "BRACRmvpconf2021ILE"
acr_enable_admin = true
