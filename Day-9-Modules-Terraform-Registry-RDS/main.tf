/*
resource "aws_db_subnet_group" "prod" {
  name       = "my-subnet-grp"
  #Add two different subnet ids from different AZ. For multi AZ, we need 3  different subnest in 3 different AZ.
  #RDS can be moved different subnets in separate VPC, If we move different subnets in same VPC it throws error.
  
  subnet_ids = ["subnet-06a25de4f3a26ecf5", "subnet-0118d1eac335c637b"]
  tags = {
    Name = "custom-subnet-group"
  }
}
*/

#Change SG and subnet group details as per your requirement
module "primary_db" {
  source = "terraform-aws-modules/rds/aws"  
  #https://github.com/terraform-aws-modules/terraform-aws-rds/blob/master/variables.tf
  #https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/latest?tab=inputs

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  password = "Admin1234"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-04730508ba3fc160b"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  #monitoring_interval    = "30"
  #monitoring_role_name   = "MyRDSMonitoringRole"
  #monitoring_role_arn      = aws_iam_role.rds_monitoring_role.arn
  #create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-06a25de4f3a26ecf5", "subnet-0118d1eac335c637b"]

  #db_subnet_group_name     = aws_db_subnet_group.prod.id

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  backup_retention_period = 7
  manage_master_user_password = false
  skip_final_snapshot = true

 }

#create read replica resource
module "read_replica" {
  source = "terraform-aws-modules/rds/aws"

  identifier                     = "demodb-replica"
  engine                         = "mysql"
  engine_version                 = "5.7"
  instance_class                 = "db.t3.micro"
  publicly_accessible            = false
  major_engine_version           = "5.7"
  family                         = "mysql5.7"
  #replicate_source_db           = "demodb"
  replicate_source_db            = module.primary_db.db_instance_identifier

  vpc_security_group_ids         = ["sg-04730508ba3fc160b"]
  

  # Ensure consistency with primary database configuration
  maintenance_window             = "Mon:00:00-Mon:03:00"
  backup_window                  = "03:00-06:00"

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  skip_final_snapshot = true
  deletion_protection = false
}

