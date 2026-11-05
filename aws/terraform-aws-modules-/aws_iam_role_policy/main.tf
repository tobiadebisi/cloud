resource "aws_iam_role_policy" "iam_role_policy" {
  name   = var.iam_role_policy_name
  role   = var.iam_role_policy_role
  policy = var.iam_role_policy_policy
}