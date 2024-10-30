locals {
  main_vpc_id    = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  public_subnets = data.aws_subnets.subnets.ids
  app_subnets    = [
    for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) :
    v.id
  ]
  db_subnets = [
    for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "db", null), "subnet_ids", null) :
    v.id
  ]

  # CIDR Block
  app_subnets_cidr = [
    for k, v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) :
    v.cidr_block
  ]

  # LB Details
  private_listener_arn = lookup(lookup(lookup(module.alb, "internal", null), "listener", null), "arn", null)
  public_listener_arn  = lookup(lookup(lookup(module.alb, "public", null), "listener", null), "arn", null)

  private_alb_dns_name   = lookup(lookup(lookup(module.alb, "internal", null), "alb", null), "dns_name", null)
  public_alb_dns_name    = lookup(lookup(lookup(module.alb, "public", null), "alb", null), "dns_name", null)
  private_alb_ip_address = data.dns_a_record_set.main.addrs

}

