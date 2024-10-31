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

# Private LB Listener ARN
# output "private_listener_arn" {
#   value = lookup(lookup(lookup(module.alb, "internal", null), "listener", null), "arn", null)
# }
#
# Public LB Listener ARN
# output "public_listener_arn" {
#   value = lookup(lookup(lookup(module.alb, "public", null), "listener", null), "arn", null)
# }

# output "LB_IP" {
#   value = data.dns_a_record_set.main.addrs
# }