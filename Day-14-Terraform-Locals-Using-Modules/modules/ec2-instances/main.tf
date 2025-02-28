variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "environment" {
  description = "The environment the instance is running in"
  type        = string
}

variable "name" {
  description = "The name of the EC2 instance"
  type        = string
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
