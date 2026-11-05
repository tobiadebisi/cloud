variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "callcenter" {
  type = string
}

variable "project" {
  type = string
}

variable "address_space" {
  type = list(any)
}

variable "cardholder_address_prefixes" {
  type = list(any)
}

variable "internal_address_prefixes" {
  type = list(any)
}

variable "application_gateway_address_prefixes" {
  type = list(any)
}

variable "apim_address_prefixes" {
  type = list(any)
}

variable "mssql_server_address_prefixes" {
  type = list(any)
}

variable "sonarqube_subnet_variable" {
  type = map(object({
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string), null)
 }))
description = "A map of subnets without delegation."
}

variable "cardholder_nsg_rule" {
  type = list(any)
}

variable "internal_nsg_rule" {
  type = list(any)
}

variable "application_gateway_nsg_rule" {
  type = list(any)
}

variable "apim_nsg_rule" {
  type = list(any)
}

variable "mssql_server_nsg_rule" {
  type = list(any)
}

variable "sonarqube_nsg_rule" {
  type = list(any)
}

variable "service_endpoints" {
  description = "Service Endpoints"
  type        = list(any)
  default     = null
}

variable "mssql_server_service_endpoints" {
  description = "Service Endpoints"
  type        = list(any)
  default     = null
}