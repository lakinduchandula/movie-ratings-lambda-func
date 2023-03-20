resource "aws_lambda_layer_version" "lambda_layer_version" {

  layer_name               = "pandas-layer-python-test"
  compatible_runtimes      = ["python3.8"]
  compatible_architectures = ["x86_64"]

  //TODO: when s3 bucket created bucketId and key

}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "lambda_function"
  role             = var.iam_role_arn
  filename         = var.lambda_zip_path
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = var.lambda_zip_output_base64sha256

  layers = [
    aws_lambda_layer_version.lambda_layer_version.arn
  ]

  depends_on = [
    aws_cloudwatch_log_group.cloudwath_log_group,
    aws_iam_role_policy_attachment.lambda_logs,
  ]
}

resource "aws_cloudwatch_log_group" "cloudwath_log_group" {
  name              = "/aws/lambda/lambda_function"
  retention_in_days = 14
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  //TODO: import from iam module
  role       = var.iam_role_name
  policy_arn = var.iam_policy_arn
}