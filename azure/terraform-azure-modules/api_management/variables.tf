variable "name" {
  description = "Name of the API Management"
  type        = string
}

variable "location" {
  description = "Location of the Resource Group within which the API Management exists"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group within which the API Management exists"
  type        = string
}

variable "publisher_name" {
  description = "(Required) The name of publisher/company"
  type        = string
}

variable "publisher_email" {
  description = "(Required) The email of publisher/company"
  type        = string
}

variable "sku_name" {
  description = "(Required) This indicate Consumption like Developer, Basic, Standard and Premium and capacity"
  type        = string
}

variable "virtual_network_type" {
  description = "Tag that identify resource's owner"
  type        = string
}

variable "subnet_id" {
  description = "Tag that identify resource's owner"
  type        = string
}

variable "public_ip_address_id" {
  description = "Tag that identify resource's owner"
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

variable "identity_ids" {
  description = "Tag that identify resource's owner"
  type        = list(any)
}

variable "apim_developer_portal" {
  description = "Tag that identify resource's owner"
  type        = list(any)
}

variable "apim_management" {
  description = "Tag that identify resource's owner"
  type        = list(any)
}

variable "apim_proxy" {
  description = "Tag that identify resource's owner"
  type        = list(any)
}