locals {
  eventhub_name = azurerm_eventhub.logging.name
  eventhub_connection_string = azurerm_eventhub_authorization_rule.root_manage.primary_connection_string
}