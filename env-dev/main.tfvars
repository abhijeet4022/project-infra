default_vpc_id         = "vpc-00cf4faf369528fd8"
default_vpc_cidr       = "172.31.0.0/16"
default_vpc_rt_id      = "rtb-06918308622056007"
env                    = "dev"
ssh_subnets_cidr       = ["172.31.22.36/32"]
zone_id                = "Z0354643VPBIKRKXRUWT"
prometheus_server_cidr = "172.31.93.31/32"
acm                    = "arn:aws:acm:us-east-1:940482433230:certificate/bad592df-28f9-45c3-84c1-8ac48e7f9894"
kms_key_id             = "arn:aws:kms:us-east-1:940482433230:key/ac63f4b2-595c-4455-8abb-ce8995a5ffcd"

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
    sg_port            = 443
  }
}

app = {
  frontend = {
    app_port         = 80
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 1
    parameters       = ["nexus"]
    tags             = { Monitor_Nginx = "yes" }
  }
  catalogue = {
    app_port         = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 2
    parameters       = ["docdb", "nexus"]
    tags             = {}
  }
  user = {
    app_port         = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 3
    parameters       = ["docdb", "nexus"]
    tags             = {}
  }
  cart = {
    app_port         = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 4
    parameters       = ["nexus"]
    tags             = {}
  }
  shipping = {
    app_port         = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 5
    parameters       = ["rds", "nexus"]
    tags             = {}
  }
  payment = {
    app_port         = 8080
    instance_type    = "t3.small"
    max_size         = 5
    min_size         = 2
    desired_capacity = 2
    lb_priority      = 6
    parameters       = ["rabbitmq", "nexus"]
    tags             = {}
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
    engine_version          = "5.7.mysql_aurora.2.11.5"
    backup_retention_period = 1
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    instance_count          = 2
    instance_class          = "db.t3.small"
  }
}

elasticache = {
  main = {
    elasticache_type = "redis"
    engine_family    = "redis6.x"
    port             = 6379
    engine           = "redis"
    node_type        = "cache.t3.micro"
    num_cache_nodes  = 1
    engine_version   = "6.2"
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.micro"
  }
}