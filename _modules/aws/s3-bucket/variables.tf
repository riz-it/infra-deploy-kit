# AWS Region
variable "aws_region" {
  type        = string
  description = "AWS Region"
}

# AWS Access Key
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

# AWS Secret Access Key
variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "aws_s3_bucket_name" {
  type        = string
  description = "AWS S3 Bucket Name"
}

variable "aws_s3_tag_name" {
  type        = string
  description = "AWS S3 Name Tag"
}

variable "aws_s3_tag_env" {
  type        = string
  description = "AWS S3 Environment Tag"
}