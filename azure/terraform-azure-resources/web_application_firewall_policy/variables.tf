variable "project" {
  type = string
  description = "value"
}

variable "location" {
  type = string
  description = "value"
}

variable "environment" {
  type = string
  description = "value"
}

variable "callcenter" {
  type = string
  description = "value"
}

variable "enabled" {
  type = bool
  description = "value"
}

variable "mode" {
  type = string
  description = "value"
}

variable "request_body_check" {
  type = bool
  description = "value"
}

variable "file_upload_limit_in_mb" {
  type = number
  description = "value"
}

variable "max_request_body_size_in_kb" {
  type = number
  description = "value"
}

variable "managed_rule_set_type" {
  type = string
  description = "value"
}

variable "managed_rule_set_version" {
  type = string
  description = "value"
}

variable "priority" {
  type        = number
  description = "value"
}

variable "rule_type" {
  type        = string
  description = "value"
}

variable "variable_name" {
  type        = string
  description = "value"
}

variable "operator" {
  type        = string
  description = "value"
}

variable "negation_condition" {
  type        = bool
  description = "value"
}

variable "match_values" {
  type        = list(any)
  description = "value"
}

variable "action" {
  type        = string
  description = "value"
}