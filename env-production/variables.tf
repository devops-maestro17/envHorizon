variable "region" {
  type        = string
  description = "AWS Region"
}

variable "bucket" {
  type = string
}

variable "environment_name" {
  type    = string
  default = "staging"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public Subnets CIDR Range"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnets CIDR Range"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "ingress_from_port" {
  type        = map(any)
  description = "Ingress From Ports"
}
variable "ingress_protocol" {
  type = string
}

variable "ingress_cidr_block" {
  type        = list(string)
  description = "Ingress CIDR Block"
}

variable "ami" {
  type        = string
  description = "AMI ID of EC2 Instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "storage" {
  type        = number
  description = "DB Storage"
}

variable "storage_type" {
  type        = string
  description = "DB Storage Type"
}

variable "engine" {
  type        = string
  description = "DB Engine"
}

variable "engine_version" {
  type        = string
  description = "DB Engine Version"
}

variable "instance_class" {
  type        = string
  description = "DB Instance Class"
}

variable "db_name" {
  type        = string
  description = "DB Name"
}

variable "vault_address" {
  type = string
}

variable "vault_role_id" {
  type = string
}

variable "vault_secret_id" {
  type = string
}