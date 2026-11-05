// Random ID
resource "random_id" "prefix" {
  byte_length = 4
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}VPC"]    
  }
}

data "aws_subnet" "private_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[0]}"]    
  }
}

data "aws_subnet" "private_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[1]}"]    
  }
}

data "aws_subnet" "private_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[2]}"]    
  }
}

data "aws_subnet" "public_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[0]}"]    
  }
}

data "aws_subnet" "public_subnet_b" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[1]}"]    
  }
}

data "aws_subnet" "public_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[2]}"]    
  }
}

// Cluster IAM roles and policies
module "EKSIAMRole" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role"
  version = "1.0.0"
  iam_role_name      = "${var.owner}${var.environment}EKSIAMRole"
  assume_role_policy = var.assume_role_policy_EKSIAMRole
}

module "AmazonEKSClusterPolicy" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy_attachment"
  version = "1.0.0"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = module.EKSIAMRole.iam_role_name
}

module "AmazonEKSServicePolicy" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy_attachment"
  version = "1.0.0" 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = module.EKSIAMRole.iam_role_name
}

module "PolicyNLB" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy"
  version = "1.0.0" 
  iam_role_policy_name   = "${var.owner}${var.environment}EKSPolicyNLB"
  iam_role_policy_role   = module.EKSIAMRole.iam_role_name
  iam_role_policy_policy = var.iam_role_policy_EKSPolicyNLB
}

module "PolicyCloudWatchMetrics" {
  source = "app.terraform.io/quidax/modules/aws/aws_iam_role_policy"
  version = "1.0.0"
  iam_role_policy_name   = "${var.owner}${var.environment}EKSPolicyCloudWatchMetrics"
  iam_role_policy_role   = module.EKSIAMRole.iam_role_name
  iam_role_policy_policy = var.iam_role_policy_EKSPolicyCloudWatchMetrics
}

// Security groups and rules
module "ControlPlaneSecurityGroup" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group"
  version = "1.0.0"
  name        = "${var.owner}${var.environment}EKSControlPlaneSecurityGroup"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = data.aws_vpc.vpc_id.id
  environment = var.environment
}

module "ClusterSharedNodeSecurityGroup" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group"
  version = "1.0.0"
  name        = "${var.owner}${var.environment}EKSClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = data.aws_vpc.vpc_id.id
  environment = var.environment
}

module "IngressDefaultClusterToNodeSG" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow managed and unmanaged nodes to communicate with each other (all ports)"
  security_group_id        = module.ClusterSharedNodeSecurityGroup.security_group_id
  source_security_group_id = module.eks_cluster.eks_cluster_security_group_id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
}

module "IngressInterNodeGroupSG" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow nodes to communicate with each other (all ports)"
  security_group_id        = module.ClusterSharedNodeSecurityGroup.security_group_id
  source_security_group_id = module.ClusterSharedNodeSecurityGroup.security_group_id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
}

module "IngressNodeToDefaultClusterSG" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_source_sg_id"
  version = "1.0.0"
  type                     = "ingress"
  description              = "Allow unmanaged nodes to communicate with control plane (all ports)"
  security_group_id        = module.eks_cluster.eks_cluster_security_group_id
  source_security_group_id = module.ClusterSharedNodeSecurityGroup.security_group_id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
}

module "EgressClusterSharedNodeAllowAll" {
  source = "app.terraform.io/quidax/modules/aws/aws_security_group_rule_cidr_blocks"
  version = "1.0.0"
  type                     = "egress"
  description              = "Allow Cluster Shared Node Security Group"
  security_group_id        = module.ClusterSharedNodeSecurityGroup.security_group_id
  cidr_blocks              = ["0.0.0.0/0"]
  ipv6_cidr_blocks         = null
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

// Cluster
module "eks_cluster" {
  source = "app.terraform.io/quidax/modules/aws/aws_eks_cluster"
  version = "1.0.0"
  name                = "${var.environment}EKS-${random_id.prefix.id}"
  role_arn            = module.EKSIAMRole.iam_role_arn
  kubernete_version   = var.kubernete_version
  security_group_ids  = [module.ControlPlaneSecurityGroup.security_group_id]
  private_subnet_a_id = data.aws_subnet.private_subnet_a.id
  private_subnet_b_id = data.aws_subnet.private_subnet_b.id
  private_subnet_c_id = data.aws_subnet.private_subnet_c.id
  public_subnet_a_id  = data.aws_subnet.public_subnet_a.id
  public_subnet_b_id  = data.aws_subnet.public_subnet_b.id
  public_subnet_c_id  = data.aws_subnet.public_subnet_c.id
  environment         = var.environment

  depends_on = [
    module.AmazonEKSClusterPolicy,
    module.AmazonEKSServicePolicy
  ]
}