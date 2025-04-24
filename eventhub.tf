resource "azurerm_eventhub" "logging" {
  name                = "${var.product_alias}-${var.service}-${var.env}-evh"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "root_manage" {
  name                = "RootManageSharedAccessKey"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  eventhub_name       = azurerm_eventhub.logging.name
  listen              = true
  send                = true
  manage              = true
  depends_on = [ azurerm_eventhub.logging ]
}

resource "azurerm_eventhub_authorization_rule" "logging_listen" {
  name                = "elastic-listener"
  namespace_name      = var.event_hub_namespace
  resource_group_name = var.resource_group_name
  eventhub_name       = azurerm_eventhub.logging.name
  listen              = true
  send                = false
  manage              = false
  depends_on = [ azurerm_eventhub.logging ]
}
