terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.47.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "./lambda_function"
  output_path = "../infrastructure/zipped/lambda.zip"
}

data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "../infrastructure/package"
  output_path = "../infrastructure/zipped/package.zip"
}

module "lambda" {
  source = "./lambda"

  lambda_zip_path                = data.archive_file.lambda_zip.output_path
  lambda_zip_output_base64sha256 = data.archive_file.lambda_zip.output_base64sha256

  s3_bucket_id  = module.s3_bucket.s3_bucket_id
  s3_bucket_key = module.s3_bucket.s3_bucket_key

}

module "s3_bucket" {
  source         = "./s3_bucket"
  
  layer_zip_path = data.archive_file.layer_zip.output_path
}
