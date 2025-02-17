terraform {
    backend "s3" {
        bucket = "my-unique-777-s3-bucket"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}