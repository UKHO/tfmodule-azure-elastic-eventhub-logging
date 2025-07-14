resource "azurerm_eventhub" "logging" {
  name                = "${var.product_alias}-${var.service}-evh-${var.env}"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "logging_send" {
  name                = "log-send"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  eventhub_name       = azurerm_eventhub.logging.name
  listen              = false
  send                = true
  manage              = false
  depends_on = [ azurerm_eventhub.logging ]
}
