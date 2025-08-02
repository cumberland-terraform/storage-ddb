# modules/dynamodb_lambda/outputs.tf

output "dynamodb_table_arn" {
  description = "The ARN of the created DynamoDB table."
  value       = aws_dynamodb_table.lambda_table.arn
}

output "lambda_function_arn" {
  description = "The ARN of the created Lambda function."
  value       = aws_lambda_function.my_lambda.arn
}