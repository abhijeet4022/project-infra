# Create the Infra Network
module "vpc" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-vpc.git"

  for_each          = var.vpc
  tags              = var.tags
  env               = var.env
  cidr_block        = each.value["cidr_block"]
  subnets           = each.value["subnets"]
  vpc_name          = each.key
  default_vpc_id    = var.default_vpc_id
  default_vpc_cidr  = var.default_vpc_cidr
  default_vpc_rt_id = var.default_vpc_rt_id
}


# Deploy the Application Load Balancer.
# module "alb" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-alb.git"
#
#   for_each           = var.alb
#   tags               = var.tags
#   env                = var.env
#   internal           = each.value["internal"]
#   load_balancer_type = each.value["load_balancer_type"]
#   vpc_id             = each.value["internal"] ? local.main_vpc_id : var.default_vpc_id
#   subnets            = each.value["internal"] ? local.app_subnets : local.public_subnets
#   cidr_block         = each.value["cidr_block"]
#   sg_port            = each.value["sg_port"]
# }


# Deploy the DocumentDB.
module "docdb" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-docdb.git"

  for_each                = var.docdb
  env                     = var.env
  tags                    = var.tags
  db_subnets              = local.db_subnets
  app_subnets_cidr        = local.app_subnets_cidr
  engine_family           = each.value["engine_family"]
  vpc_id                  = local.main_vpc_id
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  engine_version          = each.value["engine_version"]
  master_username         = data.aws_ssm_parameter.master_username.value
  master_password         = data.aws_ssm_parameter.master_password.value
  instance_count          = each.value["instance_count"]
  instance_class          = each.value["instance_class"]
}

