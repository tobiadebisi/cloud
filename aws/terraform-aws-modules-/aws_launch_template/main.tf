resource "aws_launch_template" "launch_template" {
  name = var.launch_template_name
  iam_instance_profile {
    name = var.iam_instance_profile_name
  }
  key_name      = var.ssh_key_name
  instance_type = var.instance_type
  image_id      = var.image_id
  user_data     = var.user_data
  network_interfaces {
    device_index = 0
    security_groups = [
      var.security_groups_1,
      var.security_groups_2
    ]
    associate_public_ip_address = var.associate_public_ip_address
  }

  tags = merge(
    {
      Name = var.launch_template_name
    },
    {
      CallCenter = "DevOps"
    },
    {
      Terraform = true
    },
  )
}