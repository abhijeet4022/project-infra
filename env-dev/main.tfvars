default_vpc_id    = "vpc-058c10b399cde9466"
default_vpc_cidr  = "172.31.0.0/16"
default_vpc_rt_id = "rtb-04de4de8427d67968"
env               = "dev"


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


tags = {
  Company_Name  = "ABC_Tech"
  Business_Unit = "Ecommerce"
  Project_Name  = "Roboshop"
  Cost_Center   = "ecom-rs"
  Created_By    = "terraform"
}


alb = {
  internal = {
    internal           = true
    load_balancer_type = "application"
    cidr_block         = ["172.31.0.0/16", "10.0.0.0/16"]
    sg_port            = 80
  }
  public = {
    internal           = false
    load_balancer_type = "application"
    cidr_block         = ["0.0.0.0/0"]
    sg_port            = 80
  }
}

docdb = {
  main = {
    engine_family           = "docdb4.0"
    engine_version          = "4.0.0"
    backup_retention_period = 1
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 2
    instance_class          = "db.t3.medium"
  }
}

aurora = {
  main = {
    rds_type                = "aurora-mysql"
    engine_family           = "aurora-mysql5.7"
    port                    = 3306
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    backup_retention_period = 1
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 2
    instance_class          = "db.t3.small"
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


