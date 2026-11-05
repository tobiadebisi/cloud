resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id
  tags = merge(
    {
      Name = var.nat_gateway_name
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