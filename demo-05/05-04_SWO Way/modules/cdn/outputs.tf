# output "cdn_endpoint_id" {
#   value = azurerm_cdn_endpoint.cdn.*.id
# }

output "cdn_profile_id" {
  value = azurerm_cdn_profile.cdn.id
}
output "cdn_endpoint_id" {
  value = tomap(
    {
      for k, endpoint in azurerm_cdn_endpoint.cdn : k => endpoint.name
    }
  )
}
