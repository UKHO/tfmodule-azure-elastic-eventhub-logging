resource "azurerm_eventhub" "logging" {
  name                = "${local.eventhub_name}"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}