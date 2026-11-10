owner = "organisation-name"

environment = "Staging"

project = "Infra"

assume_role_policy_EKSIAMRole = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

iam_role_policy_EKSPolicyNLB = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "elasticloadbalancing:*",
                "ec2:CreateSecurityGroup",
                "ec2:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF

iam_role_policy_EKSPolicyCloudWatchMetrics = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF

assume_role_policy_NodeInstanceRole = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

kubernete_version = "1.22"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZXKXNJF2tEDZaxNyWxc/dcG2um0maFiQTbYeXaFcxO+pXXQQiyZZgJcl+ATX3edUvrlkVDQNuQsRLq+9vhy+RqXYfstMRdYV/P5RJdLClKmndhVGfmKHVTe3gI+OSKHiT7OREfYMyOWTSgx0K5TfcxGjXRzzTbmsaB8G1jpu1MvNdGCUnJqnykKo60K6MhNJOJoljOcHGWQvVwv1flIKhTOMd4H/NsIcAg9PSaWef6Itlyp7wUxGcmPr4FZkXO09nEZQw9QPI2nMziZZH4cU7LHAbRSkJ1dDr8Vd7yGDcgJlYfQO/f4q4+IZGlUc4gCtOn3LA4Z0L4xjnYp39vTsqJCmDJd7WFTM0mUtXxtAisSa5nxMBG+pBeBUDlDhXa/g4ZZCHr1eQYWbFHRO51YmvyO0+u7gn6vDIghQn4+kfXt42ajTj0kD5Q/2u4nUDrn4xD+oCsSSF4W1dCxCHZyQ3LrP/5C//JXVGishB3XddUFN+q0u3kpms5OUoaZi6uDU= service_terraform_enterprise"

instance_type = "m5.2xlarge"

associate_public_ip_address = true

desired_capacity = 2

max_size = 2

min_size = 1

policy_type = "TargetTrackingScaling"

estimated_instance_warmup = 200

predefined_metric_type = "ASGAverageCPUUtilization"

target_value = 70.0