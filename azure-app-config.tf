resource "azurerm_app_configuration_key" "eventhub_logging_namespace_connectionstring" {
  configuration_store_id = var.configuration_store_id
  key                    = "Global:EventHubLogging:ConnectionStringTEST"
  type                   = "vault"
  vault_key_reference    = azurerm_key_vault_secret.eventhub_connectionstring.versionless_id
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_entitypath" {
  configuration_store_id = var.configuration_store_id
  key                    = "Global:EventHubLogging:EntityPathTEST"
  value                   = azurerm_eventhub.logging.name
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_environment" {
  configuration_store_id = var.configuration_store_id
  key                    = "Global:EventHubLogging:EnvironmentTEST"
  value                   = upper(var.env)
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}