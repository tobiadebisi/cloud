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

variable "location" {
  type = string
}

variable "local_project" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "callcenter" {
  type = string
}