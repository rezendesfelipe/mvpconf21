data "azurerm_resource_group" "cdn" {
  name = var.resource_group_name
}

resource "azurerm_cdn_profile" "cdn" {
  resource_group_name = data.azurerm_resource_group.cdn.name
  location            = var.location
  name                = var.cdn_profile_name
  sku                 = var.sku
  tags                = var.tags
  depends_on = [
    data.azurerm_resource_group.cdn
  ]
}

resource "random_string" "cdn" {
  length  = 4
  special = false
  number  = false
}


# resource "azurerm_cdn_endpoint" "cdn" {
#   count                         = length(var.cdn_endpoint_name) == null ? 0 : length(var.cdn_endpoint_name)
#   resource_group_name           = data.azurerm_resource_group.cdn.name
#   location                      = var.location
#   name                          = lower(join("", [var.cdn_endpoint_name[count.index], random_string.cdn.result]))
#   profile_name                  = azurerm_cdn_profile.cdn.name
#   querystring_caching_behaviour = length(var.cdn_caching_behavior) > 1 ? var.cdn_caching_behavior[count.index] : join("", var.cdn_caching_behavior)
#   origin_host_header            = length(var.cdn_origin_hostname) > 1 ? var.cdn_origin_hostname[count.index] : join("", var.cdn_origin_hostname)
#   origin_path                   = length(var.cdn_origin_path) > 1 ? var.cdn_origin_path[count.index] : join("", var.cdn_origin_path)
#   origin {
#     name      = "cdn-origin"
#     host_name = var.cdn_origin_hostname[count.index]
#   }
# }

resource "azurerm_cdn_endpoint" "cdn" {
  for_each            = var.cdn_endpoint
  resource_group_name = azurerm_cdn_profile.cdn.resource_group_name
  location            = var.location
  name                = lower(join("", [each.value["endpoint_name"], random_string.cdn.result]))
  profile_name        = azurerm_cdn_profile.cdn.name
  origin_host_header  = each.value["cdn_origin_hostname"]
  origin_path         = each.value["cdn_origin_path"]

  origin {
    name      = azurerm_cdn_profile.cdn.sku != "Standard_Microsoft" ? "endpoint-origin" : each.value["endpoint_name"]
    host_name = each.value["cdn_origin_hostname"]
  }

  depends_on = [
    azurerm_cdn_profile.cdn
  ]
}