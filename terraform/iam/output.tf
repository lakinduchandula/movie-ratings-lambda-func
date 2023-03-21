output "iam_role_arn" {
  value = aws_iam_role.lambda_iam_role.arn
}

output "iam_role_name" {
    value = aws_iam_role.lambda_iam_role.name
}

output "iam_policy_arn" {
    value = aws_iam_policy.lambda_logging.arn
}
