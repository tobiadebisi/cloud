variable "name" {
  description = "(Required) The name of the resource group in which to create the App Configuration"
  type        = string
}

variable "resource_group_name" {
  description = ""
  type        = string
}

variable "location" {
  description = "(Required) Azure location where the resource exists"
  type        = string
}

variable "sku" {
  description = "The SKU name of the the App Configuration. Possible values are free and standard"
  type        = string
}

variable "identity_ids" {
  description = "A list of User Assigned Managed Identity IDs to be assigned to this App Configuration"
  type        = list(any)
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}