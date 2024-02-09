resource "azurerm_eventhub" "logging" {
  name                = "${var.product_alias}-${var.service}-${var.env}-evh-logging"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}