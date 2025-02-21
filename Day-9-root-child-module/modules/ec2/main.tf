resource "aws_instance" "this" {
  ami           = var.ami_id  
  instance_type = var.instance_type
  key_name = var.key

  tags = {
    Name = "ec2-terraform-new-instance"
  }
}