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

# RabbitMQ Variables
variable "rabbitmq" {
  description = "RabbitMQ Config"
}

variable "ssh_subnets_cidr" {
  description = "Jupmhost IP"
}
variable "zone_id" {
  default = "Domain Zone ID"
}

# ASG Module
variable "app" {
  default = "Application ASG module"
}

# Monitoring
variable "prometheus_server_cidr" {
  description = "Provide the prometheus server CIDR"
}
