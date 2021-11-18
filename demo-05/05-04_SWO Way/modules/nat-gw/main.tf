resource "azurerm_public_ip" "natgw-pip" {
  count               = var.natgw-pip_count
  name                = lower(join("-", ["pip", var.ngw_name, count.index]))
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
  tags                = var.tags
  zones               = var.zones

}

resource "azurerm_nat_gateway" "nat-gateway" {
  name                    = lower(var.ngw_name)
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  public_ip_address_ids   = azurerm_public_ip.natgw-pip.*.id
  sku_name                = var.ngw_sku_name
  idle_timeout_in_minutes = var.ngw_idle_timeout
  tags                    = var.tags
  zones                   = var.zones
}

resource "azurerm_subnet_nat_gateway_association" "nat-subnet" {
  count          = length(var.subnet_id)
  subnet_id      = var.subnet_id[count.index]
  nat_gateway_id = azurerm_nat_gateway.nat-gateway.id
}