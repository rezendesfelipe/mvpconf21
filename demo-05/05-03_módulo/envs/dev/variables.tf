variable "location" {
  type    = string
  default = "eastus2"
}

variable "app_id" {
  type    = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "public_key" {
  type    = string
  default = null
}
