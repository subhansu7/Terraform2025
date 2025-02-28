# Define variables for environment-specific values
variable "environment" {
  description = "Environmwent Name"
  type        = string
}

variable "name" {
  description = "Name of the instance"
  type        = string
}

locals {
  # You can have environment-specific values here
  ami           = "ami-085ad6ae776d8f09c"
  instance_type = "t2.micro"
}

module "aws_instance" {
  source        = "./modules/ec2-instances"  
  ami           = local.ami
  instance_type = local.instance_type
  environment   = var.environment
  name          = var.name
}
