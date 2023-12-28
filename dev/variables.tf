variable "region" {
  type = string
}

variable "bucket" {
  type = string
}

variable "dynamo_db_table_name" {
  type = string
}

variable "billing_mode" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "hash_key_type" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "subnet_1_cidr" {
  type = string
}

variable "subnet_1_az" {
  type = string
}

variable "subnet_2_cidr" {
  type = string
}

variable "subnet_2_az" {
  type = string
}

variable "route_table_cidr" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "sg_cidr" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}