vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}






























# sg      = ["sg-0243a82da6118ecb6"]
# zone_id = "Z03000202RXSEVOPTHMK1"
#
# components = {
#   frontend  = { name = "frontend", instance_type = "t3.small" }
#   mongodb   = { name = "mongodb", instance_type = "t3.small" }
#   catalogue = { name = "catalogue", instance_type = "t3.small" }
#   redis     = { name = "redis", instance_type = "t3.small" }
#   user      = { name = "user", instance_type = "t3.small" }
#   cart      = { name = "cart", instance_type = "t3.small" }
#   mysql     = { name = "mysql", instance_type = "t3.small" }
#   shipping  = { name = "shipping", instance_type = "t3.small" }
#   rabbitmq  = { name = "rabbitmq", instance_type = "t3.small" }
#   payment   = { name = "payment", instance_type = "t3.small" }
# }


