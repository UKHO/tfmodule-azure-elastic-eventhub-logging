#locals {
#  eventhub_name = "${var.product_alias}-${var.service}-${var.env}-evh-logging"
#  EVH_ConnectionString = azurerm_eventhub_namespace.this.default_primary_connection_string #azurerm_eventhub.logging.default_primary_connection_string
#}