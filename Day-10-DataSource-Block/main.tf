provider "aws" {
  
}

# Existing Network elements
data "aws_subnet" "subnet_selected" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1"]  # Insert subnet name or tag value here
  }
}

data "aws_security_groups" "sg_selected" {  # Corrected from aws_security_groups to aws_security_group
  filter {
    name   = "tag:Name"
    values = ["test-sgroup"]  # Insert the security group name here
  }
}

resource "aws_instance" "dev1" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  key_name      = "key-n-virginia"
  
  # Using data block to reference the subnet ID
  subnet_id = data.aws_subnet.subnet_selected.id
  
  # Using data block to reference the security group ID 
  vpc_security_group_ids = [data.aws_security_groups.sg_selected.ids[0]]  
  
  tags = {
    Name = "EC2-terraform"
  }
}

/*
#Below code to get the latest Amazon Linux AMI ID.
  data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
*/