data "azurerm_resource_group" "vmssl" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vmssl" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "vmssl" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vmssl.name
}

resource "azurerm_linux_virtual_machine_scale_set" "vmssl" {
  name                = var.vmssl_name
  location            = data.azurerm_resource_group.vmssl.location
  resource_group_name = data.azurerm_resource_group.vmssl.name
  admin_username      = var.admin_username
  instances           = var.instances

  eviction_policy = var.eviction_policy
  sku             = var.sku

  single_placement_group = var.single_placement_enabled

  network_interface {
    name = var.network_interface_name

    ip_configuration {
      name                                         = var.network_interface_ip_config_name
      application_gateway_backend_address_pool_ids = var.network_interface_ip_application_gateway_backend_ids
      load_balancer_backend_address_pool_ids       = var.network_interface_ip_load_balancer_backend_ids
      load_balancer_inbound_nat_rules_ids          = var.network_interface_ip_load_balancer_inbound_nat_rules_ids
      primary                                      = var.network_interface_ip_config_primary
      subnet_id                                    = data.azurerm_subnet.vmssl.id
    }

    enable_accelerated_networking = var.network_interface_enable_accelerated_networking
    primary                       = var.network_interface_primary

  }

  os_disk {
    disk_size_gb         = var.os_disk_size == null ? null : var.os_disk_size
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  additional_capabilities {
    ultra_ssd_enabled = var.additional_capabilities_ultra_ssd_enabled
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  dynamic "data_disk" {
    for_each = toset(var.data_disks)

    content {
      caching              = data_disk.value["caching"]
      create_option        = data_disk.value["create_option"]
      disk_size_gb         = data_disk.value["disk_size_gb"]
      lun                  = data_disk.value["lun"]
      storage_account_type = data_disk.value["storage_account_type"]
    }

  }

  encryption_at_host_enabled  = var.encryption_at_host_enabled
  platform_fault_domain_count = var.platform_fault_domain_count
  priority                    = var.priority
  provision_vm_agent          = var.provision_vm_agent
  scale_in_policy             = var.scale_in_policy

  source_image_id = var.custom_image_enabled ? var.custom_image_id : null

  dynamic "source_image_reference" {
    for_each = var.custom_image_enabled ? [] : [1]
    content {
      publisher = var.image_publisher
      offer     = var.image_offer
      sku       = var.image_sku
      version   = var.image_version
    }
  }

  tags = var.tags

  zone_balance = var.zone_balance
  zones        = var.zones

}

resource "azurerm_monitor_autoscale_setting" "example" {
  count               = var.enable_autoscale_for_vmss == true ? 1 : 0
  name                = lower("auto-scale-set-${var.vmssl_name}")
  resource_group_name = data.azurerm_resource_group.vmssl.name
  location            = data.azurerm_resource_group.vmssl.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmssl.id

  dynamic "profile" {
    for_each = toset(var.profiles)
    content {
      name = profile.value["name"]
      capacity {
        default = var.instances
        minimum = profile.value["minimum"] == null ? var.instances : profile.value["minimum"]
        maximum = profile.value["maximum"]
      }
      dynamic "rule" {
        for_each = toset(profile.value["rules_Increase"])
        content {
          metric_trigger {
            metric_name        = var.metric_name
            metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmssl.id
            time_grain         = rule.value["time_grain"]
            statistic          = rule.value["statistic"]
            time_window        = rule.value["time_window"]
            time_aggregation   = rule.value["time_aggregation"]
            operator           = rule.value["operator"]
            threshold          = rule.value["scale_threshold"]
          }
          scale_action {
            direction = rule.value["direction"]
            type      = rule.value["type"]
            value     = rule.value["scale_number"]
            cooldown  = rule.value["cooldown"]
          }
        }
      }
      dynamic "rule" {
        for_each = toset(profile.value["rules_Decrease"])
        content {
          metric_trigger {
            metric_name        = var.metric_name
            metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmssl.id
            time_grain         = rule.value["time_grain"]
            statistic          = rule.value["statistic"]
            time_window        = rule.value["time_window"]
            time_aggregation   = rule.value["time_aggregation"]
            operator           = rule.value["operator"]
            threshold          = rule.value["scale_threshold"]
          }
          scale_action {
            direction = rule.value["direction"]
            type      = rule.value["type"]
            value     = rule.value["scale_number"]
            cooldown  = rule.value["cooldown"]
          }
        }
      }
    }
  }
}

#Ainda não está funcionando como esperado, portanto deixaremos está feature em hold
# resource "azurerm_virtual_machine_scale_set_extension" "ext" {
#   count = var.is_extension_enabled ? 1 : 0

#   name                         = var.ext_name
#   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmssl.id
#   publisher                    = "Microsoft.Azure.Extensions"
#   type                         = "CustomScript"
#   type_handler_version         = var.handler_version # default = 2.1

#   settings           = <<SETTINGS
#    {
#     "fileUris": ["https://${var.str_name}.blob.core.windows.net/${var.container_name}/${var.script_name}"],
#     "commandToExecute": "${var.command_exec}"

#   }
#  SETTINGS
#   protected_settings = <<PROTECTED_SETTINGS
#     {
#       "storageAccountName":"${var.str_name}",
#       "storageAccountKey":"${var.keys}"
#     }
#   PROTECTED_SETTINGS
# }

# "script":"${var.encode_script}",
