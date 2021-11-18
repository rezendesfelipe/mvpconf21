# Módulo de Azure VM-Windows
## Variáveis válidas (Globais)
Este módulo aceita as seguintes variáveis
* [Obrigatório] `resource_group_name`: Nome do Resource Group a ser utilizado. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)
* [Obrigatório] `location`: Localidade onde a VM será criada. O valor padrão é `eastus2`.
* [Opcional] `tags`: Quais tags serão utilizados. Normalmente ele já irá puxar no momento em que o módulo for chamado.

## Variáveis válidas (NIC)
* [Obrigatório] `image_resource_group_name`: Nome do Resource Group onde está a galeria de imagem compartilhada. O padrão é fazer uso do resource group de sua vertical (Ex: Impulse)

Um exemplo de como pode ser realizado:
``` Go
  resource_group_name = module.rg.rg_name
```

* [Obrigatório] `ip_allocation`: Parâmetro que define se um IP será estático ou dinâmico. O valor padrão é O valor padrão é `dinâmico`.
* [Obrigatório] `ip_address`: Endereço IP da VM 

## Variáveis válidas (VM)

* [Obrigatório] `os_flavor`: Sistema operacional utilizado. Atualmente somente suporta `Windows`.
* [Obrigatório] `vm_name`: Nome da VM.
* [Obrigatório] `vm_size`: Size da VM. "Standard B2ms"
* [Obrigatório] `admin_win_username`: Usuário de acesso para a vm.
* [Obrigatório] `admin_win_pass`: Senha de acesso para a vm. OBS.: utilizar arquivo tfvars 
* [Obrigatório] `caching`: Cache do disco. (Ex: ReadWrite) 
* [Obrigatório] `image_name`: Imagem contidada na Galeria de imagens compartilhada.
* [Obrigatório] `gallery_name`: Nome da galeria de imagens existente no ambiente Azure. 

## Casos de uso
### Exemplo de código
### The informations about your Shared Image Gallery existing on your Portal.
data "azurerm_shared_image" "existing" {
  name                = var.image_name
  gallery_name        = var.gallery_name
  resource_group_name = var.resource_group_name
}
### Provisionamento da NIC que a VM irá fazer uso:
resource "azurerm_network_interface" "vmnic" {
  name                = lower(join("-", [var.vm_name, "nic"]))
  location            = var.location #data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  tags = {
    "owner" = ""
  }
  ip_configuration {
    name                          = lower(join("-", [var.vm_name, random_id.vm.hex, "nic", "config"]))
    subnet_id                     = var.sn_id
    private_ip_address_allocation = var.ip_allocation
    private_ip_address            = var.ip_allocation == "Static" ? var.ip_address : null
    private_ip_address_version    = "IPv4"
    primary                       = true
  }
}
### Provisionamento da VM
# Block responsible for the VM
# Exemplo de uso
Terraform 0.14.x
``` Go

module "vm-vhd" {
  count               = 1 # Qtde de VMs
  source              = "../terraform-cloud/modules/vm-vhd"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  tags = {
    Owner = ""
  }
  sn_id                    = module.vnet.vnet_subnet_ids[1]
  vm_name                   = tostring(join("-", ["custom-image", count.index]))       # nome da VM no formato desejado
  admin_win_pass            = "ComplxP@ssw0rd!"
  admin_win_username        = "azureuser"
  vm_size                   = "standard_b2s"
  depends_on                = [module.rg]
  image_name                = "Image-Name"
  gallery_name              = "Image-Gallery"
}