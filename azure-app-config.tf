

resource "azurerm_app_configuration_key" "eventhub_logging_entitypath" {
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:EntityPath"
  value                   = azurerm_eventhub.logging.name
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_environment" {
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:Environment"
  value                   = upper(var.env)
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}