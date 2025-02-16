
resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"
    availability_zone = "us-east-1b"
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    tags = {
        Name = "dev"
        }  
}

#You can create a new file called backend.tf and add the following code to it. This will configure the S3 bucket as the backend for the Terraform state file.
#Or you can add the following code to the main.tf file itself.
#terraform {
#    backend "s3" {
#        bucket = "myawsbucket171"
#        key = "terraform.tfstate"
#        region = "us-east-1"
#    }
#}