variable "name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location/region of the Resource Group"
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