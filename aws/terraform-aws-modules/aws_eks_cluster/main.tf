resource "aws_eks_cluster" "eks_cluster" {
  name     = var.name
  role_arn = var.role_arn
  version  = var.kubernete_version

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids = [
      var.private_subnet_a_id,
      var.private_subnet_b_id,
      var.private_subnet_c_id,
      var.public_subnet_a_id,
      var.public_subnet_b_id,
      var.public_subnet_c_id
    ]
  }
  tags = merge(
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