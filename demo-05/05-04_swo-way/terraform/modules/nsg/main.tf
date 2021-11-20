data "azurerm_resource_group" "nsg" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.nsg.location
  resource_group_name = data.azurerm_resource_group.nsg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  count                                      = length(var.rules)
  name                                       = lookup(var.rules[count.index], "name", "default_rule_name")
  priority                                   = lookup(var.rules[count.index], "priority")
  direction                                  = lookup(var.rules[count.index], "direction", "Inbound")
  access                                     = lookup(var.rules[count.index], "access", "Allow")
  protocol                                   = lookup(var.rules[count.index], "protocol", "*")
  source_port_range                          = lookup(var.rules[count.index], "source_port_range", "*") == "*" ? "*" : null
  destination_port_ranges                    = split(",", replace(lookup(var.rules[count.index], "destination_port_range", "*"), "*", "0-65535"))
  source_address_prefix                      = lookup(var.rules[count.index], "source_application_security_group_ids", null) == null && lookup(var.rules[count.index], "source_address_prefixes", null) == null ? lookup(var.rules[count.index], "source_address_prefix", "*") : null
  source_address_prefixes                    = lookup(var.rules[count.index], "source_application_security_group_ids", null) == null ? lookup(var.rules[count.index], "source_address_prefixes", null) : null
  destination_address_prefix                 = lookup(var.rules[count.index], "destination_application_security_group_ids", null) == null && lookup(var.rules[count.index], "destination_address_prefixes", null) == null ? lookup(var.rules[count.index], "destination_address_prefix", "*") : null
  destination_address_prefixes               = lookup(var.rules[count.index], "destination_application_security_group_ids", null) == null ? lookup(var.rules[count.index], "destination_address_prefixes", null) : null
  description                                = lookup(var.rules[count.index], "description", "Regra de segurança do tipo ${lookup(var.rules[count.index], "direction", "default_direction")} para ${lookup(var.rules[count.index], "name", "default_rule_name")}")
  resource_group_name                        = data.azurerm_resource_group.nsg.name
  network_security_group_name                = azurerm_network_security_group.nsg.name
  source_application_security_group_ids      = lookup(var.rules[count.index], "source_application_security_group_ids", null)
  destination_application_security_group_ids = lookup(var.rules[count.index], "destination_application_security_group_ids", null)
}
