# Find out the subnet id's of public vpc
data "aws_subnets" "subnets" {
  filter {
	name   = "vpc-id"
	values = [var.default_vpc_id]
  }
}

# # Fetch the ami id
# data "aws_ami" "ami" {
#   most_recent = true
#   name_regex  = "Centos-8-DevOps-Practice"
#   owners      = [973714476881]
# }

# Fetch the own ami id
data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "roboshop-ami-v1"
  owners      = ["940482433230"]
}

# Find the parameter store values for DocDB
data "aws_ssm_parameter" "docdb_master_username" {
  name = "docdb.${var.env}.master_username"
}

data "aws_ssm_parameter" "docdb_master_password" {
  name = "docdb.${var.env}.master_password"
}

# Find the parameters store value for Aurora MySQL
data "aws_ssm_parameter" "rds_master_username" {
  name = "rds.${var.env}.master_username"
}

data "aws_ssm_parameter" "rds_database_name" {
  name = "rds.${var.env}.database_name"
}

data "aws_ssm_parameter" "rds_master_password" {
  name = "rds.${var.env}.master_password"
}

# Find the IP address for Private LB.
data "dns_a_record_set" "main" {
  host = local.private_alb_dns_name
}