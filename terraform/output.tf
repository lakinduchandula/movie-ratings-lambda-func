output "endpoint_url" {
    value = "${module.api_gateway.api_gateway_stge_invoke_url}/${module.api_gateway.endpoint_path}"
}