# Módulo de Front-Door
## Variáveis válidas
Este módulo aceita as seguintes variáveis
* [Obrigatório] `name`: Specifies the name of the Front Door service. Must be globally unique.
* [Obrigatório] `location`: Specifies the supported Azure location where the resource exists.
* [Obrigatório] `resource_group_name`: Specifies the name of the Resource Group in which the Front Door service should exist.
* [Obrigatório] `backend_pool`: A backend_pool block as defined below.
* Note
* Azure by default allows specifying up to 50 Backend Pools - but this quota can be increased via Microsoft Support.
* [Obrigatório] `backend_pool_health_probe`: A backend_pool_load_balancing block as defined below.
* [Opcional] `backend_pools_send_receive_timeout_seconds`: Specifies the send and receive timeout on forwarding request to the backend.
* [Opcional] `enforce_backend_pools_certificate_name_check`: Enforce certificate name check on HTTPS requests to all backend pools, this setting will have no effect on HTTP requests. Permitted values are true or false.
* [Obrigatório] `frontend_endpoint`:  A frontend_endpoint block as defined below.
* [Obrigatório] `routing_rule `: A routing_rule block as defined below.
* To see more variables availables take a look at the registry below:
* https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/frontdoor

## Exemplo de uso
Terraform 0.14.x
``` Go
module "front-door" {
  source = "../terraform-cloud/modules/front-door" 
  tags                                              = { Department = "Ops"}
  frontdoor_resource_group_name                     = azurerm_resource_group.instance.name
  frontdoor_name                                    = "my-frontdoor"
  frontdoor_loadbalancer_enabled                    = true
  backend_pools_send_receive_timeout_seconds        = 240
     
  frontend_endpoint      = [{
      name                                    = "my-frontdoor-frontend-endpoint"
      host_name                               = "my-frontdoor.azurefd.net"
      custom_https_provisioning_enabled       = false
      custom_https_configuration              = { certificate_source = "FrontDoor"}
      session_affinity_enabled                = false
      session_affinity_ttl_seconds            = 0
      waf_policy_link_id                      = ""
  }]
  
  frontdoor_routing_rule = [{
      name               = "my-routing-rule"
      accepted_protocols = ["Http", "Https"] 
      patterns_to_match  = ["/*"]
      enabled            = true             
      configuration      = "Forwarding"
      forwarding_configuration = [{
        backend_pool_name                     = "backendBing"
        cache_enabled                         = false      
        cache_use_dynamic_compression         = false      
        cache_query_parameter_strip_directive = "StripNone"
        custom_forwarding_path                = ""
        forwarding_protocol                   = "MatchRequest"  
      }]      
  }]
 
  frontdoor_loadbalancer =  [{      
      name                            = "loadbalancer"
      sample_size                     = 4
      successful_samples_required     = 2
      additional_latency_milliseconds = 0
  }]
 
  frontdoor_health_probe = [{      
      name                = "healthprobe"
      enabled             = true
      path                = "/"
      protocol            = "Http"
      probe_method        = "HEAD"
      interval_in_seconds = 60
  }]
 
  frontdoor_backend =  [{
      name               = "backendBing"
      loadbalancing_name = "loadbalancer"
      health_probe_name  = "healthprobe"
      backend = [{
        enabled     = true
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
        priority    = 1
        weight      = 50
      }]
  }]
}
```
#If you need to repeat the dynamic block, to create more than one frontend endpoint or routing rule you will need to use the "},{" under your Dynamic Block, find an example below:

frontend_endpoint      = [{
      name                                    = "my-frontdoor-frontend-endpoint"
      host_name                               = "my-frontdoor.azurefd.net"
      custom_https_provisioning_enabled       = false
      custom_https_configuration              = { certificate_source = "FrontDoor"}
      session_affinity_enabled                = false
     session_affinity_ttl_seconds            = 0
      waf_policy_link_id                      = ""
      },{
      name                                    = "two-frontdoor-frontend-endpoint"
      host_name                               = "www.rvszs.com"
      custom_https_provisioning_enabled       = false
      custom_https_configuration              = { certificate_source = "FrontDoor"}
      session_affinity_enabled                = false
      session_affinity_ttl_seconds            = 0
      waf_policy_link_id                      = ""
  }]