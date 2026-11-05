variable "name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "Supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which the Log Analytics workspace is created"
  type        = string
}

variable "sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
}

variable "retention_in_days" {
  description = "Workspace data retention in days. Possible values are between 30 and 730"
  type        = string
}
