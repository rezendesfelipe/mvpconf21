
#Criação de string aleatória que servirá para definição de nome único para o ACI Group
resource "random_string" "aci_random" {
  length  = 4
  special = false

}

#Criação do ACI
resource "azurerm_container_group" "aci" {
  name                = lower(join("", [var.aci_grp_name, random_string.aci_random.result]))
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.aci_os
  tags                = var.tags

  ip_address_type = var.aci_ip_address_type
  dns_name_label  = var.aci_grp_name

  #Criação do(s) container(s) de um mesmo host
  dynamic "container" {
    for_each = var.v_container
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

    }
  }


}