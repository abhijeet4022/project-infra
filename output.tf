# output "vpc" {
#   value = module.vpc
# }
#
# output "vpc_id" {
#   value = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
# }
#
# output "Abhijeet" {
#   value = [for k,v in lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), "app", null), "subnet_ids", null) : v.id]
# }

output "private_listener_arn" {
  value = lookup(lookup(lookup(module.alb, "internal", null), "listener", null), "arn", null)
}


output "public_listener_arn" {
  value = lookup(lookup(lookup(module.alb, "public", null), "listener", null), "arn", null)
}