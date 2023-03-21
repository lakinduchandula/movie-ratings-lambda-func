resource "aws_api_gateway_rest_api" "lambda_api_gateway" {
  name = "lambda_api_gateway"
}

resource "aws_api_gateway_resource" "lambda_api_gateway_resource" {
  parent_id   = aws_api_gateway_rest_api.lambda_api_gateway.root_resource_id
  path_part   = var.endpoint_path
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gateway.id
}

resource "aws_api_gateway_method" "api_gateway_method" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.lambda_api_gateway_resource.id
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gateway.id
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  resource_id             = aws_api_gateway_resource.lambda_api_gateway_resource.id
  rest_api_id             = aws_api_gateway_rest_api.lambda_api_gateway.id
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_api_gateway_rest_api.lambda_api_gateway.execution_arn}/*/*/*"
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api_gateway.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.lambda_api_gateway.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_api_gateway_method.api_gateway_method, aws_api_gateway_integration.api_gateway_integration]

}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.lambda_api_gateway.id
  stage_name    = "dev"
}
