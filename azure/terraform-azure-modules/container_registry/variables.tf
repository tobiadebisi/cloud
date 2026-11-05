variable "name" {
  description = "Container Registry's name"
  type        = string
}

variable "resource_group_name" {
  description = "Location of the Resource Group within which the Container Registry exists"
  type        = string
}

variable "location" {
  description = "Name of the Resource Group within which the Container Registry exists"
  type        = string
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium. Classic"
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
