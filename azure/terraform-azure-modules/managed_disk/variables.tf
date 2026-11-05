variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "create_option" {
  type = string
}

variable "disk_size_gb" {
  type    = number
  default = 1
}

variable "environment" {
  type = string
}

variable "callcenter" {
  type = string
}