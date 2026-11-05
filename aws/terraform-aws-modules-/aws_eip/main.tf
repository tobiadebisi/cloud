resource "aws_eip" "eip" {
  vpc = true
  tags = merge(
    {
      Name = var.eip_name
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