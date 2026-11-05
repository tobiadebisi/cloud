variable "owner" {
  type        = string
  description = ""
}

variable "environment" {
  type        = string
  description = ""
}

variable "project" {
  type        = string
  description = ""
}

variable "assume_role_policy_EKSIAMRole" {
  type        = string
  description = ""
}

variable "iam_role_policy_EKSPolicyNLB" {
  type        = string
  description = ""
}

variable "iam_role_policy_EKSPolicyCloudWatchMetrics" {
  type        = string
  description = ""
}

variable "assume_role_policy_NodeInstanceRole" {
  type        = string
  description = ""
}

variable "kubernete_version" {
  type        = number
  description = ""
}

variable "public_key" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = ""
}

variable "associate_public_ip_address" {
  type        = string
  description = ""
}

variable "desired_capacity" {
  type        = number
  description = ""
}

variable "max_size" {
  type        = number
  description = ""
}

variable "min_size" {
  type        = number
  description = ""
}

variable "policy_type" {
  type        = string
  description = ""
}

variable "estimated_instance_warmup" {
  type        = number
  description = ""
}

variable "predefined_metric_type" {
  type        = string
  description = ""
}

variable "target_value" {
  type        = number
  description = ""
}