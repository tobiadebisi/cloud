resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge(
    {
      Name                     = var.public_subnet_name,
      "kubernetes.io/role/elb" = "1"
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
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}