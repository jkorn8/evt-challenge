# Lambda function for GET event
data "archive_file" "evt-get-archive" {
  type        = "zip"
  source_file = "./lambdas/evt-get/index.mjs"
  output_path = "./outputs/evt-get.zip"
}

resource "aws_lambda_function" "evt-get" {
  filename      = "./outputs/evt-get.zip"
  function_name = "evt-get"
  role          = aws_iam_role.lambda-dynamodb-role.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.evt-get-archive.output_base64sha256
  runtime = "nodejs20.x"
  timeout = 10
}

# Lambda function for POST event
data "archive_file" "evt-post-archive" {
  type        = "zip"
  source_file = "./lambdas/evt-post/index.mjs"
  output_path = "./outputs/evt-post.zip"
}

resource "aws_lambda_function" "evt-post" {
  filename      = "./outputs/evt-post.zip"
  function_name = "evt-post"
  role          = aws_iam_role.lambda-dynamodb-role.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.evt-post-archive.output_base64sha256
  runtime = "nodejs20.x"
  timeout = 10
}

# Lambda function for DELETE event
data "archive_file" "evt-delete-archive" {
  type        = "zip"
  source_file = "./lambdas/evt-delete/index.mjs"
  output_path = "./outputs/evt-delete.zip"
}

resource "aws_lambda_function" "evt-delete" {
  filename      = "./outputs/evt-delete.zip"
  function_name = "evt-delete"
  role          = aws_iam_role.lambda-dynamodb-role.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.evt-delete-archive.output_base64sha256
  runtime = "nodejs20.x"
  timeout = 10
}

