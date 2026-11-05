variable "name" {
  description = "(Required) The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account"
  type        = string
}

variable "location" {
  description = "(Required) The supported Azure location where the resource exists"
  type        = string
}

variable "account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium"
  type        = string
}

variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  type        = string
}

variable "https_traffic_only_enabled" {
  description = "Boolean flag which forces HTTPS if enabled"
  type        = string
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account."
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}