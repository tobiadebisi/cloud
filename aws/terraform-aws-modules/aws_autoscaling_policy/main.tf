resource "aws_autoscaling_policy" "autoscaling_policy" {
  name = var.name
  policy_type = var.policy_type
  autoscaling_group_name = var.autoscaling_group_name
  estimated_instance_warmup = var.estimated_instance_warmup

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    target_value = var.target_value

  }
}