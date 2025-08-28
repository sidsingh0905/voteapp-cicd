provider "aws" {
  region = "ap-south-1"
}
# Step 1 — Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "voteapp-terraform-state-bucket" # Must be globally unique
  lifecycle {
    prevent_destroy = false
  }
}

# Step 2 — Block all public access to S3 bucket
resource "aws_s3_bucket_public_access_block" "terraform_state_block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Step 3 — Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Step 4 — DynamoDB table for state locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = "voteapp-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
