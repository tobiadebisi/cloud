variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "allocation_method" {
  type = string
}

variable "sku" {
  type = string
}

variable "domain_name_label" {
  type = string
  default = null
}

variable "environment" {
  type = string
}

variable "callcenter" {
  type = string
}
