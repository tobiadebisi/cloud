variable "name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Location of the Resource Group within which the Key Vault exists"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group within which the Key Vault exists"
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  type        = bool
}

variable "client_config_tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90"
  type        = number
}

variable "purge_protection_enabled" {
  description = "Enabling purge protection ensures that the key vault and its objects cannot be purged during the 90 day retention period"
  type        = bool
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  type        = string
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}