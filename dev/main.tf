terraform {
  backend "s3" {
    bucket  = "tf-remote-statefile-dev"
    key     = "statelock/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # dynamodb_table = "terraform-statelock-dev"
  }
}

module "provider" {
  source = "../global/modules/providers"
  region = var.region
}

module "s3_bucket" {
  source = "../global/modules/s3-bucket"
  bucket = var.bucket
}

# module "dynamodb_table" {
#   source = "../global/modules/dynamo-db-statelock"
#   dynamo_db_table_name = var.dynamo_db_table_name
#   billing_mode         = var.billing_mode
#   hash_key             = var.hash_key
#   hash_key_type        = var.hash_key_type
# }

module "vpc" {
  source           = "../global/modules/networking"
  cidr_block       = var.cidr_block
  subnet_1_cidr    = var.subnet_1_cidr
  subnet_1_az      = var.subnet_1_az
  subnet_2_cidr    = var.subnet_2_cidr
  subnet_2_az      = var.subnet_2_az
  route_table_cidr = var.route_table_cidr
  from_port        = var.from_port
  to_port          = var.to_port
  sg_cidr          = var.sg_cidr
}

module "ec2_instance" {
  source        = "../global/modules/compute"
  ami           = var.ami
  instance_type = var.instance_type
  instance_sg   = [module.vpc.security-group]
  subnet_id_1   = module.vpc.subnet-1
  subnet_id_2   = module.vpc.subnet-2
}