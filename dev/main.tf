provider "aws" {
  region = var.region
}

module "statelock-dynamodb" {
  source = "../modules/statelock"
}

module "networking" {
  source               = "../modules/networking"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnets_cidrs = var.public_subnets_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  ingress_from_port    = var.ingress_from_port
  ingress_protocol     = var.ingress_protocol
  ingress_cidr_block   = var.ingress_cidr_block
  environment_name     = var.environment_name
}

module "s3" {
  source = "../modules/s3"
  bucket = var.bucket
}

module "ec2_instance" {
  source           = "../modules/compute"
  ami              = var.ami
  instance_type    = var.instance_type
  subnet_id        = module.networking.aws_public_subnet_ids
  security_group   = module.networking.vpc_security_group_id
  environment_name = var.environment_name
}

module "load_balancer" {
  source            = "../modules/load-balancer"
  lb_security_group = module.networking.vpc_security_group_id
  lb_subnets        = module.networking.aws_public_subnet_ids
  lb_vpc_id         = module.networking.aws_vpc_id
  lb_target_id      = module.ec2_instance.web_server_ids
  environment_name  = var.environment_name
}

module "hashicorp_vault" {
  source          = "../modules/hashicorp-vault"
  vault_address   = var.vault_address
  vault_role_id   = var.vault_role_id
  vault_secret_id = var.vault_secret_id
}

module "rds_instance" {
  source            = "../modules/database"
  storage           = var.storage
  storage_type      = var.storage_type
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.db_name
  db_user           = module.hashicorp_vault.vault_db_username
  db_pass           = module.hashicorp_vault.vault_db_password
  db_subnet_group   = module.networking.aws_private_subnet_ids
  db_security_group = module.networking.vpc_security_group_id
  environment_name  = var.environment_name
}