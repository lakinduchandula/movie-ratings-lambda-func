variable "aws_region" {
  type        = string
  description = "AWS Region that will be used for the deployment"
  default     = "us-east-1"
}

variable "layer_zip_path" {
  type        = string
  description = "pandas-package containing the layer zip file"
  default     = "../infrastructure/zipped/package.zip"
}