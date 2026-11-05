output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "default_network_acl_id" {
  value = aws_vpc.vpc.default_network_acl_id
}