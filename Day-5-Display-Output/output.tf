output "az" {
    value = aws_instance.test.availability_zone
  
}

output "ip" {
    value = aws_instance.test.public_ip
  
}

output "privateIp" {
    value = aws_instance.test.private_ip
    sensitive = true
  
}

output "Secgroup" {
    value = aws_instance.test.security_groups
}