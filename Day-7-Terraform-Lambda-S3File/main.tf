# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_s3_bucket" {
  bucket        = "my-lambda-bucket-171"  
  force_destroy = true
  tags = {
    Name = "LambdaBucket"
  }
}


# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_s3_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip" # Path to your zip file containing the Lambda code
  etag   = filemd5("lambda_function.zip")
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "lambda_function"
  runtime          = "python3.9"
  #role             = aws_iam_role.lambda_exec_role.arn # If you want to eable this then enable functons written below for new role and policy attached.
  role             = "arn:aws:iam::038462789460:role/lambda-admin"
  handler          = "lambda_function.lambda_handler" # Replace with your function handler
  timeout          = 30
  memory_size      = 128
  s3_bucket        = aws_s3_bucket.lambda_s3_bucket.id # calling code from s3 bucket 
  s3_key           = aws_s3_object.lambda_code.key # inside this folder
  tags = {
    Name = "MyLambdaFunction"
  }
}