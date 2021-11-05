variable "resource_group_name" {
  type    = string
}
variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type    = map(any)
  default = {}
}