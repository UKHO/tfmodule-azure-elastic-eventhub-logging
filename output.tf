output "resource_group_name" {
  value = var.resource_group_name
}

output "event_hub_namespace" {
  value = var.event_hub_namespace
}

output "eventhub_name" {
  value = azurerm_eventhub.logging.name
}

output "eventhub_logging_send" {
  value = local.eventhub_connection_string_send
}

output "eventhub_logging_listen" {
  value = local.eventhub_connection_string
}
