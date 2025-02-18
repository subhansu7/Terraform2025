# Create VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "prod_vpc"
    }
}
#create public subnet
resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "pub_subnet"
    }  
}
#Create Internet Gateway
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
        name = "prod_ig"
    }
}
#Create Route Table and edit routes
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod.id
    }
}
#Assocaite public subnet with route table
resource "aws_route_table_association" "public_subnet_assoc" {
    subnet_id = aws_subnet.prod.id
    route_table_id = aws_route_table.pub_rt.id  
}

#Create private subnet
resource "aws_subnet" "prod_private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "pvt_subnet"
    }  
}

#Create elastic IP
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat_eip"
  }
}

#Create NAT Gateway
resource "aws_nat_gateway" "prod" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.prod.id
    tags = {
        name = "prod_nat"
    }
}

#Create Route Table for NAT Gateway and edit routes
resource "aws_route_table" "pvt_rt" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.prod.id
    }
}
#Assocaite private subnet with route table
resource "aws_route_table_association" "private_subnet_assoc" {
    subnet_id = aws_subnet.prod_private.id
    route_table_id = aws_route_table.pvt_rt.id 
}
#create security group
resource "aws_security_group" "prod" {
    name = "prod_sg"
    description = "Allow all traffic"
    vpc_id = aws_vpc.prod.id

    ingress {
        from_port = 443 # from and to port same means only port no 443 allowed for HTTPS
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22 # from and to port same means only port no 22 allowed for SSH
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80 # from and to port same means only port no 22 allowed for http
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#Create public instance
resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"    
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    associate_public_ip_address = true #Enabling EC2 instance to get public IP.
    tags = {
        Name = "EC2-terraform-public"
        }  
}

#Create public instance
resource "aws_instance" "name_pvt" {
    ami = "ami-085ad6ae776d8f09c"    
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    subnet_id = aws_subnet.prod_private.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
        Name = "EC2-terraform-private"
        }  
}