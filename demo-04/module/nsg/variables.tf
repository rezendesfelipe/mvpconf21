# Network Security Group definition
variable "resource_group_name" {
  description = "Nome do Resource group"
  type        = string
}

variable "nsg_name" {
  description = "Nome do Network Security Group"
  type        = string
  default     = "nsg"
}

variable "tags" {
  type = map(any)
  default = {
    env         = "dev"
    suite       = "application1"
    provisioner = "terraform"
  }
}

variable "location" {
  description = "Localização da região do Azure."
  # No default - Se não for especificado irá utilizar o do resource Group
  type    = string
  default = ""
}

# Security Rules definition 

variable "rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = any
  default     = []
}
# source address prefix to be applied to all predefined rules
# list(string) only allowed one element (CIDR, `*`, source IP range or Tags)
# Example ["10.0.3.0/24"] or ["VirtualNetwork"]
variable "source_address_prefix" {
  type    = list(string)
  default = ["*"]
}

# Destination address prefix to be applied to all predefined rules
# Example ["10.0.3.0/32","10.0.3.128/32"]
variable "source_address_prefixes" {
  type    = list(string)
  default = null
}

# Destination address prefix to be applied to all predefined rules
# list(string) only allowed one element (CIDR, `*`, source IP range or Tags)
# Example ["10.0.3.0/24"] or ["VirtualNetwork"]
variable "destination_address_prefix" {
  type    = list(string)
  default = ["*"]
}

# Destination address prefix to be applied to all predefined rules
# Example ["10.0.3.0/32","10.0.3.128/32"]
variable "destination_address_prefixes" {
  type    = list(string)
  default = null
}