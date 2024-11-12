resource "aws_iam_role_policy" "lambda-dynamodb-policy" {
  name = "evt-lambda-dynamodb-policy"
  role = aws_iam_role.lambda-dynamodb-role.id
  policy = "${file("./policies/ddb-policy.json")}"
}

resource "aws_iam_role" "lambda-dynamodb-role" {
  name = "evt-lambda-dynamodb-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })
}


# Remember to add permissions for API Gateway lambda proxy integration
resource "aws_lambda_permission" "evt-get-integration" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.evt-get.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.evt-api.execution_arn}/*/GET/spell"
}

resource "aws_lambda_permission" "evt-post-integration" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.evt-post.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.evt-api.execution_arn}/*/POST/spell"
}

resource "aws_lambda_permission" "evt-delete-integration" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.evt-delete.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.evt-api.execution_arn}/*/DELETE/spell"
}

