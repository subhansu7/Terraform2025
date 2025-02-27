# Example-1 Same names #############
# resource "aws_instance" "name" {
#     ami = "ami-085ad6ae776d8f09c"
#     instance_type = "t2.micro"
#     key_name = "ec2test"
#     availability_zone = "us-east-1a"
#     count = 2
#     # tags = {
#     #   Name = "dev"   # Two resource will create on same name 
#     # }
#     tags = {
#       Name = "dev-${count.index}" # ${count.index} is replaced by index value each time i.e.0 or 1.
#     }  
# }


# Example-2 Different names #############
# variable "env" {
#   type    = list(string) # List of string to hold different names of EC2 instances
#   default = [ "dev", "prod"]
# }

# #Dev-0, prod-1, test-2
# #Prod, dev, test created in sequence


# #resource will be created as per sequence of names in list

# resource "aws_instance" "name" {
#     ami = "ami-085ad6ae776d8f09c"
#     instance_type = "t2.micro"
#     key_name = "key-n-virginia"
#     availability_zone = "us-east-1a"
#     count = length(var.env)  # Count will be equal to length of list

#     tags = {
#       Name = var.env[count.index]
#     }
# }

# Example-4 with variables list of string 

# variable "ami" {
#   type    = string
#   default = "ami-0440d3b780d96b29d"
# }

# variable "instance_type" {
#   type    = string
#   default = "t2.micro"
# }

# variable "sandboxes" {
#   type    = list(string)
#   default = [ "sandbox_server_two", "sandbox_server_three"]
# }


# resource "aws_instance" "sandbox" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   count         = length(var.sandboxes)

#   tags = {
#     Name = var.sandboxes[count.index]
#   }
# }

#example-5 creating IAM users 
variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}
