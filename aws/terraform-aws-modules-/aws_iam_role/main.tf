// Cluster IAM roles and policies
resource "aws_iam_role" "iam_role" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy


  tags = merge(
    {
      CallCenter = "DevOps"
    },
    {
      Terraform = true
    },
  )
}