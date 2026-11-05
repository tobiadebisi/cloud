variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "location" {
  description = ""
  type        = string
}

variable "project" {
  description = ""
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90"
}

variable "purge_protection_enabled" {
  description = "Enabling purge protection ensures that the key vault and its objects cannot be purged during the 90 day retention period"
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  type        = string
}

variable "key_permissions" {
  description = "List of key permissions"
}

variable "secret_permissions" {
  description = "List of secret permissions"
}

variable "storage_permissions" {
  description = "List of storage permissions"
}

variable "certificate_permissions" {
  description = "List of certificate permissions"
}

variable "role_definition_name" {
  type        = string
  description = "value"
}