#--------------------------------------
# Common Variables
#--------------------------------------

location            = "eastus2"
resource_group_name = "rg-vms-prd"
tags = {
  owner = "carlos.oliveira@softwareone.com"
}

#--------------------------------------
# Network Variables
#--------------------------------------

vnet_name          = "vnet-testing-prd"
vnet_address_space = ["10.0.0.0/16"]

mgmt_address_prefix = ["10.0.1.0/24"]
mgmt_subnet_name    = "sn-mgmt"

web_address_prefix = ["10.0.2.0/24"]
web_subnet_name    = "sn-web"

db_address_prefix = ["10.0.3.0/24"]
db_subnet_name    = "sn-db"

web_nsg_name  = "nsg-web-prd"
mgmt_nsg_name = "nsg-mgmt-prd"
db_nsg_name   = "db-nsg-prd"

web_lb_name = "lb-webserver-prd"

#--------------------------------------
# Compute Variables
#--------------------------------------

ansible_vm_name = "vm-ansible-prd"
ansible_vm_size = "Standard_B1ls"

webserver_setup = {
  webserver-prd-0 = {
    vm_size                 = "Standard_B1ls"
    enable_public_ip        = true
    enable_boot_diagnostics = true
  }
  webserver-prd-1 = {
    vm_size                 = "Standard_B1ls"
    enable_public_ip        = true
    enable_boot_diagnostics = true
  }
}

avset_web = "avset-db-prd"
avset_db  = "avset-web-prd"

database_setup = {
  database-prd-0 = {
    vm_size                 = "Standard_B1ls"
    enable_public_ip        = false
    enable_boot_diagnostics = true
  }
  database-prd-1 = {
    vm_size                 = "Standard_B1ls"
    enable_public_ip        = false
    enable_boot_diagnostics = true
  }
  database-prd-2 = {
    vm_size                 = "Standard_B1ls"
    enable_public_ip        = false
    enable_boot_diagnostics = true
  }
}

#--------------------------------------
# On-prem Variables
#--------------------------------------
