
variable "ami_id" {
  description = "Type of EC2 instance"
  type        = string
  #default     = "t2.micro"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  #default     = "t2.micro"
}

variable "key" {
  description = "Region Specific Key Pair"
  type        = string
  #default     = "t2.micro"
}

variable "bucket_name" {
   description = "S3 Bucket name"
   type        = string
}
