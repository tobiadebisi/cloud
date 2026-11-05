variable "name" {
  description = "Name of the Subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group within which the Network Security Group exists"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network to which to attach the subnet"
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(any)
}

variable "service_endpoints" {
  description = "Service Endpoints"
  type        = list(any)
  default     = null
}

variable "delegation_name" {
  description = "Name of the Service Delegation to which to attach the subnet"
  type        = string
}

variable "service_delegation_name" {
  description = "Name of the Service Delegation to which to attach the subnet"
  type        = string
}

variable "actions" {
  description = "The address prefixes to use for the subnet"
  type        = list(any)
}