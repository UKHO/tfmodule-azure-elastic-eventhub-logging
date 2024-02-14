locals {
  eventhub_name = azurerm_eventhub.logging.name
  eventhub_connection_string = azurerm_eventhub.logging.default_primary_connection_string
}