output "resource_group_name" {
  value = var.resource_group_name
}

output "event_hub_namespace" {
  value = var.event_hub_namespace
}

output "eventhub_name" {
  value = azurerm_eventhub.logging.name
}
