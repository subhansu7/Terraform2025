resource "aws_s3_bucket" "s3_name" {
    bucket = "s3-bucket-171175"  
}

resource "aws_instance" "ec2_name" {
    ami = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    key_name = "key-n-virginia"
    # Depends on block is used to create a dependency between resources. here EC2 instance will be created only after the S3 bucket is created.
    depends_on = [ aws_s3_bucket.s3_name]
  
}

