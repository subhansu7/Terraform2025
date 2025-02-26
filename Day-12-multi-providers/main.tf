#This is for single region and single provider
provider "aws" {
    region = "us-east-1"
  
}

provider "aws" {
    region = "ap-south-1"
    alias = "provider2"
  
}

#this is for adding a new provider.
resource "aws_s3_bucket" "name" {
    bucket = "terraform2025-171"
    provider = aws.provider2
    
}

#If you do not specify the provider, it will take the default provider.
resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"
    availability_zone = "us-east-1b"
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    tags = {
        Name = "dev-instance"
        }
    security_groups =  ["test-sg"]
}

#Same resource in multiple regions