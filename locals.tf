locals {
  eventhub_name = azurerm_eventhub.logging.name
#  EVH_ConnectionString = azurerm_eventhub_namespace.this.default_primary_connection_string #azurerm_eventhub.logging.default_primary_connection_string
}