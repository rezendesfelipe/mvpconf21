[Clique para voltar à lista de Módulos](../../README.md)
# Módulo de AKS
## Inputs
Este módulo aceita as seguintes variáveis: 
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado.
* [Obrigatório] `vnet_resource_group_name`: Nome do Resource Group da VNET em que o AKS será vinculado.
* [Obrigatório] `vnet_name`: Nome da Rede virtual em que o node do AKS será vinculado
* [Obrigatório] `subnet_name`: Nome da subnet onde sera vinculado o app gateway.
* [Obrigatório] `dns_name`: Nome do cluster AKS a ser criado. Importante dizer que como o nome precisa ser único e exclusivo, uma string de 4 caracteres será criada automaticamente.
* [Obrigatório] `app_id`: Qual App Id do Service Principal usado para o AKS
* [Obrigatório] `password`: Secret do Service Principal (Recomendado utilizar tfvars aqui).
* [Opcional] `k8s_version`: Versão do Kubernetes. Padrão está como `1.19.9`. Alterar este campo força a criação de um novo recurso. Para visualizar versões suportadas, [**clique aqui**](https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar)
* [Opcional] `node_vm_disk_size`: Tamanho do disco (GB) dos nós iniciais do AKS. Default está definido como `30` no módulo.
* [Opcional] `node_av_zone`: Zona de disponibilidade onde será implementado o node.
* [Opcional] `enable_autoscaling`: Define se haverá autoscaling dos nodes ou não. Padrão é `false`.
* [Opcional] `default_node_settings` : Define em formato de Mapa os seguintes parâmetros. Aceita as entradas `node_count`, `max_count`, `min_count`. Use `max_count` e `min_count` apenas se `enable_autoscaling` for configurado como `true`. Exemplo de uso:  
```  Go
  node_count = 10 
  max_count = 30
  min_count = 5
```

* [Obrigatório] `aks_network_cidr`: Rede usada pelos pods, internamente no kubernetes. Não pode colidir com o range de IP da Rede Virtual
* [Obrigatório] `aks_dns_ip`: IP do DNS usado pelo AKS (deve estar no mesmo range definida em `aks_network_cidr`) 
* [Obrigatório] `aks_docker_bridge`: Range de IP usado pelo Docker (não pode colidir com o IP de rede da rede virtual, nem com o range definido em `aks_network_cidr`)
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Outputs 
Este módulo produz os seguintes outputs:
* `aks_cluster_name`: nome do cluster AKS.
* `aks_dns_name`: nome dns do cluster AKS.

## Exemplo de uso
Terraform 0.14.x
``` Go
module "aks-search" {
  source                    = "../terraform-cloud/modules/aks"
  resource_group_name       = var.resource_group_name
  vnet_resource_group_name  = data.terraform_remote_state.shared.outputs.rg_name
  vnet_name                 = "vnet-impulse-prd"
  node_subnet               = "subnet-search-aks"
  node_vm_size              = "Standard_E4ds_v4"
  max_pods                  = 60
  enable_autoscaling        = true
  default_node_settings     = {
    node_count  = 3
    max_count   = 5
    min_count   = 1
  }
  dns_name            = "aks-search"
  aks_network_cidr    = "172.16.0.0/16"
  aks_dns_ip          = "172.16.0.10"
  aks_docker_bridge   = "172.17.0.1/16"
  app_id              = var.app_id
  password            = var.password
  depends_on          = [module.vnet]
}
```

## Exemplo de Plan
<details><summary> Clique para ver um exemplo de como o Terraform criará o plano de execução</summary>

