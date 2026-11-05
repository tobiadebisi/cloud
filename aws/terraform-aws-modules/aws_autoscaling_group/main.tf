resource "random_id" "prefix" {
  byte_length = 4
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = var.name
  # aws_launch_template = aws_launch_template.NodeGroupLaunchTemplate.id
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  vpc_zone_identifier = [
    var.subnet_a_id,
    var.subnet_b_id,
    var.subnet_c_id
  ]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "EKSNode-${random_id.prefix.id}"
    propagate_at_launch = true
  }

  tag {
    key                 = var.key //"kubernetes.io/cluster/${aws_eks_cluster.ControlPlane.name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
  tag {
    key                 = "CallCenter"
    value               = "DevOps"
    propagate_at_launch = true
  }
}