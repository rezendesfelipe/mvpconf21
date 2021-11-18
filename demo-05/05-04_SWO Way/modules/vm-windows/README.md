
## Resources

| Name | Type |
|------|------|
| [azurerm_managed_disk.datadisk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.vmnic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.datadisk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_string.vm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_pass"></a> [admin\_pass](#input\_admin\_pass) | Local Administrator Password. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Local Administrator Username. | `string` | n/a | yes |
| <a name="input_nic_settings"></a> [nic\_settings](#input\_nic\_settings) | Define in a map object the following values: <table><thead><tr><th>Name</th><th>Description</th><th>Type</th><th>Default</th><th>Required</th></tr></thead><tbody><tr><td>subnet\_id</td><td>Subnet Id where you want this IP to be configured</td><td>`string`</td><td>n/a</td><td>yes</td></tr><tr><td>private\_ip\_address\_allocation</td><td>Ip Address Allocation Type. You can choose between `Static` and `Dynamic`</td><td>`string`</td><td>`Dynamic`</td><td>no</td></tr><tr><td>private\_ip\_address</td><td>IP address you want to attribute</td><td>`string`</td><td>`null`</td><td>no</td></tr><tr><td>private\_ip\_address\_version</td><td>IP version. You can choose between `IPv4` and `IPv6`</td><td>`string`</td><td>`IPv4`</td><td>no</td></tr><tr><td>primary</td><td>Is this the primary Ip Configuration? At least one must be `true`</td><td>`bool`</td><td>`false`</td><td>no (only 1 is required)</td></tr><tr><td>public\_ip\_address\_id</td><td>Public IP Id to attach to this IP configuration</td><td>`string`</td><td>`null`</td><td>no</td></tr></tbody></table> | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. Changing this attribute will force resources to be recreated. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Name of the virtual machine you want to create. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine based on SKU Sizes available. | `string` | n/a | yes |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | Availability Set ID where the virtual machine must be attached. Changing this forces the resource to be recreated. Cannot be used alongside the variable `zone`. | `string` | `null` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | Must follow the pattern: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>lun</td><td>`number`</td><td>n/a</td><td>Disk Logical Unit number.</td><td>yes</td></tr><tr><td>create\_option</td><td>`string`</td><td>`Empty`</td><td>Data Disk create option. Accepts `Empty` or `FromImage`.</td><td>no</td></tr><tr><td>disk\_size</td><td>`number`</td><td>n/a</td><td>Size of the disk in GB.</td><td>yes</td></tr><tr><td>storage\_account\_type</td><td>`string`</td><td>`Standard_LRS`</td><td>Data disk type. Accepts `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`.</td><td>no</td></tr><tr><td>caching</td><td>`string`</td><td>`ReadWrite`</td><td>Data disk caching type. Accepts `None`, `Read`, `ReadWrite`.</td><td>no</td></tr><tr><td>attach\_option</td><td>`string`</td><td>`Attach`</td><td>Disk type creation option. Accepts `Attach`, `Empty`.</td><td>no</td></tr></tbody></table> | `any` | `null` | no |
| <a name="input_img_offer"></a> [img\_offer](#input\_img\_offer) | Image Offer Information. Defaults to `WindowsServer`. | `string` | `"WindowsServer"` | no |
| <a name="input_img_publisher"></a> [img\_publisher](#input\_img\_publisher) | Image Publisher Information. Defaults to `MicrosoftWindowsServer`. | `string` | `"MicrosoftWindowsServer"` | no |
| <a name="input_img_sku"></a> [img\_sku](#input\_img\_sku) | Image SKU Information. Defaults to `2019-Datacenter`. | `string` | `"2019-Datacenter"` | no |
| <a name="input_img_version"></a> [img\_version](#input\_img\_version) | Image Version Information. Defaults to `latest`. | `string` | `"latest"` | no |
| <a name="input_location"></a> [location](#input\_location) | Name of the location where resources will be created. Changing this attribute will force resources to be recreated. | `string` | `"eastus2"` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | Operating System Disk Caching option. You may use use `None`, `Read` ou `ReadWrite`. | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | Operating System Disk Size. Define a value in GB. | `number` | `127` | no |
| <a name="input_os_disk_storage_type"></a> [os\_disk\_storage\_type](#input\_os\_disk\_storage\_type) | Storage Type used for the disk. Allowed values are `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`. | `string` | `"Standard_LRS"` | no |
| <a name="input_storage_uri"></a> [storage\_uri](#input\_storage\_uri) | Storage account URI used for boot diagnostics. Leave this field `null` if you want to use a Managed Storage Account. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags that will be used to classify the resources created. | `map(any)` | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone where the virtual machine will be created. Changing this forces the resource to be recreated. Cannot be used alongside the variable `availability_set_id`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | Resource ID of the virtual Machine |
| <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip) | Private IP of the Virtual Machine |

## Usage Example 

``` hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "windows_vm" {
  source              = "./modules/vm-windows"
  admin_pass          = "teste1"
  admin_username      = "teste1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = var.vm_name

  img_publisher = "MicrosoftWindowsServer"
  img_offer     = "WindowsServer"
  img_sku       = "2019-Datacenter"

  os_disk_caching      = "ReadWrite"
  os_disk_storage_type = "StandardSSD_LRS"
  os_disk_size         = 127

  vm_size = "Standard_B2s"
  zone    = "1"

  nic_settings = {
    ipconfig1 = {
      subnet_id = module.vnet.vnet_subnet_ids[var.mgmt_subnet_name]
      primary   = true
    }
    ipconfig2 = {
      subnet_id = module.vnet.vnet_subnet_ids[var.mgmt_subnet_name]
    }
  }

  data_disks = {
    datadisk1 = {
      disk_size            = 30
      storage_account_type = "StandardSSD_LRS"
      lun                  = 0
    }
    datadisk2 = {
      disk_size     = 34
      lun           = 1
      create_option = "Empty"
      attach_option = "Attach"
    }
    datadisk3 = {
      disk_size     = 100
      lun           = 2
      create_option = "Empty"
      attach_option = "Empty"
    }
  }
  depends_on = [
    module.vnet
  ]
}

```

