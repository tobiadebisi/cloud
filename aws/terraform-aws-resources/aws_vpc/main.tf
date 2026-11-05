// Random ID
resource "random_id" "prefix" {
    keepers = {
    # Generate a new id each time we switch to a new AMI id
    cidr_block  = var.vpc_cidr_block
  }

  byte_length = 4
}

// Get the availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

// VPC build
module "vpc" {
  source = "app.terraform.io/organization-name/modules/aws/aws_vpc"
  version = "1.0.0"
  cidr_block  = var.vpc_cidr_block
  vpc_name    = "${var.environment}${var.project}VPC"
  environment = var.environment
}

// Public and private subnets
module "private_subnet_a" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_subnet"
  version = "1.0.0"
  vpc_id              = module.vpc.vpc_id
  cidr_block          = var.private_subnet_a_cidr_block
  availability_zone   = data.aws_availability_zones.available.names[0]
  private_subnet_name = "${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[0]}"
  environment         = var.environment
}

module "private_subnet_b" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_subnet"
  version = "1.0.0"
  vpc_id              = module.vpc.vpc_id
  cidr_block          = var.private_subnet_b_cidr_block
  availability_zone   = data.aws_availability_zones.available.names[1]
  private_subnet_name = "${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[1]}"
  environment         = var.environment
}

module "private_subnet_c" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_subnet"
  version = "1.0.0"
  vpc_id              = module.vpc.vpc_id
  cidr_block          = var.private_subnet_c_cidr_block
  availability_zone   = data.aws_availability_zones.available.names[2]
  private_subnet_name = "${var.environment}${var.project}PrivateSubnet-${data.aws_availability_zones.available.names[2]}"
  environment         = var.environment
}

module "public_subnet_a" {
  source = "app.terraform.io/organization-name/modules/aws/aws_public_subnet"
  version = "1.0.0"
  vpc_id             = module.vpc.vpc_id
  cidr_block         = var.public_subnet_a_cidr_block
  availability_zone  = data.aws_availability_zones.available.names[0]
  public_subnet_name = "${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[0]}"
  environment        = var.environment
}

module "public_subnet_b" {
  source = "app.terraform.io/organization-name/modules/aws/aws_public_subnet"
  version = "1.0.0"
  vpc_id             = module.vpc.vpc_id
  cidr_block         = var.public_subnet_b_cidr_block
  availability_zone  = data.aws_availability_zones.available.names[1]
  public_subnet_name = "${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[1]}"
  environment        = var.environment
}

module "public_subnet_c" {
  source = "app.terraform.io/organization-name/modules/aws/aws_public_subnet"
  version = "1.0.0"
  vpc_id             = module.vpc.vpc_id
  cidr_block         = var.public_subnet_c_cidr_block
  availability_zone  = data.aws_availability_zones.available.names[2]
  public_subnet_name = "${var.environment}${var.project}PublicSubnet-${data.aws_availability_zones.available.names[2]}"
  environment        = var.environment
}

// Internet gateway
module "internet_gateway" {
  source = "app.terraform.io/organization-name/modules/aws/aws_internet_gateway"
  version = "1.0.0"
  vpc_id                = module.vpc.vpc_id
  internet_gateway_name = "${var.environment}${var.project}InternetGateway-${random_id.prefix.hex}"
  environment           = var.environment
}

// Elastic IP for the NAT gateway
module "eip" {
  source = "app.terraform.io/organization-name/modules/aws/aws_eip"
  version = "1.0.0"
  eip_name    = "${var.environment}${var.project}EIP-${random_id.prefix.hex}"
  environment = var.environment
}

// NAT gateway
module "nat_gateway" {
  source = "app.terraform.io/organization-name/modules/aws/aws_nat_gateway"
  version = "1.0.0"
  eip_id           = module.eip.eip_id
  subnet_id        = module.private_subnet_a.private_subnet_id
  nat_gateway_name = "${var.environment}${var.project}NATGateway-${random_id.prefix.hex}"
  environment      = var.environment
}

// Route tables and subnet associations
module "private_route_table_a" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_route_table"
  version = "1.0.0"
  vpc_id = module.vpc.vpc_id
  nat_gateway_id           = module.nat_gateway.nat_gateway_id
  private_route_table_name = "${var.environment}${var.project}PrivateRouteTableA-${random_id.prefix.hex}"
  environment              = var.environment
}

module "private_route_table_b" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_route_table"
  version = "1.0.0"
  vpc_id = module.vpc.vpc_id
  nat_gateway_id           = module.nat_gateway.nat_gateway_id
  private_route_table_name = "${var.environment}${var.project}PrivateRouteTableB-${random_id.prefix.hex}"
  environment              = var.environment
}

module "private_route_table_c" {
  source = "app.terraform.io/organization-name/modules/aws/aws_private_route_table"
  version = "1.0.0"
  vpc_id = module.vpc.vpc_id
  nat_gateway_id           = module.nat_gateway.nat_gateway_id
  private_route_table_name = "${var.environment}${var.project}PrivateRouteTableC-${random_id.prefix.hex}"
  environment              = var.environment
}

module "public_route_table" {
  source = "app.terraform.io/organization-name/modules/aws/aws_public_route_table"
  version = "1.0.0"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id     = module.nat_gateway.nat_gateway_id
  public_route_table_name = "${var.environment}${var.project}PublicRouteTable-${random_id.prefix.hex}"
  environment             = var.environment
}

module "private_table_association_a" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.private_subnet_a.private_subnet_id
  route_table_id = module.private_route_table_a.private_route_table_id
}

module "private_table_association_b" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.private_subnet_b.private_subnet_id
  route_table_id = module.private_route_table_b.private_route_table_id
}

module "private_table_association_c" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.private_subnet_c.private_subnet_id
  route_table_id = module.private_route_table_c.private_route_table_id
}

module "public_table_assoc_association_a" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.public_subnet_a.public_subnet_id
  route_table_id = module.public_route_table.public_route_table_id
}

module "public_table_assoc_association_b" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.public_subnet_b.public_subnet_id
  route_table_id = module.public_route_table.public_route_table_id
}

module "public_table_assoc_association_c" {
  source = "app.terraform.io/organization-name/modules/aws/aws_route_table_association"
  version = "1.0.0"
  subnet_id      = module.public_subnet_c.public_subnet_id
  route_table_id =module.public_route_table.public_route_table_id
}

module "default_network_acl" {
  source = "app.terraform.io/organization-name/modules/aws/aws_default_network_acl"
  version = "1.0.0"
  default_network_acl_id =  module.vpc.default_network_acl_id
  default_network_acl_name = "${var.environment}${var.project}DefaultNetworkACL-${random_id.prefix.hex}" 
  environment = var.environment
}
/*
module "network_acl_rule_ingress" {
  source = "app.terraform.io/organization-name/modules/aws/aws_network_acl"
  //version = "1.0.0"
  for_each = var.ingress_cidr_block

  network_acl_id = module.default_network_acl.default_network_acl_id
  rule_number    = var.rule_number
  egress         = false
  protocol       = -1
  rule_action    = "deny"
  from_port      = 0
  to_port        = 0
}

module "network_acl_rule_egress" {
  source = "app.terraform.io/organization-name/modules/aws/aws_network_acl"
  //version = "1.0.0"
  for_each = var.egress_cidr_block

  network_acl_id = module.default_network_acl.default_network_acl_id
  rule_number    = var.rule_number
  egress         = true
  protocol       = -1
  rule_action    = "deny"
  from_port      = 0
  to_port        = 0
}
*/