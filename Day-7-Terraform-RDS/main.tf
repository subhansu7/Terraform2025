#Create subnet group for RDS 
resource "aws_db_subnet_group" "prod" {
  name       = "my-subnet-grp"
  #Add two different subnet ids from different AZ. For multi AZ, we need 3  different subnest in 3 different AZ.
  #RDS can be moved different subnets in separate VPC, If we move different subnets in same VPC it throws error.
  
  subnet_ids = ["subnet-06a25de4f3a26ecf5", "subnet-0118d1eac335c637b"]
  tags = {
    Name = "custom-subnet-group"
  }
}

resource "aws_db_instance" "prod" {
  allocated_storage        = 10
  identifier               = "myrdsdbinstance"
  db_name                  = "myrdsdb"
  engine                   = "mysql"
  engine_version           = "8.0"
  instance_class           = "db.t3.micro" #Free tier selected, for Multi-AZ select prod environment and type t5 and above.
  username                 = "admin"
  password                 = "Admin1234"
  db_subnet_group_name     = aws_db_subnet_group.prod.id
  parameter_group_name     = "default.mysql8.0"

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Maintenance window. Maintenance and backup should not overlap.
  maintenance_window       = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion). If set as true you have to go inside RDS and modify DB details to delete it.
  deletion_protection      = false

  # Skip final snapshot
  skip_final_snapshot      = true #No snapshot taken after RDS DB is deleted

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring_role.arn

  # Enable performance insights
  #performance_insights_enabled = false
  #performance_insights_retention_period = 7  # Retain insights for 7 days
}


# IAM Role for RDS Enhanced Monitoring

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role-new"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}



