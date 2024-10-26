# output "vpc" {
#   value = module.vpc
# }

# output "vpc_id" {
#   value = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
# }

output "Abhijeet" {
  value = lookup(lookup(module.vpc, "main", null), "subnets", null)
}