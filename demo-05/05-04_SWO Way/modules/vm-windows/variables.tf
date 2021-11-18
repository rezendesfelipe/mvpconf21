#-------------------------
# Global Varibales
#-------------------------

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group. Changing this attribute will force resources to be recreated."
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "Name of the location where resources will be created. Changing this attribute will force resources to be recreated."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Map of tags that will be used to classify the resources created."
}

#-------------------------
# Network Variables
#-------------------------

variable "nic_settings" {
  type        = any
  description = "Define in a map object the following values: <table><thead><tr><th>Name</th><th>Description</th><th>Type</th><th>Default</th><th>Required</th></tr></thead><tbody><tr><td>subnet_id</td><td>Subnet Id where you want this IP to be configured</td><td>`string`</td><td>n/a</td><td>yes</td></tr><tr><td>private_ip_address_allocation</td><td>Ip Address Allocation Type. You can choose between `Static` and `Dynamic`</td><td>`string`</td><td>`Dynamic`</td><td>no</td></tr><tr><td>private_ip_address</td><td>IP address you want to attribute</td><td>`string`</td><td>`null`</td><td>no</td></tr><tr><td>private_ip_address_version</td><td>IP version. You can choose between `IPv4` and `IPv6`</td><td>`string`</td><td>`IPv4`</td><td>no</td></tr><tr><td>primary</td><td>Is this the primary Ip Configuration? At least one must be `true`</td><td>`bool`</td><td>`false`</td><td>no (only 1 is required)</td></tr><tr><td>public_ip_address_id</td><td>Public IP Id to attach to this IP configuration</td><td>`string`</td><td>`null`</td><td>no</td></tr></tbody></table>"
}

#-------------------------
# VM variables
#-------------------------

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine you want to create."
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine based on SKU Sizes available."
}

variable "admin_username" {
  type        = string
  description = "Local Administrator Username."
}

variable "admin_pass" {
  type        = string
  sensitive   = true
  description = "Local Administrator Password."
}

variable "zone" {
  type        = string
  default     = null
  description = "Zone where the virtual machine will be created. Changing this forces the resource to be recreated. Cannot be used alongside the variable `availability_set_id`."
}

variable "availability_set_id" {
  type        = string
  default     = null
  description = "Availability Set ID where the virtual machine must be attached. Changing this forces the resource to be recreated. Cannot be used alongside the variable `zone`."
}

#-------------------------
# VM Disk Settings
#-------------------------

variable "os_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "Operating System Disk Caching option. You may use use `None`, `Read` ou `ReadWrite`."
}

variable "os_disk_size" {
  type        = number
  default     = 127
  description = "Operating System Disk Size. Define a value in GB."
}

variable "os_disk_storage_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Storage Type used for the disk. Allowed values are `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`."
}

variable "data_disks" {
  type        = any
  default     = null
  description = "Must follow the pattern: <table><thead><tr><th>Name</th><th>Type</th><th>Default</th><th>Description</th><th>Required</th></tr></thead><tbody><tr><td>lun</td><td>`number`</td><td>n/a</td><td>Disk Logical Unit number.</td><td>yes</td></tr><tr><td>create_option</td><td>`string`</td><td>`Empty`</td><td>Data Disk create option. Accepts `Empty` or `FromImage`.</td><td>no</td></tr><tr><td>disk_size</td><td>`number`</td><td>n/a</td><td>Size of the disk in GB.</td><td>yes</td></tr><tr><td>storage_account_type</td><td>`string`</td><td>`Standard_LRS`</td><td>Data disk type. Accepts `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`.</td><td>no</td></tr><tr><td>caching</td><td>`string`</td><td>`ReadWrite`</td><td>Data disk caching type. Accepts `None`, `Read`, `ReadWrite`.</td><td>no</td></tr><tr><td>attach_option</td><td>`string`</td><td>`Attach`</td><td>Disk type creation option. Accepts `Attach`, `Empty`.</td><td>no</td></tr></tbody></table>"
}

#-------------------------
# VM Image Settings
#-------------------------

variable "img_publisher" {
  type        = string
  default     = "MicrosoftWindowsServer"
  description = "Image Publisher Information. Defaults to `MicrosoftWindowsServer`."
}

variable "img_offer" {
  type        = string
  default     = "WindowsServer"
  description = "Image Offer Information. Defaults to `WindowsServer`."
}

variable "img_sku" {
  type        = string
  default     = "2019-Datacenter"
  description = "Image SKU Information. Defaults to `2019-Datacenter`."
}

variable "img_version" {
  type        = string
  default     = "latest"
  description = "Image Version Information. Defaults to `latest`."
}

#-------------------------
# Boot Diagnostic Settings
#-------------------------

variable "storage_uri" {
  type        = string
  default     = null
  description = "Storage account URI used for boot diagnostics. Leave this field `null` if you want to use a Managed Storage Account."
}
