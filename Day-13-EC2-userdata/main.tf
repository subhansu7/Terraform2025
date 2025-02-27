resource "aws_instance" "dev" {
  ami                    = "ami-0440d3b780d96b29d"
  instance_type          = "t2.micro"
  key_name               = "key-n-virginia"
  user_data              = file("scripts.sh")
  tags = {
    Name="dev-instance"
  }
}