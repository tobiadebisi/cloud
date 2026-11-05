resource "aws_network_acl" "network_acl" {
  vpc_id = var.vpc_id
  tags = merge(
    {
      Name = var.network_acl_name
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