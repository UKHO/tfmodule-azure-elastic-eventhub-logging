variable "name" {
  type = string
  default = "test"
}

variable "product_alias" {
  type = string
  description = "The alias for the project"
}

variable "env" {
  type = string
  default = "Environment name or resource"
}

variable "location" {
  type = string
  description = "Location the resource will run in"
}

variable "resource_group_name" {
  type = string
  description = "Resource Group name"
}

variable "key_vault_id" {
  type = string
  description = "Key Vault ID"
}

variable "configuration_store_id" {}

variable agent_policy_id {}

variable "Elastic_API_Key" {}

variable "ELK_URL" {}

variable "ELK_storage_account" {}

variable "ELK_storage_account_key" {}

variable "ELK_connection_string" {}