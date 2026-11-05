variable "location" {
  type = string
}

variable "project" {
  type = string
}

variable "allocation_method" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "public_ip_sku" {
  type = string
}

variable "tier" {
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

variable "appgw_ssl_certificate" {
  type = list(any)
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






