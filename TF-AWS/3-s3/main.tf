
resource "aws_s3_bucket" "rt_s3_bucket" {
  bucket = "rt-tf-test-bucket"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Rt Bucket"
    Environment = "Test"
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table-to-state-lock" {
  name = "rt-tf-state-lock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "rt-dynamodb-table-to-lock-state"
    Environment = "Test"
  }
}