variable "name" {
  type = string
  default = "test"
}

variable "product_alias" {
  type = string
  description = "The alias for the project"
}

variable "service" {
  type = string
  description = "The service name to be logged"
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

variable "event_hub_namespace" {}

variable "configuration_store_id" {}

variable "agent_policy_id" {}

variable "elk_api_key" {}

variable "elk_url" {}

variable "elk_storage_account" {}

variable "elk_storage_account_key" {}

variable "elk_namespace" {} # must be lower case

variable "svc_min_log_level" {}

variable "ukho_min_log_level" {}
