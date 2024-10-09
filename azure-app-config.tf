

resource "azurerm_app_configuration_key" "eventhub_logging_entitypath" {
  count           = (var.using_serilog == false) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:EntityPath"
  value                   = azurerm_eventhub.logging.name
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_environment" {
  count           = (var.using_serilog == false) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:Environment"
  value                   = upper(var.env)
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_level" {
  count           = (var.using_serilog == false) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:MinimumLoggingLevel"
  value                   = var.svc_min_log_level
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "eventhub_logging_ukho_level" {
  count           = (var.using_serilog == false) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:EventHubLogging:UkhoMinimumLoggingLevel"
  value                   = var.ukho_min_log_level
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "serilog_logging_environment" {
  count           = (var.using_serilog == true) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:Serilog:Properties:_Environment"
  value                   = upper(var.env)
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}

resource "azurerm_app_configuration_key" "serilog_logging_entitypath" {
  count           = (var.using_serilog == true) ? 1 : 0
  configuration_store_id = var.configuration_store_id
  key                    = "${var.service}:Logging:EventHub:EntityPath"
  value                   = azurerm_eventhub.logging.name
  lifecycle { ignore_changes = [ value, tags, configuration_store_id ] }
}