# terraform {
#   backend "s3" {
#     bucket  = "tf-remote-statefile"
#     key     = "staging/terraform.tfstate"
#     region  = "ap-south-1"
#     encrypt = true
#     # dynamodb_table = "terraform-statelock"
#   }
# }