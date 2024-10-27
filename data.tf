# Find out the subnet id's of public vpc
data "aws_subnets" "subnets" {
  filter {
	name   = "vpc-id"
	values = [var.default_vpc_id]
  }
}

# Find the parameter store values
data "aws_ssm_parameter" "master_username" {
  name = "docdb.${var.env}.master_username"
}

data "aws_ssm_parameter" "master_password" {
  name = "docdb.${var.env}.master_password"
}

