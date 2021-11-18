variable "databricks_name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "managed_rg_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "sku" {
  type = string
}
variable "custom_param_exists" {
  type    = string
  default = null
}

variable "custom_parameter" {
  type = list(object({
    no_public_ip        = string
    private_subnet_name = string
    public_subnet_name  = string
    virtual_network_id  = string
  }))
  default = []
}