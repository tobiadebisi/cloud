variable "name" {
  description = "(Required) The name of the Container which should be created within the Storage Account"
  type        = string
}

variable "storage_account_id" {
  description = "(Required) The name of the Storage Account where the Container should be created"
  type        = string
}

variable "container_access_type" {
  description = "The Access Level configured for this Container. Possible values are blob, container or private"
  type          = string
}