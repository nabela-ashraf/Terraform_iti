#to prevent deleting the s3
resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-state-2023"
    lifecycle {
        prevent_destroy = true
    }
}

#to enable versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id 
  versioning_configuration {
    status = "Enabled"
  }
}

#to create dynamodb table to state lock 
resource "aws_dynamodb_table" "lock" {
    name = "terraform-state-lock"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
        name = "LockID"
        type = "S"
    }
}

#to configure the backend
# terraform {
#   backend "s3" {
#     bucket = "terraform-state-2023"
#     key    = "state/terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "terraform-state-lock"
#     encrypt = true
#   }
# }