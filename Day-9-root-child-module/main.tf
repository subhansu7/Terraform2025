
module "ec2_instance" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key           = var.key
}


module "s3_bucket" {
   source      = "./modules/s3"
   bucket_name = var.bucket_name
}

