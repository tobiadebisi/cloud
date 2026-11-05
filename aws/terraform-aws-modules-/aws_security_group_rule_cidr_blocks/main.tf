resource "aws_security_group_rule" "security_group_rule" {
  type                     = var.type
  description              = var.description
  security_group_id        = var.security_group_id
  cidr_blocks              = var.cidr_blocks
  ipv6_cidr_blocks         = var.ipv6_cidr_blocks
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
}