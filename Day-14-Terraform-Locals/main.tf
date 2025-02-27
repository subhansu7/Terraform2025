# #Example-1
# locals {
#   bucket-name = "${var.layer}-${var.env}-bucket-hydnaresh"
# }

# resource "aws_s3_bucket" "demo" {
#     # bucket = "web-dev-bucket"
#     # bucket = "${var.layer}-${var.env}-bucket-hyd"
#     bucket = local.bucket-name
#     tags = {
#         # Name = "${var.layer}-${var.env}-bucket-hyd"
#         Name = local.bucket-name
#         Environment = var.env
#     }  
# }

#Example-2

locals {
  region = "us-east-1"
  ami = "ami-0440d3b780d96b29d"
  environment = "dev"
  instance_type = "t2.micro"
  Name = var.name
}

resource "aws_instance" "example" {
  ami           = local.ami
  instance_type = local.instance_type

  tags = {
    Name        = local.Name
    Environment = local.environment
  }
}