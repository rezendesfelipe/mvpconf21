variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "location" {
  type        = string
  description = "Datacenter region where resources are going to be created."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Map of characters to identity the tags. Use the format `{ key = value }`."
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Network CIDR Address"
}

variable "subnets" {
  type = any
  description = "All details about the subnet that's going to be created. Must use the following inputs: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>name</td><td>`string`</td><td>n/a</td><td>This **must be used as the key of your map**</td><td>yes</td></tr><tr><td>address_prefix</td><td>`string`</td><td>n/a</td><td>Subnet CIDR address</td><td>yes</td></tr><tr><td>service_endpoints</td><td>`list(string)`</td><td>`null`</td><td>Service Endpoints to be used with this subnet. Accepted values are: `Microsoft.AzureActiveDirectory`, `Microsoft.CosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage`, `Microsoft.Web`</td><td>no</td></tr><tr><td>enforce_private_link_endpoint_network_policies</td><td>`bool`</td><td>`null`</td><td>Enable or Disable network policies for the private link endpoint on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. *Note*: Conflicts with `enforce_private_link_service_network_policies`.</td><td>no</td></tr><tr><td>enforce_private_link_service_network_policies</td><td>`bool`</td><td>`null`</td><td>Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. *Note*: Conflicts with `enforce_private_link_endpoint_network_policies`.</td><td>no</td></tr><tr><td>delegation</td><td>`map(any)`</td><td>`null`</td><td>must have the following details: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>name</td><td>`string`</td><td>n/a</td><td>Name of your Subnet Delegation</td><td>yes</td></tr><tr><td>service_actions</td><td>`map(any)`</td><td>n/a</td><td>Must follow the same structure as the [official documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_delegation) for this block attribute</td><td>yes</td></tr></tbody></table></td><td>no</td></tr></tbody></table>"
}
