variable "resource_group_name" {
  type = string
}

variable "name" {
  description = "Nome da zona a ser criada."
  type        = string
}

variable "vnet_links" {
  type = list(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = bool
  }))
  default = []
}

variable "a_records" {
  type = list(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = []
}

variable "cname_records" {
  type = list(object({
    name   = string
    ttl    = number
    record = string
  }))
  default = []
}

variable "tags" {
  type    = map(any)
  default = {}
}
