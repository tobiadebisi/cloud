variable "subnet_id" {
  type        = string
  description = "ID of the Subnet"
}

variable "route_table_id" {
  type        = string
  description = "ID of the Route Table which should be associated with the Subnet"
}