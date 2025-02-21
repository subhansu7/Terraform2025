variable "ami_id" {
  description = "AMI ID of EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}
variable "key" {
  description = "Region Specific Key Pair"
  type        = string
}
