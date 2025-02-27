variable "ami" {
  type    = string
  default = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type    = list(string)
  default = ["dev", "test", "prod"]
}
variable "subnet_id" {
    type = string
    default = "subnet-06a25de4f3a26ecf5"
  
}
resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.env)
  subnet_id     = var.subnet_id
  
  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }
}