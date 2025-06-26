locals {
  eventhub_name = lower(azurerm_eventhub.logging.name)
  eventhub_connection_string_send = azurerm_eventhub_authorization_rule.logging_send.primary_connection_string
}
