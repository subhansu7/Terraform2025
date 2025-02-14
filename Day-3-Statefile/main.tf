resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"
    availability_zone = "us-east-1b"
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    tags = {name = "dev-instance"}
    security_groups =  ["test-sg"]
}