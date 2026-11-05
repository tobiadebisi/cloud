variable "name" {
  type        = string
  description = "value"
}

variable "location" {
  type        = string
  description = "value"
}

variable "resource_group_name" {
  type        = string
  description = "value"
}

variable "environment" {
  description = "Tag that identify resource's environment"
  type        = string
}

variable "callcenter" {
  description = "Tag that identify resource's owner"
  type        = string
}