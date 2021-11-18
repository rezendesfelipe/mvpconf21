output "zone_name" {
  value = azurerm_dns_zone.zone.name
}

output "a_records" {
  value = azurerm_dns_a_record.dns-a-record.*.name
}

output "cname_records" {
  value = azurerm_dns_cname_record.dns-cname-record.*.name
}
