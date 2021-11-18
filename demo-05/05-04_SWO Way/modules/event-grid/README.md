## Variáveis válidas
The following arguments are supported:


name - (Required) Specifies the name of the EventGrid Event Subscription resource. Changing this forces a new resource to be created.

scope - (Required) Specifies the scope at which the EventGrid Event Subscription should be created. Changing this forces a new resource to be created.

expiration_time_utc - (Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339).

event_delivery_schema - (Optional) Specifies the event delivery schema for the event subscription. Possible values include: EventGridSchema, CloudEventSchemaV1_0, CustomInputSchema. Defaults to EventGridSchema. Changing this forces a new resource to be created.

azure_function_endpoint - (Optional) An azure_function_endpoint block as defined below.

eventhub_endpoint - (Optional / Deprecated in favour of eventhub_endpoint_id) A eventhub_endpoint block as defined below.

eventhub_endpoint_id - (Optional) Specifies the id where the Event Hub is located.

hybrid_connection_endpoint - (Optional / Deprecated in favour of hybrid_connection_endpoint_id) A hybrid_connection_endpoint block as defined below.

hybrid_connection_endpoint_id - (Optional) Specifies the id where the Hybrid Connection is located.

service_bus_queue_endpoint_id - (Optional) Specifies the id where the Service Bus Queue is located.

service_bus_topic_endpoint_id - (Optional) Specifies the id where the Service Bus Topic is located.

storage_queue_endpoint - (Optional) A storage_queue_endpoint block as defined below.

webhook_endpoint - (Optional) A webhook_endpoint block as defined below.

included_event_types - (Optional) A list of applicable event types that need to be part of the event subscription.

subject_filter - (Optional) A subject_filter block as defined below.

advanced_filter - (Optional) A advanced_filter block as defined below.

storage_blob_dead_letter_destination - (Optional) A storage_blob_dead_letter_destination block as defined below.

retry_policy - (Optional) A retry_policy block as defined below.

labels - (Optional) A list of labels to assign to the event subscription.

A storage_queue_endpoint supports the following:

storage_account_id - (Required) Specifies the id of the storage account id where the storage queue is located.

queue_name - (Required) Specifies the name of the storage queue where the Event Subscription will receive events.

# Casos de uso
### Exemplo de código
module "event-grid" {
  source = "../modules/event-grid"

  v_resource_group_name        = azurerm_resource_group.example.name
  v_location                   = azurerm_resource_group.example.location
  eventgrid_event_subscription = azurerm_eventgrid_event_subscription.sub.name
  account_tier                 = "standard"
  account_replication_type     = "LRS"

}

### Exemplo de plan
terraform plan -target module.event-grid