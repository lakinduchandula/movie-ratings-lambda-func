output "api_gateway_stge_invoke_url" {
    value = aws_api_gateway_stage.api_gateway_stage.invoke_url
}

output "endpoint_path" {
    value = var.endpoint_path
}