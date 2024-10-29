locals {
  main_vpc_id    = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  public_subnets = data.aws_subnets.subnets.ids
  app_subnets    = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.id]
  db_subnets     = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet_ids", null) : v.id]

  # CIDR Block
  app_subnets_cidr = [for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.cidr_block]

  private_listener_arn = lookup(lookup(lookup(module.alb, "private", null), "listener", null), "arn", null)

}

