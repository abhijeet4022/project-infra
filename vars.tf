variable "components" {
  description = "Map of application components with their names and instance types."
}
variable "sg" {
  description = "`allow-all` SG ID."
}
variable "zone_id" {
  description = "The Zone ID for the Route 53 hosted zone."
}
