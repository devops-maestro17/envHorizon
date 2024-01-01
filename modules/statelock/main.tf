resource "aws_dynamodb_table" "tf-statelock" {
  name = "terraform-statelock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}