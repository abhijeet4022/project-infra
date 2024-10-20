# Create the Infra Network
module "vpc" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-vpc.git"

  for_each       = var.vpc
  cidr_block     = each.value["cidr_block"]
  subnets        = each.value["subnets"]
  vpc_name       = each.key
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
}


