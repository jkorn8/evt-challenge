resource "aws_api_gateway_rest_api" "evt-api" {
  name        = "evt-api"
  description = "This is the API for my EVT Technical Challenge"
  endpoint_configuration {
   types = ["REGIONAL"]
  }
}

# Create the API key for API calls
resource "aws_api_gateway_api_key" "evt-api-key" {
  name  = "evt-api-key"
}

resource "aws_api_gateway_usage_plan" "evt-usage-plan" {
  name         = "evt-usage-plan"
  api_stages {
    api_id = aws_api_gateway_rest_api.evt-api.id
    stage  = aws_api_gateway_stage.evt-dev-stage.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "evt-usage-plan-key" {
  key_id        = aws_api_gateway_api_key.evt-api-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.evt-usage-plan.id
}

# Create the spells resource
resource "aws_api_gateway_resource" "spells" {
  parent_id   = aws_api_gateway_rest_api.evt-api.root_resource_id
  path_part   = "spells"
  rest_api_id = aws_api_gateway_rest_api.evt-api.id
}

# Create the spells resource
resource "aws_api_gateway_resource" "spell" {
  parent_id   = aws_api_gateway_rest_api.evt-api.root_resource_id
  path_part   = "spell"
  rest_api_id = aws_api_gateway_rest_api.evt-api.id
}

# Create the GET method for the spells resource
resource "aws_api_gateway_method" "get-spell" {
  rest_api_id   = aws_api_gateway_rest_api.evt-api.id
  resource_id   = aws_api_gateway_resource.spell.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "evt-get-integration" {
  rest_api_id             = aws_api_gateway_rest_api.evt-api.id
  resource_id             = aws_api_gateway_resource.spell.id
  http_method             = aws_api_gateway_method.get-spell.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.evt-get.invoke_arn
}

# Create the POST method for the spell resource
resource "aws_api_gateway_method" "post-spell" {
  rest_api_id   = aws_api_gateway_rest_api.evt-api.id
  resource_id   = aws_api_gateway_resource.spell.id
  http_method   = "POST"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "evt-post-integration" {
  rest_api_id             = aws_api_gateway_rest_api.evt-api.id
  resource_id             = aws_api_gateway_resource.spell.id
  http_method             = aws_api_gateway_method.post-spell.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.evt-post.invoke_arn
}

# Create the DELETE method for the spell resource
resource "aws_api_gateway_method" "delete-spell" {
  rest_api_id   = aws_api_gateway_rest_api.evt-api.id
  resource_id   = aws_api_gateway_resource.spell.id
  http_method   = "DELETE"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "evt-delete-integration" {
  rest_api_id             = aws_api_gateway_rest_api.evt-api.id
  resource_id             = aws_api_gateway_resource.spell.id
  http_method             = aws_api_gateway_method.delete-spell.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.evt-delete.invoke_arn
}

# Create the stage for the Rest API
resource "aws_api_gateway_stage" "evt-dev-stage" {
  deployment_id = aws_api_gateway_deployment.evt-api.id
  rest_api_id   = aws_api_gateway_rest_api.evt-api.id
  stage_name    = "dev"

  depends_on = [ aws_api_gateway_deployment.evt-api ]
}

resource "aws_api_gateway_deployment" "evt-api" {
  rest_api_id = aws_api_gateway_rest_api.evt-api.id
}
