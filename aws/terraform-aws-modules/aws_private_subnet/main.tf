resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false
  tags = merge(
    {
      Name                              = var.private_subnet_name,
      "kubernetes.io/role/internal-elb" = "1"
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