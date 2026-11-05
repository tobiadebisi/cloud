variable "callcenter" {
  description = "azure location to deploy resources"
}

variable "environment" {
  description = "kind of environment like staging or prod"
}

variable "project" {
  description = ""
}

variable "location" {
  description = ""
}

variable "account_tier" {
  type        = string
  description = ""
}

variable "account_replication_type" {
  type        = string
  description = ""
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = ""
}

variable "min_tls_version" {
  type        = string
  description = ""
}

variable "container_access_type" {
  type        = string
  description = ""
}