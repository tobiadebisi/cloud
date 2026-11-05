variable "name" {
  description = "Container Registry Webhook's name" #Required
  type        = string
}

variable "resource_group_name" {
  description = "Location of the Resource Group within which the Container Registry Webhook exists" #Required
  type        = string
}

variable "registry_name" {
  description = "The Name of Container registry this Webhook belongs to. Changing this forces a new resource to be created" #Required
  type        = string
}

variable "location" {
  description = "Name of the Resource Group within which the Container Registry Webhook exists" #Required
  type        = string
}

variable "service_uri" {
  description = "the service URI for the Webhook to post notifications." #Required
  type        = string
}

variable "status" {
  type        = string
  description = "Enabled Webhook to triggers notifications or not"
}

variable "actions" {
  type        = list(any)
  description = "A list of actions that trigger the Webhook to post notifications" #Required
}