resource "azurerm_eventhub" "logging" {
  name                = "${var.product_alias}-${var.env}-evh-logging-test"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}