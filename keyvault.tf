resource "azurerm_key_vault_secret" "eventhub_connectionstring" {
  key_vault_id = var.key_vault_id
  name         = "eventhub-connectionstringTEST"
  value        = azurerm_eventhub_namespace.this.default_primary_connection_string
  lifecycle { ignore_changes = [tags] }
}