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

/*** SPECIAL NOTE

  * Since AWS Lambda Functions are running on Linux environment,
  * required python packages must be downloaded under that environment.
  * but pipenv was downloading those required (pandas) packages not for
  * Linux environment.
  * So, I had to download those packages manually and zip them.
  * That is why below data source is commented out.

data "archive_file" "layer_zip" {
  type        = "zip"
  source_dir  = "../infrastructure/package"
  output_path = "../infrastructure/zipped/package.zip"
}
*/

module "lambda" {
  source = "./lambda"

  lambda_zip_path                = data.archive_file.lambda_zip.output_path
  lambda_zip_output_base64sha256 = data.archive_file.lambda_zip.output_base64sha256

  s3_bucket_id  = module.s3_bucket.s3_bucket_id
  s3_bucket_key = module.s3_bucket.s3_bucket_key

  iam_role_arn   = module.iam.iam_role_arn
  iam_role_name  = module.iam.iam_role_name
  iam_policy_arn = module.iam.iam_policy_arn

}

module "s3_bucket" {
  source = "./s3_bucket"

  layer_zip_path = var.layer_zip_path
}

module "iam" {
  source = "./iam"

}

module "api_gateway" {
  source = "./api_gateway"

  lambda_function_invoke_arn = module.lambda.lambda_function_invoke_arn
  lambda_function_name       = module.lambda.lambda_function_name
}
