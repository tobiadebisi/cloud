resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = var.vpc_name
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