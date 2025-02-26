#To create multiple profile from CLI , we can use aws configure --profile <profile-name> and then provide the access key and secret key
#To use the profile in terraform, we can use the profile attribute in provider block

resource "aws_instance" "dev" {
  ami                    = "ami-0440d3b780d96b29d"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.name.key_name
  tags = {
    Name="key-tf"
  }
}