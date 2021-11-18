variable "vertical" {
  type = string
}

variable "produto" {
  type = string
}

variable "ambiente" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tags" {
  type    = map(any)
  default = {}
}