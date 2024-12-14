resource "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket_name

  tags = {
    Name        = var.aws_s3_tag_name
    Environment = var.aws_s3_tag_env
  }
}