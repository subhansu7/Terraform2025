terraform {
    backend "s3" {
        bucket = "myawsbucket171"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}