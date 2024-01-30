
resource "azurerm_eventhub_namespace" "this" {
  name                = "${var.product_alias}-${var.env}-ehns-test"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  capacity            = 1

  lifecycle { ignore_changes = [ tags ] }
}