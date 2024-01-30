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
