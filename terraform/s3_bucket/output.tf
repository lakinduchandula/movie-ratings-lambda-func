output "s3_bucket_id" {
    description = "The ID of the S3 bucket"
    value = aws_s3_bucket.lambda_bucket.id
}

output "s3_bucket_key" {
    description = "The key of the S3 bucket"
    value = aws_s3_object.lambda_app.key
}
