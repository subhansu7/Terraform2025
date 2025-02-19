# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.12"
  #role             = aws_iam_role.lambda_exec_role.arn # If you want to eable this then enable functons written below for new role and policy attached.
  role             = "arn:aws:iam::038462789460:role/lambda-admin"
  handler          = "lambda_function.lambda_handler" # Replace with your function handler
  timeout          = 30
  memory_size      = 128
  filename       = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")
  tags = {
    Name = "MyLambdaFunction"
  }
}

# IAM Role for Lambda
/*
# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
*/