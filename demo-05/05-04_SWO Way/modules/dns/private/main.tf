data "azurerm_resource_group" "dns" {
  name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "dns-private" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.dns.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link" {
  count                 = length(var.vnet_links)
  name                  = var.vnet_links[count.index].name
  private_dns_zone_name = azurerm_private_dns_zone.dns-private.name
  resource_group_name   = data.azurerm_resource_group.dns.name
  virtual_network_id    = var.vnet_links[count.index].virtual_network_id
  registration_enabled  = var.vnet_links[count.index].registration_enabled
  tags                  = var.tags
}

resource "azurerm_private_dns_a_record" "dns-a-record" {
  count               = length(var.a_records)
  name                = var.a_records[count.index].name
  zone_name           = azurerm_private_dns_zone.dns-private.name
  resource_group_name = data.azurerm_resource_group.dns.name
  ttl                 = var.a_records[count.index].ttl
  records             = var.a_records[count.index].records
  tags                = var.tags
}

resource "azurerm_private_dns_cname_record" "dns-cname-record" {
  count               = length(var.cname_records)
  name                = var.cname_records[count.index].name
  zone_name           = azurerm_private_dns_zone.dns-private.name
  resource_group_name = data.azurerm_resource_group.dns.name
  ttl                 = var.cname_records[count.index].ttl
  record              = var.cname_records[count.index].record
  tags                = var.tags
}
