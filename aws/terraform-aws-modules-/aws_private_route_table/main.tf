resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = merge(
    {
      Name = var.private_route_table_name,
    },
    {
      Environment = var.environment
    },
    {
      CallCenter = "DevOps"
    },
    {
      Terraform = true
    },
  )
}