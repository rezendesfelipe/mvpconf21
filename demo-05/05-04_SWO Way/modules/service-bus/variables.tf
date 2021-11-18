variable "resource_group_name" {
  type = string
}
variable "tags" {
  type        = map(any)
  description = "Tags a serem aplicadas no Scale Set Linux"
  default     = {}
}
variable "location" {
  type    = string
  default = "eastus2"
}
variable "sku_name" {
  type = string
}
variable "namespace_name" {
  type = string
}
