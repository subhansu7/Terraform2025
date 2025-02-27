# # Example 1 bucket creation condition based 
# provider "aws" {
#   region = "us-east-1"
# }

# variable "create_bucket_flag" {
#   description = "Set to true to create the S3 bucket. If false, bucket is not created."
#   type        = bool
#   default     = false
# }

# resource "random_string" "suffix" {
#   count   = var.create_bucket_flag ? 1 : 0 #count is set to 1 or 0 based on value of create_bucket_flag
#   length  = 8 #length of the random string appended to bucket name
#   special = false
#   upper   = false
# }

# resource "aws_s3_bucket" "example" {
#   count = var.create_bucket_flag ? 1 : 0

#   bucket = "my-conditional-bucket-${random_string.suffix[count.index].id}"
#   #acl    = "private"

#   tags = {
#     Name        = "ConditionalBucket"
#     Environment = "Dev"
#   }
# }

#Example -2 EC2 instance creation condition based

variable "create_instance_flag" {
  description = "Set to true to create the EC2 instance."
  type        = bool
  default     = true
}


resource "aws_instance" "example" {
  count         = var.create_instance_flag ? 1 : 0
  ami           = "ami-0440d3b780d96b29d" # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "Condition-based-Instance"
  }
}

variable "aws_region" {
  description = "The region in which to create the infrastructure"
  type        = string
  nullable    = false
  default     = "us-west-2" #here we need to define either us-west-1 or eu-west-2 if i give other region will get error 
  validation {
    condition = var.aws_region == "us-west-2" || var.aws_region == "eu-west-1"
    error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1"
  }
}

provider "aws" {
  region = "us-east-1"
} 


# Example-3 with numeric condition.
# variables.tf
# variable "ami" {
#   type    = string
#   default = "ami-0230bd60aa48260c6"
# }

# variable "instance_type" {
#   type = string
#   default = "t2.nano"
# }

# # main.tf
# resource "aws_instance" "dev" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   count         = var.instance_type == "t2.micro" ? 1 : 0
#   tags = {
#     Name = "dev_server"
#   }
# }