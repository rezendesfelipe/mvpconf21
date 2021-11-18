resource "azurerm_storage_account" "default" {
  name                     = "defaults2345storadge"
  resource_group_name      = var.v_resource_group_name
  location                 = var.v_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_queue" "default" {
  name                 = "defaultstoragequeue"
  storage_account_name = azurerm_storage_account.default.name
}
resource "azurerm_eventgrid_event_subscription" "sub" {
  name  = "event-yourname-sample"
  scope = azurerm_eventgrid_topic.default-event-grid.id

  storage_queue_endpoint {
    storage_account_id = azurerm_storage_account.default.id
    queue_name         = azurerm_storage_queue.default.name
  }
}
#Topic Event linkado ao Event Subscription da tenant
resource "azurerm_eventgrid_topic" "default-event-grid" {
  name                = "default-eventgrid-topic"
  location            = var.v_location
  resource_group_name = var.v_resource_group_name

  tags = {
    source = "terraform"
  }
}