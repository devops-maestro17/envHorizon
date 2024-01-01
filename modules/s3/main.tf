resource "aws_s3_bucket" "s3_backend" {
  bucket        = var.bucket
  force_destroy = true
}