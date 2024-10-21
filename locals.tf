locals {
  main_vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
}