variable "subnet_id" {
  description = "ID of the Subnet"
  type        = string
}

variable "network_security_group_id" {
  description = "ID of the Network Security Group which should be associated with the Subnet"
  type        = string
}
