variable "client_config_object_id" {
  description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault"
  type        = string
}

variable "client_config_tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}

variable "key_vault_id" {
  description = "The id of the Key Vault resource"
  type        = string
}

variable "key_permissions" {
  description = "List of key permissions"
  type        = list(any)
}

variable "secret_permissions" {
  description = "List of secret permissions"
  type        = list(any)
}

variable "storage_permissions" {
  description = "List of storage permissions"
  type        = list(any)
}

variable "certificate_permissions" {
  description = "List of certificate permissions"
  type        = list(any)
}