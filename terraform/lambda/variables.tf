variable "s3_bucket_id" {
  description = "s3_bucket_id for lambda function"
  type        = string
}

variable "s3_bucket_key" {
  description = "s3_bucket_key for lambda function"
  type        = string
}

variable "iam_role_arn" {
  description = "iam_role_arn for lambda function"
  type        = string
}

variable "lambda_zip_path" {
  description = "lambda_zip contain the lambda function written in python"
  type        = string
}

variable "lambda_zip_output_base64sha256" {
  description = "uniquely identify the deployment package"
  type        = string
}

variable "iam_role_name" {
  description = "iam_role_name for lambda_logs"
  type        = string
}

variable "iam_policy_arn" {
  description = "iam_policy_arn for lambda_logs"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda_function_name for lambda_logs"
  type        = string
  default     = "lambda_function"
}

variable "lambda_layer_name" {
  description = "lambda_layer_name for lambda_logs"
  type        = string
  default     = "python-pkg-layer"

}