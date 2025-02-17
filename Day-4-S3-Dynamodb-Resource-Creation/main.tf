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

resource "aws_s3_bucket" "example" {
  bucket = "my-unique-779-s3-bucket"

}