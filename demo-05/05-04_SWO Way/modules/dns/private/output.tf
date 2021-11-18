output "zone_name" {
  value = azurerm_private_dns_zone.dns-private.name
}

output "a_records" {
  value = azurerm_private_dns_a_record.dns-a-record.*.name
}

output "cname_records" {
  value = azurerm_private_dns_cname_record.dns-cname-record.*.name
}
