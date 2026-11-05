variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "identity_ids" {
  type = list(any)
}

variable "sku_name" {
  type = string
}

variable "tier" {
  type = string
}

variable "firewall_policy_id" {
  type = string
}

variable "appgw_ssl_certificate" {
  type = list(any)
}

variable "gateway_ip_configuration_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "frontend_ip_configuration_name" {
  type = string
}

variable "public_ip_address_id" {
  type = string
}

variable "appgw_backend_address_pool" {
  type = list(any)
}

variable "appgw_probe" {
  type = list(any)
}

variable "appgw_backend_http_settings" {
  type = list(any)
}

variable "appgw_http_listener" {
  type = list(any)
}

variable "appgw_request_routing_rule" {
  type = list(any)
}

variable "environment" {
  type = string
}

variable "callcenter" {
  type = string
}

variable "ssl_profile-name" {
  type = string
}

variable "policy_type" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "min_capacity" {
  type = number
}

variable "max_capacity" {
  type = number
}
