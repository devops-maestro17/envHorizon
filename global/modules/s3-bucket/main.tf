resource "aws_s3_bucket" "remote-backend" {
  bucket = var.bucket
  force_destroy = true
}