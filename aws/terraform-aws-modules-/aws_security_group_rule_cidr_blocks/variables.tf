variable "type" {
  type        = string
  description = "value"
}

variable "description" {
  type        = string
  description = "value"
}

variable "security_group_id" {
  type        = string
  description = "value"
  nullable    = true
}

variable "cidr_blocks" {
  type        = list(string)
  description = "value"
  nullable    = true
}

variable "ipv6_cidr_blocks" {
  type        = list(string)
  description = "value"
  nullable    = true
}

variable "from_port" {
  type        = number
  description = "value"
}

variable "to_port" {
  type        = number
  description = "value"
}

variable "protocol" {
  type        = string
  description = "value"
}