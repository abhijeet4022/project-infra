variable "vpc" {}
variable "default_vpc_id" {}
variable "default_vpc_cidr" {}
variable "default_vpc_rt_id" {}
variable "tags" {}
variable "env" {}

variable "alb" {
  description = "A configuration map for the ALB (Application Load Balancer) module, containing details such as type, subnets, security group, and CIDR blocks for allowed traffic."
}

variable "docdb" {
  description = "A configuration map for the DocumentDB module, including settings such as engine version, VPC details, and subnet groups for deployment."
}

variable "aurora" {
  description = "Aurora SQL DB configuration"
}

variable "elasticache" {
  description = "Redis Elasticache Config"
}