variable "workspace_name" {
  type = string

}
variable "sku_agent" {
  type    = string
  default = "PerGB2018"
}

variable "retention_agent" {
  type = number

}


variable "resource_group_name" {
  type = string

}


variable "location" {
  type = string

}