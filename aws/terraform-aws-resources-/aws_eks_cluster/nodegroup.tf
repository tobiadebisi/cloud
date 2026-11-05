// Nodegroup IAM roles and policies
module "NodeInstanceRole" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role"
  version = "1.0.0"
  iam_role_name      = "${var.owner}${var.environment}NodeInstanceRole"
  assume_role_policy = var.assume_role_policy_NodeInstanceRole
}

module "AmazonEKSWorkerNodePolicy" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy_attachment"
  version = "1.0.0"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = module.NodeInstanceRole.iam_role_name
}

module "AmazonEKS_CNI_Policy" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy_attachment"
  version = "1.0.0"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = module.NodeInstanceRole.iam_role_name
}

module "AmazonEC2ContainerRegistryReadOnly" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy_attachment"
  version = "1.0.0"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = module.NodeInstanceRole.iam_role_name
}


// Instance profile
module "node_iam_instance_profile" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_instance_profile"
  version = "1.0.0"
  name = "${var.owner}${var.environment}EKSInstanceProfile"
  role = module.NodeInstanceRole.iam_role_name
}


// Security groups and rules
module "NodeGroupSecurityGroup" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group"
  version = "1.0.0"
  name        = "${var.owner}${var.environment}NodeGroupSecurityGroup"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = data.aws_vpc.vpc_id.id
  environment = var.environment
}

module "EgressInterCluster" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "egress"
  description              = "Allow control plane to communicate with worker nodes in group (kubelet and workload TCP ports)"
  security_group_id        = module.ControlPlaneSecurityGroup.security_group_id
  source_security_group_id = module.NodeGroupSecurityGroup.security_group_id
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
}

module "EgressNodeGroupAllowAll" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_cidr_blocks"
  version = "1.0.0"

  type                     = "egress"
  description              = "Allow Egress Node Group"
  security_group_id        = module.NodeGroupSecurityGroup.security_group_id
  cidr_blocks              = ["0.0.0.0/0"]
  ipv6_cidr_blocks         = null
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

module "EgressInterClusterAPI" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "egress"
  description              = "Allow control plane to communicate with worker nodegroup (workloads using HTTPS port, commonly used with extension API servers)"
  security_group_id        = module.ControlPlaneSecurityGroup.security_group_id
  source_security_group_id = module.NodeGroupSecurityGroup.security_group_id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

module "IngressInterCluster" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow worker nodegroup to communicate with control plane (kubelet and workload TCP ports)"
  security_group_id        = module.NodeGroupSecurityGroup.security_group_id
  source_security_group_id = module.ControlPlaneSecurityGroup.security_group_id
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
}

module "IngressInterClusterAPI" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow worker nodegroup to communicate with control plane (workloads using HTTPS port, commonly used with extension API servers)"
  security_group_id        = module.NodeGroupSecurityGroup.security_group_id
  source_security_group_id = module.ControlPlaneSecurityGroup.security_group_id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

module "IngressInterClusterCP" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow control plane to receive API requests from worker nodegroup"
  security_group_id        = module.ControlPlaneSecurityGroup.security_group_id
  source_security_group_id = module.NodeGroupSecurityGroup.security_group_id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

module "SSHIPv4" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_cidr_blocks"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow SSH access to worker nodegroup"
  security_group_id        = module.NodeGroupSecurityGroup.security_group_id
  cidr_blocks              = ["0.0.0.0/0"]
  ipv6_cidr_blocks         = null
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

module "SSHIPv6" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_cidr_blocks"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow SSH access to worker nodegroup"
  security_group_id        = module.NodeGroupSecurityGroup.security_group_id
  ipv6_cidr_blocks         = ["::/0"]
  cidr_blocks              = null
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

module "NodeKeyPair" {
  source = "app.terraform.io/quidax/modules/aws/aws_key_pair"
  version = "1.0.0"  

  key_name = "${var.environment}EKSNodeKeyPair"
  public_key = var.public_key
  environment = var.environment
}

// Grab the latest AMI

data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu-eks/k8s_${var.kubernete_version}/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// Create the user-data field
locals {
  node_group_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks_cluster.eks_cluster_endpoint}' --b64-cluster-ca '${module.eks_cluster.eks_cluster_certificate_authority_data}' '${module.eks_cluster.eks_cluster_name}'
USERDATA
}

// Launch template

module "NodeGroupLaunchTemplate" {
  source = "app.terraform.io/quidax/modules/aws/aws_launch_template"
  version = "1.0.0"
  launch_template_name        = "${var.environment}NodeGroupLaunchTemplate"
  iam_instance_profile_name   = module.node_iam_instance_profile.iam_instance_profile_name
  ssh_key_name                = module.NodeKeyPair.key_pair
  instance_type               = var.instance_type
  image_id                    = data.aws_ami.latest_ubuntu.image_id
  user_data                   = base64encode(local.node_group_userdata)
  security_groups_1           = module.ClusterSharedNodeSecurityGroup.security_group_id
  security_groups_2           = module.NodeGroupSecurityGroup.security_group_id
  associate_public_ip_address = var.associate_public_ip_address
}

// Autoscaling Group
module "autoscaling_group" {
  source = "app.terraform.io/quidax/modules/aws/aws_autoscaling_group"
  version = "1.0.0"
  name = "${var.environment}AutoScalingGroup-${random_id.prefix.id}"
  # aws_launch_template = aws_launch_template.NodeGroupLaunchTemplate.id
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  subnet_a_id        = data.aws_subnet.public_subnet_a.id
  subnet_b_id        = data.aws_subnet.public_subnet_b.id
  subnet_c_id        = data.aws_subnet.public_subnet_c.id
  launch_template_id = module.NodeGroupLaunchTemplate.launch_template_id
  key                = "kubernetes.io/cluster/${module.eks_cluster.eks_cluster_name}"
  environment        = var.environment
}

module "aws_autoscaling_policy" {
  source = "app.terraform.io/quidax/modules/aws/aws_autoscaling_policy"
  version = "1.0.0"
  name = "${var.environment}AutoScalingPolicy-${random_id.prefix.id}"
  policy_type = var.policy_type
  autoscaling_group_name = module.autoscaling_group.autoscaling_group_name
  estimated_instance_warmup = var.estimated_instance_warmup
  predefined_metric_type = var.predefined_metric_type
  target_value = var.target_value
}