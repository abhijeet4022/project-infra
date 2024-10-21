data "aws_subnets" "subnets" {
  filter {
	name   = "vpc-id"
	values = [var.default_vpc_id]
  }
}

output "d" {
  value = data.aws_subnets.subnets.id
}