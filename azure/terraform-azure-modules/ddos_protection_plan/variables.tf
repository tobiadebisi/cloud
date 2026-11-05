variable "network_ddos_protection_plan_name" {
  description = "Distributed dinal-of-service plan name for the vnet"
  type        = string
}

variable "network_ddos_protection_plan_resource_group_location" {
  description = "Location of the Resource Group within which the Network DDOS Protection Plan exists"
  type        = string
}

variable "network_ddos_protection_plan_resource_group_name" {
  description = "Name of the Resource Group within which the Network DDOS Protection Plan exists"
  type        = string
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type           = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}

