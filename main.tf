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
module "alb" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-alb.git"

  for_each           = var.alb
  tags               = var.tags
  env                = var.env
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]
  vpc_id             = each.value["internal"] ? local.main_vpc_id : var.default_vpc_id
  subnets            = each.value["internal"] ? local.app_subnets : local.public_subnets
  cidr_block         = each.value["cidr_block"]
  sg_port            = each.value["sg_port"]
}


# Deploy the Application ASG.
module "app" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-app.git"

  tags             = var.tags
  env              = var.env
  ssh_subnets_cidr = var.ssh_subnets_cidr
  zone_id          = var.zone_id

  for_each         = var.app
  app_port         = each.value["app_port"]
  component        = each.key
  instance_type    = each.value["instance_type"]
  max_size         = each.value["max_size"]
  min_size         = each.value["min_size"]
  desired_capacity = each.value["desired_capacity"]
  lb_priority      = each.value["lb_priority"]

  vpc_id               = local.main_vpc_id
  app_subnets_cidr     = local.app_subnets_cidr
  app_subnets          = local.app_subnets
  private_listener_arn = local.private_listener_arn
  private_alb_dns_name = local.private_alb_dns_name
  public_alb_dns_name  = local.public_alb_dns_name
  image_id             = data.aws_ami.ami.id

}


# Deploy the DocumentDB.
# module "docdb" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-docdb.git"
#
#   for_each                = var.docdb
#   env                     = var.env
#   tags                    = var.tags
#   db_subnets              = local.db_subnets
#   app_subnets_cidr        = local.app_subnets_cidr
#   engine_family           = each.value["engine_family"]
#   vpc_id                  = local.main_vpc_id
#   backup_retention_period = each.value["backup_retention_period"]
#   preferred_backup_window = each.value["preferred_backup_window"]
#   skip_final_snapshot     = each.value["skip_final_snapshot"]
#   engine_version          = each.value["engine_version"]
#   master_username         = data.aws_ssm_parameter.docdb_master_username.value
#   master_password         = data.aws_ssm_parameter.docdb_master_password.value
#   instance_count          = each.value["instance_count"]
#   instance_class          = each.value["instance_class"]
# }

# Deploy the Aurora SQL DB.
# module "aurora" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-aurorasql.git"
#
#   for_each                = var.aurora
#   env                     = var.env
#   tags                    = var.tags
#   app_subnets_cidr        = local.app_subnets_cidr
#   vpc_id                  = local.main_vpc_id
#   db_subnets              = local.db_subnets
#   rds_type                = each.value["rds_type"]
#   engine_family           = each.value["engine_family"]
#   port                    = each.value["port"]
#   engine                  = each.value["engine"]
#   engine_version          = each.value["engine_version"]
#   backup_retention_period = each.value["backup_retention_period"]
#   preferred_backup_window = each.value["preferred_backup_window"]
#   database_name           = data.aws_ssm_parameter.rds_database_name.value
#   master_username         = data.aws_ssm_parameter.rds_master_username.value
#   master_password         = data.aws_ssm_parameter.rds_master_password.value
#   skip_final_snapshot     = each.value["skip_final_snapshot"]
#   instance_count          = each.value["instance_count"]
#   instance_class          = each.value["instance_class"]
# }


# Deploy Redis Elasticache.
# module "elasticache" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-elasticache.git"
#
#   for_each         = var.elasticache
#   env              = var.env
#   tags             = var.tags
#   db_subnets       = local.db_subnets
#   vpc_id           = local.main_vpc_id
#   app_subnets_cidr = local.app_subnets_cidr
#   elasticache_type = each.value["elasticache_type"]
#   engine_family    = each.value["engine_family"]
#   port             = each.value["port"]
#   engine           = each.value["engine"]
#   node_type        = each.value["node_type"]
#   num_cache_nodes  = each.value["num_cache_nodes"]
#   engine_version   = each.value["engine_version"]
# }


# Deploy RabbitMQ
# module "rabbitmq" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-rabbitmq.git"
#
#   for_each         = var.rabbitmq
#   tags             = var.tags
#   env              = var.env
#   zone_id          = var.zone_id
#   vpc_id           = local.main_vpc_id
#   ssh_subnets_cidr = var.ssh_subnets_cidr
#   app_subnets_cidr = local.app_subnets_cidr
#   db_subnets       = local.db_subnets
#   ami_id           = data.aws_ami.ami.id
#   instance_type    = each.value["instance_type"]
# }