``` Go
Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "eastus2"
      + name     = "rg-validation"
      + tags     = {
          + "env"   = "dev"
          + "owner" = "Carlos Oliveira"
        }
    }

  # module.aks-search.data.azurerm_resource_group.aks will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_resource_group" "aks"  {
      ~ id       = "/subscriptions/1e567eea-6125-43f6-a1f0-a04cbff94088/resourceGroups/rg-validation" -> (known after apply)
      ~ location = "eastus2" -> (known after apply)
        name     = "rg-validation"
      ~ tags     = {
          - "env"   = "dev"
          - "owner" = "Carlos Oliveira"
        } -> (known after apply)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.aks-search.data.azurerm_subnet.aks_node will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_subnet" "aks_node"  {
      ~ address_prefix                                 = "10.0.0.0/23" -> (known after apply)
      ~ address_prefixes                               = [
          - "10.0.0.0/23",
        ] -> (known after apply)
      ~ enforce_private_link_endpoint_network_policies = false -> (known after apply)
      ~ enforce_private_link_service_network_policies  = false -> (known after apply)
      ~ id                                             = "/subscriptions/1e567eea-6125-43f6-a1f0-a04cbff94088/resourceGroups/rg-validation/providers/Microsoft.Network/virtualNetworks/vnet-impulse-dev/subnets/sn-search-aks" -> (known after apply)
        name                                           = "sn-search-aks"
      ~ network_security_group_id                      = "/subscriptions/1e567eea-6125-43f6-a1f0-a04cbff94088/resourceGroups/rg-validation/providers/Microsoft.Network/networkSecurityGroups/nsg-testing" -> (known after apply)
      + route_table_id                                 = (known after apply)
      ~ service_endpoints                              = [] -> (known after apply)
        # (2 unchanged attributes hidden)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.aks-search.data.azurerm_virtual_network.aks will be read during apply
  # (config refers to values not yet known)
 <= data "azurerm_virtual_network" "aks"  {
      ~ address_space       = [
          - "10.0.0.0/16",
        ] -> (known after apply)
      ~ dns_servers         = [] -> (known after apply)
      ~ guid                = "11c5a270-ac69-40d7-8f55-5f9d1e504e86" -> (known after apply)
      ~ id                  = "/subscriptions/1e567eea-6125-43f6-a1f0-a04cbff94088/resourceGroups/rg-validation/providers/Microsoft.Network/virtualNetworks/vnet-impulse-dev" -> (known after apply)
      ~ location            = "eastus2" -> (known after apply)
        name                = "vnet-impulse-dev"
      ~ subnets             = [
          - "sn-search-frontend",
          - "sn-search-api",
          - "sn-search-appgw",
          - "sn-search-data",
          - "sn-search-mgmt",
          - "sn-search-backfront",
          - "sn-search-aks",
        ] -> (known after apply)
      ~ vnet_peerings       = {} -> (known after apply)
        # (1 unchanged attribute hidden)

      + timeouts {
          + read = (known after apply)
        }
    }

  # module.aks-search.azurerm_kubernetes_cluster.aks will be created
  + resource "azurerm_kubernetes_cluster" "aks" {
      + dns_prefix              = "aks-search-lwu3"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + kube_admin_config       = (known after apply)
      + kube_admin_config_raw   = (sensitive value)
      + kube_config             = (known after apply)
      + kube_config_raw         = (sensitive value)
      + kubelet_identity        = (known after apply)
      + kubernetes_version      = (known after apply)
      + location                = (known after apply)
      + name                    = "aks-search-lwu3"
      + node_resource_group     = (known after apply)
      + private_cluster_enabled = (known after apply)
      + private_dns_zone_id     = (known after apply)
      + private_fqdn            = (known after apply)
      + private_link_enabled    = (known after apply)
      + resource_group_name     = "rg-validation"
      + sku_tier                = "Free"

      + addon_profile {
          + aci_connector_linux {
              + enabled     = (known after apply)
              + subnet_name = (known after apply)
            }

          + azure_policy {
              + enabled = (known after apply)
            }

          + http_application_routing {
              + enabled                            = (known after apply)
              + http_application_routing_zone_name = (known after apply)
            }

          + kube_dashboard {
              + enabled = (known after apply)
            }

          + oms_agent {
              + enabled                    = (known after apply)
              + log_analytics_workspace_id = (known after apply)
              + oms_agent_identity         = (known after apply)
            }
        }

      + auto_scaler_profile {
          + balance_similar_node_groups      = (known after apply)
          + expander                         = (known after apply)
          + max_graceful_termination_sec     = (known after apply)
          + new_pod_scale_up_delay           = (known after apply)
          + scale_down_delay_after_add       = (known after apply)
          + scale_down_delay_after_delete    = (known after apply)
          + scale_down_delay_after_failure   = (known after apply)
          + scale_down_unneeded              = (known after apply)
          + scale_down_unready               = (known after apply)
          + scale_down_utilization_threshold = (known after apply)
          + scan_interval                    = (known after apply)
          + skip_nodes_with_local_storage    = (known after apply)
          + skip_nodes_with_system_pods      = (known after apply)
        }

      + default_node_pool {
          + availability_zones   = [
              + "1",
              + "2",
              + "3",
            ]
          + enable_auto_scaling  = true
          + max_count            = 5
          + max_pods             = (known after apply)
          + min_count            = 1
          + name                 = "default"
          + node_count           = 3
          + orchestrator_version = (known after apply)
          + os_disk_size_gb      = 30
          + os_disk_type         = "Managed"
          + type                 = "VirtualMachineScaleSets"
          + vm_size              = "Standard_B2s"
          + vnet_subnet_id       = (known after apply)
        }

      + network_profile {
          + dns_service_ip     = "172.16.0.10"
          + docker_bridge_cidr = "172.17.0.1/16"
          + load_balancer_sku  = "standard"
          + network_mode       = (known after apply)
          + network_plugin     = "azure"
          + network_policy     = (known after apply)
          + outbound_type      = "loadBalancer"
          + pod_cidr           = (known after apply)
          + service_cidr       = "172.16.0.0/16"

          + load_balancer_profile {
              + effective_outbound_ips    = (known after apply)
              + idle_timeout_in_minutes   = (known after apply)
              + managed_outbound_ip_count = (known after apply)
              + outbound_ip_address_ids   = (known after apply)
              + outbound_ip_prefix_ids    = (known after apply)
              + outbound_ports_allocated  = (known after apply)
            }
        }

      + role_based_access_control {
          + enabled = true
        }

      + service_principal {
          + client_id     = (sensitive)
          + client_secret = (sensitive value)
        }

      + windows_profile {
          + admin_password = (sensitive value)
          + admin_username = (known after apply)
        }
    }

[...]
Plan: 10 to add, 0 to change, 0 to destroy.
```
</details>