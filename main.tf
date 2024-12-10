# Create AMI for the project.
# module "ami" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-ami.git"
#
# }


# Create the Infra Network
module "vpc" {
  source = "git::https://github.com/abhijeet4022/terraform-aws-vpc.git"

  tags              = var.tags
  env               = var.env
  default_vpc_id    = var.default_vpc_id
  default_vpc_cidr  = var.default_vpc_cidr
  default_vpc_rt_id = var.default_vpc_rt_id

  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]
  vpc_name   = each.key

}

#
# # Deploy the Application Load Balancer.
# module "alb" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-alb.git"
#
#   tags = var.tags
#   env  = var.env
#   acm  = var.acm
#
#   for_each           = var.alb
#   internal           = each.value["internal"]
#   load_balancer_type = each.value["load_balancer_type"]
#   vpc_id             = each.value["internal"] ? local.main_vpc_id : var.default_vpc_id
#   subnets            = each.value["internal"] ? local.app_subnets : local.public_subnets
#   cidr_block         = each.value["cidr_block"]
#   sg_port            = each.value["sg_port"]
# }
#
#
# # # Deploy the Application ASG.
# # module "app" {
# #   source = "git::https://github.com/abhijeet4022/terraform-aws-app.git"
# #
# #   tags                   = merge(var.tags, each.value["tags"])
# #   env                    = var.env
# #   ssh_subnets_cidr       = var.ssh_subnets_cidr
# #   zone_id                = var.zone_id
# #   default_vpc_id         = var.default_vpc_id
# #   prometheus_server_cidr = var.prometheus_server_cidr
# #   kms_key_id             = var.kms_key_id
# #
# #   for_each         = var.app
# #   app_port         = each.value["app_port"]
# #   component        = each.key
# #   instance_type    = each.value["instance_type"]
# #   max_size         = each.value["max_size"]
# #   min_size         = each.value["min_size"]
# #   desired_capacity = each.value["desired_capacity"]
# #   lb_priority      = each.value["lb_priority"]
# #   parameters       = each.value["parameters"]
# #
# #   vpc_id                 = local.main_vpc_id
# #   app_subnets_cidr       = local.app_subnets_cidr
# #   app_subnets            = local.app_subnets
# #   private_listener_arn   = local.private_listener_arn
# #   private_alb_dns_name   = local.private_alb_dns_name
# #   public_alb_dns_name    = local.public_alb_dns_name
# #   private_alb_ip_address = local.private_alb_ip_address
# #   public_listener_arn    = local.public_listener_arn
# #
# #   image_id   = data.aws_ami.ami.id
# #   depends_on = [module.alb, module.docdb, module.aurora, module.elasticache, module.rabbitmq]
# # }
#
#
# # Deploy the DocumentDB.
# module "docdb" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-docdb.git"
#
#   env        = var.env
#   tags       = var.tags
#   kms_key_id = var.kms_key_id
#
#   for_each = var.docdb
#
#   engine_family           = each.value["engine_family"]
#   backup_retention_period = each.value["backup_retention_period"]
#   preferred_backup_window = each.value["preferred_backup_window"]
#   skip_final_snapshot     = each.value["skip_final_snapshot"]
#   engine_version          = each.value["engine_version"]
#   instance_count          = each.value["instance_count"]
#   instance_class          = each.value["instance_class"]
#
#   db_subnets       = local.db_subnets
#   app_subnets_cidr = local.app_subnets_cidr
#   vpc_id           = local.main_vpc_id
#
#   master_username = data.aws_ssm_parameter.docdb_master_username.value
#   master_password = data.aws_ssm_parameter.docdb_master_password.value
#
# }
#
# # Deploy the Aurora SQL DB.
# module "aurora" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-aurorasql.git"
#
#   env        = var.env
#   tags       = var.tags
#   kms_key_id = var.kms_key_id
#
#   for_each = var.aurora
#
#   rds_type                = each.value["rds_type"]
#   engine_family           = each.value["engine_family"]
#   port                    = each.value["port"]
#   engine                  = each.value["engine"]
#   engine_version          = each.value["engine_version"]
#   backup_retention_period = each.value["backup_retention_period"]
#   preferred_backup_window = each.value["preferred_backup_window"]
#   skip_final_snapshot     = each.value["skip_final_snapshot"]
#   instance_count          = each.value["instance_count"]
#   instance_class          = each.value["instance_class"]
#
#   app_subnets_cidr = local.app_subnets_cidr
#   vpc_id           = local.main_vpc_id
#   db_subnets       = local.db_subnets
#
#   database_name   = data.aws_ssm_parameter.rds_database_name.value
#   master_username = data.aws_ssm_parameter.rds_master_username.value
#   master_password = data.aws_ssm_parameter.rds_master_password.value
#
# }
#
#
# # Deploy Redis Elasticache.
# module "elasticache" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-elasticache.git"
#
#   env  = var.env
#   tags = var.tags
#
#   for_each         = var.elasticache
#   elasticache_type = each.value["elasticache_type"]
#   engine_family    = each.value["engine_family"]
#   port             = each.value["port"]
#   engine           = each.value["engine"]
#   node_type        = each.value["node_type"]
#   num_cache_nodes  = each.value["num_cache_nodes"]
#   engine_version   = each.value["engine_version"]
#
#   db_subnets       = local.db_subnets
#   vpc_id           = local.main_vpc_id
#   app_subnets_cidr = local.app_subnets_cidr
# }
#
#
# # Deploy RabbitMQ
# module "rabbitmq" {
#   source = "git::https://github.com/abhijeet4022/terraform-aws-rabbitmq.git"
#
#   tags             = var.tags
#   env              = var.env
#   zone_id          = var.zone_id
#   ssh_subnets_cidr = var.ssh_subnets_cidr
#   kms_key_id       = var.kms_key_id
#
#   for_each      = var.rabbitmq
#   instance_type = each.value["instance_type"]
#
#   vpc_id           = local.main_vpc_id
#   app_subnets_cidr = local.app_subnets_cidr
#   db_subnets       = local.db_subnets
#   ami_id           = data.aws_ami.ami.id
# }
#
#
# # resource "aws_instance" "load-runner" {
# #   ami                    = data.aws_ami.ami.id
# #   instance_type          = "t3.medium"
# #   vpc_security_group_ids = ["sg-0243a82da6118ecb6"]
# #   user_data              = file("${path.module}/load-runner.sh")
# #   tags                   = { Name = "load-runner" }
# # }
#
#
# # Deploy EKS
# module "eks" {
#   source                         = "terraform-aws-modules/eks/aws"
#   version                        = "~> 19.0"
#   cluster_name                   = "dev-roboshop"
#   cluster_version                = "1.29"
#   cluster_endpoint_public_access = false
#   cluster_addons = {
#     coredns = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#   }
#
#   vpc_id                   = local.main_vpc_id
#   subnet_ids               = local.app_subnets
#   control_plane_subnet_ids = local.app_subnets
#   eks_managed_node_groups = {
#     blue = {}
#     green = {
#       min_size     = 1
#       max_size     = 10
#       desired_size = 2
#
#       instance_types = ["t2.medium"]
#       capacity_type  = "SPOT"
#     }
#   }
#
#   tags = var.tags
# }
#
# # IAM PolicyFor EKS.
# resource "aws_iam_role" "eks-ssm" {
#   name = "EKS_PS_ACCESS_ROLE"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Federated": "${module.eks.oidc_provider_arn}"
#         },
#         "Action": "sts:AssumeRoleWithWebIdentity",
#         "Condition": {
#           "StringEquals": {
#             "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com"
#           }
#         }
#       }
#     ]
#   })
#
#   inline_policy {
#     name = "${var.env}-eks-ssm-ro"
#
#     policy = jsonencode({
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Sid" : "VisualEditor0",
#           "Effect" : "Allow",
#           "Action" : [
#             "kms:Decrypt",
#             "ssm:GetParameterHistory",
#             "ssm:GetParametersByPath",
#             "ssm:GetParameters",
#             "ssm:GetParameter"
#           ],
#           "Resource" : "*"
#         },
#         {
#           "Sid" : "VisualEditor1",
#           "Effect" : "Allow",
#           "Action" : "ssm:DescribeParameters",
#           "Resource" : "*"
#         }
#       ]
#     })
#   }
#
# }