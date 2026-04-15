variable "bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the backend resources"
  type        = map(string)
  default     = {}
}

resource "aws_s3_bucket" "state" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}

output "state_bucket_id" {
  value = aws_s3_bucket.state.id
}

output "state_lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.state_lock.name
}
