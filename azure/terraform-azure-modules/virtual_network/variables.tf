variable "name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group within which the Virtual Network exists"
  type        = string
}

variable "location" {
  description = "Location/region of the Resource Group within where the virtual network is created"
  type        = string
}

variable "address_space" {
  description = "The address prefixes to use for the subnet. Can input more than one address space"
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


