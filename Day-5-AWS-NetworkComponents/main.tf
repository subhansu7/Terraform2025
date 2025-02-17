# Create VPC
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "prod_vpc"
    }
}
#create subnet
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
resource "aws_route_table" "prod" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod.id
    }
}
#Assocaite subnet with route table
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.prod.id
    route_table_id = aws_route_table.prod.id  
}

#create security group
resource "aws_security_group" "prod" {
    name = "prod_sg"
    description = "Allow all traffic"
    vpc_id = aws_vpc.prod.id

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/24"]
    }
    ingress {
        from_port = 22 # from and to port same meanss only port no 22 aalowed
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/24"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/24"]
    }

}
#Create instance
resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"    
    instance_type = "t2.nano"
    key_name = "key-n-virginia"
    subnet_id = aws_subnet.prod.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
        Name = "dev-terraform-custom"
        }  
}