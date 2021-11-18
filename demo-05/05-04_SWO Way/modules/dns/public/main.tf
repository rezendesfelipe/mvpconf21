data "azurerm_resource_group" "dns" {
  name = var.resource_group_name
}

resource "azurerm_dns_zone" "zone" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.dns.name
  tags                = var.tags
}

resource "azurerm_dns_a_record" "dns-a-record" {
  count               = length(var.a_records)
  name                = var.a_records[count.index].name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.dns.name
  ttl                 = var.a_records[count.index].ttl
  records             = var.a_records[count.index].records
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "dns-cname-record" {
  count               = length(var.cname_records)
  name                = var.cname_records[count.index].name
  zone_name           = azurerm_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.dns.name
  ttl                 = var.cname_records[count.index].ttl
  record              = var.cname_records[count.index].record
  tags                = var.tags
}
