variable "name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "Location/region of the Resource Group within which the Network Security Group exists"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group within which the Network Security Group exists"
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

variable "nsg_rule" {
  description = "List of security rule objects representing security rules"
  type = list(object({
    name                       = string
    direction                  = string
    access                     = string
    priority                   = number
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}