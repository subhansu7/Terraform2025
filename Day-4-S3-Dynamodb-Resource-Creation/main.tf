provider "aws" {
  region = "us-east-1"  # Replace with your preferred AWS region
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20 
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "dev" {
  bucket = "my-unique-1237-s3-bucket"

}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.dev.id
  versioning_configuration {
    status = "Enabled"
  }
}